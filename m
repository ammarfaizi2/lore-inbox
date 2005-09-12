Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVILSSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVILSSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVILSSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:18:04 -0400
Received: from magic.adaptec.com ([216.52.22.17]:39388 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750850AbVILSSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:18:03 -0400
Message-ID: <4325C653.2020905@adaptec.com>
Date: Mon, 12 Sep 2005 14:17:55 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>
In-Reply-To: <43251D8C.7020409@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 18:18:01.0336 (UTC) FILETIME=[4F651780:01C5B7C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 02:17, Douglas Gilbert wrote:
> Christoph Hellwig wrote:
> 
>>On Fri, Sep 09, 2005 at 07:44:54PM -0700, Luben Tuikov wrote:
>> * Discover logical units present in the SCSI device.  I'd like this
>> * to be moved to SCSI Core, but SCSI Core has no concept of a "SCSI
>> * device with a SCSI Target port".  A SCSI device with a SCSI Target
>> * port is a device which the _transport_ found, but other than that,
>> * the transport has little or _no_ knowledge about the device.
>> * Ideally, a LLDD would register a "SCSI device with a SCSI Target
>> * port" with SCSI Core and then SCSI Core would do LU discovery of
>> * that device.
>>
>>So what does this mean except "Luben tries to impress everyone with
>>standards gibberish, at the same time ignoring we soluitions that
>>work despite maybe not 100% elegant".
> 
> 
> Christoph,
> How about we put that another way. Luben (like yourself)
> gets to implement a LLDD for a new SCSI transport technology
> called SAS. He looks at its architecture and how it conforms
> (well not 100 %) to SAM and then he looks at the architecture
> of the kernel environment he has to fit it into.

Doug, you forgot to mention:

Luben is working with the hardware engineers who make
SAS happen.  Luben is working with the firmware engineers
which make SAS happen.  Luben is asking a lot of questions.
Luben is asking a lot of questions.  Luben is asing a lot
of questions.

Luben spends many contiguous days reading specs, open
and/or confidential of many companies implementing you-name-it
SAS device, expanders, etc.  Then he rereads them.  Then he
rereads them again.  Then he rereads them again, underlining
and highlighting things of interest.

Eventually his family gets angry at him that he's not paying
any attention to them, falling asleep with a tattered binder
full of specs on his chest, and waking up next to it.

> The latter uses terms and addressing structures appropriate
> to SCSI-2 (circa 1992). Each time a new transport (or a
> revision of SPI) comes along a larger hammer is needed to
> belt the new transport LLDDs into place.
> 
> FreeBSD threw out their original SCSI design and replaced it
> with CAM circa 1998. CAM has its problems but I would guess
> a modern SAS LLDD would have less "impedance mismatch" (sorry
> about the gibberish) than what Luben is now facing.

Just to add:

Also, the newer the transport (e.g. SAS) the closer it adheres
to SAM and SPC.

You can see this in the evolution of transports for the last
5 years, say starting with iSCSI.

Thus the more sense it makes for a LLDD to implement the
mere basics: Execute Command SCSI RPC and TMFs.

>>Sure, we'd like to move away from needing the ->id target id specifier.
>>But right now we need it, even you're code sets it in over-complicated
>>ways.  But if you send a nice patch to get rid everyone will be happy.
> 
> 
> If we look at our (im)famous <h:c:i:l> addressing string,
> the first 2 elements (i.e. "h:c") are about kernel device
> addressing (i.e. which (part of a) HBA to be initiator); the
> contentious "i" is about addressing the target and is
> transport dependent, and the "l" is for addressing within
> the target. Only the last element is true SCSI and is
> defined in SAM (to be 64 bits, not 32). In iSCSI the "i"
> is actually an adorned IP address.
> 
> So the kernel "discovers" at the "h:c" level at powerup
> (and at runtime with hotplug events); leaving the SCSI
> subsystem to do discovery at the "i" and the "l" level.

Just to add:

The kernel discovers at "h" level, which is purely
kernel implementation dependent.  I.e. how the kernel
enumerates Storage Controllers is kernel dependent.

The transport layer discovers at "c" level.  What it
discovers is "i".  _How_ it discovers is transport
dependent: iSCSI, FC, SAS, IEEE 1394, USB, etc.

"i:l" is what SCSI Core is concerned about.  SCSI Core
has no concept of "i" only, to save its life.

"c" is ugly and abhorable, as it is different per transport
protocol.  SAM calls it "SCSI domain" which unifies it
across transport protocols.

"i", is also ugly and abhorable as it is SPI centric only
and LLDD have to invent it.

"l", in the kernel is chopped to 32 bits _and_ it is
interpreted.  Both wrong.

> At this point I would like to make an observation: there
> is no absolute requirement for the SCSI subsystem to do
> discovery at either the "i" or the "l" levels. Using SAS
> as an example, only the SAS (target port) address and
> a logical unit number (identifier) or name are needed.

... to send tasks to the device.

> So an embedded system which includes a SAS initiator (HBA)
> could connect to an arbitrary device quickly and with
> minimal impact on a large SAS fabric (i.e. no SAS target
> discovery phase). As an extreme example, target discovery

Link layer is implemented in firmware, so you'll at least have
to say, to the firmware "I'd like to talk to device with
such and such SAS address, such and such port, and such
and such command set".  Then everything is cool.

One normally knows these things, if you know the SAS
port identifier and the LUN.

> in iSCSI cannot involve the whole internet (and even though
> its topology would be interesting, representing it in sysfs
> is absurd).

True, but then again, the _storage_ domain of iSCSI isn't
as interesting as SAS.  In iSCSI it would be really
straightforward to represent the domain in sysfs.

> My major objection to Luben's SAS sysfs representation is
> that "things" have to be discovered before the user space
> can talk to them. Why?? An app in the user space might

Yes, I'm aware of your concern.

But as I'm sure you're also well aware:
Any initiator has to do 
	* domain discovery *or*
	* inherit the domain
discovered by another initiator, in order to access
any device on the domain. (Cont'd below)

> _know_ that the "thing" (e.g. SAS expander or a "well
> known" logical unit) is out there. Again the obvious comparison
> is with IP addresses and the way the networking subsystem
> functions. I would like to make HBA initiators (or their ports)
> visible as interfaces (like eth0 and friends) through which
> commands/frames/primitives can be sent and events received.

Oh, no, no, no!

SAS is _not_ Ethernet and will _never_ be.

The reason is that Ethernet is *coherent* even when no one
is attached to it (thought exercise :-) ).

*But* a SAS domain is *not coherent* when no one has ever
attached to it, _unless_ expanders are self-configuring.

The general move is that expanders will _not_ self-configure,
although most of them are capable of doing this.

It is best to leave configuration to an (authorised) initiator.

Only SAS Target device can adhere to what you're saying
above, since they _reply_ to a connection.

Initiators _have_to_ have either discovered the domain, and
thus configured it (expanders), *or* inherited the domain
configuration from somewhere else.

> Traditionally, directly attached storage devices have been
> represented as device nodes in Unix/linux (e.g. /dev/hda and
> /dev/sda). Other subsystems require this. However, I suggest
> the following do _not_ need to be represented by device
> nodes or sysfs:
>   - a transport topology
>   - transport management devices (e.g. SAS expanders)
>   - SCSI management devices (e.g. "well known" logical units, SES
>     and bridge devices)

Except for the "or" you're correct.

There is _nothing_ wrong in representing the SAS domain as I've
done in the SAS Class Layer code.

Simply tack a kobject/kset to each object I'm _already_anyway_
representing internally and register it with sysfs.  Voila!

This achieves two things:
	* represents the domain as it is in the _physical_ world, and
	* does kref naturally as you'd expect the electrical signals
	to flow through.

What you mean to say is: _outside_ of the _storage_transport_
infrastructure!

"by device nodes" -- this is the keypoint in
your statement.  I cannot stress this enough:

	* Transport topology
	* Transport management devices
	* SCSI Management devices

should NOT be represented by, and here is the keypoint,
"device nodes".

Those are _storage_ entities, managed by the respective
transport layer.  They do not exist or have any meaning
outside the transport layer they are being used!

There is nothing wrong in showing the SAS domain as is
done in the SAS Class Layer -- there will be GUI applications
which will take advantage of this to control storage clusters,
and send SMP requests to expanders -- people want this.

	Luben


