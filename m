Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292291AbSCME2y>; Tue, 12 Mar 2002 23:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSCME2o>; Tue, 12 Mar 2002 23:28:44 -0500
Received: from [202.135.142.196] ([202.135.142.196]:64774 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S292291AbSCME2a>; Tue, 12 Mar 2002 23:28:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: (FORWARD) =?ISO-8859-1?Q?Ren=E9?= Scharfe: [PATCH] MSDOS filesystem option mistreatment
Date: Wed, 13 Mar 2002 15:31:14 +1100
Message-Id: <E16l0Py-0005nk-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems correct.  Al?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

------- Forwarded Message

Date: Tue, 12 Mar 2002 23:07:58 +0100
From: René Scharfe <l.s.r@web.de>
To: trivial@rustcorp.com.au
Subject: [PATCH] MSDOS filesystem option mistreatment
Message-Id: <20020312230758.243bb4cf.l.s.r@web.de>

Hello,

this fixes a longstanding buglet in kernels 2.4 and 2.5, where
the MSDOS filesystem would ignore its 'check' mount option.

René


diff -ur linux-2.5.6/fs/msdos/namei.c linux-2.5.6-fat/fs/msdos/namei.c
--- linux-2.5.6/fs/msdos/namei.c	Wed Feb 20 19:49:06 2002
+++ linux-2.5.6-fat/fs/msdos/namei.c	Tue Mar 12 22:50:58 2002
@@ -42,9 +42,10 @@
 /***** Formats an MS-DOS file name. Rejects invalid names. */
 static int msdos_format_name(const char *name,int len,
 	char *res,struct fat_mount_options *opts)
-	/* conv is relaxed/normal/strict, name is proposed name,
-	 * len is the length of the proposed name, res is the result name,
-	 * dotsOK is if hidden files get dots.
+	/* name is the proposed name, len is its length, res is
+	 * the resulting name, opts->name_check is either (r)elaxed,
+	 * (n)ormal or (s)trict, opts->dotsOK allows dots at the
+	 * beginning of name (for hidden files)
 	 */
 {
 	char *walk;
@@ -66,11 +67,11 @@
 	for (walk = res; len && walk-res < 8; walk++) {
 	    	c = *name++;
 		len--;
-		if (opts->conversion != 'r' && strchr(bad_chars,c))
+		if (opts->name_check != 'r' && strchr(bad_chars,c))
 			return -EINVAL;
-		if (opts->conversion == 's' && strchr(bad_if_strict(opts),c))
+		if (opts->name_check == 's' && strchr(bad_if_strict(opts),c))
 			return -EINVAL;
-  		if (c >= 'A' && c <= 'Z' && opts->conversion == 's')
+  		if (c >= 'A' && c <= 'Z' && opts->name_check == 's')
 			return -EINVAL;
 		if (c < ' ' || c == ':' || c == '\\') return -EINVAL;
 /*  0xE5 is legal as a first character, but we must substitute 0x05     */
@@ -83,7 +84,7 @@
 		*walk = (!opts->nocase && c >= 'a' && c <= 'z') ? c-32 : c;
 	}
 	if (space) return -EINVAL;
-	if (opts->conversion == 's' && len && c != '.') {
+	if (opts->name_check == 's' && len && c != '.') {
 		c = *name++;
 		len--;
 		if (c != '.') return -EINVAL;
@@ -94,25 +95,25 @@
 		while (len > 0 && walk-res < MSDOS_NAME) {
 			c = *name++;
 			len--;
-			if (opts->conversion != 'r' && strchr(bad_chars,c))
+			if (opts->name_check != 'r' && strchr(bad_chars,c))
 				return -EINVAL;
-			if (opts->conversion == 's' &&
+			if (opts->name_check == 's' &&
 			    strchr(bad_if_strict(opts),c))
 				return -EINVAL;
 			if (c < ' ' || c == ':' || c == '\\')
 				return -EINVAL;
 			if (c == '.') {
-				if (opts->conversion == 's')
+				if (opts->name_check == 's')
 					return -EINVAL;
 				break;
 			}
-			if (c >= 'A' && c <= 'Z' && opts->conversion == 's')
+			if (c >= 'A' && c <= 'Z' && opts->name_check == 's')
 				return -EINVAL;
 			space = c == ' ';
 			*walk++ = (!opts->nocase && c >= 'a' && c <= 'z') ? c-32 : c;
 		}
 		if (space) return -EINVAL;
-		if (opts->conversion == 's' && len) return -EINVAL;
+		if (opts->name_check == 's' && len) return -EINVAL;
 	}
 	while (walk-res < MSDOS_NAME) *walk++ = ' ';
 	if (!opts->atari)


------- End of Forwarded Message

