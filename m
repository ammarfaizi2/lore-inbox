Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVDAURh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVDAURh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVDAUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:16:06 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:28380 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262874AbVDAUJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:09:00 -0500
Subject: [patch 1/1] uml: fix compilation for __CHOOSE_MODE addition
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 01 Apr 2005 22:05:46 +0200
Message-Id: <20050401200547.ED17CA8A2@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I had added the __CHOOSE_MODE syntax to fix some warnings with newer GCC's in
the uml-fix-cond-expr-as-lvalues-warning patch.

Here is the update from the version I sent to make it work also when only one
mode (TT or SKAS) is enabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/choose-mode.h |   27 ++++++++---------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff -puN arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues-rediffed arch/um/include/choose-mode.h
--- linux-2.6.11/arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues-rediffed	2005-04-01 21:48:45.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/choose-mode.h	2005-04-01 21:50:16.000000000 +0200
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
