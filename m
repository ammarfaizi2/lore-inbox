Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWJVJZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWJVJZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWJVJZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:31151 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932315AbWJVJZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:25:06 -0400
Date: Sun, 22 Oct 2006 11:25:04 +0200
From: Nick Piggin <npiggin@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, Damien Wyart <damien.wyart@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
Message-ID: <20061022092504.GA16831@wotan.suse.de>
References: <20061021104454.GA1996@localhost.localdomain> <87lkn9x0ly.fsf@duaron.myhome.or.jp> <20061021173849.GA1999@localhost.localdomain> <20061021131932.09801b4a.akpm@osdl.org> <873b9htne9.fsf@duaron.myhome.or.jp> <20061022015028.GB17694@wotan.suse.de> <87lkn8sojb.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lkn8sojb.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 06:11:36PM +0900, OGAWA Hirofumi wrote:
> Nick Piggin <npiggin@suse.de> writes:
> 
> > On Sun, Oct 22, 2006 at 05:38:38AM +0900, OGAWA Hirofumi wrote:
> >> 
> >> As I said in this thread, generic_cont_expand() uses "to == from".
> >> Should we fix generic_cont_expand() instead? I don't know the
> >> background of this patch.
> >
> > OK I have to write an RFC for various fs developers, so I'll be sure
> > to include you.
> >
> > We want to be able to pass in a short (possibly zero) commit_write
> > length if the page data can not be fully copied.
> 
> Thanks. So, if the range is zero, what should fs driver do?

The fs driver should ensure that any userspace access to the
filesystem/pagecache should behave as if no prepare_write were
called at all.

That includes deallocating or zeroing any potentially allocated
but uninitialized blocks so they won't get read in from disk in future.
But that isn't handled properly yet though, so we can probably solve
that in the core kernel rather than your filesystem. Discussion about
this should go to the new mail I've just posted.


> > generic_cont_expand seems to be using that as a shorthand for
> > "update the i_size but don't mark anything uptdoate"? If so, I think
> > it would be nice to fix it. Why does it even need to go through the
> > prepare/commit?
> 
> It's not only for updating ->i_size.
> 
> __generic_cont_expand() is used for expanding ->i_size by trucate(2).
> In FAT case, it needs to fill the hole by zero and dirty it before
> write new ->i_size. The ->prepare_write() does it, and ->commit_write()
> writes ->i_size and dirty inode in __generic_cont_expand().
> 
> Anyway, if it's required, maybe we would be able to change
> __generic_cont_expand().

Yes I see, after reading it a bit. I'll take a look at it and try
to work out if anything needs fixing.

Thanks,
Nick

