Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTLGMRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 07:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbTLGMRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 07:17:47 -0500
Received: from holomorphy.com ([199.26.172.102]:48856 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264419AbTLGMRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 07:17:43 -0500
Date: Sun, 7 Dec 2003 04:17:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Riesen <fork0@users.sourceforge.net>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] FIx 'noexec' behavior
Message-ID: <20031207121737.GX8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Riesen <fork0@users.sourceforge.net>,
	Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@yahoo.com>
References: <20031207120634.GA1258@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207120634.GA1258@steel.home>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 01:06:34PM +0100, Alex Riesen wrote:
>  mozilla-bin   D 00000001     0  1225      1          1245  1393 (NOTLB)
>  eba79df4 00000082 c18dac80 00000001 00000003 5a5a5a5a 5a5a5a5a 5a5a5a5a 
>         5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a 5a5a5a5a c18dac80 00008714 
>         65e68354 00000130 f6efd940 f689d4dc f6efd940 fffeffff eba79e14 c01bcd27 

Slab poison on the stack is likely from uninitialized stack variables.


On Sun, Dec 07, 2003 at 01:06:34PM +0100, Alex Riesen wrote:
>  Call Trace:
>   [rwsem_down_failed_common+157/342] rwsem_down_failed_common+0x9d/0x156
>   [<c01bcd27>] rwsem_down_failed_common+0x9d/0x156
>   [do_page_fault+0/1416] do_page_fault+0x0/0x588
>   [<c011d6b1>] do_page_fault+0x0/0x588
>   [rwsem_down_read_failed+41/50] rwsem_down_read_failed+0x29/0x32
>   [<c01bca95>] rwsem_down_read_failed+0x29/0x32
>   [.text.lock.fault+27/131] .text.lock.fault+0x1b/0x83
>   [<c011dc54>] .text.lock.fault+0x1b/0x83
>   [buffered_rmqueue+237/404] buffered_rmqueue+0xed/0x194
>   [<c01433c8>] buffered_rmqueue+0xed/0x194
>   [pte_chain_alloc+143/148] pte_chain_alloc+0x8f/0x94
>   [<c015480b>] pte_chain_alloc+0x8f/0x94
>   [__alloc_pages+167/818] __alloc_pages+0xa7/0x332
>   [<c0143516>] __alloc_pages+0xa7/0x332
>   [__get_free_pages+34/69] __get_free_pages+0x22/0x45
>   [<c01437c3>] __get_free_pages+0x22/0x45

This looks like mostly garbage from an attempt to handle a fault and
then blocking on mm->mmap_sem.


On Sun, Dec 07, 2003 at 01:06:34PM +0100, Alex Riesen wrote:
>   [do_page_fault+0/1416] do_page_fault+0x0/0x588
>   [<c011d6b1>] do_page_fault+0x0/0x588
>   [error_code+45/56] error_code+0x2d/0x38
>   [<c010aec1>] error_code+0x2d/0x38
>   [do_mmap_pgoff+83/1656] do_mmap_pgoff+0x53/0x678
>   [<c01511fc>] do_mmap_pgoff+0x53/0x678
>   [pipe_read+516/628] pipe_read+0x204/0x274
>   [<c016ac01>] pipe_read+0x204/0x274
>   [sys_mmap2+155/210] sys_mmap2+0x9b/0xd2
>   [<c01111a4>] sys_mmap2+0x9b/0xd2
>   [syscall_call+7/11] syscall_call+0x7/0xb
>   [<c010a437>] syscall_call+0x7/0xb

You took a fault in do_mmap_pgoff().


-- wli


===== mm/mmap.c 1.95 vs edited =====
--- 1.95/mm/mmap.c	Sat Dec  6 14:34:36 2003
+++ edited/mm/mmap.c	Sun Dec  7 04:17:04 2003
@@ -479,8 +479,10 @@
 		if (!file->f_op || !file->f_op->mmap)
 			return -ENODEV;
 
-		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
-			return -EPERM;
+		if (file->f_vfsmnt && (prot & PROT_EXEC)) {
+			if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)
+				return -EPERM;
+		}
 	}
 
 	if (!len)
-- wli
