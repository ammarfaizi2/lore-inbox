Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268764AbUIXOMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268764AbUIXOMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUIXOMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:12:25 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:23209
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S268764AbUIXOLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:11:20 -0400
Message-Id: <s1543914.047@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Fri, 24 Sep 2004 16:12:03 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: i386 entry.S problems
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part75556D23.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part75556D23.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There appear to be two problems in i386's entry.S:

(1) With CONFIG_REGPARM, lcall7 and lcall27 did not work (they pass the
parameters to the actual handler procedure on the stack). While using
'asmlinkage' on the handler function would have seemed feasible (leaving
aside binary compatibility issues), it not really is because this is a
pointer to a function and gcc does not check that parameter passing
options match for function pointer assignments, thus making it
impossible to detect improper uses.

(2) In the NMI handler, the second of the checks for whether the
interrupted code was in the stack pointer checking code of the debug
fault/trap handler was reversed, leading to the respective fixup getting
applied whenever the interrupted code was at an address higher than the
debug fault/trap handler.

The patch attempts to address both.

Additionally it seems to me that the code early in the NMI handler that
supposedly checks whether the stack pointer is in range for the
subsequent accesses to the outer stack frame is broken, too. Namely, it
uses THREAD_SIZE to check a pointer that actually follows immediately
the TSS and is not even a single page in size, and is also not
THREAD_SIZE aligned. Thus this test is very likely to fail depending on
the exact address the individual CPU's init_tss ends up on (one may even
say guaranteed, since init_tss should in most configurations live
directly after idt_table and thus at 0x800 bytes into a page). I can't
immediately see a correct replacement for the existing code.

Jan

--- linux-2.6.8.1/arch/i386/kernel/entry.S.0	2004-08-14
12:55:09.000000000 +0200
+++ linux-2.6.8.1/arch/i386/kernel/entry.S	2004-09-24
15:25:13.968031736 +0200
@@ -147,7 +147,9 @@ ENTRY(lcall7)
 	pushl %eax
 	SAVE_ALL
 	movl %esp, %ebp
+#if !defined(CONFIG_REGPARM) || __GNUC__ < 3
 	pushl %ebp
+#endif
 	pushl $0x7
 do_lcall:
 	movl EIP(%ebp), %eax	# due to call gates, this is eflags, not
eip..
@@ -156,11 +158,18 @@ do_lcall:
 	movl %eax,EFLAGS(%ebp)	#
 	movl %edx,EIP(%ebp)	# Now we move them to their "normal"
places
 	movl %ecx,CS(%ebp)	#
-	GET_THREAD_INFO_WITH_ESP(%ebp)	# GET_THREAD_INFO
-	movl TI_exec_domain(%ebp), %edx	# Get the execution domain
-	call *EXEC_DOMAIN_handler(%edx)	# Call the handler for the
domain
-	addl $4, %esp
+#if defined(CONFIG_REGPARM) && __GNUC__ >= 3
 	popl %eax
+#endif
+	GET_THREAD_INFO_WITH_ESP(%ebp)	# GET_THREAD_INFO
+	movl TI_exec_domain(%ebp), %ecx	# Get the execution domain
+#if defined(CONFIG_REGPARM) && __GNUC__ >= 3
+	movl %esp, %edx
+#endif
+	call *EXEC_DOMAIN_handler(%ecx)	# Call the handler for the
domain
+#if !defined(CONFIG_REGPARM) || __GNUC__ < 3
+	addl $8, %esp
+#endif
 	jmp resume_userspace
 
 ENTRY(lcall27)
@@ -169,7 +178,9 @@ ENTRY(lcall27)
 	pushl %eax
 	SAVE_ALL
 	movl %esp, %ebp
+#if !defined(CONFIG_REGPARM) || __GNUC__ < 3
 	pushl %ebp
+#endif
 	pushl $0x27
 	jmp do_lcall
 
@@ -531,10 +542,10 @@ nmi_stack_fixup:
 nmi_debug_stack_check:
 	cmpw $__KERNEL_CS,16(%esp)
 	jne nmi_stack_correct
-	cmpl $debug - 1,(%esp)
-	jle nmi_stack_correct
+	cmpl $debug,(%esp)
+	jb nmi_stack_correct
 	cmpl $debug_esp_fix_insn,(%esp)
-	jle nmi_debug_stack_fixup
+	ja nmi_stack_correct
 nmi_debug_stack_fixup:
 	FIX_STACK(24,nmi_stack_correct, 1)
 	jmp nmi_stack_correct


--=__Part75556D23.0__=
Content-Type: application/octet-stream; name="linux-2.6.8.1-i386-entry.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.8.1-i386-entry.patch"

