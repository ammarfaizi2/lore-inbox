Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVILTjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVILTjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVILTjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:39:52 -0400
Received: from magic.adaptec.com ([216.52.22.17]:9198 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932169AbVILTjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:39:51 -0400
Message-ID: <4325D97B.8010401@adaptec.com>
Date: Mon, 12 Sep 2005 15:39:39 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Douglas Gilbert <dougg@torque.net>, Christoph Hellwig <hch@infradead.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave>	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>	 <20050911094656.GC5429@infradead.org>  <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave>
In-Reply-To: <1126537041.4825.28.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 19:39:45.0446 (UTC) FILETIME=[BA78E460:01C5B7D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 10:57, James Bottomley wrote:
> On Mon, 2005-09-12 at 16:17 +1000, Douglas Gilbert wrote:
> 
>>If we look at our (im)famous <h:c:i:l> addressing string,
>>the first 2 elements (i.e. "h:c") are about kernel device
>>addressing (i.e. which (part of a) HBA to be initiator); the
>>contentious "i" is about addressing the target and is
>>transport dependent, and the "l" is for addressing within
>>the target. Only the last element is true SCSI and is
>>defined in SAM (to be 64 bits, not 32). In iSCSI the "i"
>>is actually an adorned IP address.
> 
> 
> About the "i" problem, I've long agreed that we could do with an
> arbitrary string or other method there.  There is a description of how

You do not need an "i" representation in SCSI Core. In fact,
the "i" does exist, but it is _transport_ specific, e.g. Id in SPI,
or WWN in SAS.

SCSI Core can work without ever representing "i".

The IEEE1394 people have also pointed that out to you recently.

> to do it, it's just rather involved since the idea of "i" being a small
> number threads through a large amount of driver code making backward
> compatibility a bit of a nightmare.
> 
> The "l" issue should be primarily solved with the scsilun_to_int and
> int_to_scsilun functions.  OK, horribly named, but they now mean that
> the internal mid-layer representation (a 32 bit int currently) is
> abstracted from the structure the drivers use on the wire so we should
> be free to increase it if necessary.

The "L" you need to represent at face value: 64 bits, no interpretations
of any kind, BE order.

Once you do that you need not worry about it, ever.

>  Note: you do actually need either
> an array with more than two levels of nesting actually to need the
> increase and no-one actually seems to have one of these yet.

What?

>>My major objection to Luben's SAS sysfs representation is
>>that "things" have to be discovered before the user space
>>can talk to them. Why?? An app in the user space might
>>_know_ that the "thing" (e.g. SAS expander or a "well
>>known" logical unit) is out there. Again the obvious comparison
>>is with IP addresses and the way the networking subsystem
>>functions. I would like to make HBA initiators (or their ports)
>>visible as interfaces (like eth0 and friends) through which
>>commands/frames/primitives can be sent and events received.
> 
> 
> This one, I actually agree with.  Most users have small domains which

Don't rush to agree.

Read my reply where I explain that SAS is _not_ Ethernet,
half way down:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112654911906868&w=2

> will be easily amenable to total enumeration.  The other issue is that

Enumeration is wrong!  I know you want to stick to Parallel SCSI,
but enumeration is wrong.

You do not know what the domain is or looks like at SCSI Core level,
and to impose enumeration is simply wrong.

You need not an "i" part at all to make SCSI Core work.  A pointer
to scsi_domain_device (yet to be created) is enough.

> if we go with a socket like approach where the user has to connect to
> the devices, then we lose hotplug ... a true network doesn't know or
> care when another PC is plugged into it.

And a SAS domain is not a _true_ network, although very similar.

Trust me, showing the domain in sysfs naturally, does _not_ hurt
anyone.

It is simply part of evolution: The storage transport layer owns
it and controls it, SCSI Core is unaware of it due to layering
set forth in SAM and SPC (SAS too).

I've posted references to the figures and text before:
- SAM4r02, Figure 2 to Figure 8 are very good -- a picture is worth
more than a 1000 words.
- SPC4r00, Figure 1 -- very descriptive.
- SAS1r09e, Figure 1, (Figure 2 for ATA),
  Figure 10 -- very descriptive in showing what SCSI Core should
  be (yellow part) and what transport layer should be (green part).

> For things like iscsi, we do have the compromise that discovery doesn't
> begin until the endpoint is known.
> 
> If we go like net and have the whole world as our potential but non-
> discovered domain, we have to begin addressing security issues that
> arise because of the parts of the domain that we don't control ... I'd
> much rather leave these sort of issues to the net people and begin with
> the a priori assumption that a scsi domain, although it might be bridged
> across the hostile network,

[SCSI domain]
> represents a fundamentally secure and
> discoverable system.

Yes, that's a good assumption to take.

	Luben

