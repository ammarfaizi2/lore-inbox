Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVIHQIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVIHQIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVIHQIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:08:44 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:47468
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932563AbVIHQIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:08:43 -0400
Message-Id: <43207E680200007800024547@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 18:09:44 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] fix x86-64 interrupt re-enabling in oops_end()
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part31135F58.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part31135F58.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Rather than blindly re-enabling interrupts in oops_end(), save their
state
in oope_begin() and then restore that state.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/x86_64/kernel/traps.c
2.6.13-x86_64-oops-irq/arch/x86_64/kernel/traps.c
--- 2.6.13/arch/x86_64/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-oops-irq/arch/x86_64/kernel/traps.c	2005-09-07
15:37:52.000000000 +0200
@@ -342,30 +342,33 @@ void out_of_line_bug(void)
 static DEFINE_SPINLOCK(die_lock);
 static int die_owner = -1;
 
-void oops_begin(void)
+unsigned long oops_begin(void)
 {
-	int cpu = safe_smp_processor_id(); 
-	/* racy, but better than risking deadlock. */ 
-	local_irq_disable();
+	int cpu = safe_smp_processor_id();
+	unsigned long flags;
+
+	/* racy, but better than risking deadlock. */
+	local_irq_save(flags);
 	if (!spin_trylock(&die_lock)) { 
 		if (cpu == die_owner) 
 			/* nested oops. should stop eventually */;
 		else
-			spin_lock(&die_lock); 
+			spin_lock(&die_lock);
 	}
-	die_owner = cpu; 
+	die_owner = cpu;
 	console_verbose();
-	bust_spinlocks(1); 
+	bust_spinlocks(1);
+	return flags;
 }
 
