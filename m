Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSE3SLt>; Thu, 30 May 2002 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316793AbSE3SLs>; Thu, 30 May 2002 14:11:48 -0400
Received: from ppp-217-133-209-102.dialup.tiscali.it ([217.133.209.102]:42972
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316792AbSE3SLr>; Thu, 30 May 2002 14:11:47 -0400
Subject: [PATCH] [2.4, 2.5] printk helper functions
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-W9D2QFEChBJYMhdYwfqo"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 20:11:41 +0200
Message-Id: <1022782301.1920.121.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W9D2QFEChBJYMhdYwfqo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch introduces several printk_* functions that wrap printk to
make it easier to use. Specifically, they add the driver name at the
beginning of the string and a newline at the end. The debugging
functions also add file name, line number and function.

Also, since the kernel already contains other sets of function like this
one (like dbg, err, info, warn in linux/usb.h), it seems a good idea to
provide a single one in a central place like kernel.h (since printk is
defined there) and use it everywhere.

Possible naming choices:
1. printkh(KERN_ERR, "
2. printkh(ERR, "
3. printk_err("
4. err("

#2 and #4 pollute the namespace similarly, but #4 is shorter and thus
wins.
#3 is shorter than #1 and both don't pollute the namespace, so #3 wins
over #1.

The choice between #3 and #4 depends on whether it is acceptable to have
functions called "err", "dbg", "crit", and so on. This patch assumes it
isn't.

Note: I've not checked whether this applies cleanly to 2.5

diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/include/linux/kernel.h linux/include/linux/kernel.h
--- linux-base/include/linux/kernel.h	Thu May 30 13:09:51 2002
+++ linux/include/linux/kernel.h	Thu May 30 14:04:34 2002
@@ -208,4 +208,43 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
+/* printk helpers usage
+   To use these functions, add a line like the following to the source file:
+   static char printk_header[] = "USB UHCI: ";
+   
+   Note: don't put any newline in your message
+*/
+
+/* Output of consistent user-oriented messages */
+/* Messages are like this: <driver>: <message> */
+#define printk_hlp(sev, fmt, args...)  printk(sev "%s" fmt "\n", printk_header, ##args)
+
+#define printk_emerg(args...)	printk_hlp(KERN_EMERG,	## args)
+#define printk_alert(args...)	printk_hlp(KERN_ALERT,	## args)
+#define printk_crit(args...)	printk_hlp(KERN_CRIT,	## args)
+#define printk_err(args...)	printk_hlp(KERN_ERR,	## args)
+#define printk_warn(args...)	printk_hlp(KERN_WARNING,## args)
+#define printk_notice(args...)	printk_hlp(KERN_NOTICE,	## args)
+#define printk_info(args...)	printk_hlp(KERN_INFO,	## args)
+#define printk_dbglev(args...)	printk_hlp(KERN_DEBUG,	## args)
+
+/* "printk debugging" for lazy people */
+/* Messages are like this: <driver>: <file>:<line>: <function>: <message> */
+#define printk_hlp_dbg(sev, fmt, args...)  printk(sev "%s%s:%s: %s: " fmt "\n", printk_header, __FILE__, __LINE__, __FUNCTION__ , ##args)
+
+#ifdef DEBUG
+#define printk_dbg(args...) printk_hlp_dbg(KERN_DEBUG, ## args)
+#else
+#define printk_dbg(args...) do {} while(0)
+#endif
+
+#define printk_call()	  printk_dbg ("entering")
+#define printk_ret()	  printk_dbg ("returning")
+#define printk_ret_(val)  printk_dbg ("returning: %d", val)
+#define printk_res(val)   printk_dbg ("result: %d", val)
+#define printk_ok()	  printk_dbg ("successful")
+#define printk_ok_(val)   printk_dbg ("successful: %d", val)
+#define printk_fail()	  printk_dbg ("failed")
+#define printk_fail_(val) printk_dbg ("failed: %d", val)
+
 #endif

--=-W9D2QFEChBJYMhdYwfqo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA89mtddjkty3ft5+cRAqz6AKDCeHcFuerEdlEKJU4AcSMjfaOMjQCguKBv
McQy//Mj2yzv3QOLWB07W1U=
=4Gmd
-----END PGP SIGNATURE-----

--=-W9D2QFEChBJYMhdYwfqo--
