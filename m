Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSH0WDL>; Tue, 27 Aug 2002 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSH0WDL>; Tue, 27 Aug 2002 18:03:11 -0400
Received: from ppp-217-133-221-79.dialup.tiscali.it ([217.133.221.79]:24253
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317282AbSH0WDK>; Tue, 27 Aug 2002 18:03:10 -0400
Subject: [PATCH] 2.5.32: is_smp() and can_be_smp()
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-EWTpbCKaG5R3rG9sj+YY"
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 00:07:27 +0200
Message-Id: <1030486047.6203.8.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EWTpbCKaG5R3rG9sj+YY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Will be used by another patch that I'll post in the very near future.
For i386 cpucount is used rather than computing the hweight of
cpu_online_map since it's faster and already there.
Ideally the same should be done for all architectures in both these
macros and num_online_cpus and num_possible_cpus.


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/include/asm-i386/smp.h linux-2.5.32_smp/include/asm-i386/smp.h
--- linux-2.5.32/include/asm-i386/smp.h	2002-08-27 21:26:32.000000000 +0200
+++ linux-2.5.32_smp/include/asm-i386/smp.h	2002-08-27 23:25:09.000000000 +0200
@@ -94,6 +94,10 @@ extern inline unsigned int num_online_cp
 	return hweight32(cpu_online_map);
 }
 
+extern int cpucount;
+#define is_smp() (cpucount)
+#define can_be_smp() (cpucount)
+
 extern inline int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/include/linux/smp.h linux-2.5.32_smp/include/linux/smp.h
--- linux-2.5.32/include/linux/smp.h	2002-08-27 21:26:43.000000000 +0200
+++ linux-2.5.32_smp/include/linux/smp.h	2002-08-27 23:25:47.000000000 +0200
@@ -78,6 +78,19 @@ extern int register_cpu_notifier(struct 
 extern void unregister_cpu_notifier(struct notifier_block *nb);
 
 int cpu_up(unsigned int cpu);
+
+#ifndef is_smp
+#define is_smp() (num_online_cpus() > 1)
+#endif
+
+#ifndef can_be_smp
+#ifdef num_possible_cpus
+#define can_be_smp() (num_possible_cpus() > 1)
+#else
+#define can_be_smp() is_smp()
+#endif
+#endif
+
 #else /* !SMP */
 
 /*
@@ -96,6 +109,8 @@ static inline void smp_send_reschedule_a
 #define cpu_online_map				1
 #define cpu_online(cpu)				({ cpu; 1; })
 #define num_online_cpus()			1
+#define is_smp()				0
+#define can_be_smp()				0
 #define num_booting_cpus()			1
 
 struct notifier_block;


--=-EWTpbCKaG5R3rG9sj+YY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9a/gfdjkty3ft5+cRAioRAKDFhxWIdvwFr6VnIkfcWLNSgzXxxwCfTx/U
J2CVOTemxjhQjhpDJLTMhm0=
=8dMK
-----END PGP SIGNATURE-----

--=-EWTpbCKaG5R3rG9sj+YY--
