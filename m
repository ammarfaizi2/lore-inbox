Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVKGPUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVKGPUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVKGPUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:20:55 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:10705 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S964823AbVKGPUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:20:54 -0500
Date: Mon, 7 Nov 2005 17:20:53 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Shut up per_cpu_ptr() on UP
Message-ID: <20051107152053.GB29899@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently per_cpu_ptr() doesn't really do anything with 'cpu' in the UP
case. This is problematic in the cases where this is the only place the
variable is referenced:

  CC      kernel/workqueue.o
  kernel/workqueue.c: In function `current_is_keventd':
  kernel/workqueue.c:460: warning: unused variable `cpu'

How about something like this?

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 5451eb1..fb8d2d2 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -38,7 +38,7 @@ extern void free_percpu(const void *);
=20
 #else /* CONFIG_SMP */
=20
-#define per_cpu_ptr(ptr, cpu) (ptr)
+#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
=20
 static inline void *__alloc_percpu(size_t size, size_t align)
 {

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDb3DV1K+teJFxZ9wRAqYyAJ96aQ4mknpXjjumGNE6tR3wAAArZgCggpsS
gVb6mY84Qptj4jAQuLn90KI=
=xnw5
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
