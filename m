Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTJUQlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 12:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTJUQlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 12:41:22 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:62094 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263176AbTJUQlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 12:41:20 -0400
Subject: Re: LVM on md0: raid0_make_request bug: can't convert block across
	chunks or bigger than 64k
From: Karl Vogel <karl.vogel@seagha.com>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Joe Thornber <thornber@sistina.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1066753760.1161.4.camel@kvo.local.org>
References: <1066682115.1799.15.camel@kvo.local.org>
	 <1066686755.1146.6.camel@kvo.local.org>
	 <16276.31028.9351.994009@notabene.cse.unsw.edu.au>
	 <200310210841.45452.kevcorry@us.ibm.com>
	 <1066753760.1161.4.camel@kvo.local.org>
Content-Type: text/plain
Message-Id: <1066754478.1205.2.camel@kvo.local.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Tue, 21 Oct 2003 18:41:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  ----------- Diffstat output ------------
> > >  ./drivers/md/dm-table.c |    5 +++++
> > >  1 files changed, 5 insertions(+)
> > >
> > > diff ./drivers/md/dm-table.c~current~ ./drivers/md/dm-table.c
> > > --- ./drivers/md/dm-table.c~current~	2003-10-21 10:05:29.000000000 +1000
> > > +++ ./drivers/md/dm-table.c	2003-10-21 10:06:27.000000000 +1000
> > > @@ -489,6 +489,11 @@ int dm_get_device(struct dm_target *ti,
> > >  		rs->max_sectors =
> > >  			min_not_zero(rs->max_sectors, q->max_sectors);
> > >
> > > +		if (q->merge_bvec_fn)
> > > +			rs->max_sectors =
> > > +				min_not_zero(rs->max_sectors, PAGE_SIZE>>9);
> > > +
> > > +
> > >  		rs->max_phys_segments =
> > >  			min_not_zero(rs->max_phys_segments,
> > >  				     q->max_phys_segments);
> > 
> > This will probably work, as long as raid0 can split a one-page request that 
> > spans a chunk boundary. I'll be interested to see if this solves Karl's 
> > problem.
> 
> Good news... it solves the problem with my setup. I was able to copy
> files off the logical volume (did an md5sum compare to make sure I got
> the complete files.)

Forgot to mention that it generates a compiler warning:

  CC      drivers/md/dm-table.o
drivers/md/dm-table.c: In function `dm_get_device':
drivers/md/dm-table.c:494: warning: comparison of distinct pointer types
lacks a cast

Using:
$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.3.1/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--disable-checking --with-system-zlib --enable-__cxa_atexit
--host=i386-redhat-linux
Thread model: posix
gcc version 3.3.1 20030930 (Red Hat Linux 3.3.1-6)


