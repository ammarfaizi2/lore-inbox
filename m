Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUHXGgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUHXGgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHXGgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:36:35 -0400
Received: from fmr06.intel.com ([134.134.136.7]:32723 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265977AbUHXGg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:36:29 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C489A4.AE54A0EA"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: interrupt is enabled before it should be when kernel is booted
Date: Tue, 24 Aug 2004 14:36:19 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84392E19@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: interrupt is enabled before it should be when kernel is booted
Thread-Index: AcSJpKnt8shjlyZpS7KgENRmk/3kzQ==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Aug 2004 06:36:26.0776 (UTC) FILETIME=[AE74F980:01C489A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C489A4.AE54A0EA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

There is a minor problem in function start_kernel. start_kernel will
enable interrupt after calling profile_init. However, before that,
function time_init on IA64 platform could enable interrupt. See this
call sequence:
start_kernel->time_init->ia64_init_itm->register_time_interpolator->writ
e_seqlock_irq.=20
The attachment is a patch to fix it in generic source codes against
2.6.8.

Signed-off-by:	Zhang Yanmin <yanmin.zhang@intel.com>
Signed-off-by:	Yao Jun	<junx.yao@intel.com>


diff -Nraup linux-2.6.8/kernel/timer.c linux-2.6.8_fix/kernel/timer.c
--- linux-2.6.8/kernel/timer.c	2004-08-16 07:58:21.000000000 +0800
+++ linux-2.6.8_fix/kernel/timer.c	2004-08-17 17:03:38.364035163
+0800
@@ -1447,11 +1447,13 @@ is_better_time_interpolator(struct time_
 void
 register_time_interpolator(struct time_interpolator *ti)
 {
+	unsigned long	flags;
+
 	spin_lock(&time_interpolator_lock);
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock_irqsave(&xtime_lock, flags);
 	if (is_better_time_interpolator(ti))
 		time_interpolator =3D ti;
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
=20
 	ti->next =3D time_interpolator_list;
 	time_interpolator_list =3D ti;
@@ -1462,6 +1464,7 @@ void
 unregister_time_interpolator(struct time_interpolator *ti)
 {
 	struct time_interpolator *curr, **prev;
+	unsigned long	flags;
=20
 	spin_lock(&time_interpolator_lock);
 	prev =3D &time_interpolator_list;
@@ -1473,7 +1476,7 @@ unregister_time_interpolator(struct time
 		prev =3D &curr->next;
 	}
=20
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock_irqsave(&xtime_lock, flags);
 	if (ti =3D=3D time_interpolator) {
 		/* we lost the best time-interpolator: */
 		time_interpolator =3D NULL;
@@ -1482,7 +1485,7 @@ unregister_time_interpolator(struct time
 			if (is_better_time_interpolator(curr))
 				time_interpolator =3D curr;
 	}
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 	spin_unlock(&time_interpolator_lock);
 }
 #endif /* CONFIG_TIME_INTERPOLATION */



 <<time_init_enable_interrupt.patch.diff>>=20

------_=_NextPart_001_01C489A4.AE54A0EA
Content-Type: application/octet-stream;
	name="time_init_enable_interrupt.patch.diff"
Content-Transfer-Encoding: base64
Content-Description: time_init_enable_interrupt.patch.diff
Content-Disposition: attachment;
	filename="time_init_enable_interrupt.patch.diff"

ZGlmZiAtTnJhdXAgbGludXgtMi42Ljgva2VybmVsL3RpbWVyLmMgbGludXgtMi42LjhfZml4L2tl
cm5lbC90aW1lci5jCi0tLSBsaW51eC0yLjYuOC9rZXJuZWwvdGltZXIuYwkyMDA0LTA4LTE2IDA3
OjU4OjIxLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjhfZml4L2tlcm5lbC90aW1lci5j
CTIwMDQtMDgtMTcgMTc6MDM6MzguMzY0MDM1MTYzICswODAwCkBAIC0xNDQ3LDExICsxNDQ3LDEz
IEBAIGlzX2JldHRlcl90aW1lX2ludGVycG9sYXRvcihzdHJ1Y3QgdGltZV8KIHZvaWQKIHJlZ2lz
dGVyX3RpbWVfaW50ZXJwb2xhdG9yKHN0cnVjdCB0aW1lX2ludGVycG9sYXRvciAqdGkpCiB7CisJ
dW5zaWduZWQgbG9uZwlmbGFnczsKKwogCXNwaW5fbG9jaygmdGltZV9pbnRlcnBvbGF0b3JfbG9j
ayk7Ci0Jd3JpdGVfc2VxbG9ja19pcnEoJnh0aW1lX2xvY2spOworCXdyaXRlX3NlcWxvY2tfaXJx
c2F2ZSgmeHRpbWVfbG9jaywgZmxhZ3MpOwogCWlmIChpc19iZXR0ZXJfdGltZV9pbnRlcnBvbGF0
b3IodGkpKQogCQl0aW1lX2ludGVycG9sYXRvciA9IHRpOwotCXdyaXRlX3NlcXVubG9ja19pcnEo
Jnh0aW1lX2xvY2spOworCXdyaXRlX3NlcXVubG9ja19pcnFyZXN0b3JlKCZ4dGltZV9sb2NrLCBm
bGFncyk7CiAKIAl0aS0+bmV4dCA9IHRpbWVfaW50ZXJwb2xhdG9yX2xpc3Q7CiAJdGltZV9pbnRl
cnBvbGF0b3JfbGlzdCA9IHRpOwpAQCAtMTQ2Miw2ICsxNDY0LDcgQEAgdm9pZAogdW5yZWdpc3Rl
cl90aW1lX2ludGVycG9sYXRvcihzdHJ1Y3QgdGltZV9pbnRlcnBvbGF0b3IgKnRpKQogewogCXN0
cnVjdCB0aW1lX2ludGVycG9sYXRvciAqY3VyciwgKipwcmV2OworCXVuc2lnbmVkIGxvbmcJZmxh
Z3M7CiAKIAlzcGluX2xvY2soJnRpbWVfaW50ZXJwb2xhdG9yX2xvY2spOwogCXByZXYgPSAmdGlt
ZV9pbnRlcnBvbGF0b3JfbGlzdDsKQEAgLTE0NzMsNyArMTQ3Niw3IEBAIHVucmVnaXN0ZXJfdGlt
ZV9pbnRlcnBvbGF0b3Ioc3RydWN0IHRpbWUKIAkJcHJldiA9ICZjdXJyLT5uZXh0OwogCX0KIAot
CXdyaXRlX3NlcWxvY2tfaXJxKCZ4dGltZV9sb2NrKTsKKwl3cml0ZV9zZXFsb2NrX2lycXNhdmUo
Jnh0aW1lX2xvY2ssIGZsYWdzKTsKIAlpZiAodGkgPT0gdGltZV9pbnRlcnBvbGF0b3IpIHsKIAkJ
Lyogd2UgbG9zdCB0aGUgYmVzdCB0aW1lLWludGVycG9sYXRvcjogKi8KIAkJdGltZV9pbnRlcnBv
bGF0b3IgPSBOVUxMOwpAQCAtMTQ4Miw3ICsxNDg1LDcgQEAgdW5yZWdpc3Rlcl90aW1lX2ludGVy
cG9sYXRvcihzdHJ1Y3QgdGltZQogCQkJaWYgKGlzX2JldHRlcl90aW1lX2ludGVycG9sYXRvcihj
dXJyKSkKIAkJCQl0aW1lX2ludGVycG9sYXRvciA9IGN1cnI7CiAJfQotCXdyaXRlX3NlcXVubG9j
a19pcnEoJnh0aW1lX2xvY2spOworCXdyaXRlX3NlcXVubG9ja19pcnFyZXN0b3JlKCZ4dGltZV9s
b2NrLCBmbGFncyk7CiAJc3Bpbl91bmxvY2soJnRpbWVfaW50ZXJwb2xhdG9yX2xvY2spOwogfQog
I2VuZGlmIC8qIENPTkZJR19USU1FX0lOVEVSUE9MQVRJT04gKi8K

------_=_NextPart_001_01C489A4.AE54A0EA--
