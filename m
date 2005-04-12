Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVDMESH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVDMESH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVDLTEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:04:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:54729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262217AbVDLKcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:39 -0400
Message-Id: <200504121032.j3CAWY66005629@shell0.pdx.osdl.net>
Subject: [patch 123/198] uml: fix compilation for __CHOOSE_MODE addition
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, blaisorblade@yahoo.it
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I had added the __CHOOSE_MODE syntax to fix some warnings with newer GCC's
in the uml-fix-cond-expr-as-lvalues-warning patch.

Here is the update from the version I sent to make it work also when only
one mode (TT or SKAS) is enabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/um/include/choose-mode.h |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff -puN arch/um/include/choose-mode.h~uml-fix-compilation-for-__choose_mode-addition arch/um/include/choose-mode.h
--- 25/arch/um/include/choose-mode.h~uml-fix-compilation-for-__choose_mode-addition	2005-04-12 03:21:33.190091240 -0700
+++ 25-akpm/arch/um/include/choose-mode.h	2005-04-12 03:21:33.193090784 -0700
@@ -11,6 +11,13 @@
 #if defined(UML_CONFIG_MODE_TT) && defined(UML_CONFIG_MODE_SKAS)
 #define CHOOSE_MODE(tt, skas) (mode_tt ? (tt) : (skas))
 
+extern int mode_tt;
+static inline void *__choose_mode(void *tt, void *skas) {
+	return mode_tt ? tt : skas;
+}
+
+#define __CHOOSE_MODE(tt, skas) (*( (typeof(tt) *) __choose_mode(&(tt), &(skas))))
+
 #elif defined(UML_CONFIG_MODE_SKAS)
 #define CHOOSE_MODE(tt, skas) (skas)
 
@@ -21,22 +28,8 @@
 #define CHOOSE_MODE_PROC(tt, skas, args...) \
 	CHOOSE_MODE(tt(args), skas(args))
 
-extern int mode_tt;
-static inline void *__choose_mode(void *tt, void *skas) {
-	return mode_tt ? tt : skas;
-}
-
-#define __CHOOSE_MODE(tt, skas) (*( (typeof(tt) *) __choose_mode(&(tt), &(skas))))
-
+#ifndef __CHOOSE_MODE
+#define __CHOOSE_MODE(tt, skas) CHOOSE_MODE(tt, skas)
 #endif
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif
_
