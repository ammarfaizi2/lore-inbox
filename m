Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUHaTbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUHaTbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268832AbUHaT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:28:23 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7831 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268944AbUHaTYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:24:47 -0400
Date: Tue, 31 Aug 2004 21:26:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Ian Wienand <ianw@gelato.unsw.edu.au>, Christoph Hellwig <hch@lst.de>
Subject: kbuild: Support LOCALVERSION
Message-ID: <20040831192642.GA15855@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ian Wienand <ianw@gelato.unsw.edu.au>,
	Christoph Hellwig <hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch combines the request from several people.
If you place a file named localversion* in the root of your
soruce tree or the root of your output tree the text included in this
file will be appended to KERNELRELEASE.

LOCALVERSION was originally introduced by Ian Wienand <ianw@gelato.unsw.edu.au>

This allows one to put a short string in localversion identifying this
particular configuration "-smpacpi", or to identify applied patches
to the source "-llat-np".

More specifically:
$(srctree)/localversion-lowlatency contains "-llat"
$(srctree)/localversion-scheduler-nick constins "-np"

$(objtree)/localversion contains "-smpacpi"

Resulting KERNELRELEASE would be:
2.6.8.rc1-smpacpi-llat-np


Note that you no longer need to modify your Makefile to identify
your kernel so no rejects when applying new patches.
If you add a new localversion* file, or change a existing one kbuild
will pick up this and do the proper rebuild next time you run make.

Only issue is that KERNELRELEASE needs to be <= 64 chars - so keep the names short.

kbuild errors out if you are above limit.
$ cat localviersion-long
very-long-version-in-localversion-file-exceeding-64-chars-for-sure
Example:
  CHK     include/linux/version.h
"2.6.9-rc1-very-long-version-in-localversion-file-exceeding-64-chars-for-sure" exceeds 64 characters
make: *** [include/linux/version.h] Error 1
  

Where do we document this?

[This is deliberately not pushed to my bk tree - want some comments first].

	Sam

===== Makefile 1.526 vs edited =====
--- 1.526/Makefile	2004-08-30 21:23:05 +02:00
+++ edited/Makefile	2004-08-31 21:05:38 +02:00
@@ -141,7 +141,14 @@ VPATH		:= $(srctree)
 
 export srctree objtree VPATH TOPDIR
 
-KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+nullstring := 
+space      := $(nullstring) # end of line
+
+LOCALVERSION := $(subst $(space),, \
+                $(shell cat /dev/null $(objtree)/localversion* \
+                $(if $(KBUILD_SRC),$(srctree)/localversion*)))
+
+KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
@@ -329,8 +336,8 @@ CFLAGS 		:= -Wall -Wstrict-prototypes -W
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
-export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
-	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
+export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \
+	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK CHECKFLAGS
 
@@ -763,7 +770,8 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: Makefile
+include/linux/version.h: $(srctree)/Makefile \
+                         $(objtree)/localversion* $(srctree)/localversion*
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------
