Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUCELsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUCELsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:48:30 -0500
Received: from stan.yoobay.net ([62.111.67.220]:26631 "EHLO mail.authmail.net")
	by vger.kernel.org with ESMTP id S262528AbUCELsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:48:20 -0500
Date: Fri, 5 Mar 2004 13:36:08 +0100
From: Daniel Mack <daniel@zonque.org>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: lkml <linux-kernel@vger.kernel.org>, daniel@zonque.org,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.4-rc2: scripts/modpost.c
Message-ID: <20040305123608.GJ5569@zonque.dyndns.org>
References: <20040304172923.6045760e.rddunlap@osdl.org> <20040304212440.30fc8674.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304212440.30fc8674.randy.dunlap@verizon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 09:24:40PM -0800, Randy.Dunlap wrote:
> The comment and code certainly don't match, and your patch makes sense
> to me.  However, I can't reproduce the problem that you describe.
> 
> I built the kernel image and modules in "www.osdl.org/264rc2/build1",
> and all *.mod.c and *.ko ended up there with no problems.

This only occurs if you try to build kernel modules externally like 
described in http://linuxdevices.com/articles/AT4389927951.html.
The DVB driver from CVS does it like this, I'm sure there are many
more cases where this could lead to problems.

> Andrew, I applied the patch and didn't have any problems with
> 'make allyesconfig' like you alluded to.

Hmm, here is a compiler warning when builing modpost since my patch
accesses const char* memory directly (right after malloc()ing it).
The following patch has exactly the same effect but also makes gcc 
happy.


diff -ru linux-2.6.4-rc2.orig/scripts/modpost.c linux-2.6.4-rc2/scripts/modpost.c
--- linux-2.6.4-rc2.orig/scripts/modpost.c      2004-03-04 11:40:21.000000000 +0100
+++ linux-2.6.4-rc2/scripts/modpost.c   2004-03-05 12:10:24.000000000 +0100
@@ -63,17 +63,18 @@
 new_module(char *modname)
 {
        struct module *mod;
-       char *p;
+       int len;
 
        mod = NOFAIL(malloc(sizeof(*mod)));
        memset(mod, 0, sizeof(*mod));
-       mod->name = NOFAIL(strdup(modname));
-
+       len = strlen(modname);
+
        /* strip trailing .o */
-       p = strstr(mod->name, ".o");
-       if (p)
-               *p = 0;
-
+       if (len > 2 && modname[len-2] == '.' && modname[len-1] == 'o')
+               len -= 2;
+
+       mod->name = NOFAIL(strndup(modname, len));
+
        /* add to list */
        mod->next = modules;
        modules = mod;
diff -ru linux-2.6.4-rc2.orig/scripts/modpost.h linux-2.6.4-rc2/scripts/modpost.h
--- linux-2.6.4-rc2.orig/scripts/modpost.h      2004-03-04 11:40:21.000000000 +0100
+++ linux-2.6.4-rc2/scripts/modpost.h   2004-03-05 12:10:51.000000000 +0100
@@ -1,3 +1,5 @@
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>


Daniel
