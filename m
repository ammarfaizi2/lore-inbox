Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbTKAHbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 02:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTKAHbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 02:31:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30727 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263733AbTKAHbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 02:31:32 -0500
Date: Sat, 1 Nov 2003 08:31:29 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] GUI config targets fail with "make O=..."
Message-ID: <20031101073129.GA924@mars.ravnborg.org>
Mail-Followup-To: Bryan O'Sullivan <bos@serpentine.com>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <1067645690.10240.25.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067645690.10240.25.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 04:14:50PM -0800, Bryan O'Sullivan wrote:
> Hi, Sam -
> 
> There's something in the 2.6 kbuild infrastructure that does some rather
> wrong things for the gconfig and xconfig targets when object files
> should go to a separate directory.

Hi Bryan - known problem reported some weeks ago, but thanks
for the report anyhow.

Patch is present in my kbuild repository (linux-sam.bkbits.net/kbuild).
Linus has not applied them, since this is not critical fixes. I will
try to see when 2.6.1 comes out to get them applied.

Until then the relevant patch is attached here.

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
