Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbQKUMxg>; Tue, 21 Nov 2000 07:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbQKUMx0>; Tue, 21 Nov 2000 07:53:26 -0500
Received: from mail.sonytel.be ([193.74.243.200]:28134 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S129825AbQKUMxO>;
	Tue, 21 Nov 2000 07:53:14 -0500
Date: Tue, 21 Nov 2000 13:23:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] highuid.h macro expansion
Message-ID: <Pine.GSO.4.10.10011211322250.14139-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

This patch (from Andreas Schwab <schwab@suse.de>) makes macro expansion in
<linux/highuid.h> safer.

diff -urN linux-2.4.0-test11/include/linux/highuid.h geert-2.4.0-test11/include/linux/highuid.h
--- linux-2.4.0-test11/include/linux/highuid.h	Sun Nov 19 05:56:59 2000
+++ geert-2.4.0-test11/include/linux/highuid.h	Tue Nov 21 13:20:57 2000
@@ -41,14 +41,14 @@
 #ifdef CONFIG_UID16
 
 /* prevent uid mod 65536 effect by returning a default value for high UIDs */
-#define high2lowuid(uid) ((uid) > 65535) ? (old_uid_t)overflowuid : (old_uid_t)(uid)
-#define high2lowgid(gid) ((gid) > 65535) ? (old_gid_t)overflowgid : (old_gid_t)(gid)
+#define high2lowuid(uid) ((uid) > 65535 ? (old_uid_t)overflowuid : (old_uid_t)(uid))
+#define high2lowgid(gid) ((gid) > 65535 ? (old_gid_t)overflowgid : (old_gid_t)(gid))
 /*
  * -1 is different in 16 bits than it is in 32 bits
  * these macros are used by chown(), setreuid(), ...,
  */
-#define low2highuid(uid) ((uid) == (old_uid_t)-1) ? (uid_t)-1 : (uid_t)(uid)
-#define low2highgid(gid) ((gid) == (old_gid_t)-1) ? (gid_t)-1 : (gid_t)(gid)
+#define low2highuid(uid) ((uid) == (old_uid_t)-1 ? (uid_t)-1 : (uid_t)(uid))
+#define low2highgid(gid) ((gid) == (old_gid_t)-1 ? (gid_t)-1 : (gid_t)(gid))
 
 /* Avoid extra ifdefs with these macros */
 
@@ -67,13 +67,13 @@
 
 #define SET_UID16(var, uid)	do { ; } while (0)
 #define SET_GID16(var, gid)	do { ; } while (0)
-#define NEW_TO_OLD_UID(uid)	uid
-#define NEW_TO_OLD_GID(gid)	gid
+#define NEW_TO_OLD_UID(uid)	(uid)
+#define NEW_TO_OLD_GID(gid)	(gid)
 
-#define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = uid
-#define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = gid
-#define SET_STAT_UID(stat, uid)		(stat).st_uid = uid
-#define SET_STAT_GID(stat, gid)		(stat).st_gid = gid
+#define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = (uid)
+#define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = (gid)
+#define SET_STAT_UID(stat, uid)		(stat).st_uid = (uid)
+#define SET_STAT_GID(stat, gid)		(stat).st_gid = (gid)
 
 #endif /* CONFIG_UID16 */
 
@@ -97,10 +97,10 @@
  * Since these macros are used in architectures that only need limited
  * 16-bit UID back compatibility, we won't use old_uid_t and old_gid_t
  */
-#define fs_high2lowuid(uid) (uid > 65535) ? (uid16_t)fs_overflowuid : (uid16_t)uid
-#define fs_high2lowgid(gid) (gid > 65535) ? (gid16_t)fs_overflowgid : (gid16_t)gid
+#define fs_high2lowuid(uid) ((uid) > 65535 ? (uid16_t)fs_overflowuid : (uid16_t)(uid))
+#define fs_high2lowgid(gid) ((gid) > 65535 ? (gid16_t)fs_overflowgid : (gid16_t)(gid))
 
-#define low_16_bits(x)	x & 0xFFFF
-#define high_16_bits(x)	(x & 0xFFFF0000) >> 16
+#define low_16_bits(x)	((x) & 0xFFFF)
+#define high_16_bits(x)	(((x) & 0xFFFF0000) >> 16)
 
 #endif /* _LINUX_HIGHUID_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
