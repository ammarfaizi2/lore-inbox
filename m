Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTLPWAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTLPWAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:00:40 -0500
Received: from fmr01.intel.com ([192.55.52.18]:18373 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263002AbTLPWAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:00:34 -0500
Message-ID: <3FDF8057.7050901@intel.com>
Date: Tue, 16 Dec 2003 23:59:51 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>  <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <3FDF3C6C.9030609@pobox.com>
In-Reply-To: <3FDF3C6C.9030609@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Vladimir Kondratiev wrote:
>
> Definitely looks a lot better, thanks.
>
> Still a few problems to consider...
>
>
>> diff -dur linux-2.4.23/arch/i386/config.in 
>> linux-2.4.23-pciexp/arch/i386/config.in
>> --- linux-2.4.23/arch/i386/config.in    2003-11-28 20:26:19.000000000 
>> +0200
>> +++ linux-2.4.23-pciexp/arch/i386/config.in    2003-12-16 
>> 11:18:46.000000000 +0200
>> @@ -292,6 +292,15 @@
>>        fi
>>        if [ "$CONFIG_PCI_GODIRECT" = "y" -o "$CONFIG_PCI_GOANY" = "y" 
>> ]; then
>>           define_bool CONFIG_PCI_DIRECT y
>> +         bool 'PCI-Express support' CONFIG_PCI_EXPRESS
>> +         if [ "$CONFIG_PCI_EXPRESS" = "y" ]; then
>> +            bool 'Enable PCI-E custom base address' 
>> CONFIG_PCIEXP_USE_CUSTOM_BASE
>> +            if [ "$CONFIG_PCIEXP_USE_CUSTOM_BASE" = "y" ]; then
>> +               hex 'PCI-Express base address' 
>> CONFIG_PCI_EXPRESS_BASE 0xe
>> +            else
>> +               define_hex CONFIG_PCI_EXPRESS_BASE 0xe
>> +            fi
>> +         fi
>>        fi
>>     fi
>>     bool 'ISA bus support' CONFIG_ISA
>
>
> This is OK for development...   But until (if ever?) there is a 
> standard way to detect PCI Express, I think it is better to maintain a 
> list of chipsets that support PCI Express.
>
> Users are really going to hate this, once the first chipset comes out 
> that uses a non-standard address.
>
Sure, it need to be replaced, or at least complemented, with real auto 
detection. If I only could provide this list...

>> +/**
>> + * I don't know how to detect it properly.
>> + * assume it is PCI-E, sanity_check will
>> + * stop me if it is not.
>> + * + * Also, this function supposed to set rrbar_phys
>> + */
>> +static int is_pcie_platform(void)
>> +{ return 1; }
>> +
>> +/**
>> + * Initializes PCI Express method for config space access.
>> + * + * There is no standard method to recognize presence of PCI 
>> Express,
>> + * thus we will assume it is PCI-E, and rely on sanity check to
>> + * deassert PCI-E presense. If PCI-E not present,
>> + * there is no physical RAM on RRBAR address, and we should read
>> + * something like 0xff.
>> + * + * @return 1 if OK, 0 if error
>> + */
>
>
> Well, I agree with the comment, but that's not what the code does.
>
> Where is your check for 0xff?
>
sanity_check do it for me.

> Further, is_pcie_platform() unconditionally returns 1... and is only 
> used once, in PCI-Ex-specific code.
>
See above, it is placeholder for real auto detection routine.

>
> Longer term, we want to provide some way to have the read/write 
> routines generic, but support arch-specific mapping methods, I would 
> think...
>
> 64-bit arches probably wouldn't need a spinlock at all for each 
> access, I bet, since it's just a single MMIO read or write.
>
Yes, separation into generic and platform specific part seems nice, but 
besides memory mapping and locking, all you have is
very simple arithmetic. Does it worth the work for separation?

For 64-bit world, agree, it could and should be done uniform.

>> +    switch (len) {
>> +    case 2:
>> +        if (reg & 1)
>> +            return -EINVAL;
>> +        break;
>> +    case 4:
>> +        if (reg & 3)
>> +            return -EINVAL;
>> +        break;
>> +    }
>
>
> I don't see that read and write should ever return an error.
>
> The above EINVAL conditions are a BUG().
>
Indeed, it may be better to BUG() here. I did not paid attention. By the 
way, for other access methods alignment is simply not verified. 
Probable, it is ensured by some other way and I can just remove this test?

>>
>> +    /* dummy read to flush PCI write */
>> +    readb(addr);
>
>
> This is going to choke some hardware, I guarantee.
>
> You always want to make sure your flush is of the same size at the 
> write.  Reading a byte from an address that the hardware defines as 
> "32-bit writes only" can get ugly real quick ;-)
>
Good point. s/readb(addr)/readl(addr & ~3)/

> Something I missed in the previous emails comments:
>
> The above seems wrong, to blindly assume PCI-Ex means PCI config space 
> will always be 4k.  What about downstream PCI bridges, and ancient 
> devices with only 256 bytes of config registers?
>
> It really seems like the config space size should be per-device or 
> per-bus.
>
Not this bad. For PCI devices after bridges, 4k also provided. 
Everything after 256 bytes is simply useless, but present. It reads as 0.

