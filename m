Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbVLOIk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbVLOIk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVLOIk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:40:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161084AbVLOIk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:40:56 -0500
Date: Thu, 15 Dec 2005 00:40:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible
 [00000001] code: swapper/1
Message-Id: <20051215004028.0bf9791f.akpm@osdl.org>
In-Reply-To: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> Sorry, not sure who owns this code.
> 
> Here's something I don't remember seeing before.  Not sure if it is significant.
> 
> [4294669.070000] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> [4294669.070000] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> [4294669.070000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> [4294669.070000] PCI: Transparent bridge - 0000:00:1e.0
> [4294669.070000] PCI: Bus #03 (-#06) may be hidden behind transparent
> bridge #02 (-#02) (try 'pci=assign-busses')

Greg & Dominik.

> This is also new.
> 
> [4294671.491000] MC: drivers/edac/edac_mc.c version MC $Revision: 1.4.2.10 $
> [4294671.491000] PCI- Detected Parity Error on 0000:00:1e.0 0000:00:1e.0
> [4294671.492000] PCI- Detected Parity Error on 0000:00:1e.0 0000:00:1e.0

Alan.

> Here's the BUG output:
> 
> [4294671.538000] Freeing unused kernel memory: 220k freed
> [4294671.538000] BUG: using smp_processor_id() in preemptible
> [00000001] code: swapper/1
> [4294671.539000] caller is mod_page_state_offset+0x12/0x28
> [4294671.539000]  [<c1003723>] dump_stack+0x16/0x1a
> [4294671.539000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
> [4294671.539000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
> [4294671.540000]  [<c10fe7b6>] submit_bio+0x4a/0xaf
> [4294671.540000]  [<c105aac0>] submit_bh+0xc5/0xe7
> [4294671.541000]  [<c105ab57>] ll_rw_block+0x75/0x9a
> [4294671.541000]  [<c10ba06f>] ext3_find_entry+0x11b/0x2cb
> [4294671.542000]  [<c10ba3ee>] ext3_lookup+0x22/0x93
> [4294671.542000]  [<c1062bae>] real_lookup+0x52/0xb8
> [4294671.542000]  [<c1063259>] do_lookup+0x50/0x84
> [4294671.543000]  [<c106345d>] __link_path_walk+0x1d0/0x44e
> [4294671.543000]  [<c106372d>] link_path_walk+0x52/0xcb
> [4294671.544000]  [<c1063abe>] path_lookup+0x14f/0x189
> [4294671.544000]  [<c1063b30>] __path_lookup_intent_open+0x38/0x68
> [4294671.545000]  [<c1063b76>] path_lookup_open+0x16/0x18
> [4294671.545000]  [<c10642d4>] open_namei+0x6c/0x3d8
> [4294671.545000]  [<c105618a>] filp_open+0x23/0x3a
> [4294671.546000]  [<c1056432>] do_sys_open+0x3c/0xae
> [4294671.546000]  [<c10564b5>] sys_open+0x11/0x13
> [4294671.546000]  [<c10003fa>] init+0xe8/0x182
> [4294671.547000]  [<c1000eb5>] kernel_thread_helper+0x5/0xb
> 
> A little later, I get this:
> 
> [4294676.542000] BUG: using smp_processor_id() in preemptible
> [00000001] code: rcS/942
> [4294676.542000] caller is mod_page_state_offset+0x12/0x28
> [4294676.542000]  [<c1003723>] dump_stack+0x16/0x1a
> [4294676.554000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
> [4294676.565000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
> [4294676.577000]  [<c104911b>] __handle_mm_fault+0x1f/0x18e
> [4294676.589000]  [<c1013d7f>] do_page_fault+0x170/0x492
> [4294676.600000]  [<c10033f7>] error_code+0x4f/0x54
> [4294676.612000]  [<c10027ae>] ret_from_fork+0x6/0x14

Nick.

