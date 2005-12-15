Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbVLOIfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbVLOIfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVLOIfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:35:10 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:24788 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161071AbVLOIfJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:35:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XKcbuTn6mB/X2RnpX1xyJKDUo5pC6IgFVx0t8Xi69pkeTR/RxyrsEDAP7aWzdSXc7HFCLUyaYUWxoVwv4ermjEnytP0waOl8O9QYc9fGP5+2EbHLY4fyKgoPyYVc7/TVFcv7i/bAZd8SLSrrY+FDSGG304oSuI2tYNWQQO31gaE=
Message-ID: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
Date: Thu, 15 Dec 2005 00:35:08 -0800
From: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, not sure who owns this code.

Here's something I don't remember seeing before.  Not sure if it is significant.

[4294669.070000] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[4294669.070000] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
[4294669.070000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[4294669.070000] PCI: Transparent bridge - 0000:00:1e.0
[4294669.070000] PCI: Bus #03 (-#06) may be hidden behind transparent
bridge #02 (-#02) (try 'pci=assign-busses')

This is also new.

[4294671.491000] MC: drivers/edac/edac_mc.c version MC $Revision: 1.4.2.10 $
[4294671.491000] PCI- Detected Parity Error on 0000:00:1e.0 0000:00:1e.0
[4294671.492000] PCI- Detected Parity Error on 0000:00:1e.0 0000:00:1e.0

Here's the BUG output:

[4294671.538000] Freeing unused kernel memory: 220k freed
[4294671.538000] BUG: using smp_processor_id() in preemptible
[00000001] code: swapper/1
[4294671.539000] caller is mod_page_state_offset+0x12/0x28
[4294671.539000]  [<c1003723>] dump_stack+0x16/0x1a
[4294671.539000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
[4294671.539000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
[4294671.540000]  [<c10fe7b6>] submit_bio+0x4a/0xaf
[4294671.540000]  [<c105aac0>] submit_bh+0xc5/0xe7
[4294671.541000]  [<c105ab57>] ll_rw_block+0x75/0x9a
[4294671.541000]  [<c10ba06f>] ext3_find_entry+0x11b/0x2cb
[4294671.542000]  [<c10ba3ee>] ext3_lookup+0x22/0x93
[4294671.542000]  [<c1062bae>] real_lookup+0x52/0xb8
[4294671.542000]  [<c1063259>] do_lookup+0x50/0x84
[4294671.543000]  [<c106345d>] __link_path_walk+0x1d0/0x44e
[4294671.543000]  [<c106372d>] link_path_walk+0x52/0xcb
[4294671.544000]  [<c1063abe>] path_lookup+0x14f/0x189
[4294671.544000]  [<c1063b30>] __path_lookup_intent_open+0x38/0x68
[4294671.545000]  [<c1063b76>] path_lookup_open+0x16/0x18
[4294671.545000]  [<c10642d4>] open_namei+0x6c/0x3d8
[4294671.545000]  [<c105618a>] filp_open+0x23/0x3a
[4294671.546000]  [<c1056432>] do_sys_open+0x3c/0xae
[4294671.546000]  [<c10564b5>] sys_open+0x11/0x13
[4294671.546000]  [<c10003fa>] init+0xe8/0x182
[4294671.547000]  [<c1000eb5>] kernel_thread_helper+0x5/0xb

A little later, I get this:

[4294676.542000] BUG: using smp_processor_id() in preemptible
[00000001] code: rcS/942
[4294676.542000] caller is mod_page_state_offset+0x12/0x28
[4294676.542000]  [<c1003723>] dump_stack+0x16/0x1a
[4294676.554000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
[4294676.565000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
[4294676.577000]  [<c104911b>] __handle_mm_fault+0x1f/0x18e
[4294676.589000]  [<c1013d7f>] do_page_fault+0x170/0x492
[4294676.600000]  [<c10033f7>] error_code+0x4f/0x54
[4294676.612000]  [<c10027ae>] ret_from_fork+0x6/0x14

[4294680.759000] PCI- Detected Parity Error on 0000:00:1e.0 0000:00:1e.0
[4294681.552000] printk: 169937 messages suppressed.
[4294681.552000] BUG: using smp_processor_id() in preemptible
[00000001] code: modprobe/1991
[4294681.579000] caller is mod_page_state_offset+0x12/0x28
[4294681.579000]  [<c1003723>] dump_stack+0x16/0x1a
[4294681.592000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
[4294681.605000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
[4294681.618000]  [<c104911b>] __handle_mm_fault+0x1f/0x18e
[4294681.631000]  [<c1013d7f>] do_page_fault+0x170/0x492
[4294681.645000]  [<c10033f7>] error_code+0x4f/0x54
[4294681.658000]  [<c110b8e4>] copy_to_user+0x38/0x46
[4294681.671000]  [<c10729d7>] seq_read+0x1d6/0x256
[4294681.684000]  [<c1056c5b>] vfs_read+0xa5/0x145
[4294681.698000]  [<c1056f43>] sys_read+0x3a/0x61
[4294681.711000]  [<c1002877>] sysenter_past_esp+0x54/0x75

Then, eventually:

[4294686.538000] BUG: using smp_processor_id() in preemptible
[00000001] code: evms_activate/210
0
[4294686.569000] caller is mod_page_state_offset+0x12/0x28
[4294686.569000]  [<c1003723>] dump_stack+0x16/0x1a
[4294686.584000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
[4294686.600000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
[4294686.616000]  [<c104911b>] __handle_mm_fault+0x1f/0x18e
[4294686.632000]  [<c1013d7f>] do_page_fault+0x170/0x492
[4294686.648000]  [<c10033f7>] error_code+0x4f/0x54

And:

[4294691.538000] BUG: using smp_processor_id() in preemptible
[00000001] code: fsck.vfat/2130
[4294691.554000] caller is mod_page_state_offset+0x12/0x28
[4294691.554000]  [<c1003723>] dump_stack+0x16/0x1a
[4294691.569000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
[4294691.584000]  [<c10413d3>] mod_page_state_offset+0x12/0x28
[4294691.600000]  [<c10fe7b6>] submit_bio+0x4a/0xaf
[4294691.616000]  [<c105aac0>] submit_bh+0xc5/0xe7
[4294691.631000]  [<c1059d94>] block_read_full_page+0x21c/0x231
[4294691.646000]  [<c105d6d2>] blkdev_readpage+0x10/0x12
[4294691.662000]  [<c1043121>] read_pages+0x98/0xe9
[4294691.676000]  [<c1043299>] __do_page_cache_readahead+0x127/0x145
[4294691.691000]  [<c10433aa>] blockable_page_cache_readahead+0x43/0x9a
[4294691.706000]  [<c1043542>] page_cache_readahead+0xb2/0xff
[4294691.721000]  [<c103d814>] do_generic_mapping_read+0x117/0x3a6
[4294691.736000]  [<c103dcf2>] __generic_file_aio_read+0x18b/0x1e1
[4294691.751000]  [<c103dd8a>] generic_file_aio_read+0x42/0x49
[4294691.766000]  [<c1056b85>] do_sync_read+0x98/0xc9
[4294691.781000]  [<c1056c5b>] vfs_read+0xa5/0x145
[4294691.796000]  [<c1056f43>] sys_read+0x3a/0x61
[4294691.811000]  [<c1002877>] sysenter_past_esp+0x54/0x75

Anyhow, there are more, but I bet this is sufficient.

Thanks,
          Miles
