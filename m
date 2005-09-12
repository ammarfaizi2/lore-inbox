Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVILPEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVILPEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVILO63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:58:29 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:51909 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751322AbVILO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:57:58 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <43251D8C.7020409@torque.net>
References: <1126308304.4799.45.camel@mulgrave>
	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <20050911094656.GC5429@infradead.org>  <43251D8C.7020409@torque.net>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 09:57:21 -0500
Message-Id: <1126537041.4825.28.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 16:17 +1000, Douglas Gilbert wrote:
> If we look at our (im)famous <h:c:i:l> addressing string,
> the first 2 elements (i.e. "h:c") are about kernel device
> addressing (i.e. which (part of a) HBA to be initiator); the
> contentious "i" is about addressing the target and is
> transport dependent, and the "l" is for addressing within
> the target. Only the last element is true SCSI and is
> defined in SAM (to be 64 bits, not 32). In iSCSI the "i"
> is actually an adorned IP address.

About the "i" problem, I've long agreed that we could do with an
arbitrary string or other method there.  There is a description of how
to do it, it's just rather involved since the idea of "i" being a small
number threads through a large amount of driver code making backward
compatibility a bit of a nightmare.

The "l" issue should be primarily solved with the scsilun_to_int and
int_to_scsilun functions.  OK, horribly named, but they now mean that
the internal mid-layer representation (a 32 bit int currently) is
abstracted from the structure the drivers use on the wire so we should
be free to increase it if necessary.  Note: you do actually need either
an array with more than two levels of nesting actually to need the
increase and no-one actually seems to have one of these yet.

> So the kernel "discovers" at the "h:c" level at powerup
> (and at runtime with hotplug events); leaving the SCSI
> subsystem to do discovery at the "i" and the "l" level.
> 
> At this point I would like to make an observation: there
> is no absolute requirement for the SCSI subsystem to do
> discovery at either the "i" or the "l" levels. Using SAS

Right, but we've already moved away from that if you use the correct
APIs.  The fc transports (those that attach to the transport class,
anyway) no longer use the mid-layer provided sequential scan.  They
simply add targets that the fibre discovers from the log in process.
Essentially this means that the class/driver co-operate on discover and
only use the mid-layer for LUN detection once they report the existence
of a target.

> as an example, only the SAS (target port) address and
> a logical unit number (identifier) or name are needed.
> So an embedded system which includes a SAS initiator (HBA)
> could connect to an arbitrary device quickly and with
> minimal impact on a large SAS fabric (i.e. no SAS target
> discovery phase). As an extreme example, target discovery
> in iSCSI cannot involve the whole internet (and even though
> its topology would be interesting, representing it in sysfs
> is absurd).

> My major objection to Luben's SAS sysfs representation is
> that "things" have to be discovered before the user space
> can talk to them. Why?? An app in the user space might
> _know_ that the "thing" (e.g. SAS expander or a "well
> known" logical unit) is out there. Again the obvious comparison
> is with IP addresses and the way the networking subsystem
> functions. I would like to make HBA initiators (or their ports)
> visible as interfaces (like eth0 and friends) through which
> commands/frames/primitives can be sent and events received.

This one, I actually agree with.  Most users have small domains which
will be easily amenable to total enumeration.  The other issue is that
if we go with a socket like approach where the user has to connect to
the devices, then we lose hotplug ... a true network doesn't know or
care when another PC is plugged into it.

For things like iscsi, we do have the compromise that discovery doesn't
begin until the endpoint is known.

If we go like net and have the whole world as our potential but non-
discovered domain, we have to begin addressing security issues that
arise because of the parts of the domain that we don't control ... I'd
much rather leave these sort of issues to the net people and begin with
the a priori assumption that a scsi domain, although it might be bridged
across the hostile network, represents a fundamentally secure and
discoverable system.

James


