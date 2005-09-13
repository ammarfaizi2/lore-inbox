Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbVIMO65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbVIMO65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVIMO64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:58:56 -0400
Received: from magic.adaptec.com ([216.52.22.17]:22452 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932657AbVIMO6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:58:55 -0400
Message-ID: <4326E927.3010000@adaptec.com>
Date: Tue, 13 Sep 2005 10:58:47 -0400
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
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <20050913102555.GB30865@infradead.org> <4326CA76.6020504@torque.net>
In-Reply-To: <4326CA76.6020504@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 14:58:53.0407 (UTC) FILETIME=[A8498EF0:01C5B873]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 08:47, Douglas Gilbert wrote:
> Christoph Hellwig wrote:
>>>So the kernel "discovers" at the "h:c" level at powerup
>>>(and at runtime with hotplug events); leaving the SCSI
>>>subsystem to do discovery at the "i" and the "l" level.
>>
>>
>>That's not true at all.  Neither is 100% mandatory in the
> 
> 
> By "SCSI susbsystem" I refer to: all active ULDs, the
> mid level, the active LLDs and associated parts of the
> block subsystem. Given that, what is "not true at all"?

The kernel discovers at "h" level, which is purely
kernel implementation dependent.  I.e. how the kernel
enumerates Storage Controllers is kernel dependent.

The _transport layer_ discovers at "c" level.  What it
discovers is "i".  _How_ it discovers is transport
dependent: iSCSI, FC, SAS, IEEE 1394, USB, etc.

"i:l" is what SCSI Core is concerned about.  Currently,
CSI Core has no concept of "i" only, to save its life.

"c" in SCSI Core is ugly, as it is different per
transport protocol.  SAM calls it "SCSI domain" which
unifies it across transport protocols.

"i", is also ugly as it is SPI centric only
and LLDD have to invent it.

"l", in the kernel is chopped to 32 bits _and_ it is
interpreted/emaciated.
 
> Strangely, James Bottomley replied to the same
> line with: "Right, but we've already moved away ..."
> 
> 
>>scsi level.  As Luben's code shows you can just call scsi_add_device
>>and do everything yourself. 
> 
> 
> I am proposing the minimalist option. That is, nothing in
> the SCSI (kernel) subsystem (including the LLD) does discovery
> at either the transport or the lu level. I'm not suggesting
> that should be the default setting.
> 
> Can you remember when doing device discovery in the user
> space was discussed on this list? I thought that people felt
> that it was a worthwhile goal. To do it at least
> the following is needed:
>   1) a way to stop the SCSI subsystem doing it
>   2) tools to allow the user space to do it, or,
>      skip discovery, address the device directly

A SAS Domain is _not_ Ethernet.  Unless you get the domain
information from another initiator, you cannot just
"address the device directly".

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

> That way, if a user app wants to talk to a well know lu (or
> whatever), it doesn't matter if the mid level or the LLD
> in question decides that it is not a good idea to make it
> visible.

Yes, true, but why would they hide it in the first place.

> LLDs know about their transport but not what is
> behind a target device, especially if it is a bridge.

True, but your _boot_ device could be behind that bridge.

> Of course, an LLD could have a backdoor through to the user
> space to accomplish this ...
> 

Of course, naturally. :-)

>>fit into SAM at all like integrated RAID HBAs.  Besides that we
>>support a library function to do the "l" part that can be used by
>>transport classes or drivers.  There's a library function to do
>>the "i" part brute-force for SPI and modelled after SPI devices that
>>is still in scsi_mod.ko but isn't integrated with the core code
>>in any way.  Before 2.6 the predessor to this function
>>"scsi_scan_host" was called for every registered host, but we
>>fortunately got rid of that.
> 
> 
> You seem to suggest that I am pining after something in the
> past. You make the point that a one-fits-all discovery ("i"
> and "l") in the mid level is not a good idea; better to
> let the LLD do it (or have the option). I make the further
> point that a user app might be even better placed.

I think his point is that a LLDD may decide to export the actual
LUs, "i:l" it found hiding the transport (Message Passing Technology).
Or a transport may export the "SCSI Domain Device with Target Port",
"i", as is done in the Open Transport of the recently posted SAS
Layer.

Either way, according to SAM, both is fine: SCSI Core can have
entrances for both (new architecture, no HCIL of any kind):
Case 1:
	scsi_register_domain_device(ddev, no_scan=1);
	scsi_register_lu(ddev, u8 LUN[8]);
Case 2:
	scsi_register_domain_device(ddev, no_scan=0);

Respectively.

	Luben




