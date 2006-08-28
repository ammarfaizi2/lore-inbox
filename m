Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWH1VRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWH1VRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWH1VRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:17:00 -0400
Received: from mx02.qsc.de ([213.148.130.14]:9681 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1750806AbWH1VQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:16:58 -0400
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot
	time from 2.6.18-rc4.
From: Thomas Renninger <mail@renninger.de>
Reply-To: mail@renninger.de
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Thomas Renninger <trenn@suse.de>, akpm@osdl.org,
       "Brown, Len" <len.brown@intel.com>, keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       naveen.b.s@intel.com
In-Reply-To: <20060828223538.F622.Y-GOTO@jp.fujitsu.com>
References: <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
	 <223978.1156683050640.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
	 <20060828223538.F622.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 23:16:58 +0200
Message-Id: <1156799818.12158.9.camel@linux-1vxn.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 23:12 +0900, Yasunori Goto wrote: 
> Hmm.
> Ok. Followings are current my understanding of sequence
> with your patch.
> 
> At boot time, acpi_memory_device_init() is called.
> 
> acpi_memory_device_init()
>    |
>    +---> acpi_bus_register_driver()
>            |
>            +---> acpi_driver_attach()
>                    |
>                    +---> acpi_bus_driver_init()
>                            |
>                            +---> acpi_memory_device_add()
>                                     |
>                                     +---> acpi_install_notify_handler().
> 
> 
> The problem is in acpi_driver_attach(). This function is using
> "acpi_device_list" to call acpi_bus_driver_init().
> 
> This list is registered by acpi_device_register() which is called by
> acpi_add_single_object().
> However, acpi_add_single_object() skips calling it if _STA is not on.
> 
> 1015         switch (type) {
> 1016         case ACPI_BUS_TYPE_PROCESSOR:
> 1017         case ACPI_BUS_TYPE_DEVICE:
> 1018                 result = acpi_bus_get_status(device);
> 1019                 if (ACPI_FAILURE(result) || !device->status.present) {
> 1020                         result = -ENOENT;
> 1021                         goto end;
> 1022                 }
> 1023                 break;
> 
> So, notify handler is registered just for memory device which is enable
> at boot time.
> If notify event occurs for new memory device, there is no notify handler
> for it....
> 
Ah, good point. That should also be the reason why a battery inserted
after module loading won't get noticed (I didn't try right now, but I
remember complains about that).
I wonder whether the "!device->status.present" condition can just be
deleted here or checking for device HIDs that potentially can be
ejected/inserted, not sure. Hopefully someone else could comment on that
one.

> Old code registers handler for all of memory devices even if it is not
> enabled.
Yeah, therefore the mem_device cannot be passed as callback data as it
might get generated in the notify handler func and all the additional
stuff is needed..., ouch.
> 
> If my understanding is wrong, please let me know. ;-)
It's me who is wrong, thanks a lot for checking!

> Memory device might not have _EJ0/_EJD, but parent device 
> (like one NUMA node) might be able to be ejectable.
> In this case, only the parent device has _EJ0/_EJD.
> So, one more check is necessary.

I feared something like that (should have add a comment...), as the EJ0
and _STA functions are only used on the device itself I thought checking
for them makes sense, but for a missing EJ0 func powering down the
device just fails and it should not be harmful.
So the only useful thing from my patch (as long as .add is only invoked
if device is present) is using the general acpi_bus_get_status() func. 
Hmm, it must be used if the _STA function on the memory device is also
missing and the parent _STA must be used then? Could make sense on a
machine where a whole node must be inserted/ejected? The
acpi_bus_get_status() function already contains the checking for the
parent's _STA function and uses this one if the device itself has none.

  Thomas

