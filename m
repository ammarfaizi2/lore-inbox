Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBHBP3>; Wed, 7 Feb 2001 20:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130021AbRBHBPJ>; Wed, 7 Feb 2001 20:15:09 -0500
Received: from h179-210-243-135.iii.org.tw ([210.243.135.179]:43477 "EHLO
	mta0.iii.org.tw") by vger.kernel.org with ESMTP id <S129026AbRBHBO5>;
	Wed, 7 Feb 2001 20:14:57 -0500
Message-ID: <009b01c0916b$55b61b60$4c0c5c8c@trd.iii.org.tw>
From: "Greeen-III" <greeen@iii.org.tw>
To: <linux-mips-request@fnet.fr>,
        "LinuxKernelMailList" <linux-kernel@vger.kernel.org>,
        "LinuxEmbeddedMailList" <linux-embedded@waste.org>
Subject: Memory Setting with prom_meminit() in memory.c.....
Date: Thu, 8 Feb 2001 09:06:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

The board I used has two pieces of RAM.  The virtual address start at 0x0000
0000 and
0x0200 0000. One is 4 MB(0x0000 0000) and the other is 16 MB(0x0200 0000).
But
orginal file is writted as the following. How could I modify this file to
match my
target board?


Green
----------------------------------------------------------------------------
------------
/*
 * memory.c: memory initialisation code.
 *
 * Copyright (C) Harald Koerfgen
 * Copyright (C) Jim Pick
 * Copyright (C) Pavel Machek
 *
 * $Id: memory.c,v 1.16 2000/07/09 03:36:18 nop Exp $
 */
#include <asm/addrspace.h>
#include <asm/r39xx.h>
#include <asm/bootinfo.h>
#include <asm/page.h>
#include <linux/init.h>
#include <linux/config.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/bootmem.h>

/* 應該不是用vitec_helio，所以會跑other ---->This line is Chinese(Big5) */
/* We don't use VTECH_HELIO. So the CONFIG_VTECH_HELIO is not defined */

#ifdef CONFIG_VTECH_HELIO
#define PROM_DEBUG
#endif

#ifdef PROM_DEBUG
extern int prom_printf(char * fmt, ...);
#endif

#ifndef CONFIG_VTECH_HELIO
int main_memory = CONFIG_MAIN_MEMORY; /* We should autoconfigure this. For
now, just let the user select. */
int exp_memory = CONFIG_EXP_MEMORY;
#define MEGA (1024*1024)
#endif

extern char _end;
extern char _fdata;

#define PFN_UP(x) (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
#define PFN_DOWN(x) ((x) >> PAGE_SHIFT)
#define PFN_ALIGN(x) (((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)

/* Modyfied by Green  2001/02/07  */
/* This function show the message through COM port */
#ifdef JAODEBUG
extern int Jprom_printf(const char * fmt, ...);
#else
#define Jprom_printf(fmt, a...)
#endif
/* End of modification*/



#ifdef CONFIG_VTECH_HELIO  /* We didn't go here insteal of
prom_meminit_other() */
static void __init prom_meminit_helio(void)
{
.....
.....
}

#else  /* CONFIG_VTECH_HELIO */

static void __init prom_meminit_other(void)
{
 extern unsigned long videomemory;
 unsigned long free_start;
 unsigned long free_end;
 unsigned long start_pfn;
 unsigned long bootmap_size;
 unsigned long ramspace;

 static char vidmem[(320 * 240 / 2) + PAGE_SIZE - 1];

 /* Okay the Helio has an odd memory layout, split into 4 banks of 2M
  * at the following places:
  *
  * 0x00000000
  * 0x00400000
  * 0x02000000
  * 0x02400000 (add 0x80000000 for virtual address)
  *
  * We allocate the bootmem as a continuous bank and then free up the
  * relevant memory holes.  Of these the kernel will be using some
  * of the first bank so be careful how we deal with it.
  */
    Jprom_printf("prom_meminit_other------------>Beginning\n");

    videomemory = KSEG0ADDR(PFN_ALIGN(vidmem));
    start_pfn = PFN_UP((unsigned long)&_end);
/*_end=801abba0---->0x000801ac*/
    free_start = PHYSADDR(PFN_ALIGN(&_end));

#ifdef CONFIG_VTECH_HELIO_EMULATOR
        /* What's worse, the emulator implements two 4M banks at
         * 0x0000 and 0x0200.  Fixing soon, but until then:
         */
 ramspace = 0x02400000; /* With holes!! */
 free_end = 0x00400000;

 Jprom_printf("--------------------------->ramspace: 0x%08x\n", ramspace);

 bootmap_size = init_bootmem(start_pfn, ramspace >> PAGE_SHIFT);

 /* Free up the *two* memory banks */
 free_bootmem(free_start + bootmap_size, free_end - free_start -
bootmap_size);
 free_bootmem(0x02000000, 0x00400000);
#else
 ramspace = 0x02600000; /* With holes!! */
 free_end = 0x00200000;

 bootmap_size = init_bootmem(start_pfn, ramspace >> PAGE_SHIFT);
 Jprom_printf("_end         = 0x%08x-------->_end       \n",&_end);
 Jprom_printf("start_pfn    = 0x%08x-------->FPN_UP()   \n",start_pfn);
 Jprom_printf("free_start   = 0x%08x-------->PHYSADDR   \n",free_start);
 Jprom_printf("free_end     = 0x%08x-------->0x00200000 \n",free_end);
    Jprom_printf("bootmap_size =
0x%08x-------->bootmapsize\n",bootmap_size);
 Jprom_printf("PAGE_SHIFT   = 0x%08x-------->PAGE_SHIFT \n",PAGE_SHIFT);
    Jprom_printf("ramspace     = 0x%08x-------->0x02600000 \n",ramspace);
 /* Free up the four memory banks */
 free_bootmem(free_start + bootmap_size, free_end - free_start -
bootmap_size);
 free_bootmem(0x00400000, 0x00200000);
 free_bootmem(0x02000000, 0x00200000);
 free_bootmem(0x02400000, 0x00200000);
#endif


//#ifdef CONFIG_FB
// extern unsigned long videomemory;
//#endif
// unsigned long free_start, free_end, start_pfn, bootmap_size;
// unsigned long mem_size = main_memory*MEGA;
//
// free_end = mem_size;
// if (exp_memory)
//  mem_size = 0x02000000 | (exp_memory*MEGA);
//
// free_start = PHYSADDR(PFN_ALIGN(&_end));
// start_pfn = PFN_UP((unsigned long)&_end);
//
// #ifdef CONFIG_FB
/*
 * This has to be in line with VIDEORAM_SIZE in r3912fb.c
 */
// switch (mips_machtype) {
// case MACH_R39XX_SHARP_MOBILON:
// case MACH_R39XX_COMPAQ:
//modified by Jao
//free_end -= 640*240;
//  free_end -= 320*240;
//  videomemory = KSEG0ADDR(free_end);
//  break;
// case MACH_R39XX_PHILIPS_VELO:
//  free_end -= 480*240/2; /* Velo has actually 2 different bit depths, this
is for 4bit.
//        It is bigger that's why it is used here. */
//  videomemory = KSEG0ADDR(free_end);
//  break;
// case MACH_R39XX_PHILIPS_NINO:
//  free_end -= 240*320/2;
//  free_end &= PAGE_MASK;
//  videomemory = KSEG0ADDR(free_end);
//  break;
// default:
//  break;
// }
//#endif

//#ifdef PROM_DEBUG
// prom_printf("free_start: 0x%08x\n", free_start);
// prom_printf("free_end: 0x%08x\n", free_end);
// prom_printf("start_pfn: 0x%08x\n", start_pfn);
// #ifdef CONFIG_FB
// prom_printf("videomemory: 0x%08x\n", videomemory);
// #endif
//#endif

 /* Register all the contiguous memory with the bootmem allocator
    and free it.  Be careful about the bootmem freemap.  */
// bootmap_size = init_bootmem(start_pfn, mem_size >> PAGE_SHIFT);
// free_bootmem(free_start + bootmap_size, free_end - free_start -
bootmap_size);
// if (exp_memory)
//  free_bootmem(0x02000000, exp_memory*MEGA);
}

#endif  /* CONFIG_VTECH_HELIO */
void __init prom_meminit(void)
{
Jprom_printf("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\n");
#if defined(CONFIG_VTECH_HELIO)
 Jprom_printf("------->Here to go to prom_meminit_helio\n");
 prom_meminit_helio();
#else
 Jprom_printf("------->Here to go to prom_meminit_other\n");
 prom_meminit_other();
#endif
}

int __init page_is_ram(unsigned long pagenr)
{
        return 1;
}

/* Called from mem_init() to fixup the mem_map page settings. */
void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
{
}

void prom_free_prom_memory (void)
{
}


************************************
* It's Green!! (萬林明)
* TEL: 886-2-23776100  ext.620
* mailto:greeen@iii.org.tw
* Working at III(資策會)
* 台北市大安區敦化南路二段216號12F
************************************


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
