Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262508AbREUWBo>; Mon, 21 May 2001 18:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbREUWBZ>; Mon, 21 May 2001 18:01:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65034 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262505AbREUWBS>; Mon, 21 May 2001 18:01:18 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: tmpfs + sendfile bug ?
Date: 21 May 2001 15:01:05 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9ec371$gqn$1@penguin.transmeta.com>
In-Reply-To: <XFMail.20010521183553.petchema@concept-micro.com> <m3bsomwsgs.fsf@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m3bsomwsgs.fsf@linux.local>, Christoph Rohland  <cr@sap.com> wrote:
>
>tmpfs does not provide the necessary functions for sendfile and lo:
>readpage, prepare_write and commitwrite.
>
>And I do not see a way how to provide readpage in tmpfs :-(

Why not just do it the same way ramfs does?

If you don't have any backing store, you know that the page is empty. If
you _do_ have backing store, a readpage() won't be called. Ergo:

	static int ramfs_readpage(struct file *file, struct page * page)
	{
		if (!Page_Uptodate(page)) {
			memset(kmap(page), 0, PAGE_CACHE_SIZE);
			kunmap(page);
			flush_dcache_page(page);   
			SetPageUptodate(page);
		}
		UnlockPage(page);
		return 0;
	}

while the writepage ones just do a "SetPageDirty(page)" (with
prepare_write() needing to do the same "Page_Uptodate()" checks to see
if we need to clear stuff first).

		Linus
