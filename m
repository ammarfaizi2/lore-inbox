Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265262AbUEYXzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265262AbUEYXzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 19:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUEYXzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 19:55:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:3251 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S265259AbUEYXyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 19:54:41 -0400
Message-ID: <40B3C5F2.7010400@easyco.com>
Date: Tue, 25 May 2004 15:17:22 -0700
From: Doug Dumitru <doug@easyco.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1)
 - Not out of memory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the original trap dump from a __page_alloc error

__alloc_pages: 0-order allocation failed (gfp=0x20/1)

This was the first error that took the machine down entirely (it should 
be noted that the machine was >100 LoadAvg soft-hang before this error). 
  This is with "echo 1 > /proc/sys/vm/vm_gfp_debug" and I ran it thru 
ksymoops to try to decode the addresses (I hope I did this right).

ksymoops 2.4.4 on i686 2.4.25.  Options used
      -V (default)
      -k ksyms.5 (specified)
      -l /proc/modules (default)
      -o /lib/modules/2.4.26/ (specified)
      -m /boot/System.map-2.4.26 (specified)

Warning (expand_objects): object 
/lib/modules/2.4.26/kernel/drivers/md/lvm-mod.o for module lvm-mod
has changed since load
Warning (expand_objects): object 
/lib/modules/2.4.26/kernel/drivers/md/md.o for module md has
changed since load
cc68bad8 c0135289 00000000 011410ac 00000001 0000000c c03689dc 0000 
cbccb780 cbccb780 c02d23ba c7c5b838
Call Trace:    [<c0135289>] [<c01352b0>] [<c0132214>] [<c02d23ba>] 
[<c01327f1>]
   [<c029923f>] [<c01f0d3c>] [<c01f0c52>] [<c0121786>] [<c01219d9>] 
[<c01f05ec>]
   [<c010a4de>] [<c010a6f4>] [<c0133ce6>] [<c0134152>] [<c01341fc>] 
[<c0134271>]
   [<c0134dff>] [<c0135169>] [<c01352b0>] [<c014c203>] [<c02b765e>] 
[<c029634f>]
   [<c014c467>] [<c014c8e9>] [<c010a72d>] [<c0108b63>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0135289 <__alloc_pages+2d9/2f0>
Trace; c01352b0 <__get_free_pages+10/20>
Trace; c0132214 <kmem_cache_grow+c4/250>
Trace; c02d23ba <arp_process+48a/4a0>
Trace; c01327f1 <kmalloc+151/180>
Trace; c029923f <alloc_skb+ef/1c0>
Trace; c01f0d3c <e1000_alloc_rx_buffers+dc/110>
Trace; c01f0c52 <e1000_clean_rx_irq+402/410>
Trace; c0121786 <update_wall_time+16/50>
Trace; c01219d9 <timer_bh+39/3f0>
Trace; c01f05ec <e1000_intr+8c/e0>
Trace; c010a4de <handle_IRQ_event+5e/90>
Trace; c010a6f4 <do_IRQ+a4/f0>
Trace; c0133ce6 <shrink_cache+a6/420>
Trace; c0134152 <refill_inactive+f2/160>
Trace; c01341fc <shrink_caches+3c/50>
Trace; c0134271 <try_to_free_pages_zone+61/e0>
Trace; c0134dff <balance_classzone+4f/200>
Trace; c0135169 <__alloc_pages+1b9/2f0>
Trace; c01352b0 <__get_free_pages+10/20>
Trace; c014c203 <__pollwait+33/90>
Trace; c02b765e <tcp_poll+2e/150>
Trace; c029634f <sock_poll+1f/30>
Trace; c014c467 <do_select+127/240>
Trace; c014c8e9 <sys_select+339/480>
Trace; c010a72d <do_IRQ+dd/f0>
Trace; c0108b63 <system_call+33/38>


If I am reading this correctly, the system was ...

   in an interrupt
   processing some TCP select(...) stuff
   asking for a page
   doing a zone rebalance
   trying to shrink cache
     and interrupted again
     by the ethernet driver
     which wanted to allocate an skb
     which wanted a page

Thus __alloc_pages appears to be called recursively, with the 2nd call 
during a rebalance in the
first one and both calls non-interuptable (on interrupts).  Is this 
allowable?

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------


