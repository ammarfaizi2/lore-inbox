Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbUKXQuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUKXQuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUKXQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:48:58 -0500
Received: from iris.icglink.com ([216.183.105.244]:65161 "HELO
	iris.icglink.com") by vger.kernel.org with SMTP id S261486AbUKXQpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:45:52 -0500
Date: Wed, 24 Nov 2004 09:45:49 -0600
From: Phil Dier <phil@dier.us>
To: linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041124094549.4c51d6d5.phil@dier.us>
In-Reply-To: <20041122161725.21adb932.akpm@osdl.org>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004 16:17:25 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Phil Dier <phil@dier.us> wrote:
> >
> > I'm setting up a storage array with Linux, software RAID, LVM, and XFS,
> > but I keep getting oopses during heavy I/O. I've been able to reproduce
> > this with 2.6.6, 2.6.8.1, 2.6.9, and 2.6.10-rc2-bk4. I have dual xeon
> > 2.8s with 4gb of ram. I'm using adaptec and a fusion mpt scsi devices
> > (more details in the following link). Connected are 2 ultra160 scsi
> > jbods w/ 2 disks apiece. I'm using raid 10 (or should it be 01?) mirrored 
> > stripes.
> > 
> > Due to its size, I've posted my debug info at this location (I've included
> > output from all of the above kernels):
> > 
> > <http://www.icglink.com/cluster-debug-info.html> (~235kb)
> 
> yow.  The dread combination of XFS, LVM, software RAID and bloaty scsi
> drivers.  Looks like a stack overrun.
> 
> Can you rebuild the kernel with CONFIG_4KSTACKS=n?
> 


Looks like 8k stacks did the trick, at least for the oops. Now I'm
seeing the stuff below.

I got a ton more of this with jfs and xfs, but it seems much less with
reiser. Should I be worried, or is this something I can safely ignore?
It doesn't lock the system..  Could files be getting corrupted?


Nov 23 17:38:20 calculon swapper: page allocation failure. order:0, mode:0x20
Nov 23 17:38:20 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
Nov 23 17:38:20 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
Nov 23 17:38:20 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
Nov 23 17:38:20 calculon [<c0140813>] alloc_slabmgmt+0x55/0x5f
Nov 23 17:38:20 calculon [<c0140992>] cache_grow+0xab/0x14d
Nov 23 17:38:20 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
Nov 23 17:38:20 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
Nov 23 17:38:20 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
Nov 23 17:38:20 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3
Nov 23 17:38:20 calculon [<c032e8e0>] e1000_clean_rx_irq+0x189/0x44a
Nov 23 17:38:20 calculon [<c032e4f2>] e1000_intr+0x36/0x83
Nov 23 17:38:20 calculon [<c0107899>] handle_IRQ_event+0x31/0x65
Nov 23 17:38:20 calculon [<c0107c19>] do_IRQ+0xb0/0x15f
Nov 23 17:38:20 calculon [<c0105a68>] common_interrupt+0x18/0x20
Nov 23 17:38:20 calculon [<c010301e>] default_idle+0x0/0x2c
Nov 23 17:38:20 calculon [<c0103047>] default_idle+0x29/0x2c
Nov 23 17:38:20 calculon [<c01030bc>] cpu_idle+0x3f/0x58
Nov 23 17:38:20 calculon swapper: page allocation failure. order:0, mode:0x20
Nov 23 17:38:20 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
Nov 23 17:38:20 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
Nov 23 17:38:20 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
Nov 23 17:38:20 calculon [<c0140992>] cache_grow+0xab/0x14d
Nov 23 17:38:20 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
Nov 23 17:38:20 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
Nov 23 17:38:20 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
Nov 23 17:38:20 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3
Nov 23 17:38:20 calculon [<c032e8e0>] e1000_clean_rx_irq+0x189/0x44a
Nov 23 17:38:20 calculon [<c032e4f2>] e1000_intr+0x36/0x83
Nov 23 17:38:20 calculon [<c0107899>] handle_IRQ_event+0x31/0x65
Nov 23 17:38:20 calculon [<c0107c19>] do_IRQ+0xb0/0x15f
Nov 23 17:38:20 calculon [<c0105a68>] common_interrupt+0x18/0x20
Nov 23 17:38:20 calculon [<c010301e>] default_idle+0x0/0x2c
Nov 23 17:38:20 calculon [<c0103047>] default_idle+0x29/0x2c
Nov 23 17:38:20 calculon [<c01030bc>] cpu_idle+0x3f/0x58
Nov 23 17:38:20 calculon swapper: page allocation failure. order:0, mode:0x20
Nov 23 17:38:20 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
Nov 23 17:38:20 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
Nov 23 17:38:20 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
Nov 23 17:38:20 calculon [<c0140992>] cache_grow+0xab/0x14d
Nov 23 17:38:20 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
Nov 23 17:38:20 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
Nov 23 17:38:20 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
Nov 23 17:38:20 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3
Nov 23 17:38:20 calculon [<c032e8e0>] e1000_clean_rx_irq+0x189/0x44a
Nov 23 17:38:20 calculon [<c032e4f2>] e1000_intr+0x36/0x83
Nov 23 17:38:20 calculon [<c0107899>] handle_IRQ_event+0x31/0x65
Nov 23 17:38:20 calculon [<c0107c19>] do_IRQ+0xb0/0x15f
Nov 23 17:38:20 calculon [<c0105a68>] common_interrupt+0x18/0x20
Nov 23 17:38:20 calculon [<c010301e>] default_idle+0x0/0x2c
Nov 23 17:38:20 calculon [<c0103047>] default_idle+0x29/0x2c
Nov 23 17:38:20 calculon [<c01030bc>] cpu_idle+0x3f/0x58
Nov 23 17:38:20 calculon swapper: page allocation failure. order:0, mode:0x20
Nov 23 17:38:20 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
Nov 23 17:38:20 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
Nov 23 17:38:20 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
Nov 23 17:38:20 calculon [<c0140992>] cache_grow+0xab/0x14d
Nov 23 17:38:20 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
Nov 23 17:38:20 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
Nov 23 17:38:20 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
Nov 23 17:38:20 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3
Nov 23 17:38:20 calculon [<c032e8e0>] e1000_clean_rx_irq+0x189/0x44a
Nov 23 17:38:20 calculon [<c0140ff0>] __kmalloc+0x77/0x8c
Nov 23 17:38:20 calculon [<c032e4f2>] e1000_intr+0x36/0x83
Nov 23 17:38:20 calculon [<c03f5020>] alloc_skb+0xde/0xe0
Nov 23 17:38:20 calculon [<c0107899>] handle_IRQ_event+0x31/0x65
Nov 23 17:38:20 calculon [<c0107c19>] do_IRQ+0xb0/0x15f
Nov 23 17:38:20 calculon [<c0105a68>] common_interrupt+0x18/0x20
Nov 23 17:38:20 calculon [<c03fb243>] net_rx_action+0x62/0xf6
Nov 23 17:38:20 calculon [<c0121beb>] __do_softirq+0xb7/0xc6
Nov 23 17:38:20 calculon [<c0121c27>] do_softirq+0x2d/0x2f
Nov 23 17:38:20 calculon [<c0107c8d>] do_IRQ+0x124/0x15f
Nov 23 17:38:20 calculon [<c0105a68>] common_interrupt+0x18/0x20
Nov 23 17:38:20 calculon [<c010301e>] default_idle+0x0/0x2c
Nov 23 17:38:20 calculon [<c0103047>] default_idle+0x29/0x2c
Nov 23 17:38:20 calculon [<c01030bc>] cpu_idle+0x3f/0x58

