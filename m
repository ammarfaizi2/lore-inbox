Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWBFEv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWBFEv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWBFEv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:51:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750984AbWBFEv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:51:28 -0500
Date: Sun, 5 Feb 2006 20:50:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@surriel.com>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
Message-Id: <20060205205056.01a025fa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61L.0602051138260.26086@imladris.surriel.com>
References: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com>
	<Pine.LNX.4.61L.0602051138260.26086@imladris.surriel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@surriel.com> wrote:
>
> On Sun, 5 Feb 2006, Shantanu Goel wrote:
> 
>  > It seems rotate_reclaimable_page fails most of the
>  > time due the page not being on the LRU when kswapd
>  > calls writepage().
> 
>  The question is, why is the page not yet back on the
>  LRU by the time the data write completes ?

Could be they're ext3 pages which were written out by kjournald.  Such
pages are marked dirty but have clean buffers.  ext3_writepage() will
discover that the page is actually clean and will mark it thus without
performing any I/O.

In which case this code in shrink_list():

				/*
				 * A synchronous write - probably a ramdisk.  Go
				 * ahead and try to reclaim the page.
				 */
				if (TestSetPageLocked(page))
					goto keep;
				if (PageDirty(page) || PageWriteback(page))
					goto keep_locked;
				mapping = page_mapping(page);
			case PAGE_CLEAN:
				; /* try to free the page below */

should just go and reclaim the page immediately.

Shantanu, I suggest you add some instrumentation there too, see if it's
working.  (That'll be non-trivial.  Just because we hit PAGE_CLEAN: here
doesn't necessarily mean that the page will be reclaimed).

