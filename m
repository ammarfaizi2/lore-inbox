Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268758AbUHTUpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268758AbUHTUpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268763AbUHTUpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:45:19 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.68]:15792 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268737AbUHTUne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:43:34 -0400
Date: Fri, 20 Aug 2004 16:43:31 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
In-reply-to: <4126621B.3090701@optonline.net>
To: Nathan Bryant <nbryant@optonline.net>
Cc: stefandoesinger@gmx.at, acpi-devel@lists.sourceforge.net,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
Message-id: <41266273.1010604@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_VHQcvSeJne7dc570S2E+ug)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com>
 <41265443.9050800@optonline.net> <200408202201.54083.stefandoesinger@gmx.at>
 <4126621B.3090701@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_VHQcvSeJne7dc570S2E+ug)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT


Oops. Forgot the patch again. See attached.

Nathan Bryant wrote:

> Stefan Dösinger wrote:
>
>> If I re-programm the IRQ to something else than IRQ10, the device 
>> doesn't resume too. So it's not only a problem of IRQ 11.
>>  
>>
> Seems like an anything-at-all-other-than-IRQ-10 problem. If the 
> current thinking is right, your BIOS is assigning IRQ10 during boot, 
> so moving it anywhere else is what causes problems.
>
> But the current thinking doesn't quite seem right, because it seeems 
> like we're seeing these problems after the irqrouter is resumed. Can 
> you verify that with the attached patch? The patch should give us 
> enough information as long as you've got the proper kernel loglevel set.
>
> Now, I wonder if the only reason it works when you set IRQ 10 is that 
> some other driver is unconditionally claiming the interrupt...
>
> Nathan
>
>> The ipw2100 driver calls pci_disable_device in it's suspend handler. 
>> But I think the ipw2100 maintainers need help with suspend/resume 
>> because James Ketrenos can't test it on his own system.
>>  
>>
> pci_disable_device() only turns off bus-mastering, it doesn't unmap 
> the I/O or disable the slot. Maybe we also need to set power state D3 
> and do a device-specific disable-interrupts, but I think D0 gets 
> restored for us pretty early during resume anyway...
>
> Anyway, something doesn't quite add up...
>
> Nathan
>


--Boundary_(ID_VHQcvSeJne7dc570S2E+ug)
Content-type: text/x-patch; name=pci_linkdebug.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=pci_linkdebug.patch

===== drivers/acpi/pci_link.c 1.32 vs edited =====
--- 1.32/drivers/acpi/pci_link.c	2004-08-18 19:26:48 -04:00
+++ edited/drivers/acpi/pci_link.c	2004-08-20 16:28:40 -04:00
@@ -717,6 +717,8 @@
 
 	ACPI_FUNCTION_TRACE("irqrouter_resume");
 
+	printk(KERN_DEBUG "irqrouter_resume: called.\n");
+
 	list_for_each(node, &acpi_link.entries) {
 
 		link = list_entry(node, struct acpi_pci_link, node);

--Boundary_(ID_VHQcvSeJne7dc570S2E+ug)--
