Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbTK3HPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 02:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTK3HPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 02:15:05 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28936 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264874AbTK3HO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 02:14:58 -0500
From: Sam Ravnborg <sam@ravnborg.org>
To: Dosoverride <dosoverride@epix.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test11] gconfig does not build cleanly
Date: Sun, 30 Nov 2003 08:16:24 +0100
User-Agent: KMail/1.5.4
References: <200311300610.40705.dosoverride@epix.net>
In-Reply-To: <200311300610.40705.dosoverride@epix.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IlZy/6U8mcPXD84"
Message-Id: <200311300816.24749.sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_IlZy/6U8mcPXD84
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 30 November 2003 07:10, Dosoverride wrote:
> [make O=~/kernel-build-tree/test mrproper clean gconfig ]
>
> [excerpt of make command with alternate tree ]
> ./scripts/kconfig/gconf  arch/i386/Kconfig
>
> (gconf:14841): libglade-WARNING **: could not find glade file
> '/home/dosoverride/kernel-build-tree/test//scripts/kconfig/gconf.glade'
> 	   							             ^ (seems to be the problem)
> ** ERROR **: GUI loading failed !
Hi John.
The problem is know and a fix exist.
Usually reported as xconfig build fails with make O=
The fix did not pass Linus' current patchfilter - it is not critical - so it 
will be applied later. Until now here it is.

[Nw mailer, so apologize if it is whitespace damaged]

	Sam


--Boundary-00=_IlZy/6U8mcPXD84
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rev-1.1296.61.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rev-1.1296.61.2.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1296.61.1 -> 1.1296.61.2
#	scripts/Makefile.lib	1.22    -> 1.23   
#	            Makefile	1.435   -> 1.436  
#
# The following is the BitKeeper ChangeSet Log
# 03/10/12	sam@mars.ravnborg.org	1.1296.61.2
# kbuild: Fix make O=../build xconfig
# 
# Compilation of qconf required -I path to qt. kbuild invalidated the
# path to qt by prefixing it with $(srctree). No longer prefix absolute paths.
# Also do not duplicate CPPFLAGS. Previously it was appended twice to CFLAGS
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Oct 18 09:48:02 2003
+++ b/Makefile	Sat Oct 18 09:48:02 2003
@@ -404,10 +404,6 @@
 
 include $(srctree)/arch/$(ARCH)/Makefile
 
-# Let architecture Makefiles change CPPFLAGS if needed
-CFLAGS := $(CPPFLAGS) $(CFLAGS)
-AFLAGS := $(CPPFLAGS) $(AFLAGS)
-
 core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
 
 SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Sat Oct 18 09:48:02 2003
+++ b/scripts/Makefile.lib	Sat Oct 18 09:48:02 2003
@@ -154,7 +154,8 @@
 __hostcxx_flags	= $(_hostcxx_flags)
 else
 flags = $(foreach o,$($(1)),\
-	$(if $(filter -I%,$(o)),$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
+		$(if $(filter -I%,$(filter-out -I/%,$(o))), \
+		$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
 
 # -I$(obj) locate generated .h files
 # -I$(srctree)/$(src) locate .h files in srctree, from generated .c files
@@ -162,7 +163,7 @@
 __c_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_c_flags)
 __a_flags	=                              $(call flags,_a_flags)
 __hostc_flags	= -I$(obj)                     $(call flags,_hostc_flags)
-__hostcxx_flags	=                              $(call flags,_hostcxx_flags)
+__hostcxx_flags	= -I$(obj)                     $(call flags,_hostcxx_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \

--Boundary-00=_IlZy/6U8mcPXD84--

