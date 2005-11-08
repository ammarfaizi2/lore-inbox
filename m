Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVKHRLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVKHRLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKHRLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:11:09 -0500
Received: from dvhart.com ([64.146.134.43]:47300 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965237AbVKHRLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:11:06 -0500
Date: Tue, 08 Nov 2005 09:11:04 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: Panic on boot PPC64 / e1000 for 2.6.14-git10 & 2.6.14-mm1
Message-ID: <553380000.1131469864@[10.10.2.4]>
In-Reply-To: <1131397866.4652.50.camel@gaston>
References: <90760000.1131394594@flay> <20051107123919.3c226b80.akpm@osdl.org> <1131397866.4652.50.camel@gaston>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote (on Tuesday, November 08, 2005 08:11:06 +1100):

> On Mon, 2005-11-07 at 12:39 -0800, Andrew Morton wrote:
>> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
> e1000 did a config space access which caused a hash miss (probably when
> accessing the IO space) which blew up in the hashing
> (.hash_page_do_lazy_icache called from __hash_page_4K).
> 
> I think the bug is a mistake on my side:
> 
> .hash_page_do_lazy_icache() used to begin with:
> 
>         if (!pfn_valid(pte_pfn(pte)))
>                 return pp;
> 
> And that got lost. It needs to go back in. I'll send a patch later today
> (I'm at home without the necessary stuff at hand).

Seems to be fixed in -git11. Hopefully via something deliberate ;-)

Thanks,

M.

> Ben.
> 
> 
>> > Power 4 LPAR panics on boot. -git9 was fine.
>> > 
>> > Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
>> > Copyright (c) 1999-2005 Intel Corporation.
>> > Oops: Kernel access of bad area, sig: 11 [#1]
>> > SMP NR_CPUS=32 NUMA PSERIES LPAR 
>> > Modules linked in:
>> > NIP: C00000000002F4A4 LR: C00000000002F7C8 CTR: C00000000030FA08
>> > REGS: c00000003ffcb0d0 TRAP: 0300   Not tainted  (2.6.14-git10-autokern1)
>> > MSR: 8000000000001032 <ME,IR,DR>  CR: 48004088  XER: 20000000
>> > DAR: C00000078002EEC8, DSISR: 0000000040010000
>> > TASK = c00000077ffd07c0[1] 'swapper' THREAD: c00000003ffc8000 CPU: 1
>> > GPR00: C00000000002F7C8 C00000003FFCB350 C0000000006518C0 00000000000001BC 
>> > GPR04: 000000003FE48080 0000000000000300 C000000003DF4000 0000000000000300 
>> > GPR08: C0000000006578A8 C00000077FFEF080 C000000000657928 000000000003FE48 
>> > GPR12: C000000000650000 C000000000557800 0000000000000000 0000000000000000 
>> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> > GPR20: 0000000000230000 0000000003A10000 0000000000000060 0000000000000001 
>> > GPR24: 0000000000000400 C00000003FFB5000 C000000003DF2830 C000000003DF2000 
>> > GPR28: 0000000ADC7D4C2D 00000000000001BC 00007FC901000FB9 00007FC9010003B9 
>> > NIP [C00000000002F4A4] .hash_page_do_lazy_icache+0x3c/0x108
>> > LR [C00000000002F7C8] .__hash_page_4K+0x98/0xac
>> > Call Trace:
>> > [C00000003FFCB350] [C00000003FFCB540] 0xc00000003ffcb540 (unreliable)
>> > [C00000003FFCB3E0] [C00000000002F7C8] .__hash_page_4K+0x98/0xac
>> > [C00000003FFCB4E0] [C00000000002F444] .hash_page+0x158/0x17c
>> > [C00000003FFCB560] [C000000000004734] .do_hash_page+0x34/0x40
>> > --- Exception: 301 at .e1000_init_eeprom_params+0x40/0x314
>> >     LR = .e1000_probe+0x550/0x9f0
>> > [C00000003FFCB850] [C00000000028E078] .pci_bus_read_config_word+0x94/0xe0 (unreliable)
>> > [C00000003FFCB900] [C0000000004FC9A4] .e1000_probe+0x550/0x9f0
>> > [C00000003FFCB9D0] [C000000000291494] .pci_device_probe+0x11c/0x16c
>> > [C00000003FFCBA70] [C0000000002DEE50] .driver_probe_device+0x80/0x160
>> > [C00000003FFCBB00] [C0000000002DEFD8] .__driver_attach+0xa8/0xc4
>> > [C00000003FFCBB90] [C0000000002DE50C] .bus_for_each_dev+0x7c/0xd0
>> > [C00000003FFCBC40] [C0000000002DEC08] .driver_attach+0x28/0x40
>> > [C00000003FFCBCC0] [C0000000002DDCAC] .bus_add_driver+0xd4/0x1ec
>> > [C00000003FFCBD70] [C0000000002DF0D4] .driver_register+0x54/0x70
>> > [C00000003FFCBE00] [C000000000291054] .pci_register_driver+0x80/0xc4
>> > [C00000003FFCBE80] [C0000000004FC43C] .e1000_init_module+0x40/0x58
>> > [C00000003FFCBF00] [C000000000009584] .init+0x1e8/0x44c
>> > [C00000003FFCBF90] [C00000000000A358] .kernel_thread+0x4c/0x68
>> > Instruction dump:
>> > fb81ffe0 fba1ffe8 fbe1fff8 e902aef0 7c7d1b78 fbc1fff0 788ba302 f8010010 
>> > f821ff71 60000000 60000000 e92a0000 <7c0958ae> 78001f24 7d28002a 38000038 
>> >  <0>Kernel panic - not syncing: Attempted to kill init!
>> 
>> I'm going to need help understanding that trace.  Was the crash in
>> e1000_init_eeprom_params() or in hash_page_do_lazy_icache()?  The former, I
>> think?
>> 
>> git-netdev-all.patch touches e1000, but I don't see any substantial changes
>> in there.
> 
> 
> 


