Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTBULOk>; Fri, 21 Feb 2003 06:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTBULOk>; Fri, 21 Feb 2003 06:14:40 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:19105 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267292AbTBULOh>; Fri, 21 Feb 2003 06:14:37 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c with flush_tlb_all()
Date: Fri, 21 Feb 2003 12:24:32 +0100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de> <200302202131.08663.schlicht@uni-mannheim.de> <20030220205017.GA29206@codemonkey.org.uk>
In-Reply-To: <20030220205017.GA29206@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_3xgV+3o9GhBXFEb";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302211224.39021.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_3xgV+3o9GhBXFEb
Content-Type: multipart/mixed;
  boundary="Boundary-01=_wxgV+qv8bdQ5VJG"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_wxgV+qv8bdQ5VJG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

On Thu, Feb 20, 2003 21:50, Dave Jones wrote:
> Its hinting at a possible optimisation, not saying
> that it is unneeded.

OK, sorry, than I just misunderstood the comment...

So here is a minimal change patch that should solve the preempt issue in=20
flush_map().

Instead of just doing a preempt_disable() before and a preempt_enable() aft=
er=20
the flush_kernel_map() calls I just changed the order so that the preempt=20
point is not between them...

  Thomas
--Boundary-01=_wxgV+qv8bdQ5VJG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="flush_map_preempt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="flush_map_preempt.patch"

=2D-- linux-2.5.62/arch/i386/mm/pageattr.c.orig	Fri Feb 21 11:47:19 2003
+++ linux-2.5.62/arch/i386/mm/pageattr.c	Fri Feb 21 12:12:15 2003
@@ -131,10 +131,10 @@
=20
 static inline void flush_map(void)
 {=09
+	flush_kernel_map(NULL);
 #ifdef CONFIG_SMP=20
 	smp_call_function(flush_kernel_map, NULL, 1, 1);
 #endif=09
=2D	flush_kernel_map(NULL);
 }
=20
 struct deferred_page {=20
=2D-- linux-2.5.62/arch/x86_64/mm/pageattr.c.orig	Fri Feb 21 12:14:25 2003
+++ linux-2.5.62/arch/x86_64/mm/pageattr.c	Fri Feb 21 12:14:30 2003
@@ -123,10 +123,10 @@
=20
 static inline void flush_map(unsigned long address)
 {=09
+	flush_kernel_map((void *)address);
 #ifdef CONFIG_SMP=20
 	smp_call_function(flush_kernel_map, (void *)address, 1, 1);
 #endif=09
=2D	flush_kernel_map((void *)address);
 }
=20
 struct deferred_page {=20

--Boundary-01=_wxgV+qv8bdQ5VJG--

--Boundary-03=_3xgV+3o9GhBXFEb
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Vgx2YAiN+WRIZzQRAqPXAJ9MNXRWuhfonb809ePI30IR0vQKcQCeKyYs
q9XbHajVAvN27X45I67WFWA=
=W4ZY
-----END PGP SIGNATURE-----

--Boundary-03=_3xgV+3o9GhBXFEb--

