Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWIKPhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWIKPhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWIKPhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:37:03 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:39624
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964884AbWIKPhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:37:00 -0400
Message-Id: <45059EEB.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 11 Sep 2006 16:37:47 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Michael Matz" <matz@suse.de>, "Richard Guenther" <rguenther@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [development-gcc] Re: do_exit stuck
References: <200608291332.18499.ak@suse.de>
 <Pine.LNX.4.64.0608301626150.6582@wotan.suse.de>
 <44F5CAD0.76E4.0078.0@novell.com> <200608301740.41729.ak@suse.de>
In-Reply-To: <200608301740.41729.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 30.08.06 17:40 >>>
>On Wednesday 30 August 2006 17:28, Jan Beulich wrote:
>> >Hmm, yes.  Sigh, so it's either gcc changes or binutils changes, and none 
>> >of that can be relied upon, except someone has a better idea to identify 
>> >signal frames with high enough assurance to be sensible for debugging.
>> 
>> The only alternative idea I have is to take into consideration the location
>> of the return address: if it's at the default location (top of call frame),
>> then assume this is a normal frame, in all other cases assume it's an
>> interrupt/exception one. This will probably get a few cases wrong
>> (where the return address is being played with), but it might be better
>> than the current situation. Andi?
>
>Fine by me.
>
>At least it will likely be less controversal than changing all the noreturns :)

Here's a patch, including all that I think is necessary once we selectively
enable (auto-detect) CONFIG_AS_CFI_SIGNAL_FRAME for newer binutils.
It doesn't include adjustment of the printed address (i.e. for the original
example, it'd still be kernel_math_error+0 that gets displayed, but the
unwinder wouldn't get confused anymore.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.18-rc6/arch/i386/kernel/entry.S	2006-09-11 17:18:19.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/arch/i386/kernel/entry.S	2006-09-11 15:26:14.000000000 +0200
@@ -176,18 +176,21 @@ VM_MASK		= 0x00020000
 
 #define RING0_INT_FRAME \
 	CFI_STARTPROC simple;\
+	CFI_SIGNAL_FRAME;\
 	CFI_DEF_CFA esp, 3*4;\
 	/*CFI_OFFSET cs, -2*4;*/\
 	CFI_OFFSET eip, -3*4
 
 #define RING0_EC_FRAME \
 	CFI_STARTPROC simple;\
+	CFI_SIGNAL_FRAME;\
 	CFI_DEF_CFA esp, 4*4;\
 	/*CFI_OFFSET cs, -2*4;*/\
 	CFI_OFFSET eip, -3*4
 
 #define RING0_PTREGS_FRAME \
 	CFI_STARTPROC simple;\
+	CFI_SIGNAL_FRAME;\
 	CFI_DEF_CFA esp, OLDESP-EBX;\
 	/*CFI_OFFSET cs, CS-OLDESP;*/\
 	CFI_OFFSET eip, EIP-OLDESP;\
@@ -263,6 +266,7 @@ need_resched:
 	# sysenter call handler stub
 ENTRY(sysenter_entry)
 	CFI_STARTPROC simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA esp, 0
 	CFI_REGISTER esp, ebp
 	movl TSS_sysenter_esp0(%esp),%esp
--- linux-2.6.18-rc6/arch/x86_64/ia32/ia32entry.S	2006-09-11 17:18:24.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/arch/x86_64/ia32/ia32entry.S	2006-09-11 15:28:10.000000000 +0200
@@ -71,6 +71,7 @@
  */ 	
 ENTRY(ia32_sysenter_target)
 	CFI_STARTPROC32	simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA	rsp,0
 	CFI_REGISTER	rsp,rbp
 	swapgs
@@ -186,6 +187,7 @@ ENDPROC(ia32_sysenter_target)
  */ 	
 ENTRY(ia32_cstar_target)
 	CFI_STARTPROC32	simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA	rsp,PDA_STACKOFFSET
 	CFI_REGISTER	rip,rcx
 	/*CFI_REGISTER	rflags,r11*/
@@ -293,6 +295,7 @@ ia32_badarg:
 
 ENTRY(ia32_syscall)
 	CFI_STARTPROC	simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA	rsp,SS+8-RIP
 	/*CFI_REL_OFFSET	ss,SS-RIP*/
 	CFI_REL_OFFSET	rsp,RSP-RIP
@@ -370,6 +373,7 @@ ENTRY(ia32_ptregs_common)
 	popq %r11
 	CFI_ENDPROC
 	CFI_STARTPROC32	simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA	rsp,SS+8-ARGOFFSET
 	CFI_REL_OFFSET	rax,RAX-ARGOFFSET
 	CFI_REL_OFFSET	rcx,RCX-ARGOFFSET
