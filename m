Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTEFG3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTEFG3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:29:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47605 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262385AbTEFG3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:29:37 -0400
Message-ID: <3EB75924.1080304@mvista.com>
Date: Mon, 05 May 2003 23:41:40 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, kbuild-devel@lists.sourceforge.net,
       mec@shout.net,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] asm-generic magic
Content-Type: multipart/mixed;
 boundary="------------070005030608090803000405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------070005030608090803000405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



The attached patch changes topdir/Makefile to make the asm-generic
stuff to work the way I assumed it was supposed to work.  :)

That is, if the file exists in .../include/asm/ use that one, if not 
and it exist in .../include/asm-generic/ use the generic one.  This is 
compatable with current conventions but also allows asm files that do 
nothing but include the asm-generic file with the same name to go 
away.  The "magic" is to supply both include and include/asm-generic 
to CPP.  This causes it, when looking for  <asm/foo.h> to look first 
in ...include/asm/ and then in .../include/asm-generic/asm.  To make 
the ladder work we put a link (called asm) in asm-generic to point to ".".

Commits?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


--------------070005030608090803000405
Content-Type: text/plain;
 name="asm-generic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asm-generic.patch"

--- linux-2.5.69-wq/Makefile~	2003-05-05 15:33:30.000000000 -0700
+++ linux/Makefile	2003-05-05 18:00:42.000000000 -0700
@@ -181,7 +181,7 @@
 
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
-CPPFLAGS	:= -D__KERNEL__ -Iinclude
+CPPFLAGS	:= -D__KERNEL__ -Iinclude -Iinclude/generic-asm
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
@@ -403,7 +403,7 @@
 #	module versions are listed in "prepare"
 
 .PHONY: prepare
-prepare: include/linux/version.h include/asm include/config/MARKER
+prepare: include/linux/version.h include/asm include/config/MARKER include/asm-generic/asm
 ifdef KBUILD_MODULES
 ifeq ($(origin SUBDIRS),file)
 	$(Q)rm -rf $(MODVERDIR)
@@ -453,6 +453,10 @@
 	@echo '  Making asm->asm-$(ARCH) symlink'
 	@ln -s asm-$(ARCH) $@
 
+include/asm-generic/asm:
+	@echo '  Making asm-generic/asm->. symlink'
+	@ln -s . $@
+
 # 	Split autoconf.h into include/linux/config/*
 
 include/config/MARKER: scripts/split-include include/linux/autoconf.h
child process exited abnormally


--------------070005030608090803000405--