-void oops_end(void)
+void oops_end(unsigned long flags)
 { 
 	die_owner = -1;
-	bust_spinlocks(0); 
-	spin_unlock(&die_lock); 
+	bust_spinlocks(0);
+	spin_unlock_irqrestore(&die_lock, flags);
 	if (panic_on_oops)
-		panic("Oops"); 
-} 
+		panic("Oops");
+}
 
 void __die(const char * str, struct pt_regs * regs, long err)
 {
@@ -391,10 +394,11 @@ void __die(const char * str, struct pt_r
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
-	oops_begin();
+	unsigned long flags = oops_begin();
+
 	handle_BUG(regs);
 	__die(str, regs, err);
-	oops_end();
+	oops_end(flags);
 	do_exit(SIGSEGV); 
 }
 static inline void die_if_kernel(const char * str, struct pt_regs *
regs, long err)
@@ -405,7 +409,8 @@ static inline void die_if_kernel(const c
 
 void die_nmi(char *str, struct pt_regs *regs)
 {
-	oops_begin();
+	unsigned long flags = oops_begin();
+
 	/*
 	 * We are in trouble anyway, lets at least try
 	 * to get a message out.
@@ -415,7 +420,7 @@ void die_nmi(char *str, struct pt_regs *
 	if (panic_on_timeout || panic_on_oops)
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");
-	oops_end();
+	oops_end(flags);
 	do_exit(SIGSEGV);
 }
 
diff -Npru 2.6.13/arch/x86_64/mm/fault.c
2.6.13-x86_64-oops-irq/arch/x86_64/mm/fault.c
--- 2.6.13/arch/x86_64/mm/fault.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-oops-irq/arch/x86_64/mm/fault.c	2005-09-07
16:15:13.000000000 +0200
@@ -220,12 +220,13 @@ int unhandled_signal(struct task_struct 
 static noinline void pgtable_bad(unsigned long address, struct pt_regs
*regs,
 				 unsigned long error_code)
 {
-	oops_begin();
+	unsigned long flags = oops_begin();
+
 	printk(KERN_ALERT "%s: Corrupted page table at address %lx\n",
 	       current->comm, address);
 	dump_pagetable(address);
 	__die("Bad pagetable", regs, error_code);
-	oops_end();
+	oops_end(flags);
 	do_exit(SIGKILL);
 }
 
@@ -302,6 +303,7 @@ asmlinkage void do_page_fault(struct pt_
 	unsigned long address;
 	const struct exception_table_entry *fixup;
 	int write;
+	unsigned long flags;
 	siginfo_t info;
 
 #ifdef CONFIG_CHECKING
@@ -519,7 +521,7 @@ no_context:
  * terminate things with extreme prejudice.
  */
 
-	oops_begin(); 
+	flags = oops_begin(); 
 
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer
dereference");
@@ -532,7 +534,7 @@ no_context:
 	__die("Oops", regs, error_code);
 	/* Executive summary in case the body of the oops scrolled away
*/
 	printk(KERN_EMERG "CR2: %016lx\n", address);
-	oops_end(); 
+	oops_end(flags); 
 	do_exit(SIGKILL);
 
 /*
diff -Npru 2.6.13/include/asm-x86_64/kdebug.h
2.6.13-x86_64-oops-irq/include/asm-x86_64/kdebug.h
--- 2.6.13/include/asm-x86_64/kdebug.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-oops-irq/include/asm-x86_64/kdebug.h	2005-09-01
11:32:12.000000000 +0200
@@ -46,7 +46,7 @@ extern void die(const char *,struct pt_r
 extern void __die(const char *,struct pt_regs *,long);
 extern void show_registers(struct pt_regs *regs);
 extern void dump_pagetable(unsigned long);
-extern void oops_begin(void);
-extern void oops_end(void);
+extern unsigned long oops_begin(void);
+extern void oops_end(unsigned long);
 
 #endif
diff -Npru 2.6.13/include/asm-x86_64/proto.h
2.6.13-x86_64-oops-irq/include/asm-x86_64/proto.h
--- 2.6.13/include/asm-x86_64/proto.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-oops-irq/include/asm-x86_64/proto.h	2005-09-01
11:32:12.000000000 +0200
@@ -75,9 +75,6 @@ extern void acpi_reserve_bootmem(void);
 
 extern void swap_low_mappings(void);
 
-extern void oops_begin(void);
-extern void die(const char *,struct pt_regs *,long);
-extern void __die(const char * str, struct pt_regs * regs, long err);
 extern void __show_regs(struct pt_regs * regs);
 extern void show_regs(struct pt_regs * regs);
 


--=__Part31135F58.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-oops-irq.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-oops-irq.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClJhdGhlciB0aGFuIGJsaW5kbHkgcmUtZW5h
YmxpbmcgaW50ZXJydXB0cyBpbiBvb3BzX2VuZCgpLCBzYXZlIHRoZWlyIHN0YXRlCmluIG9vcGVf
YmVnaW4oKSBhbmQgdGhlbiByZXN0b3JlIHRoYXQgc3RhdGUuCgpTaWduZWQtb2ZmLWJ5OiBKYW4g
QmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCmRpZmYgLU5wcnUgMi42LjEzL2FyY2gveDg2
XzY0L2tlcm5lbC90cmFwcy5jIDIuNi4xMy14ODZfNjQtb29wcy1pcnEvYXJjaC94ODZfNjQva2Vy
bmVsL3RyYXBzLmMKLS0tIDIuNi4xMy9hcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYwkyMDA1LTA4
LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1vb3BzLWlycS9h
cmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYwkyMDA1LTA5LTA3IDE1OjM3OjUyLjAwMDAwMDAwMCAr
MDIwMApAQCAtMzQyLDMwICszNDIsMzMgQEAgdm9pZCBvdXRfb2ZfbGluZV9idWcodm9pZCkKIHN0
YXRpYyBERUZJTkVfU1BJTkxPQ0soZGllX2xvY2spOwogc3RhdGljIGludCBkaWVfb3duZXIgPSAt
MTsKIAotdm9pZCBvb3BzX2JlZ2luKHZvaWQpCit1bnNpZ25lZCBsb25nIG9vcHNfYmVnaW4odm9p
ZCkKIHsKLQlpbnQgY3B1ID0gc2FmZV9zbXBfcHJvY2Vzc29yX2lkKCk7IAotCS8qIHJhY3ksIGJ1
dCBiZXR0ZXIgdGhhbiByaXNraW5nIGRlYWRsb2NrLiAqLyAKLQlsb2NhbF9pcnFfZGlzYWJsZSgp
OworCWludCBjcHUgPSBzYWZlX3NtcF9wcm9jZXNzb3JfaWQoKTsKKwl1bnNpZ25lZCBsb25nIGZs
YWdzOworCisJLyogcmFjeSwgYnV0IGJldHRlciB0aGFuIHJpc2tpbmcgZGVhZGxvY2suICovCisJ
bG9jYWxfaXJxX3NhdmUoZmxhZ3MpOwogCWlmICghc3Bpbl90cnlsb2NrKCZkaWVfbG9jaykpIHsg
CiAJCWlmIChjcHUgPT0gZGllX293bmVyKSAKIAkJCS8qIG5lc3RlZCBvb3BzLiBzaG91bGQgc3Rv
cCBldmVudHVhbGx5ICovOwogCQllbHNlCi0JCQlzcGluX2xvY2soJmRpZV9sb2NrKTsgCisJCQlz
cGluX2xvY2soJmRpZV9sb2NrKTsKIAl9Ci0JZGllX293bmVyID0gY3B1OyAKKwlkaWVfb3duZXIg
PSBjcHU7CiAJY29uc29sZV92ZXJib3NlKCk7Ci0JYnVzdF9zcGlubG9ja3MoMSk7IAorCWJ1c3Rf
c3BpbmxvY2tzKDEpOworCXJldHVybiBmbGFnczsKIH0KIAotdm9pZCBvb3BzX2VuZCh2b2lkKQor
dm9pZCBvb3BzX2VuZCh1bnNpZ25lZCBsb25nIGZsYWdzKQogeyAKIAlkaWVfb3duZXIgPSAtMTsK
LQlidXN0X3NwaW5sb2NrcygwKTsgCi0Jc3Bpbl91bmxvY2soJmRpZV9sb2NrKTsgCisJYnVzdF9z
cGlubG9ja3MoMCk7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGllX2xvY2ssIGZsYWdzKTsK
IAlpZiAocGFuaWNfb25fb29wcykKLQkJcGFuaWMoIk9vcHMiKTsgCi19IAorCQlwYW5pYygiT29w
cyIpOworfQogCiB2b2lkIF9fZGllKGNvbnN0IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yZWdzICog
cmVncywgbG9uZyBlcnIpCiB7CkBAIC0zOTEsMTAgKzM5NCwxMSBAQCB2b2lkIF9fZGllKGNvbnN0
IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yCiAKIHZvaWQgZGllKGNvbnN0IGNoYXIgKiBzdHIsIHN0
cnVjdCBwdF9yZWdzICogcmVncywgbG9uZyBlcnIpCiB7Ci0Jb29wc19iZWdpbigpOworCXVuc2ln
bmVkIGxvbmcgZmxhZ3MgPSBvb3BzX2JlZ2luKCk7CisKIAloYW5kbGVfQlVHKHJlZ3MpOwogCV9f
ZGllKHN0ciwgcmVncywgZXJyKTsKLQlvb3BzX2VuZCgpOworCW9vcHNfZW5kKGZsYWdzKTsKIAlk
b19leGl0KFNJR1NFR1YpOyAKIH0KIHN0YXRpYyBpbmxpbmUgdm9pZCBkaWVfaWZfa2VybmVsKGNv
bnN0IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yZWdzICogcmVncywgbG9uZyBlcnIpCkBAIC00MDUs
NyArNDA5LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGRpZV9pZl9rZXJuZWwoY29uc3QgYwogCiB2
b2lkIGRpZV9ubWkoY2hhciAqc3RyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIHsKLQlvb3BzX2Jl
Z2luKCk7CisJdW5zaWduZWQgbG9uZyBmbGFncyA9IG9vcHNfYmVnaW4oKTsKKwogCS8qCiAJICog
V2UgYXJlIGluIHRyb3VibGUgYW55d2F5LCBsZXRzIGF0IGxlYXN0IHRyeQogCSAqIHRvIGdldCBh
IG1lc3NhZ2Ugb3V0LgpAQCAtNDE1LDcgKzQyMCw3IEBAIHZvaWQgZGllX25taShjaGFyICpzdHIs
IHN0cnVjdCBwdF9yZWdzICoKIAlpZiAocGFuaWNfb25fdGltZW91dCB8fCBwYW5pY19vbl9vb3Bz
KQogCQlwYW5pYygibm1pIHdhdGNoZG9nIik7CiAJcHJpbnRrKCJjb25zb2xlIHNodXRzIHVwIC4u
LlxuIik7Ci0Jb29wc19lbmQoKTsKKwlvb3BzX2VuZChmbGFncyk7CiAJZG9fZXhpdChTSUdTRUdW
KTsKIH0KIApkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL3g4Nl82NC9tbS9mYXVsdC5jIDIuNi4xMy14
ODZfNjQtb29wcy1pcnEvYXJjaC94ODZfNjQvbW0vZmF1bHQuYwotLS0gMi42LjEzL2FyY2gveDg2
XzY0L21tL2ZhdWx0LmMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIu
Ni4xMy14ODZfNjQtb29wcy1pcnEvYXJjaC94ODZfNjQvbW0vZmF1bHQuYwkyMDA1LTA5LTA3IDE2
OjE1OjEzLjAwMDAwMDAwMCArMDIwMApAQCAtMjIwLDEyICsyMjAsMTMgQEAgaW50IHVuaGFuZGxl
ZF9zaWduYWwoc3RydWN0IHRhc2tfc3RydWN0IAogc3RhdGljIG5vaW5saW5lIHZvaWQgcGd0YWJs
ZV9iYWQodW5zaWduZWQgbG9uZyBhZGRyZXNzLCBzdHJ1Y3QgcHRfcmVncyAqcmVncywKIAkJCQkg
dW5zaWduZWQgbG9uZyBlcnJvcl9jb2RlKQogewotCW9vcHNfYmVnaW4oKTsKKwl1bnNpZ25lZCBs
b25nIGZsYWdzID0gb29wc19iZWdpbigpOworCiAJcHJpbnRrKEtFUk5fQUxFUlQgIiVzOiBDb3Jy
dXB0ZWQgcGFnZSB0YWJsZSBhdCBhZGRyZXNzICVseFxuIiwKIAkgICAgICAgY3VycmVudC0+Y29t
bSwgYWRkcmVzcyk7CiAJZHVtcF9wYWdldGFibGUoYWRkcmVzcyk7CiAJX19kaWUoIkJhZCBwYWdl
dGFibGUiLCByZWdzLCBlcnJvcl9jb2RlKTsKLQlvb3BzX2VuZCgpOworCW9vcHNfZW5kKGZsYWdz
KTsKIAlkb19leGl0KFNJR0tJTEwpOwogfQogCkBAIC0zMDIsNiArMzAzLDcgQEAgYXNtbGlua2Fn
ZSB2b2lkIGRvX3BhZ2VfZmF1bHQoc3RydWN0IHB0XwogCXVuc2lnbmVkIGxvbmcgYWRkcmVzczsK
IAljb25zdCBzdHJ1Y3QgZXhjZXB0aW9uX3RhYmxlX2VudHJ5ICpmaXh1cDsKIAlpbnQgd3JpdGU7
CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAlzaWdpbmZvX3QgaW5mbzsKIAogI2lmZGVmIENPTkZJ
R19DSEVDS0lORwpAQCAtNTE5LDcgKzUyMSw3IEBAIG5vX2NvbnRleHQ6CiAgKiB0ZXJtaW5hdGUg
dGhpbmdzIHdpdGggZXh0cmVtZSBwcmVqdWRpY2UuCiAgKi8KIAotCW9vcHNfYmVnaW4oKTsgCisJ
ZmxhZ3MgPSBvb3BzX2JlZ2luKCk7IAogCiAJaWYgKGFkZHJlc3MgPCBQQUdFX1NJWkUpCiAJCXBy
aW50ayhLRVJOX0FMRVJUICJVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UiKTsKQEAgLTUzMiw3ICs1MzQsNyBAQCBub19jb250ZXh0OgogCV9fZGllKCJPb3Bz
IiwgcmVncywgZXJyb3JfY29kZSk7CiAJLyogRXhlY3V0aXZlIHN1bW1hcnkgaW4gY2FzZSB0aGUg
Ym9keSBvZiB0aGUgb29wcyBzY3JvbGxlZCBhd2F5ICovCiAJcHJpbnRrKEtFUk5fRU1FUkcgIkNS
MjogJTAxNmx4XG4iLCBhZGRyZXNzKTsKLQlvb3BzX2VuZCgpOyAKKwlvb3BzX2VuZChmbGFncyk7
IAogCWRvX2V4aXQoU0lHS0lMTCk7CiAKIC8qCmRpZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUvYXNt
LXg4Nl82NC9rZGVidWcuaCAyLjYuMTMteDg2XzY0LW9vcHMtaXJxL2luY2x1ZGUvYXNtLXg4Nl82
NC9rZGVidWcuaAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLXg4Nl82NC9rZGVidWcuaAkyMDA1LTA4
LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1vb3BzLWlycS9p
bmNsdWRlL2FzbS14ODZfNjQva2RlYnVnLmgJMjAwNS0wOS0wMSAxMTozMjoxMi4wMDAwMDAwMDAg
KzAyMDAKQEAgLTQ2LDcgKzQ2LDcgQEAgZXh0ZXJuIHZvaWQgZGllKGNvbnN0IGNoYXIgKixzdHJ1
Y3QgcHRfcgogZXh0ZXJuIHZvaWQgX19kaWUoY29uc3QgY2hhciAqLHN0cnVjdCBwdF9yZWdzICos
bG9uZyk7CiBleHRlcm4gdm9pZCBzaG93X3JlZ2lzdGVycyhzdHJ1Y3QgcHRfcmVncyAqcmVncyk7
CiBleHRlcm4gdm9pZCBkdW1wX3BhZ2V0YWJsZSh1bnNpZ25lZCBsb25nKTsKLWV4dGVybiB2b2lk
IG9vcHNfYmVnaW4odm9pZCk7Ci1leHRlcm4gdm9pZCBvb3BzX2VuZCh2b2lkKTsKK2V4dGVybiB1
bnNpZ25lZCBsb25nIG9vcHNfYmVnaW4odm9pZCk7CitleHRlcm4gdm9pZCBvb3BzX2VuZCh1bnNp
Z25lZCBsb25nKTsKIAogI2VuZGlmCmRpZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUvYXNtLXg4Nl82
NC9wcm90by5oIDIuNi4xMy14ODZfNjQtb29wcy1pcnEvaW5jbHVkZS9hc20teDg2XzY0L3Byb3Rv
LmgKLS0tIDIuNi4xMy9pbmNsdWRlL2FzbS14ODZfNjQvcHJvdG8uaAkyMDA1LTA4LTI5IDAxOjQx
OjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1vb3BzLWlycS9pbmNsdWRlL2Fz
bS14ODZfNjQvcHJvdG8uaAkyMDA1LTA5LTAxIDExOjMyOjEyLjAwMDAwMDAwMCArMDIwMApAQCAt
NzUsOSArNzUsNiBAQCBleHRlcm4gdm9pZCBhY3BpX3Jlc2VydmVfYm9vdG1lbSh2b2lkKTsKIAog
ZXh0ZXJuIHZvaWQgc3dhcF9sb3dfbWFwcGluZ3Modm9pZCk7CiAKLWV4dGVybiB2b2lkIG9vcHNf
YmVnaW4odm9pZCk7Ci1leHRlcm4gdm9pZCBkaWUoY29uc3QgY2hhciAqLHN0cnVjdCBwdF9yZWdz
ICosbG9uZyk7Ci1leHRlcm4gdm9pZCBfX2RpZShjb25zdCBjaGFyICogc3RyLCBzdHJ1Y3QgcHRf
cmVncyAqIHJlZ3MsIGxvbmcgZXJyKTsKIGV4dGVybiB2b2lkIF9fc2hvd19yZWdzKHN0cnVjdCBw
dF9yZWdzICogcmVncyk7CiBleHRlcm4gdm9pZCBzaG93X3JlZ3Moc3RydWN0IHB0X3JlZ3MgKiBy
ZWdzKTsKIAo=

--=__Part31135F58.1__=--
