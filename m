Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbVIHPNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbVIHPNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVIHPNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:13:46 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:21603
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932663AbVIHPNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:13:45 -0400
Message-Id: <4320718A0200007800024476@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:14:50 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix i386 interrupt re-enabling in die()
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part24064A7A.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part24064A7A.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Rather than blindly re-enabling interrupts in die(), save their state
upon
entry and then restore that state.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/traps.c
2.6.13-i386-die-irq/arch/i386/kernel/traps.c
--- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-die-irq/arch/i386/kernel/traps.c	2005-09-07
11:39:40.000000000 +0200
@@ -304,6 +304,7 @@ void die(const char * str, struct pt_reg
 		spinlock_t lock;
 		u32 lock_owner;
 		int lock_owner_depth;
+		unsigned long flags;
 	} die = {
 		.lock =			SPIN_LOCK_UNLOCKED,
 		.lock_owner =		-1,
@@ -313,7 +314,7 @@ void die(const char * str, struct pt_reg
 
 	if (die.lock_owner != raw_smp_processor_id()) {
 		console_verbose();
-		spin_lock_irq(&die.lock);
+		spin_lock_irqsave(&die.lock, die.flags);
 		die.lock_owner = smp_processor_id();
 		die.lock_owner_depth = 0;
 		bust_spinlocks(1);
@@ -344,7 +345,7 @@ void die(const char * str, struct pt_reg
 
 	bust_spinlocks(0);
 	die.lock_owner = -1;
-	spin_unlock_irq(&die.lock);
+	spin_unlock_irqrestore(&die.lock, die.flags);
 
 	if (kexec_should_crash(current))
 		crash_kexec(regs);


--=__Part24064A7A.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-die-irq.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-die-irq.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClJhdGhlciB0aGFuIGJsaW5kbHkgcmUtZW5h
YmxpbmcgaW50ZXJydXB0cyBpbiBkaWUoKSwgc2F2ZSB0aGVpciBzdGF0ZSB1cG9uCmVudHJ5IGFu
ZCB0aGVuIHJlc3RvcmUgdGhhdCBzdGF0ZS4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxq
YmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5lbC90
cmFwcy5jIDIuNi4xMy1pMzg2LWRpZS1pcnEvYXJjaC9pMzg2L2tlcm5lbC90cmFwcy5jCi0tLSAy
LjYuMTMvYXJjaC9pMzg2L2tlcm5lbC90cmFwcy5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAw
MDAwICswMjAwCisrKyAyLjYuMTMtaTM4Ni1kaWUtaXJxL2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMu
YwkyMDA1LTA5LTA3IDExOjM5OjQwLjAwMDAwMDAwMCArMDIwMApAQCAtMzA0LDYgKzMwNCw3IEBA
IHZvaWQgZGllKGNvbnN0IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yZWcKIAkJc3BpbmxvY2tfdCBs
b2NrOwogCQl1MzIgbG9ja19vd25lcjsKIAkJaW50IGxvY2tfb3duZXJfZGVwdGg7CisJCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7CiAJfSBkaWUgPSB7CiAJCS5sb2NrID0JCQlTUElOX0xPQ0tfVU5MT0NL
RUQsCiAJCS5sb2NrX293bmVyID0JCS0xLApAQCAtMzEzLDcgKzMxNCw3IEBAIHZvaWQgZGllKGNv
bnN0IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yZWcKIAogCWlmIChkaWUubG9ja19vd25lciAhPSBy
YXdfc21wX3Byb2Nlc3Nvcl9pZCgpKSB7CiAJCWNvbnNvbGVfdmVyYm9zZSgpOwotCQlzcGluX2xv
Y2tfaXJxKCZkaWUubG9jayk7CisJCXNwaW5fbG9ja19pcnFzYXZlKCZkaWUubG9jaywgZGllLmZs
YWdzKTsKIAkJZGllLmxvY2tfb3duZXIgPSBzbXBfcHJvY2Vzc29yX2lkKCk7CiAJCWRpZS5sb2Nr
X293bmVyX2RlcHRoID0gMDsKIAkJYnVzdF9zcGlubG9ja3MoMSk7CkBAIC0zNDQsNyArMzQ1LDcg
QEAgdm9pZCBkaWUoY29uc3QgY2hhciAqIHN0ciwgc3RydWN0IHB0X3JlZwogCiAJYnVzdF9zcGlu
bG9ja3MoMCk7CiAJZGllLmxvY2tfb3duZXIgPSAtMTsKLQlzcGluX3VubG9ja19pcnEoJmRpZS5s
b2NrKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkaWUubG9jaywgZGllLmZsYWdzKTsKIAog
CWlmIChrZXhlY19zaG91bGRfY3Jhc2goY3VycmVudCkpCiAJCWNyYXNoX2tleGVjKHJlZ3MpOwo=

--=__Part24064A7A.0__=--
