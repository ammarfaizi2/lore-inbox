Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUFBMB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUFBMB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFBMBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:01:45 -0400
Received: from fmr06.intel.com ([134.134.136.7]:29892 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261987AbUFBMBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:01:11 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C44899.3E76399C"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] One possible bugfix for CLOCK_REALTIME timer. 
Date: Wed, 2 Jun 2004 20:00:48 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E04560E0C@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] One possible bugfix for CLOCK_REALTIME timer. 
Thread-Index: AcRImT4tGCB1EhuuQjiZyDzl9M1QEw==
From: "Hu, Boris" <boris.hu@intel.com>
To: <george@mvista.com>
Cc: <drepper@redhat.com>, "Li, Adam" <adam.li@intel.com>,
       "Hu, Boris" <boris.hu@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Jun 2004 12:00:49.0383 (UTC) FILETIME=[3EC9DF70:01C44899]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C44899.3E76399C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 <<posix-abs_timer-bugfix.diff>> George,

There is one bug of CLOCK_REALTIME timer reported by Adam at
http://sources.redhat.com/ml/libc-alpha/2004-05/msg00177.html.=20

Here is one possible bugfix and it is against linux-2.6.6. All
TIMER_ABSTIME cloks will be collected in k_clock struct and updated in
sys_clock_settime. Could you review it? Thanks.=20


diff -urN -X rt.ia32/base/dontdiff
linux-2.6.6/include/linux/posix-timers.h
linux-2.6.6.dev/include/linux/posix-timers.h
--- linux-2.6.6/include/linux/posix-timers.h	2004-05-10
10:32:29.000000000 +0800
+++ linux-2.6.6.dev/include/linux/posix-timers.h	2004-06-02
10:30:57.000000000 +0800
@@ -1,9 +1,14 @@
 #ifndef _linux_POSIX_TIMERS_H
 #define _linux_POSIX_TIMERS_H
=20
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
 struct k_clock {
 	int res;		/* in nano seconds */
-	int (*clock_set) (struct timespec * tp);
+        struct list_head abs_timer_list;
+        spinlock_t abs_timer_lock;
+        int (*clock_set) (struct timespec * tp);
 	int (*clock_get) (struct timespec * tp);
 	int (*nsleep) (int flags,
 		       struct timespec * new_setting,
diff -urN -X rt.ia32/base/dontdiff linux-2.6.6/include/linux/timer.h
linux-2.6.6.dev/include/linux/timer.h
--- linux-2.6.6/include/linux/timer.h	2004-05-10 10:32:54.000000000
+0800
+++ linux-2.6.6.dev/include/linux/timer.h	2004-06-02
19:16:08.000000000 +0800
@@ -9,6 +9,7 @@
=20
 struct timer_list {
 	struct list_head entry;
+	struct list_head abs_timer_entry;
 	unsigned long expires;
=20
 	spinlock_t lock;
diff -urN -X rt.ia32/base/dontdiff linux-2.6.6/kernel/posix-timers.c
linux-2.6.6.dev/kernel/posix-timers.c
--- linux-2.6.6/kernel/posix-timers.c	2004-05-10 10:32:37.000000000
+0800
+++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-02
19:12:31.000000000 +0800
@@ -7,6 +7,9 @@
  *
  *			     Copyright (C) 2002 2003 by MontaVista
Software.
  *
+ * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
+ *                           Copyright (C) 2004 Boris Hu
+ *                           =20
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
(at
@@ -200,7 +203,9 @@
  */
 static __init int init_posix_timers(void)
 {
-	struct k_clock clock_realtime =3D {.res =3D CLOCK_REALTIME_RES };
+	struct k_clock clock_realtime =3D {.res =3D CLOCK_REALTIME_RES,
+                .abs_timer_lock =3D SPIN_LOCK_UNLOCKED

+        };
 	struct k_clock clock_monotonic =3D {.res =3D CLOCK_REALTIME_RES,
 		.clock_get =3D do_posix_clock_monotonic_gettime,
 		.clock_set =3D do_posix_clock_monotonic_settime
@@ -388,6 +393,7 @@
 		return;
 	}
 	posix_clocks[clock_id] =3D *new_clock;
+        INIT_LIST_HEAD(&posix_clocks[clock_id].abs_timer_list);
 }
=20
 static struct k_itimer * alloc_posix_timer(void)
@@ -843,8 +849,15 @@
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) !=3D SIGEV_NONE))
{
 		if (timr->it_timer.expires =3D=3D jiffies)
 			timer_notify_task(timr);
-		else
+		else {
 			add_timer(&timr->it_timer);
+                        if (flags & TIMER_ABSTIME) {
+                                spin_lock(&clock->abs_timer_lock);
+
list_add_tail(&(timr->it_timer.abs_timer_entry),
+
&(clock->abs_timer_list));
+                                spin_unlock(&clock->abs_timer_lock);
+                        }
+                }
 	}
 	return 0;
 }
