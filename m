Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUATHyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 02:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUATHyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 02:54:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16618 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265181AbUATHxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 02:53:55 -0500
Date: Tue, 20 Jan 2004 08:53:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Peter Yao <peter@exavio.com.cn>,
       linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040120075336.GK16085@suse.de>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com> <20040112151230.GB5844@devserv.devel.redhat.com> <20040112194829.A7078@infradead.org> <1073937102.3114.300.camel@compaq.xsintricity.com> <Pine.LNX.4.58L.0401131843390.6737@logos.cnet> <1074345000.13198.25.camel@compaq.xsintricity.com> <20040117165828.A4977@infradead.org> <1074366452.13198.48.camel@compaq.xsintricity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074366452.13198.48.camel@compaq.xsintricity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17 2004, Doug Ledford wrote:
> On Sat, 2004-01-17 at 11:58, Christoph Hellwig wrote:
> > On Sat, Jan 17, 2004 at 08:10:00AM -0500, Doug Ledford wrote:
> > > 4)  The last issue.  2.6 already has individual host locks for drivers. 
> > > The iorl patch for 2.4 adds the same thing.  So, adding the iorl patch
> > > to 2.4 makes it easier to have drivers be the same between 2.4 and 2.6. 
> > > Right now it takes some fairly convoluted #ifdef statements to get the
> > > locking right in a driver that supports both 2.4 and 2.6.  Adding the
> > > iorl patch allows driver authors to basically state that they don't
> > > support anything prior to whatever version of 2.4 it goes into and
> > > remove a bunch of #ifdef crap.
> > 
> > Well, no.  For one thing all the iorl patches miss the scsi_assign_lock
> > interface from 2.6 which makes drivers a big ifdef hell (especially
> > as the AS2.1 patch uses a different name for the lock as 3.0), and even
> > if it was there the use of that function is strongly discuraged in 2.6
> > in favour of just using the host_lock.
> 
> Yeah, I saw that too.  Of course, it's not like that's my fault :-P  I
> had the 2.4.9 version of the iorl patch before 2.5 had a host lock, so
> 2.5 *could* have followed the 2.4.9-iorl patch convention of using
> host->lock as the name instead of host->host_lock and then we wouldn't
> be here.  But, because 2.6 uses host->host_lock, and because usage of

First of all, ->lock is a _bad_ name. And secondly, we probably did this
at around the same time (the 2.5 block code was already "done" by the
time 2.5 opened, if you recall it was one of the first things merged in
2.5.1-pre1). The fact that I chose the better name (which is really a
rare incident, my names typically suck) is just history :-)

> the scsi_assign_lock() is discouraged, I made the iorl patch in RHEL3
> follow the 2.6 convention of using host->host_lock.  In hindsight, I
> should have just followed the 2.4.9-iorl patch convention.  Then a
> driver could have just done this:
> 
> #ifdef SCSI_HAS_HOST_LOCK
> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> 	adapter->lock_ptr = &adapter->lock;
> 	host->lock = &adapter->lock;
> #else
> 	adapter->lock_ptr = &adapter->lock;
> 	host->host_lock = &adapter->lock;
> #endif
> #else
> 	adapter->lock_ptr = &io_request_lock;
> #endif
> 
> Then you just always use adapter->lock_ptr for spin locks in the driver
> and you magically work in all kernel releases.  Now, by going to
> host->host_lock in 2.4 we get rid of one of the if statements.  This
> isn't impossible to do if both Red Hat and SuSE just release their next
> update kernel with host->lock changed to host->host_lock.

I can certainly help make that happen, I completely agree it's needed.

-- 
Jens Axboe

