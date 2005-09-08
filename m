Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVIHOsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVIHOsD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbVIHOsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:48:03 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:32350
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751377AbVIHOsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:48:01 -0400
Message-Id: <43206B84020000780002443D@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 16:49:08 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] pass irq handling status down to low-level code
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part30125E74.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part30125E74.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

In order for low-level code to know whether/how a hardware interrupt
was
serviced, make sure this information gets passed down correctly.

At once, use the proper type (irqreturn_t) for returning this
information,
which in turn required breaking up a header into two to resolve
recursive
inclusion problems resulting otherwise.

Architecture dependent code needs to change for this to fully work,
but
no change should be necessary if the described functionality isn't
consumed on a given architecture. Thus respective adjustments in this
patch
are only to those architectures I have further depend code for (i386,
x86_64, ia64).

(Kernel debuggers may want to convert a hardware interrupt, say from a
hot key press, into a pseudo-exception, requiring that they should
have
a way to get this information communicated from the respective
interrupt
handler. For this to fully work, additional adjustments are necessary,
so this is meant ot only be the first step.)

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/irq.c
2.6.13-irqreturn/arch/i386/kernel/irq.c
--- 2.6.13/arch/i386/kernel/irq.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-irqreturn/arch/i386/kernel/irq.c	2005-09-01
11:32:11.000000000 +0200
@@ -51,7 +51,7 @@ static union irq_ctx *softirq_ctx[NR_CPU
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-fastcall unsigned int do_IRQ(struct pt_regs *regs)
+fastcall irqreturn_t do_IRQ(struct pt_regs *regs)
 {	
 	/* high bits used in ret_from_ code */
 	int irq = regs->orig_eax & 0xff;
@@ -59,6 +59,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
 #endif
+	irqreturn_t ret;
 
 	irq_enter();
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
@@ -88,7 +89,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 	 * current stack (which is the irq stack already after all)
 	 */
 	if (curctx != irqctx) {
-		int arg1, arg2, ebx;
+		int edx, ebx;
 
 		/* build the stack frame on the IRQ stack */
 		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
@@ -99,17 +100,17 @@ fastcall unsigned int do_IRQ(struct pt_r
 			"       xchgl   %%ebx,%%esp      \n"
 			"       call    __do_IRQ         \n"
 			"       movl   %%ebx,%%esp      \n"
-			: "=a" (arg1), "=d" (arg2), "=b" (ebx)
-			:  "0" (irq),   "1" (regs),  "2" (isp)
+			: "=a" (ret), "=d" (edx), "=b" (ebx)
+			:  "0" (irq),  "1" (regs), "2" (isp)
 			: "memory", "cc", "ecx"
 		);
 	} else
 #endif
-		__do_IRQ(irq, regs);
+		ret = __do_IRQ(irq, regs);
 
 	irq_exit();
 
-	return 1;
+	return ret;
 }
 
 #ifdef CONFIG_4KSTACKS
diff -Npru 2.6.13/arch/i386/mach-visws/visws_apic.c
2.6.13-irqreturn/arch/i386/mach-visws/visws_apic.c
--- 2.6.13/arch/i386/mach-visws/visws_apic.c	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-irqreturn/arch/i386/mach-visws/visws_apic.c	2005-03-16
12:24:41.000000000 +0100
@@ -198,6 +198,7 @@ static irqreturn_t piix4_master_intr(int
 	int realirq;
 	irq_desc_t *desc;
 	unsigned long flags;
+	irqreturn_t ret;
 
 	spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -246,12 +247,14 @@ static irqreturn_t piix4_master_intr(int
 	kstat_cpu(smp_processor_id()).irqs[realirq]++;
 
 	if (likely(desc->action != NULL))
-		handle_IRQ_event(realirq, regs, desc->action);
+		ret = handle_IRQ_event(realirq, regs, desc->action);
+	else
+		ret = IRQ_NONE;
 
 	if (!(desc->status & IRQ_DISABLED))
 		enable_8259A_irq(realirq);
 
-	return IRQ_HANDLED;
+	return ret;
 
 out_unlock:
 	spin_unlock_irqrestore(&i8259A_lock, flags);
diff -Npru 2.6.13/arch/ia64/kernel/irq_ia64.c
2.6.13-irqreturn/arch/ia64/kernel/irq_ia64.c
--- 2.6.13/arch/ia64/kernel/irq_ia64.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-irqreturn/arch/ia64/kernel/irq_ia64.c	2005-09-01
14:08:15.000000000 +0200
@@ -99,10 +99,11 @@ free_irq_vector (int vector)
  * interrupt. This branches to the correct hardware IRQ handler via
  * function ptr.
  */
-void
+irqreturn_t
 ia64_handle_irq (ia64_vector vector, struct pt_regs *regs)
 {
 	unsigned long saved_tpr;
+	irqreturn_t ret;
 
 #if IRQ_DEBUG
 	{
@@ -142,12 +143,13 @@ ia64_handle_irq (ia64_vector vector, str
 	irq_enter();
 	saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
 	ia64_srlz_d();
+	ret = IRQ_NONE;
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (!IS_RESCHEDULE(vector)) {
 			ia64_setreg(_IA64_REG_CR_TPR, vector);
 			ia64_srlz_d();
 
-			__do_IRQ(local_vector_to_irq(vector), regs);
+			ret |= __do_IRQ(local_vector_to_irq(vector),
regs);
 
 			/*
 			 * Disable interrupts and send EOI:
@@ -164,6 +166,7 @@ ia64_handle_irq (ia64_vector vector, str
 	 * come through until ia64_eoi() has been done.
 	 */
 	irq_exit();
+	return ret;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff -Npru 2.6.13/arch/x86_64/kernel/irq.c
2.6.13-irqreturn/arch/x86_64/kernel/irq.c
--- 2.6.13/arch/x86_64/kernel/irq.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-irqreturn/arch/x86_64/kernel/irq.c	2005-09-01
11:32:11.000000000 +0200
@@ -93,18 +93,19 @@ skip:
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(struct pt_regs *regs)
+asmlinkage irqreturn_t do_IRQ(struct pt_regs *regs)
 {	
 	/* high bits used in ret_from_ code  */
 	unsigned irq = regs->orig_rax & 0xff;
+	irqreturn_t ret = IRQ_NONE;
 
 	irq_enter();
-	BUG_ON(irq > 256);
 
-	__do_IRQ(irq, regs);
+	ret = __do_IRQ(irq, regs);
+
 	irq_exit();
 
-	return 1;
+	return ret;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff -Npru 2.6.13/include/linux/interrupt.h
2.6.13-irqreturn/include/linux/interrupt.h
--- 2.6.13/include/linux/interrupt.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-irqreturn/include/linux/interrupt.h	2005-03-21
14:20:20.000000000 +0100
@@ -8,31 +8,12 @@
 #include <linux/bitops.h>
 #include <linux/preempt.h>
 #include <linux/cpumask.h>
+#include <linux/irqreturn.h>
 #include <linux/hardirq.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 
-/*
- * For 2.4.x compatibility, 2.4.x can use
- *
- *	typedef void irqreturn_t;
- *	#define IRQ_NONE
- *	#define IRQ_HANDLED
- *	#define IRQ_RETVAL(x)
- *
- * To mix old-style and new-style irq handler returns.
- *
- * IRQ_NONE means we didn't handle it.
- * IRQ_HANDLED means that we did have a valid interrupt and handled
it.
- * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for
handled)
- */
-typedef int irqreturn_t;
-
-#define IRQ_NONE	(0)
-#define IRQ_HANDLED	(1)
-#define IRQ_RETVAL(x)	((x) != 0)
-
 struct irqaction {
 	irqreturn_t (*handler)(int, void *, struct pt_regs *);
 	unsigned long flags;
diff -Npru 2.6.13/include/linux/irq.h
2.6.13-irqreturn/include/linux/irq.h
--- 2.6.13/include/linux/irq.h	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-irqreturn/include/linux/irq.h	2005-09-01
17:43:05.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
+#include <linux/irqreturn.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
@@ -86,7 +87,7 @@ extern int noirqdebug_setup(char *str);
 
 extern fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs
*regs,
 					struct irqaction *action);
-extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs
*regs);
+extern fastcall irqreturn_t __do_IRQ(unsigned int irq, struct pt_regs
*regs);
 extern void note_interrupt(unsigned int irq, irq_desc_t *desc,
 					int action_ret, struct pt_regs
*regs);
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
diff -Npru 2.6.13/include/linux/irqreturn.h
2.6.13-irqreturn/include/linux/irqreturn.h
--- 2.6.13/include/linux/irqreturn.h	1970-01-01 01:00:00.000000000
+0100
+++ 2.6.13-irqreturn/include/linux/irqreturn.h	2005-03-21
14:21:06.000000000 +0100
@@ -0,0 +1,27 @@
+/* irqreturn.h */
+#ifndef _LINUX_IRQRETURN_H
+#define _LINUX_IRQRETURN_H
+
+#include <linux/config.h>
+
+/*
+ * For 2.4.x compatibility, 2.4.x can use
+ *
+ *	typedef void irqreturn_t;
+ *	#define IRQ_NONE
+ *	#define IRQ_HANDLED
+ *	#define IRQ_RETVAL(x)
+ *
+ * To mix old-style and new-style irq handler returns.
+ *
+ * IRQ_NONE means we didn't handle it.
+ * IRQ_HANDLED means that we did have a valid interrupt and handled
it.
+ * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for
handled)
+ */
+typedef int irqreturn_t;
+
+#define IRQ_NONE	(0)
+#define IRQ_HANDLED	(1)
+#define IRQ_RETVAL(x)	((x) != 0)
+
+#endif
diff -Npru 2.6.13/kernel/irq/handle.c
2.6.13-irqreturn/kernel/irq/handle.c
--- 2.6.13/kernel/irq/handle.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-irqreturn/kernel/irq/handle.c	2005-09-01
17:54:23.000000000 +0200
@@ -76,16 +76,18 @@ irqreturn_t no_action(int cpl, void *dev
 /*
  * Have got an event to handle:
  */
-fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+fastcall irqreturn_t handle_IRQ_event(unsigned int irq, struct pt_regs
*regs,
 				struct irqaction *action)
 {
-	int ret, retval = 0, status = 0;
+	int status = 0;
+	irqreturn_t retval = IRQ_NONE;
 
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
 	do {
-		ret = action->handler(irq, action->dev_id, regs);
+		irqreturn_t ret = action->handler(irq, action->dev_id,
regs);
+
 		if (ret == IRQ_HANDLED)
 			status |= action->flags;
 		retval |= ret;
@@ -104,15 +106,16 @@ fastcall int handle_IRQ_event(unsigned i
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs
*regs)
+fastcall irqreturn_t __do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
+	irqreturn_t ret = IRQ_NONE;
 
 	kstat_this_cpu.irqs[irq]++;
 	if (desc->status & IRQ_PER_CPU) {
-		irqreturn_t action_ret;
+		irqreturn_t action_ret = IRQ_NONE;
 
 		/*
 		 * No locking required for CPU-local interrupts:
@@ -120,7 +123,7 @@ fastcall unsigned int __do_IRQ(unsigned 
 		desc->handler->ack(irq);
 		action_ret = handle_IRQ_event(irq, regs, desc->action);
 		desc->handler->end(irq);
-		return 1;
+		return action_ret;
 	}
 
 	spin_lock(&desc->lock);
@@ -173,6 +176,7 @@ fastcall unsigned int __do_IRQ(unsigned 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret, regs);
+		ret |= action_ret;
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
@@ -187,6 +191,6 @@ out:
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
 
-	return 1;
+	return ret;
 }
 


--=__Part30125E74.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-irqreturn.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-irqreturn.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkluIG9yZGVyIGZvciBsb3ctbGV2ZWwgY29k
ZSB0byBrbm93IHdoZXRoZXIvaG93IGEgaGFyZHdhcmUgaW50ZXJydXB0IHdhcwpzZXJ2aWNlZCwg
bWFrZSBzdXJlIHRoaXMgaW5mb3JtYXRpb24gZ2V0cyBwYXNzZWQgZG93biBjb3JyZWN0bHkuCgpB
dCBvbmNlLCB1c2UgdGhlIHByb3BlciB0eXBlIChpcnFyZXR1cm5fdCkgZm9yIHJldHVybmluZyB0
aGlzIGluZm9ybWF0aW9uLAp3aGljaCBpbiB0dXJuIHJlcXVpcmVkIGJyZWFraW5nIHVwIGEgaGVh
ZGVyIGludG8gdHdvIHRvIHJlc29sdmUgcmVjdXJzaXZlCmluY2x1c2lvbiBwcm9ibGVtcyByZXN1
bHRpbmcgb3RoZXJ3aXNlLgoKQXJjaGl0ZWN0dXJlIGRlcGVuZGVudCBjb2RlIG5lZWRzIHRvIGNo
YW5nZSBmb3IgdGhpcyB0byBmdWxseSB3b3JrLCBidXQKbm8gY2hhbmdlIHNob3VsZCBiZSBuZWNl
c3NhcnkgaWYgdGhlIGRlc2NyaWJlZCBmdW5jdGlvbmFsaXR5IGlzbid0CmNvbnN1bWVkIG9uIGEg
Z2l2ZW4gYXJjaGl0ZWN0dXJlLiBUaHVzIHJlc3BlY3RpdmUgYWRqdXN0bWVudHMgaW4gdGhpcyBw
YXRjaAphcmUgb25seSB0byB0aG9zZSBhcmNoaXRlY3R1cmVzIEkgaGF2ZSBmdXJ0aGVyIGRlcGVu
ZCBjb2RlIGZvciAoaTM4NiwKeDg2XzY0LCBpYTY0KS4KCihLZXJuZWwgZGVidWdnZXJzIG1heSB3
YW50IHRvIGNvbnZlcnQgYSBoYXJkd2FyZSBpbnRlcnJ1cHQsIHNheSBmcm9tIGEKaG90IGtleSBw
cmVzcywgaW50byBhIHBzZXVkby1leGNlcHRpb24sIHJlcXVpcmluZyB0aGF0IHRoZXkgc2hvdWxk
IGhhdmUKYSB3YXkgdG8gZ2V0IHRoaXMgaW5mb3JtYXRpb24gY29tbXVuaWNhdGVkIGZyb20gdGhl
IHJlc3BlY3RpdmUgaW50ZXJydXB0CmhhbmRsZXIuIEZvciB0aGlzIHRvIGZ1bGx5IHdvcmssIGFk
ZGl0aW9uYWwgYWRqdXN0bWVudHMgYXJlIG5lY2Vzc2FyeSwKc28gdGhpcyBpcyBtZWFudCBvdCBv
bmx5IGJlIHRoZSBmaXJzdCBzdGVwLikKClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1
bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5lbC9pcnEu
YyAyLjYuMTMtaXJxcmV0dXJuL2FyY2gvaTM4Ni9rZXJuZWwvaXJxLmMKLS0tIDIuNi4xMy9hcmNo
L2kzODYva2VybmVsL2lycS5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisr
KyAyLjYuMTMtaXJxcmV0dXJuL2FyY2gvaTM4Ni9rZXJuZWwvaXJxLmMJMjAwNS0wOS0wMSAxMToz
MjoxMS4wMDAwMDAwMDAgKzAyMDAKQEAgLTUxLDcgKzUxLDcgQEAgc3RhdGljIHVuaW9uIGlycV9j
dHggKnNvZnRpcnFfY3R4W05SX0NQVQogICogU01QIGNyb3NzLUNQVSBpbnRlcnJ1cHRzIGhhdmUg
dGhlaXIgb3duIHNwZWNpZmljCiAgKiBoYW5kbGVycykuCiAgKi8KLWZhc3RjYWxsIHVuc2lnbmVk
IGludCBkb19JUlEoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCitmYXN0Y2FsbCBpcnFyZXR1cm5fdCBk
b19JUlEoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiB7CQogCS8qIGhpZ2ggYml0cyB1c2VkIGluIHJl
dF9mcm9tXyBjb2RlICovCiAJaW50IGlycSA9IHJlZ3MtPm9yaWdfZWF4ICYgMHhmZjsKQEAgLTU5
LDYgKzU5LDcgQEAgZmFzdGNhbGwgdW5zaWduZWQgaW50IGRvX0lSUShzdHJ1Y3QgcHRfcgogCXVu
aW9uIGlycV9jdHggKmN1cmN0eCwgKmlycWN0eDsKIAl1MzIgKmlzcDsKICNlbmRpZgorCWlycXJl
dHVybl90IHJldDsKIAogCWlycV9lbnRlcigpOwogI2lmZGVmIENPTkZJR19ERUJVR19TVEFDS09W
RVJGTE9XCkBAIC04OCw3ICs4OSw3IEBAIGZhc3RjYWxsIHVuc2lnbmVkIGludCBkb19JUlEoc3Ry
dWN0IHB0X3IKIAkgKiBjdXJyZW50IHN0YWNrICh3aGljaCBpcyB0aGUgaXJxIHN0YWNrIGFscmVh
ZHkgYWZ0ZXIgYWxsKQogCSAqLwogCWlmIChjdXJjdHggIT0gaXJxY3R4KSB7Ci0JCWludCBhcmcx
LCBhcmcyLCBlYng7CisJCWludCBlZHgsIGVieDsKIAogCQkvKiBidWlsZCB0aGUgc3RhY2sgZnJh
bWUgb24gdGhlIElSUSBzdGFjayAqLwogCQlpc3AgPSAodTMyKikgKChjaGFyKilpcnFjdHggKyBz
aXplb2YoKmlycWN0eCkpOwpAQCAtOTksMTcgKzEwMCwxNyBAQCBmYXN0Y2FsbCB1bnNpZ25lZCBp
bnQgZG9fSVJRKHN0cnVjdCBwdF9yCiAJCQkiICAgICAgIHhjaGdsICAgJSVlYngsJSVlc3AgICAg
ICBcbiIKIAkJCSIgICAgICAgY2FsbCAgICBfX2RvX0lSUSAgICAgICAgIFxuIgogCQkJIiAgICAg
ICBtb3ZsICAgJSVlYngsJSVlc3AgICAgICBcbiIKLQkJCTogIj1hIiAoYXJnMSksICI9ZCIgKGFy
ZzIpLCAiPWIiIChlYngpCi0JCQk6ICAiMCIgKGlycSksICAgIjEiIChyZWdzKSwgICIyIiAoaXNw
KQorCQkJOiAiPWEiIChyZXQpLCAiPWQiIChlZHgpLCAiPWIiIChlYngpCisJCQk6ICAiMCIgKGly
cSksICAiMSIgKHJlZ3MpLCAiMiIgKGlzcCkKIAkJCTogIm1lbW9yeSIsICJjYyIsICJlY3giCiAJ
CSk7CiAJfSBlbHNlCiAjZW5kaWYKLQkJX19kb19JUlEoaXJxLCByZWdzKTsKKwkJcmV0ID0gX19k
b19JUlEoaXJxLCByZWdzKTsKIAogCWlycV9leGl0KCk7CiAKLQlyZXR1cm4gMTsKKwlyZXR1cm4g
cmV0OwogfQogCiAjaWZkZWYgQ09ORklHXzRLU1RBQ0tTCmRpZmYgLU5wcnUgMi42LjEzL2FyY2gv
aTM4Ni9tYWNoLXZpc3dzL3Zpc3dzX2FwaWMuYyAyLjYuMTMtaXJxcmV0dXJuL2FyY2gvaTM4Ni9t
YWNoLXZpc3dzL3Zpc3dzX2FwaWMuYwotLS0gMi42LjEzL2FyY2gvaTM4Ni9tYWNoLXZpc3dzL3Zp
c3dzX2FwaWMuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEz
LWlycXJldHVybi9hcmNoL2kzODYvbWFjaC12aXN3cy92aXN3c19hcGljLmMJMjAwNS0wMy0xNiAx
MjoyNDo0MS4wMDAwMDAwMDAgKzAxMDAKQEAgLTE5OCw2ICsxOTgsNyBAQCBzdGF0aWMgaXJxcmV0
dXJuX3QgcGlpeDRfbWFzdGVyX2ludHIoaW50CiAJaW50IHJlYWxpcnE7CiAJaXJxX2Rlc2NfdCAq
ZGVzYzsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOworCWlycXJldHVybl90IHJldDsKIAogCXNwaW5f
bG9ja19pcnFzYXZlKCZpODI1OUFfbG9jaywgZmxhZ3MpOwogCkBAIC0yNDYsMTIgKzI0NywxNCBA
QCBzdGF0aWMgaXJxcmV0dXJuX3QgcGlpeDRfbWFzdGVyX2ludHIoaW50CiAJa3N0YXRfY3B1KHNt
cF9wcm9jZXNzb3JfaWQoKSkuaXJxc1tyZWFsaXJxXSsrOwogCiAJaWYgKGxpa2VseShkZXNjLT5h
Y3Rpb24gIT0gTlVMTCkpCi0JCWhhbmRsZV9JUlFfZXZlbnQocmVhbGlycSwgcmVncywgZGVzYy0+
YWN0aW9uKTsKKwkJcmV0ID0gaGFuZGxlX0lSUV9ldmVudChyZWFsaXJxLCByZWdzLCBkZXNjLT5h
Y3Rpb24pOworCWVsc2UKKwkJcmV0ID0gSVJRX05PTkU7CiAKIAlpZiAoIShkZXNjLT5zdGF0dXMg
JiBJUlFfRElTQUJMRUQpKQogCQllbmFibGVfODI1OUFfaXJxKHJlYWxpcnEpOwogCi0JcmV0dXJu
IElSUV9IQU5ETEVEOworCXJldHVybiByZXQ7CiAKIG91dF91bmxvY2s6CiAJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmaTgyNTlBX2xvY2ssIGZsYWdzKTsKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9p
YTY0L2tlcm5lbC9pcnFfaWE2NC5jIDIuNi4xMy1pcnFyZXR1cm4vYXJjaC9pYTY0L2tlcm5lbC9p
cnFfaWE2NC5jCi0tLSAyLjYuMTMvYXJjaC9pYTY0L2tlcm5lbC9pcnFfaWE2NC5jCTIwMDUtMDgt
MjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtaXJxcmV0dXJuL2FyY2gvaWE2
NC9rZXJuZWwvaXJxX2lhNjQuYwkyMDA1LTA5LTAxIDE0OjA4OjE1LjAwMDAwMDAwMCArMDIwMApA
QCAtOTksMTAgKzk5LDExIEBAIGZyZWVfaXJxX3ZlY3RvciAoaW50IHZlY3RvcikKICAqIGludGVy
cnVwdC4gVGhpcyBicmFuY2hlcyB0byB0aGUgY29ycmVjdCBoYXJkd2FyZSBJUlEgaGFuZGxlciB2
aWEKICAqIGZ1bmN0aW9uIHB0ci4KICAqLwotdm9pZAoraXJxcmV0dXJuX3QKIGlhNjRfaGFuZGxl
X2lycSAoaWE2NF92ZWN0b3IgdmVjdG9yLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIHsKIAl1bnNp
Z25lZCBsb25nIHNhdmVkX3RwcjsKKwlpcnFyZXR1cm5fdCByZXQ7CiAKICNpZiBJUlFfREVCVUcK
IAl7CkBAIC0xNDIsMTIgKzE0MywxMyBAQCBpYTY0X2hhbmRsZV9pcnEgKGlhNjRfdmVjdG9yIHZl
Y3Rvciwgc3RyCiAJaXJxX2VudGVyKCk7CiAJc2F2ZWRfdHByID0gaWE2NF9nZXRyZWcoX0lBNjRf
UkVHX0NSX1RQUik7CiAJaWE2NF9zcmx6X2QoKTsKKwlyZXQgPSBJUlFfTk9ORTsKIAl3aGlsZSAo
dmVjdG9yICE9IElBNjRfU1BVUklPVVNfSU5UX1ZFQ1RPUikgewogCQlpZiAoIUlTX1JFU0NIRURV
TEUodmVjdG9yKSkgewogCQkJaWE2NF9zZXRyZWcoX0lBNjRfUkVHX0NSX1RQUiwgdmVjdG9yKTsK
IAkJCWlhNjRfc3Jsel9kKCk7CiAKLQkJCV9fZG9fSVJRKGxvY2FsX3ZlY3Rvcl90b19pcnEodmVj
dG9yKSwgcmVncyk7CisJCQlyZXQgfD0gX19kb19JUlEobG9jYWxfdmVjdG9yX3RvX2lycSh2ZWN0
b3IpLCByZWdzKTsKIAogCQkJLyoKIAkJCSAqIERpc2FibGUgaW50ZXJydXB0cyBhbmQgc2VuZCBF
T0k6CkBAIC0xNjQsNiArMTY2LDcgQEAgaWE2NF9oYW5kbGVfaXJxIChpYTY0X3ZlY3RvciB2ZWN0
b3IsIHN0cgogCSAqIGNvbWUgdGhyb3VnaCB1bnRpbCBpYTY0X2VvaSgpIGhhcyBiZWVuIGRvbmUu
CiAJICovCiAJaXJxX2V4aXQoKTsKKwlyZXR1cm4gcmV0OwogfQogCiAjaWZkZWYgQ09ORklHX0hP
VFBMVUdfQ1BVCmRpZmYgLU5wcnUgMi42LjEzL2FyY2gveDg2XzY0L2tlcm5lbC9pcnEuYyAyLjYu
MTMtaXJxcmV0dXJuL2FyY2gveDg2XzY0L2tlcm5lbC9pcnEuYwotLS0gMi42LjEzL2FyY2gveDg2
XzY0L2tlcm5lbC9pcnEuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysg
Mi42LjEzLWlycXJldHVybi9hcmNoL3g4Nl82NC9rZXJuZWwvaXJxLmMJMjAwNS0wOS0wMSAxMToz
MjoxMS4wMDAwMDAwMDAgKzAyMDAKQEAgLTkzLDE4ICs5MywxOSBAQCBza2lwOgogICogU01QIGNy
b3NzLUNQVSBpbnRlcnJ1cHRzIGhhdmUgdGhlaXIgb3duIHNwZWNpZmljCiAgKiBoYW5kbGVycyku
CiAgKi8KLWFzbWxpbmthZ2UgdW5zaWduZWQgaW50IGRvX0lSUShzdHJ1Y3QgcHRfcmVncyAqcmVn
cykKK2FzbWxpbmthZ2UgaXJxcmV0dXJuX3QgZG9fSVJRKHN0cnVjdCBwdF9yZWdzICpyZWdzKQog
ewkKIAkvKiBoaWdoIGJpdHMgdXNlZCBpbiByZXRfZnJvbV8gY29kZSAgKi8KIAl1bnNpZ25lZCBp
cnEgPSByZWdzLT5vcmlnX3JheCAmIDB4ZmY7CisJaXJxcmV0dXJuX3QgcmV0ID0gSVJRX05PTkU7
CiAKIAlpcnFfZW50ZXIoKTsKLQlCVUdfT04oaXJxID4gMjU2KTsKIAotCV9fZG9fSVJRKGlycSwg
cmVncyk7CisJcmV0ID0gX19kb19JUlEoaXJxLCByZWdzKTsKKwogCWlycV9leGl0KCk7CiAKLQly
ZXR1cm4gMTsKKwlyZXR1cm4gcmV0OwogfQogCiAjaWZkZWYgQ09ORklHX0hPVFBMVUdfQ1BVCmRp
ZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUvbGludXgvaW50ZXJydXB0LmggMi42LjEzLWlycXJldHVy
bi9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oCi0tLSAyLjYuMTMvaW5jbHVkZS9saW51eC9pbnRl
cnJ1cHQuaAkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWly
cXJldHVybi9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oCTIwMDUtMDMtMjEgMTQ6MjA6MjAuMDAw
MDAwMDAwICswMTAwCkBAIC04LDMxICs4LDEyIEBACiAjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+
CiAjaW5jbHVkZSA8bGludXgvcHJlZW1wdC5oPgogI2luY2x1ZGUgPGxpbnV4L2NwdW1hc2suaD4K
KyNpbmNsdWRlIDxsaW51eC9pcnFyZXR1cm4uaD4KICNpbmNsdWRlIDxsaW51eC9oYXJkaXJxLmg+
CiAjaW5jbHVkZSA8YXNtL2F0b21pYy5oPgogI2luY2x1ZGUgPGFzbS9wdHJhY2UuaD4KICNpbmNs
dWRlIDxhc20vc3lzdGVtLmg+CiAKLS8qCi0gKiBGb3IgMi40LnggY29tcGF0aWJpbGl0eSwgMi40
LnggY2FuIHVzZQotICoKLSAqCXR5cGVkZWYgdm9pZCBpcnFyZXR1cm5fdDsKLSAqCSNkZWZpbmUg
SVJRX05PTkUKLSAqCSNkZWZpbmUgSVJRX0hBTkRMRUQKLSAqCSNkZWZpbmUgSVJRX1JFVFZBTCh4
KQotICoKLSAqIFRvIG1peCBvbGQtc3R5bGUgYW5kIG5ldy1zdHlsZSBpcnEgaGFuZGxlciByZXR1
cm5zLgotICoKLSAqIElSUV9OT05FIG1lYW5zIHdlIGRpZG4ndCBoYW5kbGUgaXQuCi0gKiBJUlFf
SEFORExFRCBtZWFucyB0aGF0IHdlIGRpZCBoYXZlIGEgdmFsaWQgaW50ZXJydXB0IGFuZCBoYW5k
bGVkIGl0LgotICogSVJRX1JFVFZBTCh4KSBzZWxlY3RzIG9uIHRoZSB0d28gZGVwZW5kaW5nIG9u
IHggYmVpbmcgbm9uLXplcm8gKGZvciBoYW5kbGVkKQotICovCi10eXBlZGVmIGludCBpcnFyZXR1
cm5fdDsKLQotI2RlZmluZSBJUlFfTk9ORQkoMCkKLSNkZWZpbmUgSVJRX0hBTkRMRUQJKDEpCi0j
ZGVmaW5lIElSUV9SRVRWQUwoeCkJKCh4KSAhPSAwKQotCiBzdHJ1Y3QgaXJxYWN0aW9uIHsKIAlp
cnFyZXR1cm5fdCAoKmhhbmRsZXIpKGludCwgdm9pZCAqLCBzdHJ1Y3QgcHRfcmVncyAqKTsKIAl1
bnNpZ25lZCBsb25nIGZsYWdzOwpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2xpbnV4L2lycS5o
IDIuNi4xMy1pcnFyZXR1cm4vaW5jbHVkZS9saW51eC9pcnEuaAotLS0gMi42LjEzL2luY2x1ZGUv
bGludXgvaXJxLmgJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4x
My1pcnFyZXR1cm4vaW5jbHVkZS9saW51eC9pcnEuaAkyMDA1LTA5LTAxIDE3OjQzOjA1LjAwMDAw
MDAwMCArMDIwMApAQCAtMTcsNiArMTcsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2NhY2hlLmg+CiAj
aW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KICNpbmNsdWRlIDxsaW51eC9jcHVtYXNrLmg+Cisj
aW5jbHVkZSA8bGludXgvaXJxcmV0dXJuLmg+CiAKICNpbmNsdWRlIDxhc20vaXJxLmg+CiAjaW5j
bHVkZSA8YXNtL3B0cmFjZS5oPgpAQCAtODYsNyArODcsNyBAQCBleHRlcm4gaW50IG5vaXJxZGVi
dWdfc2V0dXAoY2hhciAqc3RyKTsKIAogZXh0ZXJuIGZhc3RjYWxsIGludCBoYW5kbGVfSVJRX2V2
ZW50KHVuc2lnbmVkIGludCBpcnEsIHN0cnVjdCBwdF9yZWdzICpyZWdzLAogCQkJCQlzdHJ1Y3Qg
aXJxYWN0aW9uICphY3Rpb24pOwotZXh0ZXJuIGZhc3RjYWxsIHVuc2lnbmVkIGludCBfX2RvX0lS
USh1bnNpZ25lZCBpbnQgaXJxLCBzdHJ1Y3QgcHRfcmVncyAqcmVncyk7CitleHRlcm4gZmFzdGNh
bGwgaXJxcmV0dXJuX3QgX19kb19JUlEodW5zaWduZWQgaW50IGlycSwgc3RydWN0IHB0X3JlZ3Mg
KnJlZ3MpOwogZXh0ZXJuIHZvaWQgbm90ZV9pbnRlcnJ1cHQodW5zaWduZWQgaW50IGlycSwgaXJx
X2Rlc2NfdCAqZGVzYywKIAkJCQkJaW50IGFjdGlvbl9yZXQsIHN0cnVjdCBwdF9yZWdzICpyZWdz
KTsKIGV4dGVybiBpbnQgY2FuX3JlcXVlc3RfaXJxKHVuc2lnbmVkIGludCBpcnEsIHVuc2lnbmVk
IGxvbmcgaXJxZmxhZ3MpOwpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2xpbnV4L2lycXJldHVy
bi5oIDIuNi4xMy1pcnFyZXR1cm4vaW5jbHVkZS9saW51eC9pcnFyZXR1cm4uaAotLS0gMi42LjEz
L2luY2x1ZGUvbGludXgvaXJxcmV0dXJuLmgJMTk3MC0wMS0wMSAwMTowMDowMC4wMDAwMDAwMDAg
KzAxMDAKKysrIDIuNi4xMy1pcnFyZXR1cm4vaW5jbHVkZS9saW51eC9pcnFyZXR1cm4uaAkyMDA1
LTAzLTIxIDE0OjIxOjA2LjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDI3IEBACisvKiBpcnFy
ZXR1cm4uaCAqLworI2lmbmRlZiBfTElOVVhfSVJRUkVUVVJOX0gKKyNkZWZpbmUgX0xJTlVYX0lS
UVJFVFVSTl9ICisKKyNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KKworLyoKKyAqIEZvciAyLjQu
eCBjb21wYXRpYmlsaXR5LCAyLjQueCBjYW4gdXNlCisgKgorICoJdHlwZWRlZiB2b2lkIGlycXJl
dHVybl90OworICoJI2RlZmluZSBJUlFfTk9ORQorICoJI2RlZmluZSBJUlFfSEFORExFRAorICoJ
I2RlZmluZSBJUlFfUkVUVkFMKHgpCisgKgorICogVG8gbWl4IG9sZC1zdHlsZSBhbmQgbmV3LXN0
eWxlIGlycSBoYW5kbGVyIHJldHVybnMuCisgKgorICogSVJRX05PTkUgbWVhbnMgd2UgZGlkbid0
IGhhbmRsZSBpdC4KKyAqIElSUV9IQU5ETEVEIG1lYW5zIHRoYXQgd2UgZGlkIGhhdmUgYSB2YWxp
ZCBpbnRlcnJ1cHQgYW5kIGhhbmRsZWQgaXQuCisgKiBJUlFfUkVUVkFMKHgpIHNlbGVjdHMgb24g
dGhlIHR3byBkZXBlbmRpbmcgb24geCBiZWluZyBub24temVybyAoZm9yIGhhbmRsZWQpCisgKi8K
K3R5cGVkZWYgaW50IGlycXJldHVybl90OworCisjZGVmaW5lIElSUV9OT05FCSgwKQorI2RlZmlu
ZSBJUlFfSEFORExFRAkoMSkKKyNkZWZpbmUgSVJRX1JFVFZBTCh4KQkoKHgpICE9IDApCisKKyNl
bmRpZgpkaWZmIC1OcHJ1IDIuNi4xMy9rZXJuZWwvaXJxL2hhbmRsZS5jIDIuNi4xMy1pcnFyZXR1
cm4va2VybmVsL2lycS9oYW5kbGUuYwotLS0gMi42LjEzL2tlcm5lbC9pcnEvaGFuZGxlLmMJMjAw
NS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pcnFyZXR1cm4va2Vy
bmVsL2lycS9oYW5kbGUuYwkyMDA1LTA5LTAxIDE3OjU0OjIzLjAwMDAwMDAwMCArMDIwMApAQCAt
NzYsMTYgKzc2LDE4IEBAIGlycXJldHVybl90IG5vX2FjdGlvbihpbnQgY3BsLCB2b2lkICpkZXYK
IC8qCiAgKiBIYXZlIGdvdCBhbiBldmVudCB0byBoYW5kbGU6CiAgKi8KLWZhc3RjYWxsIGludCBo
YW5kbGVfSVJRX2V2ZW50KHVuc2lnbmVkIGludCBpcnEsIHN0cnVjdCBwdF9yZWdzICpyZWdzLAor
ZmFzdGNhbGwgaXJxcmV0dXJuX3QgaGFuZGxlX0lSUV9ldmVudCh1bnNpZ25lZCBpbnQgaXJxLCBz
dHJ1Y3QgcHRfcmVncyAqcmVncywKIAkJCQlzdHJ1Y3QgaXJxYWN0aW9uICphY3Rpb24pCiB7Ci0J
aW50IHJldCwgcmV0dmFsID0gMCwgc3RhdHVzID0gMDsKKwlpbnQgc3RhdHVzID0gMDsKKwlpcnFy
ZXR1cm5fdCByZXR2YWwgPSBJUlFfTk9ORTsKIAogCWlmICghKGFjdGlvbi0+ZmxhZ3MgJiBTQV9J
TlRFUlJVUFQpKQogCQlsb2NhbF9pcnFfZW5hYmxlKCk7CiAKIAlkbyB7Ci0JCXJldCA9IGFjdGlv
bi0+aGFuZGxlcihpcnEsIGFjdGlvbi0+ZGV2X2lkLCByZWdzKTsKKwkJaXJxcmV0dXJuX3QgcmV0
ID0gYWN0aW9uLT5oYW5kbGVyKGlycSwgYWN0aW9uLT5kZXZfaWQsIHJlZ3MpOworCiAJCWlmIChy
ZXQgPT0gSVJRX0hBTkRMRUQpCiAJCQlzdGF0dXMgfD0gYWN0aW9uLT5mbGFnczsKIAkJcmV0dmFs
IHw9IHJldDsKQEAgLTEwNCwxNSArMTA2LDE2IEBAIGZhc3RjYWxsIGludCBoYW5kbGVfSVJRX2V2
ZW50KHVuc2lnbmVkIGkKICAqIFNNUCBjcm9zcy1DUFUgaW50ZXJydXB0cyBoYXZlIHRoZWlyIG93
biBzcGVjaWZpYwogICogaGFuZGxlcnMpLgogICovCi1mYXN0Y2FsbCB1bnNpZ25lZCBpbnQgX19k
b19JUlEodW5zaWduZWQgaW50IGlycSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCitmYXN0Y2FsbCBp
cnFyZXR1cm5fdCBfX2RvX0lSUSh1bnNpZ25lZCBpbnQgaXJxLCBzdHJ1Y3QgcHRfcmVncyAqcmVn
cykKIHsKIAlpcnFfZGVzY190ICpkZXNjID0gaXJxX2Rlc2MgKyBpcnE7CiAJc3RydWN0IGlycWFj
dGlvbiAqIGFjdGlvbjsKIAl1bnNpZ25lZCBpbnQgc3RhdHVzOworCWlycXJldHVybl90IHJldCA9
IElSUV9OT05FOwogCiAJa3N0YXRfdGhpc19jcHUuaXJxc1tpcnFdKys7CiAJaWYgKGRlc2MtPnN0
YXR1cyAmIElSUV9QRVJfQ1BVKSB7Ci0JCWlycXJldHVybl90IGFjdGlvbl9yZXQ7CisJCWlycXJl
dHVybl90IGFjdGlvbl9yZXQgPSBJUlFfTk9ORTsKIAogCQkvKgogCQkgKiBObyBsb2NraW5nIHJl
cXVpcmVkIGZvciBDUFUtbG9jYWwgaW50ZXJydXB0czoKQEAgLTEyMCw3ICsxMjMsNyBAQCBmYXN0
Y2FsbCB1bnNpZ25lZCBpbnQgX19kb19JUlEodW5zaWduZWQgCiAJCWRlc2MtPmhhbmRsZXItPmFj
ayhpcnEpOwogCQlhY3Rpb25fcmV0ID0gaGFuZGxlX0lSUV9ldmVudChpcnEsIHJlZ3MsIGRlc2Mt
PmFjdGlvbik7CiAJCWRlc2MtPmhhbmRsZXItPmVuZChpcnEpOwotCQlyZXR1cm4gMTsKKwkJcmV0
dXJuIGFjdGlvbl9yZXQ7CiAJfQogCiAJc3Bpbl9sb2NrKCZkZXNjLT5sb2NrKTsKQEAgLTE3Myw2
ICsxNzYsNyBAQCBmYXN0Y2FsbCB1bnNpZ25lZCBpbnQgX19kb19JUlEodW5zaWduZWQgCiAJCXNw
aW5fbG9jaygmZGVzYy0+bG9jayk7CiAJCWlmICghbm9pcnFkZWJ1ZykKIAkJCW5vdGVfaW50ZXJy
dXB0KGlycSwgZGVzYywgYWN0aW9uX3JldCwgcmVncyk7CisJCXJldCB8PSBhY3Rpb25fcmV0Owog
CQlpZiAobGlrZWx5KCEoZGVzYy0+c3RhdHVzICYgSVJRX1BFTkRJTkcpKSkKIAkJCWJyZWFrOwog
CQlkZXNjLT5zdGF0dXMgJj0gfklSUV9QRU5ESU5HOwpAQCAtMTg3LDYgKzE5MSw2IEBAIG91dDoK
IAlkZXNjLT5oYW5kbGVyLT5lbmQoaXJxKTsKIAlzcGluX3VubG9jaygmZGVzYy0+bG9jayk7CiAK
LQlyZXR1cm4gMTsKKwlyZXR1cm4gcmV0OwogfQogCg==

--=__Part30125E74.0__=--