LS0tIGxpbnV4LTIuNi44LjEvYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TLjAJMjAwNC0wOC0xNCAx
Mjo1NTowOS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi44LjEvYXJjaC9pMzg2L2tlcm5l
bC9lbnRyeS5TCTIwMDQtMDktMjQgMTU6MjU6MTMuOTY4MDMxNzM2ICswMjAwCkBAIC0xNDcsNyAr
MTQ3LDkgQEAgRU5UUlkobGNhbGw3KQogCXB1c2hsICVlYXgKIAlTQVZFX0FMTAogCW1vdmwgJWVz
cCwgJWVicAorI2lmICFkZWZpbmVkKENPTkZJR19SRUdQQVJNKSB8fCBfX0dOVUNfXyA8IDMKIAlw
dXNobCAlZWJwCisjZW5kaWYKIAlwdXNobCAkMHg3CiBkb19sY2FsbDoKIAltb3ZsIEVJUCglZWJw
KSwgJWVheAkjIGR1ZSB0byBjYWxsIGdhdGVzLCB0aGlzIGlzIGVmbGFncywgbm90IGVpcC4uCkBA
IC0xNTYsMTEgKzE1OCwxOCBAQCBkb19sY2FsbDoKIAltb3ZsICVlYXgsRUZMQUdTKCVlYnApCSMK
IAltb3ZsICVlZHgsRUlQKCVlYnApCSMgTm93IHdlIG1vdmUgdGhlbSB0byB0aGVpciAibm9ybWFs
IiBwbGFjZXMKIAltb3ZsICVlY3gsQ1MoJWVicCkJIwotCUdFVF9USFJFQURfSU5GT19XSVRIX0VT
UCglZWJwKQkjIEdFVF9USFJFQURfSU5GTwotCW1vdmwgVElfZXhlY19kb21haW4oJWVicCksICVl
ZHgJIyBHZXQgdGhlIGV4ZWN1dGlvbiBkb21haW4KLQljYWxsICpFWEVDX0RPTUFJTl9oYW5kbGVy
KCVlZHgpCSMgQ2FsbCB0aGUgaGFuZGxlciBmb3IgdGhlIGRvbWFpbgotCWFkZGwgJDQsICVlc3AK
KyNpZiBkZWZpbmVkKENPTkZJR19SRUdQQVJNKSAmJiBfX0dOVUNfXyA+PSAzCiAJcG9wbCAlZWF4
CisjZW5kaWYKKwlHRVRfVEhSRUFEX0lORk9fV0lUSF9FU1AoJWVicCkJIyBHRVRfVEhSRUFEX0lO
Rk8KKwltb3ZsIFRJX2V4ZWNfZG9tYWluKCVlYnApLCAlZWN4CSMgR2V0IHRoZSBleGVjdXRpb24g
ZG9tYWluCisjaWYgZGVmaW5lZChDT05GSUdfUkVHUEFSTSkgJiYgX19HTlVDX18gPj0gMworCW1v
dmwgJWVzcCwgJWVkeAorI2VuZGlmCisJY2FsbCAqRVhFQ19ET01BSU5faGFuZGxlciglZWN4KQkj
IENhbGwgdGhlIGhhbmRsZXIgZm9yIHRoZSBkb21haW4KKyNpZiAhZGVmaW5lZChDT05GSUdfUkVH
UEFSTSkgfHwgX19HTlVDX18gPCAzCisJYWRkbCAkOCwgJWVzcAorI2VuZGlmCiAJam1wIHJlc3Vt
ZV91c2Vyc3BhY2UKIAogRU5UUlkobGNhbGwyNykKQEAgLTE2OSw3ICsxNzgsOSBAQCBFTlRSWShs
Y2FsbDI3KQogCXB1c2hsICVlYXgKIAlTQVZFX0FMTAogCW1vdmwgJWVzcCwgJWVicAorI2lmICFk
ZWZpbmVkKENPTkZJR19SRUdQQVJNKSB8fCBfX0dOVUNfXyA8IDMKIAlwdXNobCAlZWJwCisjZW5k
aWYKIAlwdXNobCAkMHgyNwogCWptcCBkb19sY2FsbAogCkBAIC01MzEsMTAgKzU0MiwxMCBAQCBu
bWlfc3RhY2tfZml4dXA6CiBubWlfZGVidWdfc3RhY2tfY2hlY2s6CiAJY21wdyAkX19LRVJORUxf
Q1MsMTYoJWVzcCkKIAlqbmUgbm1pX3N0YWNrX2NvcnJlY3QKLQljbXBsICRkZWJ1ZyAtIDEsKCVl
c3ApCi0JamxlIG5taV9zdGFja19jb3JyZWN0CisJY21wbCAkZGVidWcsKCVlc3ApCisJamIgbm1p
X3N0YWNrX2NvcnJlY3QKIAljbXBsICRkZWJ1Z19lc3BfZml4X2luc24sKCVlc3ApCi0JamxlIG5t
aV9kZWJ1Z19zdGFja19maXh1cAorCWphIG5taV9zdGFja19jb3JyZWN0CiBubWlfZGVidWdfc3Rh
Y2tfZml4dXA6CiAJRklYX1NUQUNLKDI0LG5taV9zdGFja19jb3JyZWN0LCAxKQogCWptcCBubWlf
c3RhY2tfY29ycmVjdAo=

--=__Part75556D23.0__=--
