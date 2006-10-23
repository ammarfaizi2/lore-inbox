Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWJWUjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWJWUjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWJWUjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:39:47 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:58782 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751161AbWJWUjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:39:46 -0400
Date: Mon, 23 Oct 2006 21:39:44 +0100
To: Damien Wyart <damien.wyart@free.fr>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
Message-ID: <20061023203944.GA17290@skynet.ie>
References: <20061021104454.GA1996@localhost.localdomain> <87lkn9x0ly.fsf@duaron.myhome.or.jp> <20061021173849.GA1999@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061021173849.GA1999@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/10/06 19:38), Damien Wyart didst pronounce:
> > > I have noticed something strange (and bad :) since using
> > > 2.6.19-rc2-mm2 (the problem is NOT present on 2.6.19-rc2-mm1 ; do
> > > not know for mainline, I have not been able to test yet, but I think
> > > there have not been recent changes in this area) : writing a file to
> > > a vfat fs (fat 32) writes it, but with size 0 and no content.
> 
> * OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> [2006-10-21 22:24]:
> > diff -puN fs/fat/inode.c~fs-prepare_write-fixes fs/fat/inode.c
> > --- a/fs/fat/inode.c~fs-prepare_write-fixes
> > +++ a/fs/fat/inode.c
> > @@ -150,7 +150,11 @@ static int fat_commit_write(struct file 
> >  			    unsigned from, unsigned to)
> >  {
> >  	struct inode *inode = page->mapping->host;
> > -	int err = generic_commit_write(file, page, from, to);
> > +	int err;
> > +	if (to - from > 0)
> > +		return 0;
> > +
> > +	err = generic_commit_write(file, page, from, to);
> >  	if (!err && !(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
> >  		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
> >  		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
> 
> > This change does't update ->i_size. Could you just delete, and test
> > it? Anyway, this seems wrong even if it's "if ((to - from) == 0)".
> 
> Reverting the change makes the problem go away. But I do not know if
> this is safe wrt the fs-prepare_write-fixes patch.
> 

I don't know about the fix, but the issue is pretty serious for IA64 and the
EFI bootloader. On the IA64 I have access to, the bootloader and related
files are stored on a VFAT file system so when an automated system ran a
simple boot-test, the bootloader was blown away as a result.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
