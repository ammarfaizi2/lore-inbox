Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266194AbRGKAvt>; Tue, 10 Jul 2001 20:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266198AbRGKAvk>; Tue, 10 Jul 2001 20:51:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2553 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S266194AbRGKAvd>; Tue, 10 Jul 2001 20:51:33 -0400
Message-ID: <3B4BA24E.1FB614B0@mvista.com>
Date: Tue, 10 Jul 2001 17:48:14 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mips@oss.sgi.com
Subject: memory alloc failuer : __alloc_pages: 1-order allocation failed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I am running 2.4.2 on a linux/mips box, with 32MB system RAM (no swap).  When
I run a stress test, I will hit memory allocation failure:

__alloc_pages: 1-order allocation failed.
IP: queue_glue: no memory for gluing queue 8108cce0


However, I traced the system and found several questions.

First, free reports enough free memory and LOTS of cache memory.  See below. 
Should'nt Linux free cache memory to satisfy this request?

             total       used       free     shared    buffers     cached
Mem:         30052      29296        756          0          0      16928
-/+ buffers/cache:      12368      17684
Swap:            0          0          0

I used kgdb and dig into rmqueue() in mm/page_alloc.c file.  There are two
zones in this system.  They do have many free pages but none of free blocks
seem to be big enough for the 2-page request.  Does this make sense?  Why does
kernel end up with so many fragmented 1-page free areas?  See the kgdb output
below.

(gdb) p order
$14 = 1
(gdb) p *zone
$15 = {lock = {gcc_is_buggy = 0}, offset = 4096, free_pages = 65, 
  inactive_clean_pages = 262, inactive_dirty_pages = 10, pages_min = 32, 
  pages_low = 64, pages_high = 96, inactive_clean_list = {next = 0x8107cdf0, 
    prev = 0x81053c40}, free_area = {{free_list = {next = 0x8105f548, 
        prev = 0x810562a8}, map = 0x810884e0}, {free_list = {
        next = 0x801fe5f0, prev = 0x801fe5f0}, map = 0x810886e0}, {
      free_list = {next = 0x801fe5fc, prev = 0x801fe5fc}, map = 0x810887e0}, {
      free_list = {next = 0x801fe608, prev = 0x801fe608}, map = 0x81088860}, {
      free_list = {next = 0x801fe614, prev = 0x801fe614}, map = 0x810888a0}, {
      free_list = {next = 0x801fe620, prev = 0x801fe620}, map = 0x810888c0}, {
      free_list = {next = 0x801fe62c, prev = 0x801fe62c}, map = 0x810888e0}, {
      free_list = {next = 0x801fe638, prev = 0x801fe638}, map = 0x81088900}, {
      free_list = {next = 0x801fe644, prev = 0x801fe644}, map = 0x81088920}, {
      free_list = {next = 0x801fe650, prev = 0x801fe650}, map = 0x81088940}}, 
  name = 0x801af0e4 "Normal", size = 4096, zone_pgdat = 0x801fe504, 
  zone_start_paddr = 16777216, zone_start_mapnr = 4096, 
  zone_mem_map = 0x81044010}


(gdb) p z
$23 = (zone_t *) 0x801fe504
(gdb) p *z
$24 = {lock = {gcc_is_buggy = 0}, offset = 0, free_pages = 329, 
  inactive_clean_pages = 861, inactive_dirty_pages = 16, pages_min = 128, 
  pages_low = 256, pages_high = 384, inactive_clean_list = {next = 0x81020888, 
    prev = 0x81036508}, free_area = {{free_list = {next = 0x8102d1c4, 
        prev = 0x81035430}, map = 0x81088060}, {free_list = {
        next = 0x801fe538, prev = 0x801fe538}, map = 0x81088260}, {
      free_list = {next = 0x801fe544, prev = 0x801fe544}, map = 0x81088360}, {
      free_list = {next = 0x801fe550, prev = 0x801fe550}, map = 0x810883e0}, {
      free_list = {next = 0x801fe55c, prev = 0x801fe55c}, map = 0x81088420}, {
      free_list = {next = 0x801fe568, prev = 0x801fe568}, map = 0x81088440}, {
      free_list = {next = 0x801fe574, prev = 0x801fe574}, map = 0x81088460}, {
      free_list = {next = 0x801fe580, prev = 0x801fe580}, map = 0x81088480}, {
      free_list = {next = 0x801fe58c, prev = 0x801fe58c}, map = 0x810884a0}, {
      free_list = {next = 0x801fe598, prev = 0x801fe598}, map = 0x810884c0}}, 
  name = 0x801af0ec "DMA", size = 4096, zone_pgdat = 0x801fe504, 
  zone_start_paddr = 0, zone_start_mapnr = 0, zone_mem_map = 0x81000010}

The current process does not have PF_MEMALLOC flag set.

The callstack trace is as follows: (kgdb is lying - the gfp_mask should be 2
at frame #1.  The size in kmalloc is probably a lie from kgdb too.)

#0  __alloc_pages (zonelist=0x801fe754, order=1) at page_alloc.c:498
#1  0x800b3c08 in __get_free_pages (gfp_mask=0, order=1)
    at
/local/jsun/2ND-DISK/work/ddb5477/build/hhl-2.4.2-010709/hhl-2.4.2/linux/
include/linux/mm.h:355
#2  0x800aedbc in kmem_cache_grow (cachep=0x8108b700, flags=2) at slab.c:485
#3  0x800af258 in kmalloc (size=2149573892, flags=2) at slab.c:1331
#4  0x801585bc in alloc_skb (size=4160, gfp_mask=2) at skbuff.c:189
#5  0x80166cbc in ip_frag_reasm (qp=0x8108cce0, dev=0x810a1800)
    at
/local/jsun/2ND-DISK/work/ddb5477/build/hhl-2.4.2-010709/hhl-2.4.2/linux/
include/linux/skbuff.h:919
#6  0x80167040 in ip_defrag (skb=0x0) at ip_fragment.c:626
#7  0x80165c28 in ip_local_deliver (skb=0x810dcd20) at ip_input.c:291
#8  0x80166184 in ip_rcv (skb=0x810dcd20, dev=0x1, pt=0x0) at ip_input.c:363
#9  0x8015b5ec in net_rx_action (h=0x801fe504) at dev.c:1403
#10 0x800993d8 in do_softirq () at softirq.c:78
#11 0x801a2eb4 in do_IRQ (irq=16, regs=0x81c79d18) at irq.c:644
#12 0x801a50ec in vrc5477_irq_dispatch (regs=0x81c79d18) at irq.c:175

Would appreciate any pointers.

Jun
