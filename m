Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWINIeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWINIeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWINIeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:34:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:7391 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751370AbWINIeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:34:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=VMIgWj+IMfo5NnvFkowxzwPfI/B/Hvd785/XOdFfSFiq91L0ZRC3ZjIHlYtVzh8XuNx0BluTtmEHVsyFuD6bJfrOsJbNdOOu9d+ahiLGabnbM0MlyjmGFVjVa+5b+3mXbP4a0fsaoC3n/ierPBWu7RqzxJW2f6K81csfveB7EI8=
Message-ID: <787b0d920609140134j5935c743kae4af8d51eea2a90@mail.gmail.com>
Date: Thu, 14 Sep 2006 04:34:00 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, "Linus Torvalds" <torvalds@osdl.org>,
       hpa@zytor.com
Subject: [PATCH] i386/x86_64 signal handler arg fixes
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_40093_30503902.1158222840159"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_40093_30503902.1158222840159
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some time ago, the i386 kernel was patched to support user code that
has signal handlers marked with __attribute__((regparm(3))) or compiled
with the -mregparm=3 gcc option. This is useful for klibc at least.
The code wasn't quite right, and it never got ported to x86_64.

For i386, the non-RT frame is wrong. It was using the raw sig value
instead of the translated value, and did not pass the semi-documented
extra parameters.

For x86-64, the regparm 3 calling convention was simply missing.

