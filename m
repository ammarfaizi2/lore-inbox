Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTFDVVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbTFDVVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:21:18 -0400
Received: from elin.scali.no ([62.70.89.10]:11676 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S264134AbTFDVVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:21:11 -0400
Date: Wed, 4 Jun 2003 23:34:31 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: linux-kernel@vger.kernel.org
Subject: Correct method of pinning pages for zero-copy
In-Reply-To: <200306042127.27397.gj@pointblue.com.pl>
Message-ID: <Pine.LNX.4.44.0306042301170.29602-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I've been struggeling for some time with a small driver doing zerocopy 
network I/O. I can't seem to find the correct method of pinning down the 
pages and releasing them again. I've tried get_user_pages directly and 
also kiobufs. What I always seem to get into is :

  1. the pinning doesn't stick through a fork() (COW). I somehow solved 
     this by setting the VM_RESERVED bit in the respective VMAs.

  2  when the skb stack releases the data after transmit and _if_ the 
     application has decremented the page referenceces (exited or 
     munmapped), the page somehow get the LRU bit set, and __free_pages_ok 
     barfs at line 95 (2.4.20) :

        if (PageLRU(page)) {
                if (unlikely(in_interrupt()))
->>                      BUG();
                lru_cache_del(page);
        }

     A typical Oops looks like this (this is a RH kernel so the line 
     number in page_alloc.c is different from plain 2.4.20) :

kernel BUG at page_alloc.c:97!
invalid operand: 0000
scadet nfs lockd sunrpc sg esm autofs tg3 iptable_filter ip_tables mousedev keybdev hid input usb-ohci usbcore ext3 jbd aic7xxx sd_mod scsi_mod  
CPU:    0
EIP:    0010:[<c01439f4>]    Tainted: PF
EFLAGS: 00010202

EIP is at __free_pages_ok [kernel] 0x364 (2.4.20-18.8smp)
eax: 00000001   ebx: c1d63518   ecx: 00000000   edx: 00000000
esi: f0c9f580   edi: 00000000   ebp: 00000000   esp: f7fa7f24
ds: 0018   es: 0018   ss: 0018
Process ksoftirqd_CPU0 (pid: 3, stackpage=f7fa7000)
Stack: 0000003e f3847c00 00000286 f10b9b80 f3847c00 c36b0018 f3840018 ffffff1c 
       c013dd49 00000010 00000002 f0c9f580 00000000 f10b9b80 c020421e f10b9b80 
       f0c9f580 f0c9f580 c0204257 f0c9f580 00000001 f0c9f580 f0c9f580 c02043c6 
Call Trace:   [<c013dd49>] kfree [kernel] 0x59 (0xf7fa7f44))
[<c020421e>] skb_release_data [kernel] 0x6e (0xf7fa7f5c))
[<c0204257>] kfree_skbmem [kernel] 0x17 (0xf7fa7f6c))
[<c02043c6>] __kfree_skb [kernel] 0x106 (0xf7fa7f80))
[<c0208fd7>] net_tx_action [kernel] 0x57 (0xf7fa7f94))
[<c0126129>] do_softirq [kernel] 0xd9 (0xf7fa7fb0))
[<c01266a5>] ksoftirqd [kernel] 0xe5 (0xf7fa7fcc))
[<c0105000>] stext [kernel] 0x0 (0xf7fa7fe8))
[<c010758e>] arch_kernel_thread [kernel] 0x2e (0xf7fa7ff0))
[<c01265c0>] ksoftirqd [kernel] 0x0 (0xf7fa7ff8))

I've also been looking at the implementation of mlock(), but I'm not 
sure if it will handle the issues above.

I'll appreciate any hints you may have.

Regards,
Steffen Persvold