@@ -1085,16 +1098,61 @@
 sys_clock_settime(clockid_t which_clock, const struct timespec __user
*tp)
 {
 	struct timespec new_tp;
+        struct timespec before, now;
+        struct k_clock *clock;
+        long ret;
+        struct timer_list *timer, *tmp;
+        struct timespec delta;
+        u64 exp =3D 0;
=20
-	if ((unsigned) which_clock >=3D MAX_CLOCKS ||
+        if ((unsigned) which_clock >=3D MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
-	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
+
+        clock =3D &posix_clocks[which_clock];
+
+        if (copy_from_user(&new_tp, tp, sizeof (*tp)))
 		return -EFAULT;
 	if (posix_clocks[which_clock].clock_set)
 		return posix_clocks[which_clock].clock_set(&new_tp);
=20
-	return do_sys_settimeofday(&new_tp, NULL);
+        do_posix_gettime(clock, &before);
+       =20
+	ret =3D do_sys_settimeofday(&new_tp, NULL);
+
+        /*
+         * Check if there exist TIMER_ABSTIME timers to update.
+         */
+        if (which_clock !=3D CLOCK_REALTIME ||
+            list_empty(&clock->abs_timer_list))
+                return ret;
+
+        do_posix_gettime(clock, &now);
+        delta.tv_sec =3D before.tv_sec - now.tv_sec;
+        delta.tv_nsec =3D before.tv_nsec - now.tv_nsec;
+        while (delta.tv_nsec >=3D NSEC_PER_SEC) {
+                delta.tv_sec ++;
+                delta.tv_nsec -=3D NSEC_PER_SEC;
+        }
+        while (delta.tv_nsec < 0) {
+                delta.tv_sec --;
+                delta.tv_nsec +=3D NSEC_PER_SEC;
+        }
+
+        tstojiffie(&delta, clock->res, &exp);
+
+        spin_lock(&(clock->abs_timer_lock));
+        list_for_each_entry_safe(timer, tmp,
+                                 &clock->abs_timer_list,
+                                 abs_timer_entry) {
+                if (timer && del_timer(timer)) { //the timer has not
run
+                        timer->expires +=3D exp;=20
+                        add_timer(timer);
+                } else
+                        list_del(&timer->abs_timer_entry);
+        }
+        spin_unlock(&(clock->abs_timer_lock));
+        return ret;
 }
=20
 asmlinkage long

Good Luck !
Boris Hu (Hu Jiangtao)
Intel China Software Center
86-021-5257-4545#1277
iNET: 8-752-1277
************************************
There are my thoughts, not my employer's.
************************************
"gpg --recv-keys --keyserver wwwkeys.pgp.net 0FD7685F"
{0FD7685F:CFD6 6F5C A2CB 7881 725B  CEA0 956F 9F14 0FD7 685F}



------_=_NextPart_001_01C44899.3E76399C
Content-Type: application/octet-stream;
	name="posix-abs_timer-bugfix.diff"
Content-Transfer-Encoding: base64
Content-Description: posix-abs_timer-bugfix.diff
Content-Disposition: attachment;
	filename="posix-abs_timer-bugfix.diff"

ZGlmZiAtdXJOIC1YIHJ0LmlhMzIvYmFzZS9kb250ZGlmZiBsaW51eC0yLjYuNi9pbmNsdWRlL2xp
bnV4L3Bvc2l4LXRpbWVycy5oIGxpbnV4LTIuNi42LmRldi9pbmNsdWRlL2xpbnV4L3Bvc2l4LXRp
bWVycy5oCi0tLSBsaW51eC0yLjYuNi9pbmNsdWRlL2xpbnV4L3Bvc2l4LXRpbWVycy5oCTIwMDQt
MDUtMTAgMTA6MzI6MjkuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuNi5kZXYvaW5jbHVk
ZS9saW51eC9wb3NpeC10aW1lcnMuaAkyMDA0LTA2LTAyIDEwOjMwOjU3LjAwMDAwMDAwMCArMDgw
MApAQCAtMSw5ICsxLDE0IEBACiAjaWZuZGVmIF9saW51eF9QT1NJWF9USU1FUlNfSAogI2RlZmlu
ZSBfbGludXhfUE9TSVhfVElNRVJTX0gKIAorI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4KKyNpbmNs
dWRlIDxsaW51eC9zcGlubG9jay5oPgorCiBzdHJ1Y3Qga19jbG9jayB7CiAJaW50IHJlczsJCS8q
IGluIG5hbm8gc2Vjb25kcyAqLwotCWludCAoKmNsb2NrX3NldCkgKHN0cnVjdCB0aW1lc3BlYyAq
IHRwKTsKKyAgICAgICAgc3RydWN0IGxpc3RfaGVhZCBhYnNfdGltZXJfbGlzdDsKKyAgICAgICAg
c3BpbmxvY2tfdCBhYnNfdGltZXJfbG9jazsKKyAgICAgICAgaW50ICgqY2xvY2tfc2V0KSAoc3Ry
dWN0IHRpbWVzcGVjICogdHApOwogCWludCAoKmNsb2NrX2dldCkgKHN0cnVjdCB0aW1lc3BlYyAq
IHRwKTsKIAlpbnQgKCpuc2xlZXApIChpbnQgZmxhZ3MsCiAJCSAgICAgICBzdHJ1Y3QgdGltZXNw
ZWMgKiBuZXdfc2V0dGluZywKZGlmZiAtdXJOIC1YIHJ0LmlhMzIvYmFzZS9kb250ZGlmZiBsaW51
eC0yLjYuNi9pbmNsdWRlL2xpbnV4L3RpbWVyLmggbGludXgtMi42LjYuZGV2L2luY2x1ZGUvbGlu
dXgvdGltZXIuaAotLS0gbGludXgtMi42LjYvaW5jbHVkZS9saW51eC90aW1lci5oCTIwMDQtMDUt
MTAgMTA6MzI6NTQuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuNi5kZXYvaW5jbHVkZS9s
aW51eC90aW1lci5oCTIwMDQtMDYtMDIgMTk6MTY6MDguMDAwMDAwMDAwICswODAwCkBAIC05LDYg
KzksNyBAQAogCiBzdHJ1Y3QgdGltZXJfbGlzdCB7CiAJc3RydWN0IGxpc3RfaGVhZCBlbnRyeTsK
KwlzdHJ1Y3QgbGlzdF9oZWFkIGFic190aW1lcl9lbnRyeTsKIAl1bnNpZ25lZCBsb25nIGV4cGly
ZXM7CiAKIAlzcGlubG9ja190IGxvY2s7CmRpZmYgLXVyTiAtWCBydC5pYTMyL2Jhc2UvZG9udGRp
ZmYgbGludXgtMi42LjYva2VybmVsL3Bvc2l4LXRpbWVycy5jIGxpbnV4LTIuNi42LmRldi9rZXJu
ZWwvcG9zaXgtdGltZXJzLmMKLS0tIGxpbnV4LTIuNi42L2tlcm5lbC9wb3NpeC10aW1lcnMuYwky
MDA0LTA1LTEwIDEwOjMyOjM3LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjYuZGV2L2tl
cm5lbC9wb3NpeC10aW1lcnMuYwkyMDA0LTA2LTAyIDE5OjEyOjMxLjAwMDAwMDAwMCArMDgwMApA
QCAtNyw2ICs3LDkgQEAKICAqCiAgKgkJCSAgICAgQ29weXJpZ2h0IChDKSAyMDAyIDIwMDMgYnkg
TW9udGFWaXN0YSBTb2Z0d2FyZS4KICAqCisgKiAyMDA0LTA2LTAxICBGaXggQ0xPQ0tfUkVBTFRJ
TUUgY2xvY2svdGltZXIgVElNRVJfQUJTVElNRSBidWcuCisgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIENvcHlyaWdodCAoQykgMjAwNCBCb3JpcyBIdQorICogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRp
c3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKICAqIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yIChh
dApAQCAtMjAwLDcgKzIwMyw5IEBACiAgKi8KIHN0YXRpYyBfX2luaXQgaW50IGluaXRfcG9zaXhf
dGltZXJzKHZvaWQpCiB7Ci0Jc3RydWN0IGtfY2xvY2sgY2xvY2tfcmVhbHRpbWUgPSB7LnJlcyA9
IENMT0NLX1JFQUxUSU1FX1JFUyB9OworCXN0cnVjdCBrX2Nsb2NrIGNsb2NrX3JlYWx0aW1lID0g
ey5yZXMgPSBDTE9DS19SRUFMVElNRV9SRVMsCisgICAgICAgICAgICAgICAgLmFic190aW1lcl9s
b2NrID0gU1BJTl9MT0NLX1VOTE9DS0VEICAgICAgICAgICAgICAgICAgICAgICAgIAorICAgICAg
ICB9OwogCXN0cnVjdCBrX2Nsb2NrIGNsb2NrX21vbm90b25pYyA9IHsucmVzID0gQ0xPQ0tfUkVB
TFRJTUVfUkVTLAogCQkuY2xvY2tfZ2V0ID0gZG9fcG9zaXhfY2xvY2tfbW9ub3RvbmljX2dldHRp
bWUsCiAJCS5jbG9ja19zZXQgPSBkb19wb3NpeF9jbG9ja19tb25vdG9uaWNfc2V0dGltZQpAQCAt
Mzg4LDYgKzM5Myw3IEBACiAJCXJldHVybjsKIAl9CiAJcG9zaXhfY2xvY2tzW2Nsb2NrX2lkXSA9
ICpuZXdfY2xvY2s7CisgICAgICAgIElOSVRfTElTVF9IRUFEKCZwb3NpeF9jbG9ja3NbY2xvY2tf
aWRdLmFic190aW1lcl9saXN0KTsKIH0KIAogc3RhdGljIHN0cnVjdCBrX2l0aW1lciAqIGFsbG9j
X3Bvc2l4X3RpbWVyKHZvaWQpCkBAIC04NDMsOCArODQ5LDE1IEBACiAJaWYgKCgodGltci0+aXRf
c2lnZXZfbm90aWZ5ICYgflNJR0VWX1RIUkVBRF9JRCkgIT0gU0lHRVZfTk9ORSkpIHsKIAkJaWYg
KHRpbXItPml0X3RpbWVyLmV4cGlyZXMgPT0gamlmZmllcykKIAkJCXRpbWVyX25vdGlmeV90YXNr
KHRpbXIpOwotCQllbHNlCisJCWVsc2UgewogCQkJYWRkX3RpbWVyKCZ0aW1yLT5pdF90aW1lcik7
CisgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZmxhZ3MgJiBUSU1FUl9BQlNUSU1FKSB7Cisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmY2xvY2stPmFic190aW1l
cl9sb2NrKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgm
KHRpbXItPml0X3RpbWVyLmFic190aW1lcl9lbnRyeSksCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJihjbG9jay0+YWJzX3RpbWVyX2xpc3QpKTsKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJmNsb2NrLT5hYnNfdGltZXJf
bG9jayk7CisgICAgICAgICAgICAgICAgICAgICAgICB9CisgICAgICAgICAgICAgICAgfQogCX0K
IAlyZXR1cm4gMDsKIH0KQEAgLTEwODUsMTYgKzEwOTgsNjEgQEAKIHN5c19jbG9ja19zZXR0aW1l
KGNsb2NraWRfdCB3aGljaF9jbG9jaywgY29uc3Qgc3RydWN0IHRpbWVzcGVjIF9fdXNlciAqdHAp
CiB7CiAJc3RydWN0IHRpbWVzcGVjIG5ld190cDsKKyAgICAgICAgc3RydWN0IHRpbWVzcGVjIGJl
Zm9yZSwgbm93OworICAgICAgICBzdHJ1Y3Qga19jbG9jayAqY2xvY2s7CisgICAgICAgIGxvbmcg
cmV0OworICAgICAgICBzdHJ1Y3QgdGltZXJfbGlzdCAqdGltZXIsICp0bXA7CisgICAgICAgIHN0
cnVjdCB0aW1lc3BlYyBkZWx0YTsKKyAgICAgICAgdTY0IGV4cCA9IDA7CiAKLQlpZiAoKHVuc2ln
bmVkKSB3aGljaF9jbG9jayA+PSBNQVhfQ0xPQ0tTIHx8CisgICAgICAgIGlmICgodW5zaWduZWQp
IHdoaWNoX2Nsb2NrID49IE1BWF9DTE9DS1MgfHwKIAkJCQkJIXBvc2l4X2Nsb2Nrc1t3aGljaF9j
bG9ja10ucmVzKQogCQlyZXR1cm4gLUVJTlZBTDsKLQlpZiAoY29weV9mcm9tX3VzZXIoJm5ld190
cCwgdHAsIHNpemVvZiAoKnRwKSkpCisKKyAgICAgICAgY2xvY2sgPSAmcG9zaXhfY2xvY2tzW3do
aWNoX2Nsb2NrXTsKKworICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoJm5ld190cCwgdHAsIHNp
emVvZiAoKnRwKSkpCiAJCXJldHVybiAtRUZBVUxUOwogCWlmIChwb3NpeF9jbG9ja3Nbd2hpY2hf
Y2xvY2tdLmNsb2NrX3NldCkKIAkJcmV0dXJuIHBvc2l4X2Nsb2Nrc1t3aGljaF9jbG9ja10uY2xv
Y2tfc2V0KCZuZXdfdHApOwogCi0JcmV0dXJuIGRvX3N5c19zZXR0aW1lb2ZkYXkoJm5ld190cCwg
TlVMTCk7CisgICAgICAgIGRvX3Bvc2l4X2dldHRpbWUoY2xvY2ssICZiZWZvcmUpOworICAgICAg
ICAKKwlyZXQgPSBkb19zeXNfc2V0dGltZW9mZGF5KCZuZXdfdHAsIE5VTEwpOworCisgICAgICAg
IC8qCisgICAgICAgICAqIENoZWNrIGlmIHRoZXJlIGV4aXN0IFRJTUVSX0FCU1RJTUUgdGltZXJz
IHRvIHVwZGF0ZS4KKyAgICAgICAgICovCisgICAgICAgIGlmICh3aGljaF9jbG9jayAhPSBDTE9D
S19SRUFMVElNRSB8fAorICAgICAgICAgICAgbGlzdF9lbXB0eSgmY2xvY2stPmFic190aW1lcl9s
aXN0KSkKKyAgICAgICAgICAgICAgICByZXR1cm4gcmV0OworCisgICAgICAgIGRvX3Bvc2l4X2dl
dHRpbWUoY2xvY2ssICZub3cpOworICAgICAgICBkZWx0YS50dl9zZWMgPSBiZWZvcmUudHZfc2Vj
IC0gbm93LnR2X3NlYzsKKyAgICAgICAgZGVsdGEudHZfbnNlYyA9IGJlZm9yZS50dl9uc2VjIC0g
bm93LnR2X25zZWM7CisgICAgICAgIHdoaWxlIChkZWx0YS50dl9uc2VjID49IE5TRUNfUEVSX1NF
QykgeworICAgICAgICAgICAgICAgIGRlbHRhLnR2X3NlYyArKzsKKyAgICAgICAgICAgICAgICBk
ZWx0YS50dl9uc2VjIC09IE5TRUNfUEVSX1NFQzsKKyAgICAgICAgfQorICAgICAgICB3aGlsZSAo
ZGVsdGEudHZfbnNlYyA8IDApIHsKKyAgICAgICAgICAgICAgICBkZWx0YS50dl9zZWMgLS07Cisg
ICAgICAgICAgICAgICAgZGVsdGEudHZfbnNlYyArPSBOU0VDX1BFUl9TRUM7CisgICAgICAgIH0K
KworICAgICAgICB0c3RvamlmZmllKCZkZWx0YSwgY2xvY2stPnJlcywgJmV4cCk7CisKKyAgICAg
ICAgc3Bpbl9sb2NrKCYoY2xvY2stPmFic190aW1lcl9sb2NrKSk7CisgICAgICAgIGxpc3RfZm9y
X2VhY2hfZW50cnlfc2FmZSh0aW1lciwgdG1wLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmNsb2NrLT5hYnNfdGltZXJfbGlzdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGFic190aW1lcl9lbnRyeSkgeworICAgICAgICAgICAgICAgIGlmICh0aW1lciAmJiBk
ZWxfdGltZXIodGltZXIpKSB7IC8vdGhlIHRpbWVyIGhhcyBub3QgcnVuCisgICAgICAgICAgICAg
ICAgICAgICAgICB0aW1lci0+ZXhwaXJlcyArPSBleHA7IAorICAgICAgICAgICAgICAgICAgICAg
ICAgYWRkX3RpbWVyKHRpbWVyKTsKKyAgICAgICAgICAgICAgICB9IGVsc2UKKyAgICAgICAgICAg
ICAgICAgICAgICAgIGxpc3RfZGVsKCZ0aW1lci0+YWJzX3RpbWVyX2VudHJ5KTsKKyAgICAgICAg
fQorICAgICAgICBzcGluX3VubG9jaygmKGNsb2NrLT5hYnNfdGltZXJfbG9jaykpOworICAgICAg
ICByZXR1cm4gcmV0OwogfQogCiBhc21saW5rYWdlIGxvbmcK

------_=_NextPart_001_01C44899.3E76399C--