This patch should do the job, provided I'm right in guessing that a
struct passed by value is really passed as a pointer in this case.
(the non-RT signal handler's second arg is a pass-by-value struct)

Signed-off-by: Albert Cahalan <acahalan@gmail.com>
---
I'm sending this inline for review, and attached because
the whitespace will surely be mangled.


diff -Naurd old/arch/i386/kernel/signal.c new/arch/i386/kernel/signal.c
--- old/arch/i386/kernel/signal.c       2006-09-14 03:49:30.000000000 -0400
+++ new/arch/i386/kernel/signal.c       2006-09-14 03:52:54.000000000 -0400
@@ -375,9 +375,9 @@
        /* Set up registers for signal handler */
        regs->esp = (unsigned long) frame;
        regs->eip = (unsigned long) ka->sa.sa_handler;
-       regs->eax = (unsigned long) sig;
-       regs->edx = (unsigned long) 0;
-       regs->ecx = (unsigned long) 0;
+       regs->eax = (unsigned long) usig;
+       regs->edx = (unsigned long) &frame->sc;
+       regs->ecx = (unsigned long) &frame->fpstate;

        set_fs(USER_DS);
        regs->xds = __USER_DS;
diff -Naurd old/arch/x86_64/ia32/ia32_signal.c
new/arch/x86_64/ia32/ia32_signal.c
--- old/arch/x86_64/ia32/ia32_signal.c  2006-09-14 03:21:21.000000000 -0400
+++ new/arch/x86_64/ia32/ia32_signal.c  2006-09-14 03:47:32.000000000 -0400
@@ -433,6 +433,7 @@
 {
        struct sigframe __user *frame;
        int err = 0;
+       int usig;

        frame = get_sigframe(ka, regs, sizeof(*frame));

@@ -441,12 +442,10 @@

        {
                struct exec_domain *ed = current_thread_info()->exec_domain;
-               err |= __put_user((ed
-                          && ed->signal_invmap
-                          && sig < 32
-                          ? ed->signal_invmap[sig]
-                          : sig),
-                         &frame->sig);
+               usig = ed && ed->signal_invmap && sig < 32
+                       ? ed->signal_invmap[sig]
+                       : sig;
+               err |= __put_user(usig,&frame->sig);
        }
        if (err)
                goto give_sigsegv;
@@ -493,6 +492,9 @@
        /* Set up registers for signal handler */
        regs->rsp = (unsigned long) frame;
        regs->rip = (unsigned long) ka->sa.sa_handler;
+       regs->rax = (unsigned long) usig;
+       regs->rdx = (unsigned long) &frame->sc;
+       regs->rcx = (unsigned long) &frame->fpstate;

        asm volatile("movl %0,%%ds" :: "r" (__USER32_DS));
        asm volatile("movl %0,%%es" :: "r" (__USER32_DS));
@@ -522,6 +524,7 @@
 {
        struct rt_sigframe __user *frame;
        int err = 0;
+       int usig;

        frame = get_sigframe(ka, regs, sizeof(*frame));

@@ -530,12 +533,10 @@

        {
                struct exec_domain *ed = current_thread_info()->exec_domain;
-               err |= __put_user((ed
-                          && ed->signal_invmap
-                          && sig < 32
-                          ? ed->signal_invmap[sig]
-                          : sig),
-                         &frame->sig);
+               usig = ed && ed->signal_invmap && sig < 32
+                       ? ed->signal_invmap[sig]
+                       : sig;
+               err |= __put_user(usig,&frame->sig);
        }
        err |= __put_user(ptr_to_compat(&frame->info), &frame->pinfo);
        err |= __put_user(ptr_to_compat(&frame->uc), &frame->puc);
@@ -589,6 +590,9 @@
        /* Set up registers for signal handler */
        regs->rsp = (unsigned long) frame;
        regs->rip = (unsigned long) ka->sa.sa_handler;
+       regs->rax = (unsigned long) usig;
+       regs->rdx = (unsigned long) &frame->info;
+       regs->rcx = (unsigned long) &frame->uc;

        asm volatile("movl %0,%%ds" :: "r" (__USER32_DS));
        asm volatile("movl %0,%%es" :: "r" (__USER32_DS));

------=_Part_40093_30503902.1158222840159
Content-Type: text/x-patch; name=regparm3.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_es2v5tpy
Content-Disposition: attachment; filename="regparm3.patch"

ZGlmZiAtTmF1cmQgb2xkL2FyY2gvaTM4Ni9rZXJuZWwvc2lnbmFsLmMgbmV3L2FyY2gvaTM4Ni9r
ZXJuZWwvc2lnbmFsLmMKLS0tIG9sZC9hcmNoL2kzODYva2VybmVsL3NpZ25hbC5jCTIwMDYtMDkt
MTQgMDM6NDk6MzAuMDAwMDAwMDAwIC0wNDAwCisrKyBuZXcvYXJjaC9pMzg2L2tlcm5lbC9zaWdu
YWwuYwkyMDA2LTA5LTE0IDAzOjUyOjU0LjAwMDAwMDAwMCAtMDQwMApAQCAtMzc1LDkgKzM3NSw5
IEBACiAJLyogU2V0IHVwIHJlZ2lzdGVycyBmb3Igc2lnbmFsIGhhbmRsZXIgKi8KIAlyZWdzLT5l
c3AgPSAodW5zaWduZWQgbG9uZykgZnJhbWU7CiAJcmVncy0+ZWlwID0gKHVuc2lnbmVkIGxvbmcp
IGthLT5zYS5zYV9oYW5kbGVyOwotCXJlZ3MtPmVheCA9ICh1bnNpZ25lZCBsb25nKSBzaWc7Ci0J
cmVncy0+ZWR4ID0gKHVuc2lnbmVkIGxvbmcpIDA7Ci0JcmVncy0+ZWN4ID0gKHVuc2lnbmVkIGxv
bmcpIDA7CisJcmVncy0+ZWF4ID0gKHVuc2lnbmVkIGxvbmcpIHVzaWc7CisJcmVncy0+ZWR4ID0g
KHVuc2lnbmVkIGxvbmcpICZmcmFtZS0+c2M7CisJcmVncy0+ZWN4ID0gKHVuc2lnbmVkIGxvbmcp
ICZmcmFtZS0+ZnBzdGF0ZTsKIAogCXNldF9mcyhVU0VSX0RTKTsKIAlyZWdzLT54ZHMgPSBfX1VT
RVJfRFM7CmRpZmYgLU5hdXJkIG9sZC9hcmNoL3g4Nl82NC9pYTMyL2lhMzJfc2lnbmFsLmMgbmV3
L2FyY2gveDg2XzY0L2lhMzIvaWEzMl9zaWduYWwuYwotLS0gb2xkL2FyY2gveDg2XzY0L2lhMzIv
aWEzMl9zaWduYWwuYwkyMDA2LTA5LTE0IDAzOjIxOjIxLjAwMDAwMDAwMCAtMDQwMAorKysgbmV3
L2FyY2gveDg2XzY0L2lhMzIvaWEzMl9zaWduYWwuYwkyMDA2LTA5LTE0IDAzOjQ3OjMyLjAwMDAw
MDAwMCAtMDQwMApAQCAtNDMzLDYgKzQzMyw3IEBACiB7CiAJc3RydWN0IHNpZ2ZyYW1lIF9fdXNl
ciAqZnJhbWU7CiAJaW50IGVyciA9IDA7CisJaW50IHVzaWc7CiAKIAlmcmFtZSA9IGdldF9zaWdm
cmFtZShrYSwgcmVncywgc2l6ZW9mKCpmcmFtZSkpOwogCkBAIC00NDEsMTIgKzQ0MiwxMCBAQAog
CiAJewogCQlzdHJ1Y3QgZXhlY19kb21haW4gKmVkID0gY3VycmVudF90aHJlYWRfaW5mbygpLT5l
eGVjX2RvbWFpbjsKLQkJZXJyIHw9IF9fcHV0X3VzZXIoKGVkCi0JCSAgICAgICAgICAgJiYgZWQt
PnNpZ25hbF9pbnZtYXAKLQkJICAgICAgICAgICAmJiBzaWcgPCAzMgotCQkgICAgICAgICAgID8g
ZWQtPnNpZ25hbF9pbnZtYXBbc2lnXQotCQkgICAgICAgICAgIDogc2lnKSwKLQkJICAgICAgICAg
ICZmcmFtZS0+c2lnKTsKKwkJdXNpZyA9IGVkICYmIGVkLT5zaWduYWxfaW52bWFwICYmIHNpZyA8
IDMyCisJCQk/IGVkLT5zaWduYWxfaW52bWFwW3NpZ10KKwkJCTogc2lnOworCQllcnIgfD0gX19w
dXRfdXNlcih1c2lnLCZmcmFtZS0+c2lnKTsKIAl9CiAJaWYgKGVycikKIAkJZ290byBnaXZlX3Np
Z3NlZ3Y7CkBAIC00OTMsNiArNDkyLDkgQEAKIAkvKiBTZXQgdXAgcmVnaXN0ZXJzIGZvciBzaWdu
YWwgaGFuZGxlciAqLwogCXJlZ3MtPnJzcCA9ICh1bnNpZ25lZCBsb25nKSBmcmFtZTsKIAlyZWdz
LT5yaXAgPSAodW5zaWduZWQgbG9uZykga2EtPnNhLnNhX2hhbmRsZXI7CisJcmVncy0+cmF4ID0g
KHVuc2lnbmVkIGxvbmcpIHVzaWc7CisJcmVncy0+cmR4ID0gKHVuc2lnbmVkIGxvbmcpICZmcmFt
ZS0+c2M7CisJcmVncy0+cmN4ID0gKHVuc2lnbmVkIGxvbmcpICZmcmFtZS0+ZnBzdGF0ZTsKIAog
CWFzbSB2b2xhdGlsZSgibW92bCAlMCwlJWRzIiA6OiAiciIgKF9fVVNFUjMyX0RTKSk7IAogCWFz
bSB2b2xhdGlsZSgibW92bCAlMCwlJWVzIiA6OiAiciIgKF9fVVNFUjMyX0RTKSk7IApAQCAtNTIy
LDYgKzUyNCw3IEBACiB7CiAJc3RydWN0IHJ0X3NpZ2ZyYW1lIF9fdXNlciAqZnJhbWU7CiAJaW50
IGVyciA9IDA7CisJaW50IHVzaWc7CiAKIAlmcmFtZSA9IGdldF9zaWdmcmFtZShrYSwgcmVncywg
c2l6ZW9mKCpmcmFtZSkpOwogCkBAIC01MzAsMTIgKzUzMywxMCBAQAogCiAJewogCQlzdHJ1Y3Qg
ZXhlY19kb21haW4gKmVkID0gY3VycmVudF90aHJlYWRfaW5mbygpLT5leGVjX2RvbWFpbjsKLQkJ
ZXJyIHw9IF9fcHV0X3VzZXIoKGVkCi0JCSAgICAJICAgJiYgZWQtPnNpZ25hbF9pbnZtYXAKLQkJ
ICAgIAkgICAmJiBzaWcgPCAzMgotCQkgICAgCSAgID8gZWQtPnNpZ25hbF9pbnZtYXBbc2lnXQot
CQkJICAgOiBzaWcpLAotCQkJICAmZnJhbWUtPnNpZyk7CisJCXVzaWcgPSBlZCAmJiBlZC0+c2ln
bmFsX2ludm1hcCAmJiBzaWcgPCAzMgorCQkJPyBlZC0+c2lnbmFsX2ludm1hcFtzaWddCisJCQk6
IHNpZzsKKwkJZXJyIHw9IF9fcHV0X3VzZXIodXNpZywmZnJhbWUtPnNpZyk7CiAJfQogCWVyciB8
PSBfX3B1dF91c2VyKHB0cl90b19jb21wYXQoJmZyYW1lLT5pbmZvKSwgJmZyYW1lLT5waW5mbyk7
CiAJZXJyIHw9IF9fcHV0X3VzZXIocHRyX3RvX2NvbXBhdCgmZnJhbWUtPnVjKSwgJmZyYW1lLT5w
dWMpOwpAQCAtNTg5LDYgKzU5MCw5IEBACiAJLyogU2V0IHVwIHJlZ2lzdGVycyBmb3Igc2lnbmFs
IGhhbmRsZXIgKi8KIAlyZWdzLT5yc3AgPSAodW5zaWduZWQgbG9uZykgZnJhbWU7CiAJcmVncy0+
cmlwID0gKHVuc2lnbmVkIGxvbmcpIGthLT5zYS5zYV9oYW5kbGVyOworCXJlZ3MtPnJheCA9ICh1
bnNpZ25lZCBsb25nKSB1c2lnOworCXJlZ3MtPnJkeCA9ICh1bnNpZ25lZCBsb25nKSAmZnJhbWUt
PmluZm87CisJcmVncy0+cmN4ID0gKHVuc2lnbmVkIGxvbmcpICZmcmFtZS0+dWM7CiAKIAlhc20g
dm9sYXRpbGUoIm1vdmwgJTAsJSVkcyIgOjogInIiIChfX1VTRVIzMl9EUykpOyAKIAlhc20gdm9s
YXRpbGUoIm1vdmwgJTAsJSVlcyIgOjogInIiIChfX1VTRVIzMl9EUykpOyAK
------=_Part_40093_30503902.1158222840159--