--- linux-2.6.18-rc6/arch/x86_64/kernel/entry.S	2006-09-11 17:18:24.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/arch/x86_64/kernel/entry.S	2006-09-11 15:26:47.000000000 +0200
@@ -115,6 +115,7 @@
 	.macro	CFI_DEFAULT_STACK start=1
 	.if \start
 	CFI_STARTPROC	simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA	rsp,SS+8
 	.else
 	CFI_DEF_CFA_OFFSET SS+8
@@ -199,6 +200,7 @@ END(ret_from_fork)
 
 ENTRY(system_call)
 	CFI_STARTPROC	simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA	rsp,PDA_STACKOFFSET
 	CFI_REGISTER	rip,rcx
 	/*CFI_REGISTER	rflags,r11*/
@@ -316,6 +318,7 @@ END(system_call)
  */ 	
 ENTRY(int_ret_from_sys_call)
 	CFI_STARTPROC	simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA	rsp,SS+8-ARGOFFSET
 	/*CFI_REL_OFFSET	ss,SS-ARGOFFSET*/
 	CFI_REL_OFFSET	rsp,RSP-ARGOFFSET
@@ -476,6 +479,7 @@ END(stub_rt_sigreturn)
  */
 	.macro _frame ref
 	CFI_STARTPROC simple
+	CFI_SIGNAL_FRAME
 	CFI_DEF_CFA rsp,SS+8-\ref
 	/*CFI_REL_OFFSET ss,SS-\ref*/
 	CFI_REL_OFFSET rsp,RSP-\ref
--- linux-2.6.18-rc6/include/asm-i386/dwarf2.h	2006-09-11 17:18:42.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/include/asm-i386/dwarf2.h	2006-09-11 15:16:45.000000000 +0200
@@ -28,6 +28,11 @@
 #define CFI_RESTORE .cfi_restore
 #define CFI_REMEMBER_STATE .cfi_remember_state
 #define CFI_RESTORE_STATE .cfi_restore_state
+#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
+#define CFI_SIGNAL_FRAME .cfi_signal_frame
+#else
+#define CFI_SIGNAL_FRAME
+#endif
 
 #else
 
@@ -48,6 +53,7 @@
 #define CFI_RESTORE	ignore
 #define CFI_REMEMBER_STATE ignore
 #define CFI_RESTORE_STATE ignore
+#define CFI_SIGNAL_FRAME ignore
 
 #endif
 
--- linux-2.6.18-rc6/include/asm-i386/unwind.h	2006-09-11 17:18:42.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/include/asm-i386/unwind.h	2006-09-11 16:10:20.000000000 +0200
@@ -18,6 +18,7 @@ struct unwind_frame_info
 {
 	struct pt_regs regs;
 	struct task_struct *task;
+	unsigned call_frame:1;
 };
 
 #define UNW_PC(frame)        (frame)->regs.eip
@@ -42,6 +43,10 @@ struct unwind_frame_info
 	PTREGS_INFO(edi), \
 	PTREGS_INFO(eip)
 
