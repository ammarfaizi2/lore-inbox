Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWFBJHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWFBJHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWFBJHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:07:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751347AbWFBJHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:07:05 -0400
Date: Fri, 2 Jun 2006 02:11:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060602021115.e42ad5dd.akpm@osdl.org>
In-Reply-To: <20060602084327.GA3964@suse.de>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
	<20060601121200.457c0335.akpm@osdl.org>
	<20060601201050.GA32221@suse.de>
	<20060601142400.1352f903.akpm@osdl.org>
	<20060601214158.GA438@suse.de>
	<20060601145747.274df976.akpm@osdl.org>
	<20060602084327.GA3964@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 10:43:27 +0200
Olaf Hering <olh@suse.de> wrote:

>  On Thu, Jun 01, Andrew Morton wrote:
> 
> 
> > > Do you want it like that?
> > > 
> > > lock_page(page);
> > > if (PageUptodate(page)) {
> > >         SetPageDirty(page);
> > >         mb();
> > >         return page;
> > > }
> > 
> > Not really ;)  It's hacky.  It'd be better to take a lock.
> 
> Which lock exactly?

Ah, sorry, there isn't such a lock.  I was just carrying on.

> I'm not sure how to proceed from here.

I'd suggest you run SetPagePrivate() and SetPageChecked() on the locked
page and implement a_ops.releasepage(), which will fail if PageChecked(),
and will succeed otherwise:

/*
 * cramfs_releasepage() will fail if cramfs_read() set PG_checked.  This
 * is so that invalidate_inode_pages() cannot zap the page while
 * cramfs_read() is trying to get at its contents.
 */
cramfs_releasepage(...)
{
	if (PageChecked(page))
		return 0;
	return 1;
}


cramfs_read(...)
{
	lock_page(page);
	SetPagePrivate(page);
	SetPageChecked(page);
	read_mapping_page(...);
	lock_page(page);
	if (page->mapping == NULL) {
		/* truncate got there first */
		unlock_page(page);
		bale();
	}
	memcpy();
	ClearPageChecked(page);
	ClearPagePrivate(page);
	unlock_page(page);
}

PG_checked is a filesystem-private flag.  It'll soon be renamed to
PG_fs_misc.

