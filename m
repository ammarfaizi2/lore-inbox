Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRB1DNC>; Tue, 27 Feb 2001 22:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130053AbRB1DMx>; Tue, 27 Feb 2001 22:12:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31217 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S129706AbRB1DMf>; Tue, 27 Feb 2001 22:12:35 -0500
Date: Tue, 27 Feb 2001 19:12:33 -0800
From: Brian Moyle <bmoyle@mvista.com>
Message-Id: <200102280312.TAA13404@bia.mvista.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac6 hangs on boot w/AMD Elan SC520 dev board
Cc: bmoyle@mvista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.2-ac6 hangs while booting an AMD Elan SC520 development board.

Long-story-short
================
If I define "STANDARD_MEMORY_BIOS_CALL" in setup.S and misc.c, it boots 
fine.  Here are the results:

memory map that hangs (added debugging to setup.S to determine E820 map):
   hand-copied physical RAM map:
    bios-e820: 000000000009f400 @ 0000000000000000 (usable)
    bios-e820: 0000000000000c00 @ 000000000009f400 (reserved)
    bios-e820: 0000000003f00000 @ 0000000000100000 (usable)
    bios-e820: 0000000003f00000 @ 0000000000100000 (usable)
    bios-e820: 0000000000100000 @ 00000000fff00000 (reserved)

memory map that works (#define STANDARD_MEMORY_BIOS_CALL in setup.S & misc.c):
   BIOS-provided physical RAM map:
    BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
    BIOS-88: 0000000003f00000 @ 0000000000100000 (usable)


Is this the result of a BIOS problem?


Long-story-long
===============
(when STANDARD_MEMORY_BIOS_CALL is not defined)

Booting from a floppy, I see the following message:

   "Uncompressing Linux... Ok, booting the kernel."

That's the last print statement I see.

Adding debug, it appears to go through the following:

   init/main.c:
      start_kernel {
         ...
         setup_arch(&command_line);
         ...
      }

   arch/i386/kernel/setup.c:
      setup_arch {
         ...
         for (i = 0; i < e820.nr_map; i++) {
            ...
            free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size)); ...
            ...
         }
         ...
      }

   mm/bootmem.c:
      free_bootmem{
         return(free_bootmem_core(contig_page_data.bdata, addr, size));
      }

   mm/bootmem.c:
      free_bootmem_core {
         ...
         for (i = sidx; i < eidx; i++) {
            ...
            if (!test_and_clear_bit(i, bdata->node_bootmem_map)) {
               BUG();
            }
         }
      }

   include/asm-i386/page.h:
      BUG {
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__);
         ...
      }

   (at this point, it appears to be in an infinite printk loop <?>)

I didn't spend much time looking into the printk loop, but it seems to 
end up there, even if CONFIG_DEBUG_BUGVERBOSE is not defined, as if the 
".byte 0x0f,0x0b" is causing the loop to begin.

Any ideas/suggestions/comments?

Brian
bmoyle@mvista.com

