Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbUKCTm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbUKCTm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKCTlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:41:53 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:25074 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261844AbUKCTij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:38:39 -0500
Message-ID: <4189336C.6030903@us.ibm.com>
Date: Wed, 03 Nov 2004 11:37:16 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com> <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random> <418837D1.402@us.ibm.com> <20041103022606.GI3571@dualathlon.random> <418846E9.1060906@us.ibm.com> <20041103030558.GK3571@dualathlon.random>
In-Reply-To: <20041103030558.GK3571@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
>>I'll see what I can do to get some backtraces of the __pg_prot(0) &&
>>page->mapped cases.

These appear to be the 2 most common paths:  cache_init_objs() and 
kfree().  But, the path that I'm hitting now appears to be that 
something got page_count(kpte_page) to -1 (*NOT* page->_count), and then 
the BUG_ON() trips after a get_page() is done on it.  I'm tracking this 
down now.

kpte: c0011000
address: c1a00000
kpte_page: c1000264
split: ffffffff
pgprot_val(prot): 00000000
pgprot_val(PAGE_KERNEL): 00000163
(pte_val(*kpte) & _PAGE_PSE): 00000000
path: 1
Badness in __change_page_attr at arch/i386/mm/pageattr.c:156
  [<c0114e43>] __change_page_attr+0x443/0x5a4
  [<c01150d9>] kernel_map_pages+0x31/0x80
  [<c0114fda>] change_page_attr+0x36/0x54
  [<c01150f3>] kernel_map_pages+0x4b/0x80
  [<c013de18>] cache_init_objs+0x194/0x1d8
  [<c013e014>] cache_grow+0xe8/0x154
  [<c013e74a>] cache_alloc_refill+0x226/0x274
  [<c013edb3>] __kmalloc+0x8b/0xbc
  [<c0181302>] proc_create+0x76/0xcc
  [<c01814c3>] create_proc_entry+0x6b/0xb4
  [<c0121c3b>] register_proc_table+0xcb/0x110
  [<c0121c67>] register_proc_table+0xf7/0x110
  [<c0420994>] sysctl_init+0x10/0x1c
  [<c0413934>] do_basic_setup+0x14/0x20
  [<c01004ec>] init+0xa8/0x15c
  [<c0100444>] init+0x0/0x15c
  [<c0102305>] kernel_thread_helper+0x5/0xc

kpte: c0006978
address: c052f000
kpte_page: c10000d8
split: ffffffff
pgprot_val(prot): 00000000
pgprot_val(PAGE_KERNEL): 00000163
(pte_val(*kpte) & _PAGE_PSE): 00000000
path: 1
Badness in __change_page_attr at arch/i386/mm/pageattr.c:156
  [<c0114e43>] __change_page_attr+0x443/0x5a4
  [<c02367db>] scsi_run_queue+0xaf/0xb8
  [<c0114fda>] change_page_attr+0x36/0x54
  [<c01150f3>] kernel_map_pages+0x4b/0x80
  [<c013e422>] cache_free_debugcheck+0x2a6/0x2c0
  [<c02385a5>] scsi_probe_and_add_lun+0x135/0x188
  [<c013f00b>] kfree+0x9f/0xdc
  [<c02385a5>] scsi_probe_and_add_lun+0x135/0x188
  [<c02385a5>] scsi_probe_and_add_lun+0x135/0x188
  [<c0238ac7>] scsi_scan_target+0x63/0xbc
  [<c0238b60>] scsi_scan_channel+0x40/0x68
  [<c0238bfe>] scsi_scan_host_selected+0x76/0xb0
  [<c0238c4a>] scsi_scan_host+0x12/0x18
  [<c024b7ff>] ahc_linux_register_host+0x283/0x290
  [<c01857e9>] sysfs_create_file+0x41/0x48
  [<c01e4392>] pci_create_newid_file+0x1a/0x24
  [<c01e470a>] pci_populate_driver_dir+0xa/0x10
  [<c01e4786>] pci_register_driver+0x76/0x88
  [<c024a867>] ahc_linux_detect+0x3b/0x60
  [<c042750a>] ahc_linux_init+0xa/0x30
  [<c04138ca>] do_initcalls+0x66/0xbc
  [<c041393e>] do_basic_setup+0x1e/0x20
  [<c01004ec>] init+0xa8/0x15c
  [<c0100444>] init+0x0/0x15c
  [<c0102305>] kernel_thread_helper+0x5/0xc
