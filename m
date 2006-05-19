Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWESW5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWESW5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWESW5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:57:51 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:14771 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751425AbWESW5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:57:50 -0400
Date: Fri, 19 May 2006 23:57:46 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Christian Kujau <evil@g-house.de>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
Message-ID: <20060519225746.GA11883@skynet.ie>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org> <20060519141032.23de6eee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060519141032.23de6eee.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Christian Kujau" <evil@g-house.de> wrote:
>>
>> [sorry for repost, local MTA problems here...]
>>
>> Hi list, Hi Andrew,
>>
>> I cannot boot 2.6.17-rc4-mm1 because my rootdisk is a scsi disk and upon
>> scsi-init (SYM53C8XX_2) I'm getting:
>>
>> May 19 15:39:55 prinz sym0: <895> rev 0x1 at pci 0000:02:09.0 irq 161
>> May 19 15:39:55 prinz sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
>> May 19 15:39:55 prinz sym0: SCSI BUS has been reset.
>> May 19 15:39:55 prinz scsi0 : sym-2.2.3
>> May 19 15:40:08 prinz 0:0:0:0: ABORT operation started.
>> May 19 15:40:13 prinz 0:0:0:0: ABORT operation timed-out.
>> May 19 15:40:13 prinz 0:0:0:0: DEVICE RESET operation started.
>> May 19 15:40:18 prinz 0:0:0:0: DEVICE RESET operation timed-out.
>> May 19 15:40:18 prinz 0:0:0:0: BUS RESET operation started.
>> May 19 15:40:23 prinz 0:0:0:0: BUS RESET operation timed-out.
>> May 19 15:40:23 prinz 0:0:0:0: HOST RESET operation started.
>> May 19 15:40:23 prinz sym0: SCSI BUS has been reset.
>> May 19 15:40:28 prinz 0:0:0:0: HOST RESET operation timed-out.
>> May 19 15:40:28 prinz 0:0:0:0: scsi: Device offlined - not ready after
>> error recovery
>> May 19 15:40:33 prinz 0:0:1:0: ABORT operation started.
>> May 19 15:40:38 prinz 0:0:1:0: ABORT operation timed-out.
>> May 19 15:40:38 prinz 0:0:1:0: DEVICE RESET operation started.
>> May 19 15:40:43 prinz 0:0:1:0: DEVICE RESET operation timed-out.
>> May 19 15:40:43 prinz 0:0:1:0: BUS RESET operation started.
>>
>> I have backed out drivers-scsi-use-array_size-macro.patch, but to no
>> avail. There are other scsi-related patches in the broken-out
>> mm-directory, any hint which one to try first? Sometimes they're dependent
>> on each other, so I find it not easy to just "patch -R" all "*scsi*.patch"
>> files.
>>
>> Please see http://www.nerdbynature.de/bits/2.6.17-rc4-mm1/  for a
>> netsconsole-dmesg for 2.6.17-rc4 (working fine) and a the -mm1.
>>
>> I've tried different .configs for -mm1, created with:
>>
>> - yes ''  | make oldconfig (config-2.6-mm.2.6.17-rc4-mm1.oldconfig_default)
>> - yes 'N' | make oldconfig (config-2.6-mm.2.6.17-rc4-mm1.oldconfig_no)
>> - make oldlconfig (interactive, config-2.6-mm.2.6.17-rc4-mm1.oldconfig_my)
>>
>
> Thanks for the report, and thanks for testing.  The full demsg output
> really helps.
>
>
> It goes pear-shaped very early:
>
> --- prinz64-nc.2.6.17-rc4.log	Fri May 19 13:56:34 2006
> +++ prinz64-nc.2.6.17-rc4-mm1.log	Fri May 19 13:56:58 2006
> @@ -12,20 +12,17 @@
> BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> DMI 2.2 present.
> +ACPI: Unable to map RSDT header
> +node 0 zone Normal missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
> +node 0 zone HighMem missaligned start pfn, enable UNALIGNED_ZONE_BOUNDRIES
>
>
> And from then on, ACPI is kaput.  So your interrupts are kaput, as is the
> disk controller.
>
> I had some of this happening too - it's due to some of the MM patches from
> Mel and/or Andy.

The warnings in this case is valid but I would think harmless.  ZONE_NORMAL
on x86_64 begins at MAX_DMA32_PFN on the 4GiB boundary which is MAX_ORDER
aligned. From the e820 map, I am guessing the machine has 1GiB of memory
so the normal and highmem zones are empty. Andy's latest patches should
catch that.

The places where I now expect to see zone alignment error messages is
where the lowest PFN in a node is not aligned so the zone appears to
start unaligned. As the node_mem_map is aligned to the MAX_ORDER
boundary, we will see the warning, but it'll be harmless again.

I am struggling to see how the alignment patches or
arch-independent-zone-sizing would clobber the mapping of the ACPI table :(

> I also managed to provoke "Too many memory regions,
> truncating" out of it.
>

"Too many memory regions, truncating" is of concern because memory will be 
effectively lost. Is this on x86_64 as well? If so, I need to submit a 
patch that sets CONFIG_MAX_ACTIVE_REGIONS to 128 on x86_64 which is the 
same value of E820MAX. This is similar to what PPC64 does for LMB regions 
(see MAX_ACTIVE_REGIONS in arch/powerpc/Kconfig for example). If it's not 
x86_64, what arch does it occur on?

> I hope that's all sorted out now.  Please test next -mm (hopefully
> tomorrow) and let us know?
>
> Or, if you're super-keen,
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 is my current rollup
> (against 2.6.17-rc4).  It was compilable this morning, but I've since
> merged stuff ;) It would be interesting to know if that has fixed the bug.
>
