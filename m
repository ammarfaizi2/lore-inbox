Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTJKTWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbTJKTWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:22:17 -0400
Received: from fmr09.intel.com ([192.52.57.35]:22967 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263381AbTJKTWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:22:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3902C.F546CFF0"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH][BUGFIX] Bug in timer_tsc cpufreq callback
Date: Sat, 11 Oct 2003 12:22:06 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600778D6@scsmsx403.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][BUGFIX] Bug in timer_tsc cpufreq callback
Thread-Index: AcOQLPRsvyKwqDeSS1yO5OaQDRkzXQ==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2003 19:22:06.0802 (UTC) FILETIME=[F57C2320:01C3902C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3902C.F546CFF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

There is a bug in cpufreq call back funtion in timer_tsc routines,
that can result in system deadlock. The issue is: grabbing the
write_lock on xtime_lock without disabling the interrupts. So,=20
if we happen to get a timer interrupt while we are in this code,
system will go into a deadlock.

This bug only effects the kernels that have CONFIG_CPU_FREQ enabled.
Attached patch fixes it. Please apply.


Thanks,
-Venkatesh


--- linux-2.6.0-test6/arch/i386/kernel/timers/timer_tsc.c.org
2003-10-10 14:01:02.000000000 -0700
+++ linux-2.6.0-test6/arch/i386/kernel/timers/timer_tsc.c
2003-10-10 14:01:24.000000000 -0700
@@ -321,7 +321,7 @@ time_cpufreq_notifier(struct notifier_bl
 {
 	struct cpufreq_freqs *freq =3D data;
=20
-	write_seqlock(&xtime_lock);
+	write_seqlock_irq(&xtime_lock);
 	if (!ref_freq) {
 		ref_freq =3D freq->old;
 		loops_per_jiffy_ref =3D
cpu_data[freq->cpu].loops_per_jiffy;
@@ -342,7 +342,7 @@ time_cpufreq_notifier(struct notifier_bl
 		}
 #endif
 	}
-	write_sequnlock(&xtime_lock);
+	write_sequnlock_irq(&xtime_lock);
=20
 	return 0;
 }

------_=_NextPart_001_01C3902C.F546CFF0
Content-Type: application/octet-stream;
	name="tsc-deadlock.patch"
Content-Transfer-Encoding: base64
Content-Description: tsc-deadlock.patch
Content-Disposition: attachment;
	filename="tsc-deadlock.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3Q2L2FyY2gvaTM4Ni9rZXJuZWwvdGltZXJzL3RpbWVyX3RzYy5j
Lm9yZwkyMDAzLTEwLTEwIDE0OjAxOjAyLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjAt
dGVzdDYvYXJjaC9pMzg2L2tlcm5lbC90aW1lcnMvdGltZXJfdHNjLmMJMjAwMy0xMC0xMCAxNDow
MToyNC4wMDAwMDAwMDAgLTA3MDAKQEAgLTMyMSw3ICszMjEsNyBAQCB0aW1lX2NwdWZyZXFfbm90
aWZpZXIoc3RydWN0IG5vdGlmaWVyX2JsCiB7CiAJc3RydWN0IGNwdWZyZXFfZnJlcXMgKmZyZXEg
PSBkYXRhOwogCi0Jd3JpdGVfc2VxbG9jaygmeHRpbWVfbG9jayk7CisJd3JpdGVfc2VxbG9ja19p
cnEoJnh0aW1lX2xvY2spOwogCWlmICghcmVmX2ZyZXEpIHsKIAkJcmVmX2ZyZXEgPSBmcmVxLT5v
bGQ7CiAJCWxvb3BzX3Blcl9qaWZmeV9yZWYgPSBjcHVfZGF0YVtmcmVxLT5jcHVdLmxvb3BzX3Bl
cl9qaWZmeTsKQEAgLTM0Miw3ICszNDIsNyBAQCB0aW1lX2NwdWZyZXFfbm90aWZpZXIoc3RydWN0
IG5vdGlmaWVyX2JsCiAJCX0KICNlbmRpZgogCX0KLQl3cml0ZV9zZXF1bmxvY2soJnh0aW1lX2xv
Y2spOworCXdyaXRlX3NlcXVubG9ja19pcnEoJnh0aW1lX2xvY2spOwogCiAJcmV0dXJuIDA7CiB9
Cg==

------_=_NextPart_001_01C3902C.F546CFF0--
