Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUAQUlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUAQUlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:41:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266142AbUAQUlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:41:14 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
In-Reply-To: <20040117192946.A6479@infradead.org>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
	 <20040112151230.GB5844@devserv.devel.redhat.com>
	 <20040112194829.A7078@infradead.org>
	 <1073937102.3114.300.camel@compaq.xsintricity.com>
	 <Pine.LNX.4.58L.0401131843390.6737@logos.cnet>
	 <1074345000.13198.25.camel@compaq.xsintricity.com>
	 <20040117165828.A4977@infradead.org>
	 <1074366452.13198.48.camel@compaq.xsintricity.com>
	 <20040117191704.A6344@infradead.org>
	 <1074367303.13198.52.camel@compaq.xsintricity.com>
	 <20040117192946.A6479@infradead.org>
Content-Type: text/plain
Message-Id: <1074371793.13198.58.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sat, 17 Jan 2004 15:36:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-17 at 14:29, Christoph Hellwig wrote:
> On Sat, Jan 17, 2004 at 02:21:43PM -0500, Doug Ledford wrote:
> > I should pay more attention to what goes on in 2.6.  That was a crap
> > decision.  There are drivers out there that use global data and need one
> > lock across all controllers.  Putting a lock in the scsi host struct for
> > per controller locks is a waste of space.  Let the driver decide if it
> > needs a global driver lock, a per controller lock (in which case it
> > should be part of the driver private host struct), or just the global
> > io_request_lock.  It really is up to the driver and putting it into the
> > scsi host struct doesn't make sense.
> 
> I tend to disagree.  Giving the driver control over the lock used by the
> midlayer is just wrong.  If it has global state (which a good driver better
> shouldn't) it's up to the driver to protect it.  That we still have a way
> to override that lock is the big bug rather, and in fact only three drivers
> are doing that, and they all override it with a lock that's per-HBA anyway.

/me calls Christoph various unrepeatable names :-P

I'm exactly the opposite.  In my opinion, the mid layer should be using
the device locks for its internal operations and calling into the low
level drivers with no locks held.  The fact that the mid layer still
tries to lock drivers for the drivers is a bug IMO.  Every time I see a
driver do spin_unlock_irq(host->host_lock); do driver work;
spin_lock_irq(host->host_lock); return; it really points out that the
mid layer has no business locking down drivers for them.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


