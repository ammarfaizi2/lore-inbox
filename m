Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTJSHSG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 03:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTJSHSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 03:18:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:53521 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261984AbTJSHSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 03:18:01 -0400
Date: Sun, 19 Oct 2003 09:17:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Steudten <alpha@steudten.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: linux-2.6.0-test7: make O=/var/tmp/build xconfig
Message-ID: <20031019071756.GA1162@mars.ravnborg.org>
Mail-Followup-To: Thomas Steudten <alpha@steudten.com>,
	linux-kernel@vger.kernel.org
References: <3F849088.7010105@steudten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F849088.7010105@steudten.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 12:32:40AM +0200, Thomas Steudten wrote:
> Hello
> 
> Maybe i´m not up-to-date, but i tried out the new 2.6 kernel
> with the new O option and it fails with:
> I think here´s something wrong, one -I is missing between
> the //: 
> -I/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7//usr/lib/qt-2.3.1/include
> 
> --------------------8<-------------------8<--------------
> [62]:thomas (2) $ make  -w V=1 O=/var/tmp/build xconfig

Hi Thomas - the following patch fixes this and also avoid duplicating
some options on the gcc command line.

	Sam

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
