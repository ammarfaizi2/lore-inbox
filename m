Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVHUWHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVHUWHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 18:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVHUWHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 18:07:04 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:56232 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751156AbVHUWHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 18:07:01 -0400
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
From: James Bottomley <James.Bottomley@SteelEye.com>
To: luben_tuikov@adaptec.com
Cc: Andrew Morton <akpm@osdl.org>, Jim Houston <jim.houston@ccur.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050821172758.36512.qmail@web51608.mail.yahoo.com>
References: <20050821172758.36512.qmail@web51608.mail.yahoo.com>
Content-Type: text/plain
Date: Sun, 21 Aug 2005 17:03:50 -0500
Message-Id: <1124661830.5068.19.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-21 at 10:27 -0700, Luben Tuikov wrote:
> Is this the only use _you_ could find for a *radix tree*? ;-)
> Since of course sd.c uses it just as an enumeration, according to
> you this must be the only use? :-)

And Dicto Simpliciter to you too.

> It was designed as a general purpose id to pointer translation
> service, just as the comment in it says.

idr was specifically designed with unlocked pre-allocation in mind.  The
change you're proposing wants to allow pre allocation from irq context.
This really doesn't look like a good change because the whole point of
pre allocation is to do it at a point in time when the system can sleep
if it has to.

What I don't understand is why you need to pre allocate this tag from
irq context.  Best practise is to allocate when you have user context
but make use of it in IRQ context.

> > However, there is an infrastructure in the block layer called the
> > generic tag infrastructure which was designed precisely for this purpose
> > and which is designed to operate in IRQ context.
> 
> James, I'm sure you're well aware that,
>    - a request_queue is LU-bound,
>    - a SCSI _transport_ (*ANY*) can _only_ address domain devices, but
>      _not_ LUs.  LUs are *not* seen on the domain.
> 
> See the different associations?  Then why are you posting such emails?

So you're planning to do some type of tag command queueing outside of
the block framework?  Could you just look at what it would take to do it
within the existing framework first?  I seem to have wasted quite a bit
of time recently pulling spurious queueing code out of Adaptec drivers.

Remember that the code is adaptable ... we have non-block devices that
use block queues for instance.

James


