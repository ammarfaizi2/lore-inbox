Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTACRi4>; Fri, 3 Jan 2003 12:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbTACRi4>; Fri, 3 Jan 2003 12:38:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32159 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S267599AbTACRiy>; Fri, 3 Jan 2003 12:38:54 -0500
Date: Fri, 3 Jan 2003 17:48:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Matt Domsch <matt_domsch@dell.com>, Pam Delaney <pdelaney@lsil.com>,
       Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] I/O APIC confusion
Message-ID: <Pine.LNX.4.44.0301031743170.10151-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell 2600 could not bring up its MPT Fusion and hung there:
I/O APIC #7 at 0xFEC82000 was muddled with #8 at 0xFEC82800,
because the IO_APIC_BASE fixmap macro assumed page boundary.

No longer do I think all those I/O APIC messages at startup
a waste of log buffer!  Patch against 2.5.54: first appeared
in 2.4.18, then 2.5-dj: please apply.

Hugh

--- 2.5.54/include/asm-i386/io_apic.h	Wed Nov 27 23:48:16 2002
+++ linux/include/asm-i386/io_apic.h	Fri Jan  3 14:29:44 2003
@@ -16,7 +16,8 @@
 #define APIC_MISMATCH_DEBUG
 
 #define IO_APIC_BASE(idx) \
-		((volatile int *)__fix_to_virt(FIX_IO_APIC_BASE_0 + idx))
+		((volatile int *)(__fix_to_virt(FIX_IO_APIC_BASE_0 + idx) \
+		+ (mp_ioapics[idx].mpc_apicaddr & ~PAGE_MASK)))
 
 /*
  * The structure of the IO-APIC:

