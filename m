Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268710AbTBZKmu>; Wed, 26 Feb 2003 05:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268711AbTBZKmu>; Wed, 26 Feb 2003 05:42:50 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:7553 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S268710AbTBZKmr>; Wed, 26 Feb 2003 05:42:47 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Date: Wed, 26 Feb 2003 11:52:45 +0100
User-Agent: KMail/1.5
Cc: torvalds@transmeta.com, hugh@veritas.com, linux-kernel@vger.kernel.org
References: <200302251908.55097.schlicht@uni-mannheim.de> <20030226111905.GA32415@suse.de> <20030226022819.44e1873a.akpm@digeo.com>
In-Reply-To: <20030226022819.44e1873a.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_DyJX+1xlWmxP1wo";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302261152.51479.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_DyJX+1xlWmxP1wo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Dave Jones <davej@codemonkey.org.uk> wrote:
> btw, (unrelated) shouldn't smp_call_function be doing magick checks
> with cpu_online() ?

Andrew Morton wrote:
> Looks OK?  It sprays the IPI out to all the other CPUs in cpu_online_map,
> and waits for num_online_cpus()-1 CPUs to answer.
>
> All very racy in the presence of CPUs going offline, but that's all over
> the place.  Depends how the offlining will be done I guess.

Well, now I see the check for num_online_cpus() !=3D 1 in smp_call_function=
(),=20
too, so the check in on_each_cpu() is not needed and possibly better this=20
patch should apply to the include/linux/smp.h file...

  Thomas

=2D-- linux-2.5.63/include/linux/smp.h.orig       Mon Feb 24 20:05:33 2003
+++ linux-2.5.63/include/linux/smp.h    Wed Feb 26 11:41:45 2003
@@ -10,9 +10,10 @@

 #ifdef CONFIG_SMP

+#include <linux/preempt.h>
 #include <linux/kernel.h>
 #include <linux/compiler.h>
=2D#include <linux/threads.h>
+#include <linux/thread_info.h>
 #include <asm/smp.h>
 #include <asm/bug.h>

@@ -54,6 +55,24 @@
                              int retry, int wait);

 /*
+ * Call a function on all processors
+ */
+static inline int on_each_cpu(void (*func) (void *info), void *info,
+                             int retry, int wait)
+{
+       int ret;
+
+       preempt_disable();
+
+       ret =3D smp_call_function(func, info, retry, wait);
+       func(info);
+
+       preempt_enable();
+
+       return ret;
+}
+
+/*
  * True once the per process idle is forked
  */
 extern int smp_threads_ready;
@@ -96,6 +115,7 @@
 #define hard_smp_processor_id()                        0
 #define smp_threads_ready                      1
 #define smp_call_function(func,info,retry,wait)        ({ 0; })
+#define on_each_cpu(func,info,retry,wait)      ({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map                         1

--Boundary-02=_DyJX+1xlWmxP1wo
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+XJyDYAiN+WRIZzQRAvasAJ9q/oCm7lSxL1IsoZs51yb0ag0trACgn/gQ
x17Jq8JVAeK3RDClpXmNlVs=
=8t1Q
-----END PGP SIGNATURE-----

--Boundary-02=_DyJX+1xlWmxP1wo--