+#define UNW_DEFAULT_RA(raItem, dataAlign) \
+	((raItem).where == Memory && \
+	 !((raItem).value * (dataAlign) + 4))
+
 static inline void arch_unw_init_frame_info(struct unwind_frame_info *info,
                                             /*const*/ struct pt_regs *regs)
 {
--- linux-2.6.18-rc6/include/asm-x86_64/dwarf2.h	2006-09-11 17:18:44.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/include/asm-x86_64/dwarf2.h	2006-09-11 15:17:13.000000000 +0200
@@ -28,6 +28,11 @@
 #define CFI_REMEMBER_STATE .cfi_remember_state
 #define CFI_RESTORE_STATE .cfi_restore_state
 #define CFI_UNDEFINED .cfi_undefined
+#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
+#define CFI_SIGNAL_FRAME .cfi_signal_frame
+#else
+#define CFI_SIGNAL_FRAME
+#endif
 
 #else
 
@@ -45,6 +50,7 @@
 #define CFI_REMEMBER_STATE	#
 #define CFI_RESTORE_STATE	#
 #define CFI_UNDEFINED	#
+#define CFI_SIGNAL_FRAME	#
 
 #endif
 
--- linux-2.6.18-rc6/include/asm-x86_64/unwind.h	2006-09-11 17:18:44.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/include/asm-x86_64/unwind.h	2006-09-11 16:10:29.000000000 +0200
@@ -18,6 +18,7 @@ struct unwind_frame_info
 {
 	struct pt_regs regs;
 	struct task_struct *task;
+	unsigned call_frame:1;
 };
 
 #define UNW_PC(frame)        (frame)->regs.rip
@@ -57,6 +58,10 @@ struct unwind_frame_info
 	PTREGS_INFO(r15), \
 	PTREGS_INFO(rip)
 
+#define UNW_DEFAULT_RA(raItem, dataAlign) \
+	((raItem).where == Memory && \
+	 !((raItem).value * (dataAlign) + 8))
+
 static inline void arch_unw_init_frame_info(struct unwind_frame_info *info,
                                             /*const*/ struct pt_regs *regs)
 {
--- linux-2.6.18-rc6/kernel/unwind.c	2006-09-11 17:18:46.000000000 +0200
+++ 2.6.18-rc6-unwind-adjust-caller-pc/kernel/unwind.c	2006-09-11 16:44:02.000000000 +0200
@@ -603,6 +603,7 @@ int unwind(struct unwind_frame_info *fra
 #define FRAME_REG(r, t) (((t *)frame)[reg_info[r].offs])
 	const u32 *fde = NULL, *cie = NULL;
 	const u8 *ptr = NULL, *end = NULL;
+	unsigned long pc = UNW_PC(frame) - frame->call_frame;
 	unsigned long startLoc = 0, endLoc = 0, cfa;
 	unsigned i;
 	signed ptrType = -1;
@@ -612,7 +613,7 @@ int unwind(struct unwind_frame_info *fra
 
 	if (UNW_PC(frame) == 0)
 		return -EINVAL;
-	if ((table = find_table(UNW_PC(frame))) != NULL
+	if ((table = find_table(pc)) != NULL
 	    && !(table->size & (sizeof(*fde) - 1))) {
 		unsigned long tableSize = table->size;
 
@@ -647,7 +648,7 @@ int unwind(struct unwind_frame_info *fra
 			                        ptrType & DW_EH_PE_indirect
 			                        ? ptrType
 			                        : ptrType & (DW_EH_PE_FORM|DW_EH_PE_signed));
-			if (UNW_PC(frame) >= startLoc && UNW_PC(frame) < endLoc)
+			if (pc >= startLoc && pc < endLoc)
 				break;
 			cie = NULL;
 		}
@@ -657,16 +658,28 @@ int unwind(struct unwind_frame_info *fra
 		state.cieEnd = ptr; /* keep here temporarily */
 		ptr = (const u8 *)(cie + 2);
 		end = (const u8 *)(cie + 1) + *cie;
+		frame->call_frame = 1;
 		if ((state.version = *ptr) != 1)
 			cie = NULL; /* unsupported version */
 		else if (*++ptr) {
 			/* check if augmentation size is first (and thus present) */
 			if (*ptr == 'z') {
-				/* check for ignorable (or already handled)
-				 * nul-terminated augmentation string */
-				while (++ptr < end && *ptr)
-					if (strchr("LPR", *ptr) == NULL)
+				while (++ptr < end && *ptr) {
+					switch(*ptr) {
+					/* check for ignorable (or already handled)
+					 * nul-terminated augmentation string */
+					case 'L':
+					case 'P':
+					case 'R':
+						continue;
+					case 'S':
+						frame->call_frame = 0;
+						continue;
+					default:
 						break;
+					}
+					break;
+				}
 			}
 			if (ptr >= end || *ptr)
 				cie = NULL;
@@ -755,7 +768,7 @@ int unwind(struct unwind_frame_info *fra
 	state.org = startLoc;
 	memcpy(&state.cfa, &badCFA, sizeof(state.cfa));
 	/* process instructions */
-	if (!processCFI(ptr, end, UNW_PC(frame), ptrType, &state)
+	if (!processCFI(ptr, end, pc, ptrType, &state)
 	   || state.loc > endLoc
 	   || state.regs[retAddrReg].where == Nowhere
 	   || state.cfa.reg >= ARRAY_SIZE(reg_info)
@@ -763,6 +776,11 @@ int unwind(struct unwind_frame_info *fra
 	   || state.cfa.offs % sizeof(unsigned long))
 		return -EIO;
 	/* update frame */
+#ifndef CONFIG_AS_CFI_SIGNAL_FRAME
+	if(frame->call_frame
+	   && !UNW_DEFAULT_RA(state.regs[retAddrReg], state.dataAlign))
+		frame->call_frame = 0;
+#endif
 	cfa = FRAME_REG(state.cfa.reg, unsigned long) + state.cfa.offs;
 	startLoc = min((unsigned long)UNW_SP(frame), cfa);
 	endLoc = max((unsigned long)UNW_SP(frame), cfa);
@@ -866,6 +884,7 @@ int unwind_init_frame_info(struct unwind
                            /*const*/ struct pt_regs *regs)
 {
 	info->task = tsk;
+	info->call_frame = 0;
 	arch_unw_init_frame_info(info, regs);
 
 	return 0;
@@ -879,6 +898,7 @@ int unwind_init_blocked(struct unwind_fr
                         struct task_struct *tsk)
 {
 	info->task = tsk;
+	info->call_frame = 0;
 	arch_unw_init_blocked(info);
 
 	return 0;
@@ -894,6 +914,7 @@ int unwind_init_running(struct unwind_fr
                         void *arg)
 {
 	info->task = current;
+	info->call_frame = 0;
 
 	return arch_unwind_init_running(info, callback, arg);
 }


