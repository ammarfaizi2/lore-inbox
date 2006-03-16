Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbWCPUOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWCPUOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWCPUOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:14:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:50120 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932718AbWCPUOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:14:45 -0500
X-Authenticated: #427522
Message-ID: <4419C88A.1060000@gmx.de>
Date: Thu, 16 Mar 2006 21:20:26 +0100
From: Mathis Ahrens <Mathis.Ahrens@gmx.de>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Makefile: localversion fix (was: [2.6.16-rc6] CONFIG_LOCALVERSION_AUTO)
References: <44179C77.1010902@gmx.de>
In-Reply-To: <44179C77.1010902@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathis Ahrens wrote:
> 1.
> Semantics of LOCALVERSION are confusing and probably buggy.
> The Makefile states:
>
> # Take the contents of any files called localversion* and the config
> # variable CONFIG_LOCALVERSION and append them to KERNELRELEASE.
> # LOCALVERSION from the command line override all of this
>
> whereas my simplified view of current code is:
>
> version = major + minor + patch + extra
> release = version + localver-full
> localver-full = localver + localver-auto
> localver = <concat all localversions*> + $CONFIG_LOCALVERSION
> localver-auto = $LOCALVERSION + <some -gxxxxxx>
>
> LOCALVERSION does not seem to /override/ anything if specified on the
> command line, but rather (with CONFIG_LOCALVERSION_AUTO=y) gets
> /inserted/.
>
> Also, with CONFIG_LOCALVERSION_AUTO=n, specifying LOCALVERSION
> on the command line currently does nothing at all. This is a regression
> from 2.6.15, I suppose.
>   

Hmm, no comments on this?
I am not sure if different behaviour is desired, but here goes my proposal:

From: Mathis Ahrens <Mathis.Ahrens@gmx.de>

Fix Makefile to honor LOCALVERSION if specified on the command line.
Make it then replace any other localversions from files, CONFIG_LOCALVERSION
or CONFIG_LOCALVERSION_AUTO.

Signed-off-by: Mathis Ahrens <Mathis.Ahrens@gmx.de>

--- linux/Makefile.orig    2006-03-15 01:49:26.000000000 +0100
+++ linux/Makefile    2006-03-16 18:10:38.000000000 +0100
@@ -760,22 +760,27 @@ $(vmlinux-dirs): prepare scripts
 # The KERNELRELEASE is stored in a file named .kernelrelease
 # to be used when executing for example make install or make
modules_install
 #
-# Take the contents of any files called localversion* and the config
-# variable CONFIG_LOCALVERSION and append them to KERNELRELEASE.
-# LOCALVERSION from the command line override all of this
+# If LOCALVERSION from the command line is not empty, that is
+# appended to the KERNELRELEASE.
+#
+# Else we append in that order
+#     - the contents of any files called localversion*
+#     - the config variable CONFIG_LOCALVERSION
+#     - if CONFIG_LOCALVERSION_AUTO is set, another scm-specific string
 
 nullstring :=
 space      := $(nullstring) # end of line
 
-___localver = $(objtree)/localversion* $(srctree)/localversion*
-__localver  = $(sort $(wildcard $(___localver)))
+__localver-filelist = $(objtree)/localversion* $(srctree)/localversion*
+_localver-filelist  = $(sort $(wildcard $(__localver-filelist)))
 # skip backup files (containing '~')
-_localver = $(foreach f, $(__localver), $(if $(findstring ~, $(f)),,$(f)))
+localver-filelist = $(foreach f, $(_localver-filelist), \
+                    $(if $(findstring ~, $(f)),,$(f)))
+
+localver-files = $(subst $(space),, $(shell cat /dev/null
$(localver-filelist)))
+localver-conf = $(subst $(space),, $(patsubst
"%",%,$(CONFIG_LOCALVERSION)))
+
 
-localver = $(subst $(space),, \
-       $(shell cat /dev/null $(_localver)) \
-       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
-          
 # If CONFIG_LOCALVERSION_AUTO is set scripts/setlocalversion is called
 # and if the SCM is know a tag from the SCM is appended.
 # The appended tag is determinded by the SCM used.
@@ -784,12 +789,15 @@ localver = $(subst $(space),, \
 # Other SCMs can edit scripts/setlocalversion and add the appropriate
 # checks as needed.
 ifdef CONFIG_LOCALVERSION_AUTO
-    _localver-auto = $(shell $(CONFIG_SHELL) \
+    localver-auto = $(shell $(CONFIG_SHELL) \
                       $(srctree)/scripts/setlocalversion $(srctree))
-    localver-auto  = $(LOCALVERSION)$(_localver-auto)
 endif
 
-localver-full = $(localver)$(localver-auto)
+ifeq ($(LOCALVERSION),)
+    localver-full = $(localver-files)$(localver-conf)$(localver-auto)
+else
+    localver-full = $(subst $(space),, $(LOCALVERSION))
+endif
 
 # Store (new) KERNELRELASE string in .kernelrelease
 kernelrelease = $(KERNELVERSION)$(localver-full)


