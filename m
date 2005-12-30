Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVL3OIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVL3OIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 09:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVL3OIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 09:08:52 -0500
Received: from mail.gmx.net ([213.165.64.21]:6102 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932099AbVL3OIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 09:08:51 -0500
X-Authenticated: #2308221
Date: Fri, 30 Dec 2005 15:08:42 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230140842.GA11169@hermes.uziel.local>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org> <20051229153529.GH3811@stusta.de> <20051229154241.GY22293@devserv.devel.redhat.com> <p73oe2zexx9.fsf@verdi.suse.de> <20051230094045.GA5799@elte.hu> <20051230101443.GA13072@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20051230101443.GA13072@elte.hu>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Fri, Dec 30, 2005 at 11:14:43AM +0100, Ingo Molnar wrote:
>=20
> * Ingo Molnar <mingo@elte.hu> wrote:
>=20
> [...] The queue is at:
>=20
>   http://redhat.com/~mingo/debloating-patches/
>=20

I was curious and applied among others the uninline-capable patch, with
the result that modules complain about an unknown symbol "capable". The
attached patch is a manually adapted version of yours, extended by the
EXPORT_SYMBOL_GPL required for modules to load again.

The code with the EXPORT_SYMBOL_GPL line works (I am currently running
that kernel) and the patch should apply cleanly.

Regards,
Chris


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename="uninline-and-export-capable.patch"
Content-Transfer-Encoding: quoted-printable

Subject: uninline capable()

uninline capable(). Saves 2K of kernel text on a generic .config, and 1K
on a tiny config.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/sched.h |   15 ++-------------
 kernel/sys.c          |   11 +++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-gcc.q/include/linux/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-gcc.q.orig/include/linux/sched.h
+++ linux-gcc.q/include/linux/sched.h
@@ -1102,19 +1102,8 @@ static inline int sas_ss_flags(unsigned=20
 }
=20
=20
-#ifdef CONFIG_SECURITY
-/* code is in security.c */
-extern int capable(int cap);
-#else
-static inline int capable(int cap)
-{
-	if (cap_raised(current->cap_effective, cap)) {
-		current->flags |=3D PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
-#endif
+/* code is in security.c or kernel/sys.c if !SECURITY */
+extern int FASTCALL(capable(int cap));
=20
 /*
  * Routines for handling mm_structs
Index: linux-gcc.q/kernel/sys.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-gcc.q.orig/kernel/sys.c
+++ linux-gcc.q/kernel/sys.c
@@ -222,6 +222,18 @@ int unregister_reboot_notifier(struct no
=20
 EXPORT_SYMBOL(unregister_reboot_notifier);
=20
+#ifndef CONFIG_SECURITY
+int fastcall capable(int cap)
+{
+        if (cap_raised(current->cap_effective, cap)) {
+	       current->flags |=3D PF_SUPERPRIV;
+	       return 1;
+        }
+        return 0;
+}
+EXPORT_SYMBOL_GPL(capable);
+#endif
+
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
 	int no_nice;

--uAKRQypu60I7Lcqm--

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ7U/aF2m8MprmeOlAQJUzw//e5hs7zaAFHZyKV7FBJHvjG+vqxqUZ+vC
GqN3FhepU0nWnpvMxvaUsIaWN4MbjPRPQqG+avdXZm/qXrm5/7Hq5KlzZ+hzO9b0
HQ3um7dQwuBZOTgfzUwSW4nFthGZa0DoDSshqUglb5qVztyE9Ni/0XytVfXRShqJ
mmmMlMnxqmr9iVZFgsr4p8fRyxc6qDNDpQjUFebMCj3Hd2uqr7qqAu6FKikRhhOv
kjoWuQrxsespyWT2aHcVm0sCkIuLc+lBwWeQnBu5gV+B4JNOFef2i8L6r5touYC9
rKd2fj/jZfu6FlER9fdk8zmdKGPYaxSrZcwKd3uvgFPa5hsKzlXnToeKjThcWlh+
8ulh0+3EJ+t1Yfstq48q6KTCQjd+wCWXcGyngs8eaSpQO9Vd1u4Xrv0Rh2ebc+5N
iiRaqY+xCvjLyCQKdfIN9kC7uZPgwjApG28N+/LGNJ0SUJsF2NBtWU/FUWiHX8V4
XJ3F349yMy9PWIRCZBMS6nPbyh9Vnso47gvRW3y9TnNILIJ6cG3fL1EtjqALG88F
crpgo0AQP+aGlOEZSfLBXxnxGrlMM/lrStpymvPghF0fYXzilx1Hir8kLBkHlucc
EtWJBg+b1qWs9qLivmLVSg8/t5TGWczz/Q1tqNj7f3nzmZd2J3kWkq88zWHTZZby
O7WEcggQf4M=
=aRXg
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--

