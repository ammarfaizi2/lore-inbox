Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUAaBiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 20:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUAaBiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 20:38:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:12975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262078AbUAaBiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 20:38:09 -0500
Date: Fri, 30 Jan 2004 17:38:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: hch@infradead.org, miquels@cistron.nl, linux-kernel@vger.kernel.org,
       nathans@sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-Id: <20040130173851.2cc5938f.akpm@osdl.org>
In-Reply-To: <20040131012507.GQ25833@drinkel.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl>
	<20040128222521.75a7d74f.akpm@osdl.org>
	<20040130202155.GM25833@drinkel.cistron.nl>
	<20040130221353.GO25833@drinkel.cistron.nl>
	<20040130143459.5eed31f0.akpm@osdl.org>
	<20040130225353.A26383@infradead.org>
	<20040130151316.40d70ed3.akpm@osdl.org>
	<20040131012507.GQ25833@drinkel.cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>
> On Sat, 31 Jan 2004 00:13:16, Andrew Morton wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Fri, Jan 30, 2004 at 02:34:59PM -0800, Andrew Morton wrote:
> > > > If two CPUs hit i_size_write() at the same time we have a bug.  That
> > > > function requires that the caller provide external serialisation, via i_sem.
> > > 
> > > O_APPEND|O_DIRECT writes could do that under XFS..
> > 
> > Sigh.
> >
> > diff -puN mm/filemap.c~i_size_write-check mm/filemap.c
> > --- 25/mm/filemap.c~i_size_write-check	Fri Jan 30 15:10:23 2004
> > +++ 25-akpm/mm/filemap.c	Fri Jan 30 15:11:41 2004
> > @@ -2010,3 +2010,18 @@ out:
> >  }
> >  
> >  EXPORT_SYMBOL_GPL(generic_file_direct_IO);
> > +
> > +void i_size_write_check(struct inode *inode)
> > +{
> > +	static int count = 0;
> > +
> > +	if (down_trylock(&inode->i_sem) == 0) {
> > +		if (count < 10) {
> 
> You want to set this to 100 at least, since at boot time the message
> happens _often_ even without XFS.

fun.

> It's caused by sysfs:

OK, sysfs_symlink() needs i_sem.

> Also, bd_set_size runs unlocked:

I don't expect we'll ever see a race over the blockdev's i_size in there. 
It might be simplest to just do a straight assignment.  I'll work that with
viro.

> But the XFS problem appears to be vn_revalidate which calls i_size_write()
> without holding i_sem:

There's your bug.


