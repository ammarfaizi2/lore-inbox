Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVKGFsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVKGFsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 00:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVKGFsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 00:48:37 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:49167 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S964782AbVKGFsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 00:48:36 -0500
Message-ID: <436EEADC.3010908@snapgear.com>
Date: Mon, 07 Nov 2005 15:49:16 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.6.14-uc0 (MMU-less support)
References: <40564dc5fa508b27c752b692f93562f4@bga.com>
In-Reply-To: <40564dc5fa508b27c752b692f93562f4@bga.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milton,

Milton Miller wrote:
> On Tue Nov 01 2005 - 23:01:02 EST, Greg Ungerer wrote:
>>  An update of the uClinux (MMU-less) fixups against 2.6.14.
>>
>>  Some new platform support, for the 5207/5208 ColdFire parts.
>>  A few bug fixes and some other minor cleanups.
>>
>> http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.14- 
>> uc0.patch.gz
> 
> 
> Hi Greg.
> 
> I'm not a user but thought I would give it a once over to see what you  
> were carrying.
> 
> 
>>  /*
>> + *    The Freescale 5208EVB board has 32MB of RAM.
>> + */
>> +#if defined(CONFIG_M5208EVB)
>> +#define    RAM_START    0x40020000
>> +#define    RAM_LENGTH    0x01e00000
>> +#endif
>> +
>> +/*
> 
> 
> That doesn't quite add up to 32MB.  Should that be 0x1FE0000 or
> is the last 0x1E0000 (1920k) supposed to be reserved too?  Again,
> I am not a user.

Yeah, your right, that should be 0x1fe0000. Looks like a yank bug.


>> diff -Naur linux-2.6.14/drivers/net/Kconfig  
>> linux-2.6.14-uc0/drivers/net/Kconfig
>> --- linux-2.6.14/drivers/net/Kconfig    2005-10-31 15:39:46.000000000  
>> +1000
>> +++ linux-2.6.14-uc0/drivers/net/Kconfig    2005-10-31 
>> 15:41:58.000000000  +1000
>> @@ -730,7 +730,7 @@
>>
>>  config NET_VENDOR_SMC
>>      bool "Western Digital/SMC cards"
>> -    depends on NET_ETHERNET && (ISA || MCA || EISA || MAC)
>> +    depends on NET_ETHERNET && (ISA || MCA || EISA || MAC || EMBEDDED)
>>      help
>>        If you have a network (Ethernet) card belonging to this class, 
>> say  Y
>>        and read the Ethernet-HOWTO, available from
>> @@ -820,7 +820,7 @@
>>
>>  config SMC9194
>>      tristate "SMC 9194 support"
>> -    depends on NET_VENDOR_SMC && (ISA || MAC && BROKEN)
>> +    depends on NET_VENDOR_SMC && (ISA || MAC && BROKEN || EMBEDDED)
>>      select CRC32
>>      ---help---
>>        This is support for the SMC9xxx based Ethernet cards. Choose this
>> @@ -1059,7 +1059,7 @@
>>
>>  config NE2000
>>      tristate "NE2000/NE1000 support"
>> -    depends on NET_ISA || (Q40 && m) || M32R
>> +    depends on NET_ISA || (Q40 && m) || M32R || EMBEDDED
>>      select CRC32
>>      ---help---
>>        If you have a network (Ethernet) card of this type, say Y and read
>> @@ -1190,7 +1190,7 @@
>>
>>  config NET_PCI
>>      bool "EISA, VLB, PCI and on board controllers"
>> -    depends on NET_ETHERNET && (ISA || EISA || PCI)
>> +    depends on NET_ETHERNET && (ISA || EISA || PCI || EMBEDDED)
>>      help
>>        This is another class of network cards which attach directly to 
>> the
>>        bus. If you have one of those, say Y and read the Ethernet-HOWTO,
>>
> 
> Lots of people turn on EMBEDDED for lots of reasons, asking about
> a lot more drivers seems burdensome.
> 
> Care to create a single intermediate Kconfig var for those?
> Something like "Controllers attached directly to a cpu?"

Yes indeed, this is a mis-use of CONFIG_EMBEDDED.

I would be happy to see another config option for another
more generic bus type. There is a whole bunch of peripherals
that are attached to directly (or at least to some other
fixed) bus type - not just network adapters.

I can see that some will argue that these are ISA bus
peripherals, therefore CONFIG_ISA should be enabled.
Maybe. But in this type of deeply embedded hardware it is
not hooked up to an ISA bus in the normal sense. Typically
there is some dedicated logic to massage the signals just
enough for the periperal device to work.


>> +config CS89x0_SWAPPED
>> +    bool "Hardware swapped CS89x0"
>> +    depends on CS89x0 && !NET_PCI && !ISA
>> +    ---help---
>> +      Say Y if your CS89x0 data bus is swapped.
>> +      This option is for single board computers using a CS89x0 chip. 
>> If  you
>> +      are using a regular Ethernet card, say N.
>> +
>>
> 
> This would then depend on your directly attached config and you
> could have both it and pci configured.
> 
>>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>> -CFLAGS        += -Os
>> +CFLAGS        += -O
>>  else
>>  CFLAGS        += -O2
>>  endif
> 
> 
> Sees this undoes part of the benefit, perhaps you should add a
> third option.

This is a bug workaround for some versions of gcc (arm targeted) that
produced huge stack consumption on some codes. I recall some crypto
functions where the problem. I could dig around and find out more
about the extac versions, etc, if interrested...

This one crept in here, and doesn't belong here at all.

Thanks
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
