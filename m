Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318693AbSHQNIC>; Sat, 17 Aug 2002 09:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318704AbSHQNIC>; Sat, 17 Aug 2002 09:08:02 -0400
Received: from ppp-217-133-219-65.dialup.tiscali.it ([217.133.219.65]:61846
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318693AbSHQNIB>; Sat, 17 Aug 2002 09:08:01 -0400
Subject: [PATCH] [2.5] is_smp() and can_be_smp()
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-uac3hR3eVZ1kVEr1N8SI"
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Aug 2002 15:11:58 +0200
Message-Id: <1029589918.1996.28.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uac3hR3eVZ1kVEr1N8SI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Will be used by another patch that I'll post in the near future.
For i386 cpucount is used rather than computing the hweight of
cpu_online_map since it's faster and already there.
Ideally the same should be done for all architectures in both these
macros and num_online_cpus and num_possible_cpus.


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	2002-08-13 19:36:13.000000000 +0200
+++ b/include/asm-i386/smp.h	2002-08-17 14:45:50.000000000 +0200
@@ -95,6 +95,10 @@ extern inline unsigned int num_online_cp
 	return hweight32(cpu_online_map);
 }
 
+extern int cpucount;
+#define is_smp() (cpucount)
+#define can_be_smp() (cpucount)
+
 extern inline int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp a/include/linux/smp.h b/include/linux/smp.h
--- a/include/linux/smp.h	2002-08-13 19:58:12.000000000 +0200
+++ b/include/linux/smp.h	2002-08-16 04:57:31.000000000 +0200
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
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var


--=-uac3hR3eVZ1kVEr1N8SI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9Xkuddjkty3ft5+cRAg5mAKC3BHYjbl21OBw3OwiYqyPxYVSfFgCfdyOo
gjrKT21OeJ6xBpIhc3q3zJ4=
=rNlJ
-----END PGP SIGNATURE-----

--=-uac3hR3eVZ1kVEr1N8SI--
