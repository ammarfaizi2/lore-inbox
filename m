Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTBUMcX>; Fri, 21 Feb 2003 07:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTBUMcX>; Fri, 21 Feb 2003 07:32:23 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:61890 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267436AbTBUMcV>; Fri, 21 Feb 2003 07:32:21 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w ith flush_tlb_all()
Date: Fri, 21 Feb 2003 13:42:12 +0100
User-Agent: KMail/1.5
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302211217390.1531-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0302211217390.1531-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_q6hV+1KViJ/Xbs7";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302211342.19007.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_q6hV+1KViJ/Xbs7
Content-Type: multipart/mixed;
  boundary="Boundary-01=_k6hV+bZUc4vlwog"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_k6hV+bZUc4vlwog
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: body text
Content-Disposition: inline

On Fri, 21 Feb 2003, Hugh Dickins wrote:
> No.  All that does is make sure that the cpu you start out on is
> flushed, once or twice, and the cpu you end up on may be missed.
> Use preempt_disable and preempt_enable.

Oh, you are right! I think I am totally stupid this morning...!
Now finally I hope this is the correct patch...

  Thomas Schlichter
--Boundary-01=_k6hV+bZUc4vlwog
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="flush_map_preempt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="flush_map_preempt.patch"

=2D-- linux-2.5.62/arch/i386/mm/pageattr.c.orig	Fri Feb 21 13:27:59 2003
+++ linux-2.5.62/arch/i386/mm/pageattr.c	Fri Feb 21 13:32:39 2003
@@ -131,10 +131,14 @@
=20
 static inline void flush_map(void)
 {=09
=2D#ifdef CONFIG_SMP=20
+#ifdef CONFIG_SMP
+	preempt_disable();
 	smp_call_function(flush_kernel_map, NULL, 1, 1);
=2D#endif=09
 	flush_kernel_map(NULL);
+	preempt_enable();
+#else
+	flush_kernel_map(NULL);
+#endif
 }
=20
 struct deferred_page {=20
=2D-- linux-2.5.62/arch/x86_64/mm/pageattr.c.orig	Fri Feb 21 13:33:38 2003
+++ linux-2.5.62/arch/x86_64/mm/pageattr.c	Fri Feb 21 13:34:40 2003
@@ -123,10 +123,14 @@
=20
 static inline void flush_map(unsigned long address)
 {=09
=2D#ifdef CONFIG_SMP=20
+#ifdef CONFIG_SMP
+	preempt_disable();
 	smp_call_function(flush_kernel_map, (void *)address, 1, 1);
=2D#endif=09
 	flush_kernel_map((void *)address);
+	preempt_enable();
+#else
+	flush_kernel_map((void *)address);
+#endif
 }
=20
 struct deferred_page {=20

--Boundary-01=_k6hV+bZUc4vlwog--

--Boundary-03=_q6hV+1KViJ/Xbs7
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Vh6qYAiN+WRIZzQRAr3tAJ0VAT0rpgLQ6pRK0gfhA9rYfVCfuQCfTo9+
esno/Sqz1nFTu6jYSlGdRko=
=/bb/
-----END PGP SIGNATURE-----

--Boundary-03=_q6hV+1KViJ/Xbs7--

