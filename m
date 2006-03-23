Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWCWWEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWCWWEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCWWEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:04:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:61834 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932185AbWCWWEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:04:30 -0500
X-Authenticated: #704063
Subject: [Patch] Fix compilation for sound/oss/vwsnd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Mar 2006 23:04:28 +0100
Message-Id: <1143151469.13816.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this patch fixes compilation for sound/oss/vwsnd.o, by moving
li_destroy() above li_create()

sound/oss/vwsnd.c:275: warning: conflicting types for ‘li_destroy’
sound/oss/vwsnd.c:275: error: static declaration of ‘li_destroy’ follows non-static declaration
sound/oss/vwsnd.c:264: error: previous implicit declaration of ‘li_destroy’ was here

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-git6/sound/oss/vwsnd.c	2006-03-23 22:57:54.000000000 +0100
+++ linux-2.6.16-git6.new/sound/oss/vwsnd.c	2006-03-23 22:58:30.000000000 +0100
@@ -247,6 +247,26 @@ typedef struct lithium {
 } lithium_t;
 
 /*
+ * li_destroy destroys the lithium_t structure and vm mappings.
+ */
+
+static void li_destroy(lithium_t *lith)
+{
+	if (lith->page0) {
+		iounmap(lith->page0);
+		lith->page0 = NULL;
+	}
+	if (lith->page1) {
+		iounmap(lith->page1);
+		lith->page1 = NULL;
+	}
+	if (lith->page2) {
+		iounmap(lith->page2);
+		lith->page2 = NULL;
+	}
+}
+
+/*
  * li_create initializes the lithium_t structure and sets up vm mappings
  * to access the registers.
  * Returns 0 on success, -errno on failure.
@@ -268,26 +288,6 @@ static int __init li_create(lithium_t *l
 }
 
 /*
- * li_destroy destroys the lithium_t structure and vm mappings.
- */
-
-static void li_destroy(lithium_t *lith)
-{
-	if (lith->page0) {
-		iounmap(lith->page0);
-		lith->page0 = NULL;
-	}
-	if (lith->page1) {
-		iounmap(lith->page1);
-		lith->page1 = NULL;
-	}
-	if (lith->page2) {
-		iounmap(lith->page2);
-		lith->page2 = NULL;
-	}
-}
-
-/*
  * basic register accessors - read/write long/byte
  */
 


