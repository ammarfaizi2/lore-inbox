Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVIMMrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVIMMrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVIMMrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:47:25 -0400
Received: from zorg.st.net.au ([203.16.233.9]:53704 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932636AbVIMMrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:47:23 -0400
Message-ID: <4326CA76.6020504@torque.net>
Date: Tue, 13 Sep 2005 22:47:50 +1000
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
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <20050913102555.GB30865@infradead.org>
In-Reply-To: <20050913102555.GB30865@infradead.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Sep 12, 2005 at 04:17:48PM +1000, Douglas Gilbert wrote:
> 
>>FreeBSD threw out their original SCSI design and replaced it
>>with CAM circa 1998. CAM has its problems but I would guess
>>a modern SAS LLDD would have less "impedance mismatch" (sorry
>>about the gibberish) than what Luben is now facing.
> 
> 
> Their code doesn't scale well to current needs at all.  Please look
> at the freebsd-scsi list and all the problems they have with things
> like FC or iSCSI.  Or no support for REPORT_LUNs at all.  While I
> wouldn't say we have the best thing since slided bread it's certainly
> not as bad as some people would like to make it.
> 
> 
>>If we look at our (im)famous <h:c:i:l> addressing string,
>>the first 2 elements (i.e. "h:c") are about kernel device
>>addressing (i.e. which (part of a) HBA to be initiator); the
>>contentious "i" is about addressing the target and is
>>transport dependent, and the "l" is for addressing within
>>the target. Only the last element is true SCSI and is
>>defined in SAM (to be 64 bits, not 32). In iSCSI the "i"
>>is actually an adorned IP address.
>>
>>So the kernel "discovers" at the "h:c" level at powerup
>>(and at runtime with hotplug events); leaving the SCSI
>>subsystem to do discovery at the "i" and the "l" level.
> 
> 
> That's not true at all.  Neither is 100% mandatory in the

By "SCSI susbsystem" I refer to: all active ULDs, the
mid level, the active LLDs and associated parts of the
block subsystem. Given that, what is "not true at all"?

Strangely, James Bottomley replied to the same
line with: "Right, but we've already moved away ..."

> scsi level.  As Luben's code shows you can just call scsi_add_device
> and do everything yourself. 

I am proposing the minimalist option. That is, nothing in
the SCSI (kernel) subsystem (including the LLD) does discovery
at either the transport or the lu level. I'm not suggesting
that should be the default setting.

Can you remember when doing device discovery in the user
space was discussed on this list? I thought that people felt
that it was a worthwhile goal. To do it at least
the following is needed:
  1) a way to stop the SCSI subsystem doing it
  2) tools to allow the user space to do it, or,
     skip discovery, address the device directly

That way, if a user app wants to talk to a well know lu (or
whatever), it doesn't matter if the mid level or the LLD
in question decides that it is not a good idea to make it
visible. LLDs know about their transport but not what is
behind a target device, especially if it is a bridge.

Of course, an LLD could have a backdoor through to the user
space to accomplish this ...

> fit into SAM at all like integrated RAID HBAs.  Besides that we
> support a library function to do the "l" part that can be used by
> transport classes or drivers.  There's a library function to do
> the "i" part brute-force for SPI and modelled after SPI devices that
> is still in scsi_mod.ko but isn't integrated with the core code
> in any way.  Before 2.6 the predessor to this function
> "scsi_scan_host" was called for every registered host, but we
> fortunately got rid of that.

You seem to suggest that I am pining after something in the
past. You make the point that a one-fits-all discovery ("i"
and "l") in the mid level is not a good idea; better to
let the LLD do it (or have the option). I make the further
point that a user app might be even better placed.

Doug Gilbert

