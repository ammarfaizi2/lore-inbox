Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUCEWxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUCEWxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:53:43 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:59497 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261401AbUCEWxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:53:41 -0500
Date: Fri, 5 Mar 2004 23:56:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Daniel Mack <daniel@zonque.org>
Subject: [PATCH] kbuild: fix usage with directories containing '.o'
Message-ID: <20040305225610.GA6644@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Mack <daniel@zonque.org>, me

modpost unconditionally searched for ".o" assuming this is always
the suffix of the module. This fails in two cases:
a) when building external modules where any
   directory include ".o" in the name.
   One example is a directory named: .../cvs.alsa.org/...
b) when someone names a kernel directory so it contains ".o".
   One example is drivers/scsi/aic.ok/...

case b) was triggered by renaming the directory for aic7xxx, and
modifying Makefile and Kconfig. This caused make modules to fail.

	Sam

kbuild-fix-modpost.patch:
===== scripts/modpost.c 1.19 vs edited =====
--- 1.19/scripts/modpost.c	Fri Feb 27 06:33:07 2004
+++ edited/scripts/modpost.c	Fri Mar  5 23:42:26 2004
@@ -64,17 +64,20 @@
 {
 	struct module *mod;
 	char *p;
+	size_t len;
 	
 	mod = NOFAIL(malloc(sizeof(*mod)));
 	memset(mod, 0, sizeof(*mod));
-	mod->name = NOFAIL(strdup(modname));
+	p = NOFAIL(strdup(modname));
 
-	/* strip trailing .o */
-	p = strstr(mod->name, ".o");
-	if (p)
-		*p = 0;
+	len = strlen(p);
 
+	/* strip trailing .o */
+	if (len > 2 && p[len-2] == '.' && p[len-1] == 'o')
+		p[len -2] = '\0';
+	
 	/* add to list */
+	mod->name = NOFAIL(strdup(p));	
 	mod->next = modules;
 	modules = mod;
 
