Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWH2ByM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWH2ByM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWH2ByM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:54:12 -0400
Received: from mother.pmc-sierra.com ([216.241.224.12]:30168 "HELO
	mother.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1750966AbWH2ByK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:54:10 -0400
Message-ID: <478F19F21671F04298A2116393EEC3D5540A32@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
       Radjendirane Codandaramane 
	<Radjendirane_Codandaramane@pmc-sierra.com>,
       Ronald Lee <Ronald_Lee@pmc-sierra.com>,
       Shawn Jin <Shawn_Jin@pmc-sierra.com>
Subject: PPC 2.6.11.4 kernel panics while doing insmod (store fault with d
	cbst in icache_flush_range)
Date: Mon, 28 Aug 2006 18:53:58 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting an "oops" while doing insmod.

Sys_init_module() -> Load_module() -> module_alloc(mod->core_size)

Mod->core_size is = 0x1ff4

A few lines from module_alloc() routine:

ptr = module_alloc(mod->core_size); // core_size is 0x1ff4
        if (!ptr) {
                err = -ENOMEM;
                goto free_percpu;
        }
  memset(ptr, 0, mod->core_size);
  mod->module_core = ptr;

Module_alloc calls vmalloc, which populates the page tables entries; no TLB entry is updated at this moment for the newly vmalloc'd memory.

Next, when memset is done, we do see two TLB entries are allocated one for each page (ptr == D21B8000, core_size being 0x1ff4 we need two pages).

0x0000-0000
0xD21B-8210
0x0063-B000
0x0000-0107

0x0000-0000
0xD21B-9210
0x0063-7000
0x0000-0107

A few lines from sys_init_module()
  /* Do all the hard work */
        mod = load_module(umod, len, uargs);
        if (IS_ERR(mod)) {
                up(&module_mutex);
                return PTR_ERR(mod);
        }

        /* Flush the instruction cache, since we've played with text */
        if (mod->module_init)
                flush_icache_range((unsigned long)mod->module_init,
                                   (unsigned long)mod->module_init
                                   + mod->init_size);
        flush_icache_range((unsigned long)mod->module_core,
                           (unsigned long)mod->module_core + mod->core_size);

Next, at the routine          

flush_icache_range((unsigned long)mod->module_core,
                       (unsigned long)mod->module_core + mod->core_size);

we see that one of the TLB entries is not present, which is probably normal.

A few lines from flush_icache_range():

        mr      r6,r3
1:      dcbst   0,r3
        addi    r3,r3,L1_CACHE_LINE_SIZE
        bdnz    1b

The instruction takes a store fault (DST bit, bit 8 of ESR gets set), kernel panics with oops (signal 11).

It is probably normal that the TLB entry for vmalloc'd memory may not be present.

How do we fix the problem?

We do see the problem only when we have big drivers compiled into the kernel.

Thanks,
Kallol



