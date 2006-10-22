Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422909AbWJVBua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422909AbWJVBua (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 21:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWJVBua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 21:50:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15237 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422909AbWJVBua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 21:50:30 -0400
Date: Sun, 22 Oct 2006 03:50:28 +0200
From: Nick Piggin <npiggin@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, Damien Wyart <damien.wyart@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
Message-ID: <20061022015028.GB17694@wotan.suse.de>
References: <20061021104454.GA1996@localhost.localdomain> <87lkn9x0ly.fsf@duaron.myhome.or.jp> <20061021173849.GA1999@localhost.localdomain> <20061021131932.09801b4a.akpm@osdl.org> <873b9htne9.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873b9htne9.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 05:38:38AM +0900, OGAWA Hirofumi wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Sat, 21 Oct 2006 19:38:49 +0200
> > Damien Wyart <damien.wyart@free.fr> wrote:
> >
> >> > --- a/fs/fat/inode.c~fs-prepare_write-fixes
> >> > +++ a/fs/fat/inode.c
> >> > @@ -150,7 +150,11 @@ static int fat_commit_write(struct file 
> >> >  			    unsigned from, unsigned to)
> >> >  {
> >> >  	struct inode *inode = page->mapping->host;
> >> > -	int err = generic_commit_write(file, page, from, to);
> >> > +	int err;
> >> > +	if (to - from > 0)
> >> > +		return 0;
> >> > +
> >
> > That should have been
> >
> > 	if (to - from == 0)
> > 		return 0;
> 
> As I said in this thread, generic_cont_expand() uses "to == from".
> Should we fix generic_cont_expand() instead? I don't know the
> background of this patch.

OK I have to write an RFC for various fs developers, so I'll be sure
to include you.

We want to be able to pass in a short (possibly zero) commit_write
length if the page data can not be fully copied.

generic_cont_expand seems to be using that as a shorthand for
"update the i_size but don't mark anything uptdoate"? If so, I think
it would be nice to fix it. Why does it even need to go through the
prepare/commit? Why not make __generic_cont_expand a standalone
function, and call that from cont_prepare_write? 
