Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUCCEVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUCCEVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:21:12 -0500
Received: from fmr09.intel.com ([192.52.57.35]:45798 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261463AbUCCEVG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:21:06 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: per-cpu blk_plug_list
Date: Tue, 2 Mar 2004 20:20:53 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB50211E5C8@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: per-cpu blk_plug_list
Thread-Index: AcQA0zlEcG9pgEfkRDetKG2iD9c2IwAAsorQ
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jesse Barnes" <jbarnes@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 03 Mar 2004 04:20:53.0587 (UTC) FILETIME=[EAD25230:01C400D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand the proposal here.  There is a per-device lock
already.  But the plugged queue need to be on some list outside itself
so a group of them can be unplugged later on to flush all the I/O.

- Ken


-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Tuesday, March 02, 2004 7:56 PM
To: Jesse Barnes
Cc: Chen, Kenneth W; linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list

> On Mon, Mar 01, 2004 at 01:18:40PM -0800, Chen, Kenneth W wrote:
> > blk_plug_list/blk_plug_lock manages plug/unplug action.  When you
have
> > lots of cpu simultaneously submits I/O, there are lots of movement
with
> > the device queue on and off that global list.  Our measurement
showed
> > that blk_plug_lock contention prevents linux-2.6.3 kernel to scale
pass
> > beyond 40 thousand I/O per second in the I/O submit path.
> 
> This helped out our machines quite a bit too.  Without the patch, we
> weren't able to scale above 80000 IOPS, but now we exceed 110000 (and
> parity with our internal XSCSI based tree).
> 
> Maybe the plug lists and locks should be per-device though, rather
than
> per-cpu?  That would make the migration case easier I think.  Is that
> possible?

It's possible, yes.  It is the preferred solution.  We need to identify
all
the queues which need to be unplugged to permit a VFS-level IO request
to
complete.  It involves running down the device stack and running around
all
the contributing queues at each level.

Relatively straightforward, but first those dang sempahores in device
mapper need to become spinlocks.  I haven't looked into what
difficulties
might be present in the RAID implementation.
