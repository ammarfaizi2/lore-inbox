Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267541AbUHEEqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267541AbUHEEqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHEEow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:44:52 -0400
Received: from holomorphy.com ([207.189.100.168]:62400 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267499AbUHEEoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:44:30 -0400
Date: Wed, 4 Aug 2004 21:44:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [4/13] smp_processor_id() BITFIXUP fixes
Message-ID: <20040805044427.GV2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805044130.GU2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:41:30PM -0700, William Lee Irwin III wrote:
> cpu_present_map is a cpumask_t. Sweep arch/sparc/kernel/sun4d_smp.c so
> that it is treated as such.

The SMP initialization functions try to do btfixups on the wrong
symbols for smp_processor_id(), which is now implemented in terms
of current_thread_info()->cpu. hard_smp_processor_id() etc. are now
in use where smp_processor_id() was once used.


Index: mm2-2.6.8-rc2/arch/sparc/kernel/sun4m_smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/sun4m_smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/sun4m_smp.c
@@ -458,9 +458,9 @@
 
 void __init sun4m_init_smp(void)
 {
-	BTFIXUPSET_BLACKBOX(smp_processor_id, smp4m_blackbox_id);
+	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, smp4m_blackbox_id);
 	BTFIXUPSET_BLACKBOX(load_current, smp4m_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4m_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_message_pass, smp4m_message_pass, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__smp_processor_id, __smp4m_processor_id, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4m_processor_id, BTFIXUPCALL_NORM);
 }
Index: mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/sun4d_smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
@@ -496,11 +496,11 @@
 	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);
 	
 	/* And set btfixup... */
-	BTFIXUPSET_BLACKBOX(smp_processor_id, smp4d_blackbox_id);
+	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, smp4d_blackbox_id);
 	BTFIXUPSET_BLACKBOX(load_current, smp4d_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4d_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_message_pass, smp4d_message_pass, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__smp_processor_id, __smp4d_processor_id, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4d_processor_id, BTFIXUPCALL_NORM);
 	
 	for (i = 0; i < NR_CPUS; i++) {
 		ccall_info.processors_in[i] = 1;
