Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVILGRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVILGRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 02:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVILGRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 02:17:33 -0400
Received: from zorg.st.net.au ([203.16.233.9]:61642 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751154AbVILGRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 02:17:32 -0400
Message-ID: <43251D8C.7020409@torque.net>
Date: Mon, 12 Sep 2005 16:17:48 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org>
In-Reply-To: <20050911094656.GC5429@infradead.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Sep 09, 2005 at 07:44:54PM -0700, Luben Tuikov wrote:
> 
>>>this one completely duplicates the
>>>mid-layer infrastructure for handling devices with Logical Units.
>>
>>No, it does *not*.  James, you have _stop_ spreading FUD, relying
>>that other people have not read the SCSI Core code.
>>
>>See here:
>>    SCSI Core has *no representation* of a SCSI Device with a
>>SCSI Target Port.
> 
> 
> struct scsi_target
> 
> 
>>I've _clearly_ outlined that in the comments of the code,
>>which you _conveniently_ did _not_ cut and paste here.
> 
> 
>  * Discover logical units present in the SCSI device.  I'd like this
>  * to be moved to SCSI Core, but SCSI Core has no concept of a "SCSI
>  * device with a SCSI Target port".  A SCSI device with a SCSI Target
>  * port is a device which the _transport_ found, but other than that,
>  * the transport has little or _no_ knowledge about the device.
>  * Ideally, a LLDD would register a "SCSI device with a SCSI Target
>  * port" with SCSI Core and then SCSI Core would do LU discovery of
>  * that device.
> 
> So what does this mean except "Luben tries to impress everyone with
> standards gibberish, at the same time ignoring we soluitions that
> work despite maybe not 100% elegant".

Christoph,
How about we put that another way. Luben (like yourself)
gets to implement a LLDD for a new SCSI transport technology
called SAS. He looks at its architecture and how it conforms
(well not 100 %) to SAM and then he looks at the architecture
of the kernel environment he has to fit it into.

The latter uses terms and addressing structures appropriate
to SCSI-2 (circa 1992). Each time a new transport (or a
revision of SPI) comes along a larger hammer is needed to
belt the new transport LLDDs into place.

FreeBSD threw out their original SCSI design and replaced it
with CAM circa 1998. CAM has its problems but I would guess
a modern SAS LLDD would have less "impedance mismatch" (sorry
about the gibberish) than what Luben is now facing.

> Sure, we'd like to move away from needing the ->id target id specifier.
> But right now we need it, even you're code sets it in over-complicated
> ways.  But if you send a nice patch to get rid everyone will be happy.

If we look at our (im)famous <h:c:i:l> addressing string,
the first 2 elements (i.e. "h:c") are about kernel device
addressing (i.e. which (part of a) HBA to be initiator); the
contentious "i" is about addressing the target and is
transport dependent, and the "l" is for addressing within
the target. Only the last element is true SCSI and is
defined in SAM (to be 64 bits, not 32). In iSCSI the "i"
is actually an adorned IP address.

So the kernel "discovers" at the "h:c" level at powerup
(and at runtime with hotplug events); leaving the SCSI
subsystem to do discovery at the "i" and the "l" level.

At this point I would like to make an observation: there
is no absolute requirement for the SCSI subsystem to do
discovery at either the "i" or the "l" levels. Using SAS
as an example, only the SAS (target port) address and
a logical unit number (identifier) or name are needed.
So an embedded system which includes a SAS initiator (HBA)
could connect to an arbitrary device quickly and with
minimal impact on a large SAS fabric (i.e. no SAS target
discovery phase). As an extreme example, target discovery
in iSCSI cannot involve the whole internet (and even though
its topology would be interesting, representing it in sysfs
is absurd).

My major objection to Luben's SAS sysfs representation is
that "things" have to be discovered before the user space
can talk to them. Why?? An app in the user space might
_know_ that the "thing" (e.g. SAS expander or a "well
known" logical unit) is out there. Again the obvious comparison
is with IP addresses and the way the networking subsystem
functions. I would like to make HBA initiators (or their ports)
visible as interfaces (like eth0 and friends) through which
commands/frames/primitives can be sent and events received.

Traditionally, directly attached storage devices have been
represented as device nodes in Unix/linux (e.g. /dev/hda and
/dev/sda). Other subsystems require this. However, I suggest
the following do _not_ need to be represented by device
nodes or sysfs:
  - a transport topology
  - transport management devices (e.g. SAS expanders)
  - SCSI management devices (e.g. "well known" logical units, SES
    and bridge devices)


Ducking for cover
Doug Gilbert

