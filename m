Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbTAKBSG>; Fri, 10 Jan 2003 20:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbTAKBSG>; Fri, 10 Jan 2003 20:18:06 -0500
Received: from havoc.daloft.com ([64.213.145.173]:33494 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267003AbTAKBSF>;
	Fri, 10 Jan 2003 20:18:05 -0500
Date: Fri, 10 Jan 2003 20:26:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [BK/PATCH] better i386 compiler flags
Message-ID: <20030111012645.GB24847@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[this kills scads of warnings with CONFIG_MCYRIXIII and gcc 3.2,
 also starts using -march=pentium3/4/athlon when available.  I've been
 doing that for a while now without problems.]



Marcelo, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.4

This will update the following files:

 arch/i386/Makefile |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/01/10 1.994)
   arch/i386/Makefile: improved support for gcc 3.2 compiler flags
   
   * Adds useful 'check_gcc' makefile function
   * stop using the deprecated -malign* arguments when -falign* is available
   * call -march={pentium3,pentium4,k6,athlon,c3,winchip*} when available





--- 1.4/arch/i386/Makefile	Mon Sep 30 12:45:01 2002
+++ edited/arch/i386/Makefile	Fri Jan 10 19:49:03 2003
@@ -23,8 +23,10 @@
 
 CFLAGS += -pipe
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 # prevent gcc from keeping the stack 16 byte aligned
-CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)
+CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
 ifdef CONFIG_M386
 CFLAGS += -march=i386
@@ -51,19 +53,19 @@
 endif
 
 ifdef CONFIG_MPENTIUMIII
-CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-march=pentium3,-march=i686)
 endif
 
 ifdef CONFIG_MPENTIUM4
-CFLAGS += -march=i686
+CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
 endif
 
 ifdef CONFIG_MK6
-CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
+CFLAGS += $(call check_gcc,-march=k6,-march=i586)
 endif
 
 ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+CFLAGS += $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
 endif
 
 ifdef CONFIG_MCRUSOE
@@ -71,11 +73,11 @@
 endif
 
 ifdef CONFIG_MWINCHIPC6
-CFLAGS += -march=i586
+CFLAGS += $(call check_gcc,-march=winchip-c6,-march=i586)
 endif
 
 ifdef CONFIG_MWINCHIP2
-CFLAGS += -march=i586
+CFLAGS += $(call check_gcc,-march=winchip2,-march=i586)
 endif
 
 ifdef CONFIG_MWINCHIP3D
@@ -83,7 +85,8 @@
 endif
 
 ifdef CONFIG_MCYRIXIII
-CFLAGS += -march=i486 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+CFLAGS += $(call check_gcc,-march=c3,-march=i486)
+CFLAGS += $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 endif
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
