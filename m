Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVIIJoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVIIJoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVIIJoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:44:12 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:7958
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030203AbVIIJoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:44:10 -0400
Message-Id: <432175CB02000078000248D0@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 11:45:15 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix i386 interrupt re-enabling in die() (attempt
	2)
References: <4320718A0200007800024476@emea1-mh.id2.novell.com> <Pine.LNX.4.63.0509081036110.8052@r3000.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.63.0509081036110.8052@r3000.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartE8CA87BB.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartE8CA87BB.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>>> Zwane Mwaikambo <zwane@arm.linux.org.uk> 08.09.05 19:37:20 >>>
>On Thu, 8 Sep 2005, Jan Beulich wrote:
>
>> diff -Npru 2.6.13/arch/i386/kernel/traps.c
>> 2.6.13-i386-die-irq/arch/i386/kernel/traps.c
>> --- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
>> +0200
>> +++ 2.6.13-i386-die-irq/arch/i386/kernel/traps.c	2005-09-07
>> 11:39:40.000000000 +0200
>> @@ -304,6 +304,7 @@ void die(const char * str, struct pt_reg
>>  		spinlock_t lock;
>>  		u32 lock_owner;
>>  		int lock_owner_depth;
>> +		unsigned long flags;
>>  	} die = {
>>  		.lock =			SPIN_LOCK_UNLOCKED,
>>  		.lock_owner =		-1,
>> @@ -313,7 +314,7 @@ void die(const char * str, struct pt_reg
>>  
>>  	if (die.lock_owner != raw_smp_processor_id()) {
>>  		console_verbose();
>> -		spin_lock_irq(&die.lock);
>> +		spin_lock_irqsave(&die.lock, die.flags);
>
>This corrupts flags on contention, use a stack variable.

Indeed. Corrected below:

(Note: Patch also attached because the inline version is certain to
get
line wrapped.)

Rather than blindly re-enabling interrupts in die(), save their state
upon
entry and then restore that state.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/traps.c
2.6.13-i386-die-irq/arch/i386/kernel/traps.c
--- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-die-irq/arch/i386/kernel/traps.c	2005-09-09
11:33:30.202343904 +0200
@@ -310,14 +310,17 @@ void die(const char * str, struct pt_reg
 		.lock_owner_depth =	0
 	};
 	static int die_counter;
+	unsigned long flags;
 
 	if (die.lock_owner != raw_smp_processor_id()) {
 		console_verbose();
-		spin_lock_irq(&die.lock);
+		spin_lock_irqsave(&die.lock, flags);
 		die.lock_owner = smp_processor_id();
 		die.lock_owner_depth = 0;
 		bust_spinlocks(1);
 	}
+	else
+		local_save_flags(flags);
 
 	if (++die.lock_owner_depth < 3) {
 		int nl = 0;
@@ -344,7 +347,7 @@ void die(const char * str, struct pt_reg
 
 	bust_spinlocks(0);
 	die.lock_owner = -1;
-	spin_unlock_irq(&die.lock);
+	spin_unlock_irqrestore(&die.lock, flags);
 
 	if (kexec_should_crash(current))
 		crash_kexec(regs);


--=__PartE8CA87BB.1__=
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
YwkyMDA1LTA5LTA5IDExOjMzOjMwLjIwMjM0MzkwNCArMDIwMApAQCAtMzEwLDE0ICszMTAsMTcg
QEAgdm9pZCBkaWUoY29uc3QgY2hhciAqIHN0ciwgc3RydWN0IHB0X3JlZwogCQkubG9ja19vd25l
cl9kZXB0aCA9CTAKIAl9OwogCXN0YXRpYyBpbnQgZGllX2NvdW50ZXI7CisJdW5zaWduZWQgbG9u
ZyBmbGFnczsKIAogCWlmIChkaWUubG9ja19vd25lciAhPSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgp
KSB7CiAJCWNvbnNvbGVfdmVyYm9zZSgpOwotCQlzcGluX2xvY2tfaXJxKCZkaWUubG9jayk7CisJ
CXNwaW5fbG9ja19pcnFzYXZlKCZkaWUubG9jaywgZmxhZ3MpOwogCQlkaWUubG9ja19vd25lciA9
IHNtcF9wcm9jZXNzb3JfaWQoKTsKIAkJZGllLmxvY2tfb3duZXJfZGVwdGggPSAwOwogCQlidXN0
X3NwaW5sb2NrcygxKTsKIAl9CisJZWxzZQorCQlsb2NhbF9zYXZlX2ZsYWdzKGZsYWdzKTsKIAog
CWlmICgrK2RpZS5sb2NrX293bmVyX2RlcHRoIDwgMykgewogCQlpbnQgbmwgPSAwOwpAQCAtMzQ0
LDcgKzM0Nyw3IEBAIHZvaWQgZGllKGNvbnN0IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yZWcKIAog
CWJ1c3Rfc3BpbmxvY2tzKDApOwogCWRpZS5sb2NrX293bmVyID0gLTE7Ci0Jc3Bpbl91bmxvY2tf
aXJxKCZkaWUubG9jayk7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGllLmxvY2ssIGZsYWdz
KTsKIAogCWlmIChrZXhlY19zaG91bGRfY3Jhc2goY3VycmVudCkpCiAJCWNyYXNoX2tleGVjKHJl
Z3MpOwo=

--=__PartE8CA87BB.1__=--