Nov 24 01:18:09 calculon swapper: page allocation failure. order:0, mode:0x20
Nov 24 01:18:09 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
Nov 24 01:18:09 calculon [<c040ce57>] ip_local_deliver_finish+0x0/0x181
Nov 24 01:18:09 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
Nov 24 01:18:09 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
Nov 24 01:18:09 calculon [<c0140813>] alloc_slabmgmt+0x55/0x5f
Nov 24 01:18:09 calculon [<c0140992>] cache_grow+0xab/0x14d
Nov 24 01:18:09 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
Nov 24 01:18:09 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
Nov 24 01:18:09 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
Nov 24 01:18:09 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3
Nov 24 01:18:09 calculon [<c032e8e0>] e1000_clean_rx_irq+0x189/0x44a
Nov 24 01:18:09 calculon [<c012d45d>] rcu_check_quiescent_state+0x78/0x8e
Nov 24 01:18:09 calculon [<c032e4f2>] e1000_intr+0x36/0x83
Nov 24 01:18:09 calculon [<c0107899>] handle_IRQ_event+0x31/0x65
Nov 24 01:18:09 calculon [<c0107c19>] do_IRQ+0xb0/0x15f
Nov 24 01:18:09 calculon [<c0105a68>] common_interrupt+0x18/0x20
Nov 24 01:18:09 calculon [<c010301e>] default_idle+0x0/0x2c
Nov 24 01:18:09 calculon [<c0103047>] default_idle+0x29/0x2c
Nov 24 01:18:09 calculon [<c01030bc>] cpu_idle+0x3f/0x58
Nov 24 01:18:09 calculon swapper: page allocation failure. order:0, mode:0x20
Nov 24 01:18:09 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
Nov 24 01:18:09 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
Nov 24 01:18:09 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
Nov 24 01:18:09 calculon [<c0140992>] cache_grow+0xab/0x14d
Nov 24 01:18:09 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
Nov 24 01:18:09 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
Nov 24 01:18:09 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
Nov 24 01:18:09 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3
Nov 24 01:18:09 calculon [<c032e8e0>] e1000_clean_rx_irq+0x189/0x44a
Nov 24 01:18:09 calculon [<c012d45d>] rcu_check_quiescent_state+0x78/0x8e
Nov 24 01:18:09 calculon [<c032e4f2>] e1000_intr+0x36/0x83
Nov 24 01:18:09 calculon [<c0107899>] handle_IRQ_event+0x31/0x65
Nov 24 01:18:09 calculon [<c0107c19>] do_IRQ+0xb0/0x15f
Nov 24 01:18:09 calculon [<c0105a68>] common_interrupt+0x18/0x20
Nov 24 01:18:09 calculon [<c010301e>] default_idle+0x0/0x2c
Nov 24 01:18:09 calculon [<c0103047>] default_idle+0x29/0x2c
Nov 24 01:18:09 calculon [<c01030bc>] cpu_idle+0x3f/0x58



-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
