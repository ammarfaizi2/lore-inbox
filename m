Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUKNBdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUKNBdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUKNBdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:33:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:21218 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261230AbUKNBdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:33:21 -0500
Date: Sun, 14 Nov 2004 02:33:14 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __initdata in dm.c
Message-ID: <20041114013313.GA8518@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c	2004-10-30 21:44:00.000000000 +0200
+++ b/drivers/md/dm.c	2004-11-14 00:46:47.000000000 +0100
@@ -138,23 +138,20 @@ static void local_exit(void)
 	DMINFO("cleaned up");
 }
 
-/*
- * We have a lot of init/exit functions, so it seems easier to
- * store them in an array.  The disposable macro 'xx'
- * expands a prefix into a pair of function names.
- */
-static struct {
-	int (*init) (void);
-	void (*exit) (void);
-
-} _inits[] = {
-#define xx(n) {n ## _init, n ## _exit},
-	xx(local)
-	xx(dm_target)
-	xx(dm_linear)
-	xx(dm_stripe)
-	xx(dm_interface)
-#undef xx
+int (*_inits[])(void) __initdata = {
+	local_init,
+	dm_target_init,
+	dm_linear_init,
+	dm_stripe_init,
+	dm_interface_init,
+};
+
+void (*_exits[])(void) __exitdata = {
+	local_exit,
+	dm_target_exit,
+	dm_linear_exit,
+	dm_stripe_exit,
+	dm_interface_exit,
 };
 
 static int __init dm_init(void)
@@ -164,7 +161,7 @@ static int __init dm_init(void)
 	int r, i;
 
 	for (i = 0; i < count; i++) {
-		r = _inits[i].init();
+		r = _inits[i]();
 		if (r)
 			goto bad;
 	}
@@ -173,17 +170,17 @@ static int __init dm_init(void)
 
       bad:
 	while (i--)
-		_inits[i].exit();
+		_exits[i]();
 
 	return r;
 }
 
 static void __exit dm_exit(void)
 {
-	int i = ARRAY_SIZE(_inits);
+	int i = ARRAY_SIZE(_exits);
 
 	while (i--)
-		_inits[i].exit();
+		_exits[i]();
 }
 
 /*
