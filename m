Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268761AbTCCUPz>; Mon, 3 Mar 2003 15:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268764AbTCCUPz>; Mon, 3 Mar 2003 15:15:55 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:59140 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268761AbTCCUPt>;
	Mon, 3 Mar 2003 15:15:49 -0500
Date: Mon, 3 Mar 2003 21:26:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>, klibc@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.63
Message-ID: <20030303202618.GA15819@mars.ravnborg.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>, klibc@zytor.com,
	linux-kernel@vger.kernel.org
References: <20030224225659.GD3775@kroah.com> <b3ego8$eac$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ego8$eac$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 05:26:32PM -0800, H. Peter Anvin wrote:
> Greg has taken on the job of integrating klibc with the kernel, but
> please post klibc bug reports to the klibc mailing list at
> <klibc@zytor.com>.

To avoid annoying warning from gcc I had to check for compatibility with
-falign-* like we do in arch/i386/Makefile.
check_usergcc located in top-level makefile to allow other architectures
to use it later.
Also modified a few assignment to use :=.

On top of Gregh's latest bk tree.

	Sam

===== Makefile 1.385 vs edited =====
--- 1.385/Makefile	Mon Mar  3 18:17:13 2003
+++ edited/Makefile	Mon Mar  3 21:18:11 2003
@@ -933,4 +933,7 @@
 # Usage is deprecated, because make does not see this as an invocation of make.
 descend =$(Q)$(MAKE) -f scripts/Makefile.build obj=$(1) $(2)
 
+check_usergcc = $(shell if $(USERCC) $(1) -S -o /dev/null -xc /dev/null > \
+	/dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 FORCE:
===== usr/lib/arch/i386/MCONFIG 1.1 vs edited =====
--- 1.1/usr/lib/arch/i386/MCONFIG	Sat Feb 15 23:53:51 2003
+++ edited/usr/lib/arch/i386/MCONFIG	Mon Mar  3 21:18:08 2003
@@ -13,12 +13,19 @@
 # them to be cdecl
 # REGPARM = -mregparm=3 -DREGPARM
 
-OPTFLAGS = $(REGPARM) -march=i386 -Os -fomit-frame-pointer \
-	   -malign-functions=0 -malign-jumps=0 -malign-loops=0
-BITSIZE  = 32
+#check_usergcc = $(shell if $(USERCC) $(1) -S -o /dev/null -xc /dev/null > \
+	/dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
+
+OPTFLAGS	:= $(REGPARM) -march=i386 -Os -fomit-frame-pointer
+OPTFLAGS	+= $(call check_usergcc, \
+		   -falign-functions=0 -falign-jumps=0 -falign-loops=0, \
+		   -malign-functions=0 -malign-jumps=0 -malign-loops=0)
+
+BITSIZE		:= 32
 
 # Extra linkflags when building the shared version of the library
 # This address needs to be reachable using normal inter-module
 # calls, and work on the memory models for this architecture
 # 96 MB - normal binaries start at 128 MB
-SHAREDFLAGS	= -Ttext 0x06000200
+SHAREDFLAGS	:= -Ttext 0x06000200
