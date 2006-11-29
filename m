Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967130AbWK2LMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967130AbWK2LMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967133AbWK2LMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:12:19 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14102
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S967130AbWK2LMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:12:18 -0500
Message-Id: <456D7985.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 29 Nov 2006 11:13:57 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] more sanity checks in Dwarf2 unwinder
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tighten the requirements on both input to and output from the Dwarf2
unwinder.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-rc6/arch/i386/kernel/traps.c	2006-11-29 10:03:03.000000000 +0100
+++ 2.6.19-rc6-unwind-more-sanity-checks/arch/i386/kernel/traps.c	2006-11-28 17:18:45.000000000 +0100
@@ -159,12 +159,19 @@ dump_trace_unwind(struct unwind_frame_in
 {
 	struct ops_and_data *oad = (struct ops_and_data *)data;
 	int n = 0;
+	unsigned long sp = UNW_SP(info);
 
+	if (arch_unw_user_mode(info))
+		return -1;
 	while (unwind(info) == 0 && UNW_PC(info)) {
 		n++;
 		oad->ops->address(oad->data, UNW_PC(info));
 		if (arch_unw_user_mode(info))
 			break;
+		if ((sp & ~(PAGE_SIZE - 1)) == (UNW_SP(info) & ~(PAGE_SIZE - 1))
+		    && sp > UNW_SP(info))
+			break;
+		sp = UNW_SP(info);
 	}
 	return n;
 }
--- linux-2.6.19-rc6/arch/x86_64/kernel/traps.c	2006-11-29 10:03:18.000000000 +0100
+++ 2.6.19-rc6-unwind-more-sanity-checks/arch/x86_64/kernel/traps.c	2006-11-28 17:18:28.000000000 +0100
@@ -225,12 +225,19 @@ static int dump_trace_unwind(struct unwi
 {
 	struct ops_and_data *oad = (struct ops_and_data *)context;
 	int n = 0;
+	unsigned long sp = UNW_SP(info);
 
+	if (arch_unw_user_mode(info))
+		return -1;
 	while (unwind(info) == 0 && UNW_PC(info)) {
 		n++;
 		oad->ops->address(oad->data, UNW_PC(info));
 		if (arch_unw_user_mode(info))
 			break;
+		if ((sp & ~(PAGE_SIZE - 1)) == (UNW_SP(info) & ~(PAGE_SIZE - 1))
+		    && sp > UNW_SP(info))
+			break;
+		sp = UNW_SP(info);
 	}
 	return n;
 }
--- linux-2.6.19-rc6/include/asm-i386/unwind.h	2006-11-29 10:04:04.000000000 +0100
+++ 2.6.19-rc6-unwind-more-sanity-checks/include/asm-i386/unwind.h	2006-11-28 17:20:26.000000000 +0100
@@ -78,17 +78,13 @@ extern asmlinkage int arch_unwind_init_r
                                                                           void *arg),
                                                void *arg);
 
-static inline int arch_unw_user_mode(const struct unwind_frame_info *info)
+static inline int arch_unw_user_mode(/*const*/ struct unwind_frame_info *info)
 {
-#if 0 /* This can only work when selector register and EFLAGS saves/restores
-         are properly annotated (and tracked in UNW_REGISTER_INFO). */
-	return user_mode_vm(&info->regs);
-#else
-	return info->regs.eip < PAGE_OFFSET
+	return user_mode_vm(&info->regs)
+	       || info->regs.eip < PAGE_OFFSET
 	       || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
-	            && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
+	           && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
 	       || info->regs.esp < PAGE_OFFSET;
-#endif
 }
 
 #else
