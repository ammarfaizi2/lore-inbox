Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUHLAho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUHLAho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268510AbUHLAez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:34:55 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:5013 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268455AbUHLAWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:22:23 -0400
From: Benno <benjl@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org, roms@tilp.info
Date: Thu, 12 Aug 2004 10:22:20 +1000
Subject: [PATCH] Re: Building on platforms other than Linux
Message-ID: <20040812002220.GF24657@cse.unsw.edu.au>
References: <20040811091349.GX862@cse.unsw.edu.au> <20040811185453.GA7217@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20040811185453.GA7217@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed Aug 11, 2004 at 20:54:53 +0200, Sam Ravnborg wrote:
>On Wed, Aug 11, 2004 at 07:13:49PM +1000, Benno wrote:
>> Hi,
>> 
>> I was wondering if there were any, in priniciple, objections
>> to making the Linux kernel buildable on different Unix-like 
>> platforms?
>
>The userbase for building kernels are only increasing and there
>continue to be more focus from the embedded people.
>Having experince in this field first-hand tells me that a kernel
>that can be build on several paltforms are a good thing.

This is the direction I am coming from.

>For kbuild you will at some point start to see patches so at least
>the build system does not restrict us to Linux alone.

Great.

>People on this list usually reply: "shift development to a Linux
>based platform". This is for many developers a nice dream,
>but they are restricted by coporate rules etc.
>
>So please feed patches to this list with your findings.
>
>> 
>> I am currently compiling on MacOSX and this, for the most part was
>> fairly straightforward and simple. The biggest gotcha I had was
>> that libkconfig is compiled as a shared library, and unfortunately shared
>> libraries are done quite different on different systems. Specifically MacOSX
>> doesn't support gcc -shared.
>
>Please submit a patch for this and make sure to include Roman Zippel, he
>is the maintainer of kconfig.

Attached is a patch to avoid using shared libraries in the build system. 
It is very simple, instead of [m]conf linked against libkconfig.so, they
directly link against $(libkconfig-objs).

For (g|q)conf they no longer use dl_open and also directly link against 
$(libkconfig-objs). (Achieved by export LKC_DIRECT_LINK to the compile.)

(Give this change one could also get rid of rules to build .so files
in Makefile.lib)

Cheers,

Benno

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="no_shared.diff"

--- ../../../linux-2.6.7/scripts/kconfig/Makefile	2004-06-16 15:20:26.000000000 +1000
+++ Makefile	2004-08-12 09:53:15.000000000 +1000
@@ -68,8 +68,8 @@
 libkconfig-objs := zconf.tab.o
 
 host-progs	:= conf mconf qconf gconf
-conf-objs	:= conf.o  libkconfig.so
-mconf-objs	:= mconf.o libkconfig.so
+conf-objs	:= conf.o  $(libkconfig-objs)
+mconf-objs	:= mconf.o $(libkconfig-objs)
 
 ifeq ($(MAKECMDGOALS),xconfig)
 	qconf-target := 1
@@ -81,11 +81,11 @@
 
 ifeq ($(qconf-target),1)
 qconf-cxxobjs	:= qconf.o
-qconf-objs	:= kconfig_load.o
+qconf-objs	:= $(libkconfig-objs)
 endif
 
 ifeq ($(gconf-target),1)
-gconf-objs	:= gconf.o kconfig_load.o
+gconf-objs	:= gconf.o $(libkconfig-objs)
 endif
 
 clean-files	:= libkconfig.so lkc_defs.h qconf.moc .tmp_qtcheck \
@@ -96,10 +96,10 @@
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
 HOSTLOADLIBES_qconf	= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(QTLIB) -ldl
-HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 
+HOSTCXXFLAGS_qconf.o	= -DLKC_DIRECT_LINK -I$(QTDIR)/include 
 
 HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
-HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags`
+HOSTCFLAGS_gconf.o	= -DLKC_DIRECT_LINK `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags`
 
 $(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h
 

--HcAYCG3uE/tztfnV--
