Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVLFNdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVLFNdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVLFNdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:33:18 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:62878 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932562AbVLFNdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:33:17 -0500
Message-ID: <4395933A.2040603@jp.fujitsu.com>
Date: Tue, 06 Dec 2005 22:33:46 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1
References: <20051204232153.258cd554.akpm@osdl.org>
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PAGE_OWNER=y, there is a bug in page allocation failure path.
(turn on Kernel Hacking -> Track page owner)

Patch is attached below.
error message is this
==
Dec  6 22:21:34 aworks kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000020
Dec  6 22:21:34 aworks kernel:  printing eip:
Dec  6 22:21:34 aworks kernel: c0148267
Dec  6 22:21:34 aworks kernel: *pde = 00000000
Dec  6 22:21:34 aworks kernel: Oops: 0002 [#1]
Dec  6 22:21:34 aworks kernel: SMP
Dec  6 22:21:34 aworks kernel: last sysfs file: /class/vc/vcs2/dev
Dec  6 22:21:34 aworks kernel: Modules linked in: video
Dec  6 22:21:34 aworks kernel: CPU:    0
Dec  6 22:21:34 aworks kernel: EIP:    0060:[<c0148267>]    Not tainted VLI
Dec  6 22:21:34 aworks kernel: EFLAGS: 00010286   (2.6.15-rc5-mm1)
Dec  6 22:21:34 aworks kernel: EIP is at __alloc_pages+0x297/0x3c0
Dec  6 22:21:34 aworks su(pam_unix)[2660]: session closed for user root
Dec  6 22:21:34 aworks kernel: eax: 0000000a   ebx: e884c000   ecx: 00000000   edx: e884decc
Dec  6 22:21:34 aworks kernel: esi: 000242d2   edi: 00000000   ebp: e884decc   esp: e884de88
Dec  6 22:21:34 aworks kernel: ds: 007b   es: 007b   ss: 0068
Dec  6 22:21:34 aworks kernel: Process bash (pid: 2663, threadinfo=e884c000 task=ed9ff070)
Dec  6 22:21:34 aworks kernel: Stack: <0>000242d2 0000000a c04a3ba8 00000042 00000000 000242d2 c04a3ba8 0000000a
Dec  6 22:21:34 aworks kernel:        <0>00000010 00000000 e884c000 00000042 e884dea6 00000000 c1090000 000001f4
Dec  6 22:21:34 aworks kernel:        <0>ec06abc0 e884ded8 c015ce58 c1090000 e884def0 c015d117 c1090000 e884dfa0
Dec  6 22:21:34 aworks kernel: Call Trace:
Dec  6 22:21:34 aworks kernel:  [<c0103dc2>] show_stack+0xa2/0xe0
Dec  6 22:21:34 aworks kernel:  [<c0103f8f>] show_registers+0x16f/0x200
Dec  6 22:21:34 aworks kernel:  [<c01041df>] die+0x11f/0x1b0
Dec  6 22:21:34 aworks kernel:  [<c0428500>] do_page_fault+0x330/0x638
Dec  6 22:21:34 aworks kernel:  [<c0103a4f>] error_code+0x4f/0x54
Dec  6 22:21:34 aworks kernel:  [<c015ce58>] alloc_fresh_huge_page+0x18/0x50
Dec  6 22:21:34 aworks kernel:  [<c015d117>] set_max_huge_pages+0x47/0xc0
Dec  6 22:21:34 aworks kernel:  [<c015d1d1>] hugetlb_sysctl_handler+0x41/0x50
Dec  6 22:21:34 aworks kernel:  [<c0125c48>] do_rw_proc+0xe8/0x100
Dec  6 22:21:34 aworks kernel:  [<c0125cde>] proc_writesys+0x2e/0x30
Dec  6 22:21:34 aworks kernel:  [<c01668b6>] vfs_write+0xa6/0x190
Dec  6 22:21:34 aworks kernel:  [<c0166a57>] sys_write+0x47/0x70
Dec  6 22:21:34 aworks kernel:  [<c0102ecf>] sysenter_past_esp+0x54/0x75
Dec  6 22:21:34 aworks kernel: Code: c0 89 44 24 04 89 54 24 08 e8 06 6c fd ff e8 b1 bb fb ff e8 ac ce fc ff 8b 4d e0 8b 45 d8 8d 5d ec 89 ea 81 e3 00 e0 ff ff 89 cf <89> 41 20 89 71 24 83 c7 28 31 c0 b9 08 00 00 00 f3 ab 31 f6 39
==

--Kame
---
Fix NULL pointer reference of set_page_owner() in allcation faulure path.

Signed-Off-by: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitu.com>

Index: linux-2.6.15-rc5-mm1.org/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm1.org.orig/mm/page_alloc.c
+++ linux-2.6.15-rc5-mm1.org/mm/page_alloc.c
@@ -1136,7 +1136,8 @@ nopage:
  	}
  got_pg:
  #ifdef CONFIG_PAGE_OWNER
-	set_page_owner(page, order, gfp_mask);
+	if (page)
+		set_page_owner(page, order, gfp_mask);
  #endif
  	return page;
  }

