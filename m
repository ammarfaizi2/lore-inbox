Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbUKRKbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUKRKbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbUKRKa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:30:29 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:50686 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262719AbUKRK0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:26:34 -0500
Date: Thu, 18 Nov 2004 15:56:41 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org, akpm@osdl.org, davem@davemloft.net,
       prasanna@in.ibm.com, suparna@in.ibm.com
Subject: [PATCH] Kprobes: wrapper to define jprobe.entry
Message-ID: <20041118102641.GB8830@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch that adds a wrapper for defining jprobe.entry to make
it easy to handle the three dword function descriptors defined by the
PowerPC ELF ABI.

Current patch against 2.6.10-rc2-mm1 + kprobes patch for ppc64.

Changes for adding this wrapper for x86, ppc64 (tested) and x86_64 
(untested) below. The earlier method of defining jprobe.entry will
continue to work.

Here is a pseudocode snippet to use jprobes with this patch.

............
struct jprobe jp;
                                                                                
jtcp_v4_rcv(struct skbuff *skb)
{
        /* decode and log skb related details as required */
                                                                                
        jprobe_return();
        return 0;
}
                                                                                
init_module
{
        jp.kp.addr = (kprobe_opcode_t *)<addr of tcp_v4_rcv>;
        jp.entry = JPROBE_ENTRY(jtcp_v4_rcv);
        register_jprobe(&jp);
        return 0;
}
                                                                                
cleanup_module
{
        unregister_jprobe(&jp);
}
............

Dave,

I am not aware of the semantics for sparc64 for making this change.

Thanks,
Ananth

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

diff -Naurp temp/linux-2.6.10-rc2/include/asm-i386/kprobes.h linux-2.6.10-rc2/include/asm-i386/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-i386/kprobes.h	2004-11-15 06:57:53.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-i386/kprobes.h	2004-11-18 12:28:03.873952360 +0530
@@ -38,6 +38,8 @@ typedef u8 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
diff -Naurp temp/linux-2.6.10-rc2/include/asm-ppc64/kprobes.h linux-2.6.10-rc2/include/asm-ppc64/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-ppc64/kprobes.h	2004-11-18 12:26:43.236962848 +0530
+++ linux-2.6.10-rc2/include/asm-ppc64/kprobes.h	2004-11-18 12:28:03.875952056 +0530
@@ -35,6 +35,8 @@ typedef unsigned int kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
 #define MAX_INSN_SIZE 1
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
+
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
 	/* copy of original instruction */
diff -Naurp temp/linux-2.6.10-rc2/include/asm-x86_64/kprobes.h linux-2.6.10-rc2/include/asm-x86_64/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-x86_64/kprobes.h	2004-11-15 06:56:41.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-x86_64/kprobes.h	2004-11-18 12:28:03.877951752 +0530
@@ -37,6 +37,8 @@ typedef u8 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
