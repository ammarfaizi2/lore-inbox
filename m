Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTIHSCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTIHSCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:02:23 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:29446 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263438AbTIHSCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:02:22 -0400
Date: Mon, 8 Sep 2003 19:02:21 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix AGP __setup warning + elsewhere
Message-ID: <20030908180221.GA78834@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19wQLF-000G22-Ih*AF4TmzzzRPk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/char/agp/backend.c:322: warning: `agp_setup' defined but not used

Whilst __setup is allegedly obsolete, this usage at least is going to stay
around, and there are plenty of other places that currently have unnecessary
#ifdefs (any place that's worried about a few bytes of module size bloat can
still keep the ifdefs of course ...)

This just uses the same trick as module_init() to avoid the warning.

regards
john


diff -Naurp -X dontdiff linux-cvs/include/linux/init.h linux-fixes/include/linux/init.h
--- linux-cvs/include/linux/init.h	2003-06-14 16:54:23.000000000 +0100
+++ linux-fixes/include/linux/init.h	2003-09-08 19:01:59.000000000 +0100
@@ -167,7 +167,9 @@ struct obs_kernel_param {
 	{ return exitfn; }					\
 	void cleanup_module(void) __attribute__((alias(#exitfn)));
 
-#define __setup(str,func) /* nothing */
+#define __setup(str,func)                                       \
+	static inline int (*__setup_dummy_##func(void))(char *) \
+	{ return func; }
 #endif
 
 /* Data marked not to be saved by software_suspend() */
