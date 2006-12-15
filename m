Return-Path: <linux-kernel-owner+w=401wt.eu-S1751720AbWLOS17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWLOS17 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbWLOS17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:27:59 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:47015 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbWLOS16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:27:58 -0500
Message-ID: <4582E92C.7030004@s5r6.in-berlin.de>
Date: Fri, 15 Dec 2006 19:27:56 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/3] Import fw-sbp2 driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052253.7213.41796.stgit@dinky.boston.redhat.com> <45750C9A.607@garzik.org> <4581B88C.9040104@redhat.com> <4581C4D1.8090803@s5r6.in-berlin.de> <4582BA68.1010303@redhat.com>
In-Reply-To: <4582BA68.1010303@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(added Cc: lsml)

Kristian Høgsberg wrote at lkml:
> I saw that the stack
[the FireWire stack]
> creates a struct device per LUN, which is kinda gross in my opinion.

If you mean regular "unit directories" here, not SCSI LUs, then one
device per unit makes sense. Different units of a node may implement
different protocols and may have different lifetimes.

If you mean the special representation of SBP-2 logical units by
multiple leaf entries in one and the same unit directory (Why the heck
did they allow two different representations?), then you are right that
the burden could certainly be shifted from the FireWire core to the
SBP-2 protocol driver, WRT ROM scanning and generic device representation.

> It's easy enough to discover the LUNs from the rom, I just need to
> figure out how to tell the SCSI stack about multiple LUNs.

Since REPORT LUNS is not guaranteed to work with SBP-2 targets, we stick
to scsi_add_device(). With some effort we could supply scsi_add_device()
with common instances of Scsi_Host and target for units which reside on
the same target. Alas the scsi_add_device() API has a concept of target
which is quite unfit for most SCSI transports other than SPI. We have
got the following alternatives:
 - Implement a mapping of SAM targets to scsi_add_device targets in
   sbp2. Effectively, map from pointer or EUI-64 to uint. <linux/idr.h>
   has an infrastructure for such a mapping.
   (This is not the Linux way of doing things, but wicked people may be
   tempted to call it 'the Linux SCSI way so far'.)
 - Reform the scsi_add_device API to support SAM targets.
 - Leave stuff as is, concentrate on fixing the FireWire stack's issues
   first.
If you look closely, you see the order of list items reflecting my
personal preference. :-)

Of course, as mentioned before, a precondition to represent multiple LUs
beneath a single representation of a target is to convert sbp2 to
instantiante only one Scsi_Host for many or all SBP-2 units.
-- 
Stefan Richter
-=====-=-==- ==-- -====
http://arcgraph.de/sr/
