Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUHSNza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUHSNza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUHSNza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:55:30 -0400
Received: from fmr06.intel.com ([134.134.136.7]:25550 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266170AbUHSNzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:55:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] Re: 2.6.8.1-mm1 hangs on boot with ACPI
Date: Thu, 19 Aug 2004 21:54:07 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F039A1A4E@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: 2.6.8.1-mm1 hangs on boot with ACPI
Thread-Index: AcSF6VsBlsLffhL0Rlqt0LYDu6g6JgAB6erg
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <eric.valette@free.fr>
Cc: "Brown, Len" <len.brown@intel.com>,
       "Pontus Fuchs" <pontus.fuchs@tactel.se>, "Greg KH" <greg@kroah.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 19 Aug 2004 13:54:09.0877 (UTC) FILETIME=[006B6850:01C485F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Eric Valette
>Sent: Thursday, August 19, 2004 8:36 PM
>To: Pontus Fuchs; greg@kroah.com
>Cc: Brown, Len; linux-kernel@vger.kernel.org; ACPI Developers
>Subject: Re: [ACPI] Re: 2.6.8.1-mm1 hangs on boot with ACPI
>
>Pontus Fuchs wrote:
>> On Thu, 2004-08-19 at 08:49, Len Brown wrote:
>>
>>>On Tue, 2004-08-17 at 04:55, Pontus Fuchs wrote:
>>>
>>>>Hi,
>>>>
>>>>After upgrading to 2.6.8.1-mm1 from plain 2.6.8.1 my machine does
not
>>>>boot anymore. The last message i see is:
>>>>
>>>>ACPI: Processor [CPU0] (supports C1,C2,C3, 8 throttling states)
>>>>
>>>>In plain 2.6.8.1 the next messages would be:
>>>>
>>>>ACPI: Thermal Zone [THRM] (52 C)
>>>>Console: switching to colour frame buffer device 175x65
>>>>Linux agpgart interface v0.100 (c) Dave Jones
>>>>agpgart: Detected SiS 648 chipset
>>>>
>>>>Booting with acpi=off works fine. I have also tried pci=routeirq but
>>>>it
>>>>does not make any difference.
>>>>
>>>>The machine is an Asus L5c laptop.
>>>
>>>Please try booting with "pci=routeirq"
>>>If that doesn't work, please take stock 2.6.8.1 and apply the latest
>>>patch here:
>>>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/relea
se/2
>.6.8/
>>>and give it a go.
>>>
>>>This will bring your kernel up to the same ACPI patch that is in the
-mm
>>>tree, but without all the other stuff in the mm tree.
>>>
>>>If it fails, then ACPI broke.  If it works, then something in -mm
broke
>>>ACPI.
>>
>>
>> Hi,
>>
>> I found this another Asus laptop with intel chipset which also has
>> problems with the latest ACPI code, and I tried the same trick on my
>> machine, and now the machine boots again!
>>
>> http://bugme.osdl.org/show_bug.cgi?id=3191
>>
>> I have no clue what I'm actually doing so please don't consider the
>> patch a fix for the problem, but rather a way do show how to make the
>> symptom go away.
>>
>> --- quirks.c.bak        2004-08-19 13:25:23.000000000 +0200
>> +++ quirks.c    2004-08-19 13:25:47.000000000 +0200
>> @@ -756,11 +756,13 @@
>>   */
>>  static void __init quirk_sis_96x_smbus(struct pci_dev *dev)
>>  {
>> +/*
>> 	u8 val = 0;
>> 	printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
>> 	pci_read_config_byte(dev, 0x77, &val);
>> 	pci_write_config_byte(dev, 0x77, val & ~0x10);
>> 	pci_read_config_byte(dev, 0x77, &val);
>> +*/
>>  }
>
>Well the problem is not really in the ACPI code, but rather in the PCI
>code that tries to inconditionnaly enable SMBus and thus PCI devices
>without _also_ honoring the firmware configured IO port regions for the
>devices it just enabled. Thus, when ACPI use the DTST to also map the
>same IO ports regions  that obviously assume the default firmware
value,
>ACPI fails.
>
>Current victimcs are :
>	- Asus L3C, L5C users,
>	- Probably any user of pci quirk.c code that enables the
SMbus...
>
>On the L3C at least, the code to enable the SMBus works perfectly, the
>firmware configured value for the IO region is coherent with what the
>DTST contains but the PCI code change PCI configuration space default
>value and thus breaks ACPI...
Eric,
Why this breaks ACPI? ACPI just try to reserve the IO port declared in
DSDT (ACPI itself doesn't use the io ports), but if the attempt failed,
it doesn't matter. Eric, why the code change the default IO ports in
SMBus? It seems just to enable it to me.

Thanks,
Shaohua
