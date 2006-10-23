Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbWJWTsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbWJWTsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWJWTsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:48:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:59570 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964996AbWJWTrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:47:49 -0400
Date: Mon, 23 Oct 2006 15:33:59 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 5/11] i386: Reserve kernel memory starting from _text
Message-ID: <20061023193359.GF13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
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
--- linux-2.6.19-rc2-git7-reloc/arch/i386/kernel/setup.c~i386-setup.c-Reserve-kernel-memory-starting-from-_text	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/kernel/setup.c	2006-10-23 13:15:21.000000000 -0400
@@ -1118,8 +1118,8 @@ void __init setup_bootmem_allocator(void
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
