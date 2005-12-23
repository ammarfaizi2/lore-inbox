Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVLWHdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVLWHdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 02:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVLWHdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 02:33:25 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27514
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030226AbVLWHdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 02:33:25 -0500
Message-Id: <43ABB683.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 23 Dec 2005 08:34:11 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Roman Zippel" <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: .config not updated after make clean
References: <43AABBA1.76F0.0078.0@novell.com> <20051222212508.GA1323@mars.ravnborg.org>
In-Reply-To: <20051222212508.GA1323@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks better than any of the alternatives I had come to think of.
Thanks, and assuming you're going to push this upwards... Jan

>>> Sam Ravnborg <sam@ravnborg.org> 22.12.05 22:25:08 >>>
On Thu, Dec 22, 2005 at 02:43:45PM +0100, Jan Beulich wrote:
> Sam,
> 
> since 'make clean' doesn't delete include/linux/autoconf.h (but
> obviously does delete .config.cmd), .config cannot get updated
anymore
> if any of the Kconfig-s in the tree changes.

Correct but thats unfortunate though.

> Is there a particular
> reason that include/linux/autoconf.h only gets deleted by 'make
> mrproper', but not by 'make clean'?
make clean is used to clean out all intermidiate files not needed for:
- building applications that users kernel headers directly
- building external modules

For the latter autoconf.h is needed in order to obtain the
current kernel configuration.

> If that cannot be adjusted, I can't
> see how else to force proper re-generation of .config through the
> silentoldconfig target.

The current flow is something in the line of:

all Kconfig files => .config + include/linux/autoconf.h +.config.cmd
include/linux/autoconf.h => include/config/* + include/config/MARKER

When we execute make clean we delete the .config.cmd file so
we will not detect when a Kconfig file is changed - not good.

Since for reasons listed above we want to keep the autoconf.h
around also after make clean a new approach is needed.
We could keep the .config.cmd file but thats clearly not
supposed to stay around after a make clean.

So I went for another solution and if .config.cmd - renamed to
kconfig.dep - does not exists we execute make silentoldconfig

The reason for the rename is the clash with the normal kbuild .cmd
file which caused it to have multiple targets if it was created.

	Sam
	
diff --git a/Makefile b/Makefile
index f4218b5..43ab980 100644
--- a/Makefile
+++ b/Makefile
@@ -481,18 +481,20 @@ ifeq ($(dot-config),1)
 
 # Read in dependencies to all Kconfig* files, make sure to run
 # oldconfig if changes are detected.
--include .config.cmd
+-include .kconfig.dep
 
 include .config
 
 # If .config needs to be updated, it will be done via the dependency
 # that autoconf has on .config.
 # To avoid any implicit rule to kick in, define an empty command
-.config: ;
+.config .kconfig.dep: ;
 
 # If .config is newer than include/linux/autoconf.h, someone tinkered
-# with it and forgot to run make oldconfig
-include/linux/autoconf.h: .config
+# with it and forgot to run make oldconfig.
+# If kconfig.dep is missing then we are probarly in a cleaned tree so
+# we execute the config step to be sure to catch updated Kconfig
files
+include/linux/autoconf.h: .kconfig.dep .config
 	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
@@ -981,7 +983,7 @@ endif # CONFIG_MODULES
 
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
-CLEAN_FILES +=	vmlinux System.map \
+CLEAN_FILES +=	vmlinux System.map .kconfig.dep\
                 .tmp_kallsyms* .tmp_version .tmp_vmlinux*
.tmp_System.map
 
 # Directories & files removed with 'make mrproper'
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 1fa4c0b..854d247 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -33,7 +33,7 @@ int file_write_dep(const char *name)
 	FILE *out;
 
 	if (!name)
-		name = ".config.cmd";
+		name = ".kconfig.dep";
 	out = fopen("..config.tmp", "w");
 	if (!out)
 		return 1;
