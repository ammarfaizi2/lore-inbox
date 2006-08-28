Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWH1ONd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWH1ONd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWH1ONd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:13:33 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:27069 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750856AbWH1ONc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:13:32 -0400
Date: Mon, 28 Aug 2006 23:12:34 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>,
       keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       naveen.b.s@intel.com
In-Reply-To: <223978.1156683050640.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
References: <20060825205423.0778.Y-GOTO@jp.fujitsu.com> <223978.1156683050640.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20060828223538.F622.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am Fr 25.08.2006 13:59 schrieb Yasunori Goto <y-goto@jp.fujitsu.com>:
> >
> >>
> >> > I sent a patch a while ago that gets rid of the whole namespace
> >> > walking
> >> > by making acpi_memoryhotplug an acpi device and making use of the
> >> > .add
> >> > callback function and the acpi_bus_register_driver call.
> >> >
> >> > I am not sure whether this is possible if you have multiple memory
> >> > devices, though (if not maybe it should be made possible?)...
> >> >
> >> > Yasunori even tested the patch and sent an Ok:
> >> > http://marc.theaimsgroup.com/?t=114065312400001&r=1&w=2
> >> >
> >> > If this is acceptable I can rebase the patch on a current kernel.
> >>
> >> Hi. Thomas-san.
> >> Did you rebase your patch?
> >>
> >> I'm trying to do it now too.
> >> But, current code (2.6.18-rc4) seems to register handler for
> >> only enable status devices at boot time.
> >> So, notification is -discarded- due to no handler for new memory
> >> device when hot-add event occurs. Hmmm. :-(
> >No, what I see the notify handler is always installed.

Hmm.
Ok. Followings are current my understanding of sequence
with your patch.

At boot time, acpi_memory_device_init() is called.

acpi_memory_device_init()
   |
   +---> acpi_bus_register_driver()
           |
           +---> acpi_driver_attach()
                   |
                   +---> acpi_bus_driver_init()
                           |
                           +---> acpi_memory_device_add()
                                    |
                                    +---> acpi_install_notify_handler().


The problem is in acpi_driver_attach(). This function is using
"acpi_device_list" to call acpi_bus_driver_init().

This list is registered by acpi_device_register() which is called by
acpi_add_single_object().
However, acpi_add_single_object() skips calling it if _STA is not on.

1015         switch (type) {
1016         case ACPI_BUS_TYPE_PROCESSOR:
1017         case ACPI_BUS_TYPE_DEVICE:
1018                 result = acpi_bus_get_status(device);
1019                 if (ACPI_FAILURE(result) || !device->status.present) {
1020                         result = -ENOENT;
1021                         goto end;
1022                 }
1023                 break;

So, notify handler is registered just for memory device which is enable
at boot time.
If notify event occurs for new memory device, there is no notify handler
for it....

Old code registers handler for all of memory devices even if it is not
enabled.

If my understanding is wrong, please let me know. ;-)
Bye.

-- 
Yasunori Goto 


