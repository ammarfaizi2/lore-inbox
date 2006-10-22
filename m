Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWJVBe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWJVBe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 21:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWJVBe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 21:34:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59267 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030395AbWJVBe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 21:34:28 -0400
Date: Sun, 22 Oct 2006 03:34:27 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Damien Wyart <damien.wyart@free.fr>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
Message-ID: <20061022013427.GA17694@wotan.suse.de>
References: <20061021104454.GA1996@localhost.localdomain> <87lkn9x0ly.fsf@duaron.myhome.or.jp> <20061021173849.GA1999@localhost.localdomain> <20061021131932.09801b4a.akpm@osdl.org> <20061021132431.0ced0dc6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061021132431.0ced0dc6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 01:24:31PM -0700, Andrew Morton wrote:
> On Sat, 21 Oct 2006 13:19:32 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Sat, 21 Oct 2006 19:38:49 +0200
> > Damien Wyart <damien.wyart@free.fr> wrote:
> > 
> > > > --- a/fs/fat/inode.c~fs-prepare_write-fixes
> > > > +++ a/fs/fat/inode.c
> > > > @@ -150,7 +150,11 @@ static int fat_commit_write(struct file 
> > > >  			    unsigned from, unsigned to)
> > > >  {
> > > >  	struct inode *inode = page->mapping->host;
> > > > -	int err = generic_commit_write(file, page, from, to);
> > > > +	int err;
> > > > +	if (to - from > 0)
> > > > +		return 0;
> > > > +
> > 
> > That should have been
> > 
> > 	if (to - from == 0)
> > 		return 0;
> 
> otoh, it's still wrong that we're not updating i_size.  We happen to know
> that the caller will retry without dropping i_mutex, but it's a bit
> incestuous.

It can possibly fail for example if the source buffer gets unmapped.
However in the length == 0 case, that signals a failure to write anything
so we needn't update i_size, I think?