--- linux-2.6.19-rc6/include/asm-x86_64/unwind.h	2006-11-29 10:04:06.000000000 +0100
+++ 2.6.19-rc6-unwind-more-sanity-checks/include/asm-x86_64/unwind.h	2006-11-28 17:18:08.000000000 +0100
@@ -87,14 +87,10 @@ extern int arch_unwind_init_running(stru
 
 static inline int arch_unw_user_mode(const struct unwind_frame_info *info)
 {
-#if 0 /* This can only work when selector register saves/restores
-         are properly annotated (and tracked in UNW_REGISTER_INFO). */
-	return user_mode(&info->regs);
-#else
-	return (long)info->regs.rip >= 0
+	return user_mode(&info->regs)
+	       || (long)info->regs.rip >= 0
 	       || (info->regs.rip >= VSYSCALL_START && info->regs.rip < VSYSCALL_END)
 	       || (long)info->regs.rsp >= 0;
-#endif
 }
 
 #else
--- linux-2.6.19-rc6/kernel/unwind.c	2006-11-29 10:04:11.000000000 +0100
+++ 2.6.19-rc6-unwind-more-sanity-checks/kernel/unwind.c	2006-11-28 16:35:58.000000000 +0100
@@ -94,6 +94,7 @@ static const struct {
 
 typedef unsigned long uleb128_t;
 typedef   signed long sleb128_t;
+#define sleb128abs __builtin_labs
 
 static struct unwind_table {
 	struct {
@@ -786,7 +787,7 @@ int unwind(struct unwind_frame_info *fra
 #define FRAME_REG(r, t) (((t *)frame)[reg_info[r].offs])
 	const u32 *fde = NULL, *cie = NULL;
 	const u8 *ptr = NULL, *end = NULL;
-	unsigned long pc = UNW_PC(frame) - frame->call_frame;
+	unsigned long pc = UNW_PC(frame) - frame->call_frame, sp;
 	unsigned long startLoc = 0, endLoc = 0, cfa;
 	unsigned i;
 	signed ptrType = -1;
@@ -935,6 +936,9 @@ int unwind(struct unwind_frame_info *fra
 		state.dataAlign = get_sleb128(&ptr, end);
 		if (state.codeAlign == 0 || state.dataAlign == 0 || ptr >= end)
 			cie = NULL;
+		else if (UNW_PC(frame) % state.codeAlign
+		         || UNW_SP(frame) % sleb128abs(state.dataAlign))
+			return -EPERM;
 		else {
 			retAddrReg = state.version <= 1 ? *ptr++ : get_uleb128(&ptr, end);
 			/* skip augmentation */
@@ -966,6 +970,8 @@ int unwind(struct unwind_frame_info *fra
 #endif
 
 #ifdef CONFIG_FRAME_POINTER
+		if ((UNW_SP(frame) | UNW_FP(frame)) % sizeof(unsigned long))
+			return -EPERM;
 		top = STACK_TOP(frame->task);
 		bottom = STACK_BOTTOM(frame->task);
 # if FRAME_RETADDR_OFFSET < 0
@@ -1015,6 +1021,7 @@ int unwind(struct unwind_frame_info *fra
 	   || state.regs[retAddrReg].where == Nowhere
 	   || state.cfa.reg >= ARRAY_SIZE(reg_info)
 	   || reg_info[state.cfa.reg].width != sizeof(unsigned long)
+	   || FRAME_REG(state.cfa.reg, unsigned long) % sizeof(unsigned long)
 	   || state.cfa.offs % sizeof(unsigned long))
 		return -EIO;
 	/* update frame */
@@ -1035,6 +1042,8 @@ int unwind(struct unwind_frame_info *fra
 #else
 # define CASES CASE(8); CASE(16); CASE(32); CASE(64)
 #endif
+	pc = UNW_PC(frame);
+	sp = UNW_SP(frame);
 	for (i = 0; i < ARRAY_SIZE(state.regs); ++i) {
 		if (REG_INVALID(i)) {
 			if (state.regs[i].where == Nowhere)
@@ -1115,6 +1124,11 @@ int unwind(struct unwind_frame_info *fra
 		}
 	}
 
+	if (UNW_PC(frame) % state.codeAlign
+	    || UNW_SP(frame) % sleb128abs(state.dataAlign)
+	    || (pc == UNW_PC(frame) && sp == UNW_SP(frame)))
+		return -EIO;
+
 	return 0;
 #undef CASES
 #undef FRAME_REG


