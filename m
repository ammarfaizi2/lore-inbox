Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWJUUYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWJUUYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 16:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWJUUYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 16:24:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbWJUUYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 16:24:38 -0400
Date: Sat, 21 Oct 2006 13:24:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Damien Wyart <damien.wyart@free.fr>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
Message-Id: <20061021132431.0ced0dc6.akpm@osdl.org>
In-Reply-To: <20061021131932.09801b4a.akpm@osdl.org>
References: <20061021104454.GA1996@localhost.localdomain>
	<87lkn9x0ly.fsf@duaron.myhome.or.jp>
	<20061021173849.GA1999@localhost.localdomain>
	<20061021131932.09801b4a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 13:19:32 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Sat, 21 Oct 2006 19:38:49 +0200
> Damien Wyart <damien.wyart@free.fr> wrote:
> 
> > > --- a/fs/fat/inode.c~fs-prepare_write-fixes
> > > +++ a/fs/fat/inode.c
> > > @@ -150,7 +150,11 @@ static int fat_commit_write(struct file 
> > >  			    unsigned from, unsigned to)
> > >  {
> > >  	struct inode *inode = page->mapping->host;
> > > -	int err = generic_commit_write(file, page, from, to);
> > > +	int err;
> > > +	if (to - from > 0)
> > > +		return 0;
> > > +
> 
> That should have been
> 
> 	if (to - from == 0)
> 		return 0;

otoh, it's still wrong that we're not updating i_size.  We happen to know
that the caller will retry without dropping i_mutex, but it's a bit
incestuous.

