Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267467AbUGNSib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267467AbUGNSib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267459AbUGNSia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:38:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:23682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265200AbUGNShu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:37:50 -0400
Subject: [PATCH] mmap PROT_NONE fix (was Re: serious performance regression
	due to NX patch)
From: Daniel McNeil <daniel@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Mark Haverkamp <markh@osdl.org>, davidm@hpl.hp.com,
       Linus Torvalds <torvalds@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1089737382.2600.60.camel@ibm-c.pdx.osdl.net>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	 <20040711123803.GD21264@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
	 <16626.62318.880165.774044@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
	 <1089734729.1356.79.camel@markh1.pdx.osdl.net>
	 <1089737382.2600.60.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1089830200.2285.25.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 11:36:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes mmap PROT_NONE from elf binaries that do not
have the PT_GNU_STACK so that the do not have execute permission.

Before this fix, calling access() with a PROT_NONE page
was returning ENOENT instead of EFAULT.

BEFORE: 
$ x.gcc322
p2=0x40013000
pid=1982
 
access 0 ptr (nil) return code -1 errno 14
access result:: Bad address
access 1 ptr 0xffffffff return code -1 errno 14
access result:: Bad address
access 2 ptr 0x40013000 return code -1 errno 2
access result:: No such file or directory

AFTER:

$ ./x.gcc322
p2=0x40017000
pid=2492
                                                                                
access 0 ptr (nil) return code -1 errno 14
access result:: Bad address
access 1 ptr 0xffffffff return code -1 errno 14
access result:: Bad address
access 2 ptr 0x40017000 return code -1 errno 14
access result:: Bad address


Program available at
http://developer.osdl.org/daniel/mmap.PROT_NONE.bug/

Here is the patch.

Signed-off-by: Daniel McNeil <daniel@osdl.org>


===== mm/mmap.c 1.133 vs edited =====
--- 1.133/mm/mmap.c	2004-06-29 07:43:12 -07:00
+++ edited/mm/mmap.c	2004-07-14 09:56:37 -07:00
@@ -792,6 +792,12 @@
 	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
+	/*
+	 * mm->def_flags might have VM_EXEC set, which PROT_NONE does NOT want.
+	 */
+	if (prot == PROT_NONE)
+		vm_flags &= ~VM_EXEC;
+
 	if (flags & MAP_LOCKED) {
 		if (!capable(CAP_IPC_LOCK))
 			return -EPERM;


