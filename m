Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUAQT00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUAQT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:26:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62166 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266154AbUAQT0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:26:21 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
In-Reply-To: <20040117191704.A6344@infradead.org>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
	 <20040112151230.GB5844@devserv.devel.redhat.com>
	 <20040112194829.A7078@infradead.org>
	 <1073937102.3114.300.camel@compaq.xsintricity.com>
	 <Pine.LNX.4.58L.0401131843390.6737@logos.cnet>
	 <1074345000.13198.25.camel@compaq.xsintricity.com>
	 <20040117165828.A4977@infradead.org>
	 <1074366452.13198.48.camel@compaq.xsintricity.com>
	 <20040117191704.A6344@infradead.org>
Content-Type: text/plain
Message-Id: <1074367303.13198.52.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sat, 17 Jan 2004 14:21:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-17 at 14:17, Christoph Hellwig wrote:
> On Sat, Jan 17, 2004 at 02:07:33PM -0500, Doug Ledford wrote:
> > #ifdef SCSI_HAS_HOST_LOCK
> > #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> > 	adapter->lock_ptr = &adapter->lock;
> > 	host->lock = &adapter->lock;
> > #else
> > 	adapter->lock_ptr = &adapter->lock;
> > 	host->host_lock = &adapter->lock;
> > #endif
> > #else
> > 	adapter->lock_ptr = &io_request_lock;
> > #endif
> 
> Still looks wrong for the 2.6 case which should just be;
> 
> 	adapter->lock_ptr = shost->host_lock;
> 
> as I just stated in the review for the megaraid update.

I should pay more attention to what goes on in 2.6.  That was a crap
decision.  There are drivers out there that use global data and need one
lock across all controllers.  Putting a lock in the scsi host struct for
per controller locks is a waste of space.  Let the driver decide if it
needs a global driver lock, a per controller lock (in which case it
should be part of the driver private host struct), or just the global
io_request_lock.  It really is up to the driver and putting it into the
scsi host struct doesn't make sense.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


