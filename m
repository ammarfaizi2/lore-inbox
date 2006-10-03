Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWJCRcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWJCRcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWJCRby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:31:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:28135 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030356AbWJCRbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:31:03 -0400
Date: Tue, 3 Oct 2006 13:12:57 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 5/12] i386 setup.c: Reserve kernel memory starting from _text
Message-ID: <20061003171257.GE3164@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003170032.GA30036@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Currently when we are reserving the memory the kernel text
resides in we start at __PHYSICAL_START which happens to be
correct but not very obvious.  In addition when we start relocating
the kernel __PHYSICAL_START is the wrong value, as it is an
absolute symbol that does not get relocated.

By starting the reservation at __pa_symbol(_text)
the code is clearer and will be correct when relocated.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/setup.c~i386-setup.c-Reserve-kernel-memory-starting-from-_text arch/i386/kernel/setup.c
--- linux-2.6.18-git17/arch/i386/kernel/setup.c~i386-setup.c-Reserve-kernel-memory-starting-from-_text	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/arch/i386/kernel/setup.c	2006-10-02 13:17:58.000000000 -0400
@@ -1119,8 +1119,8 @@ void __init setup_bootmem_allocator(void
 	 * the (very unlikely) case of us accidentally initializing the
 	 * bootmem allocator with an invalid RAM area.
 	 */
-	reserve_bootmem(__PHYSICAL_START, (PFN_PHYS(min_low_pfn) +
-			 bootmap_size + PAGE_SIZE-1) - (__PHYSICAL_START));
+	reserve_bootmem(__pa_symbol(_text), (PFN_PHYS(min_low_pfn) +
+			 bootmap_size + PAGE_SIZE-1) - __pa_symbol(_text));
 
 	/*
 	 * reserve physical page 0 - it's a special BIOS page on many boxes,
_
