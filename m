Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132724AbRDILa1>; Mon, 9 Apr 2001 07:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132722AbRDILaI>; Mon, 9 Apr 2001 07:30:08 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:6418 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S132720AbRDIL36>; Mon, 9 Apr 2001 07:29:58 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: build -->/usr/src/linux
Date: Mon, 9 Apr 2001 11:29:57 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9as6fl$gmq$1@ncc1701.cistron.net>
In-Reply-To: <3AD079EA.50DA97F3@rcn.com> <3AD0A029.C17C3EFC@rcn.com> <9aqmci$gn2$1@ncc1701.cistron.net> <20010409010103.A16562@pcep-jamie.cern.ch>
X-Trace: ncc1701.cistron.net 986815797 17114 195.64.65.67 (9 Apr 2001 11:29:57 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010409010103.A16562@pcep-jamie.cern.ch>,
Jamie Lokier  <lk@tantalophile.demon.co.uk> wrote:
>Miquel van Smoorenburg wrote:
>> .. but there should be a cleaner way to get at the CFLAGS used
>> to compile the kernel.
>
>There is a way though I'd not call it clean.  Here is an extract from

Do you think something like this is the correct approach? If it
was part of the official kernel you could write a Makefile like this:

KSRC = /lib/modules/`uname -r`/build
include $(KSRC)/include/config.mak

CFLAGS := $(CFLAGS) $(MODFLAGS)

module.c:  module.h

--- linux-2.2.19.orig/Makefile	Mon Apr  9 13:01:37 2001
+++ linux-2.2.19/Makefile	Mon Apr  9 13:20:21 2001
@@ -325,7 +325,8 @@
 MODFLAGS += -DMODVERSIONS -include $(HPATH)/linux/modversions.h
 endif
 
-modules: include/config/MARKER $(patsubst %, _mod_%, $(SUBDIRS))  
+modules: include/config/MARKER $(patsubst %, _mod_%, $(SUBDIRS))  \
+		include/linux/config.mak
 
 $(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h
 	$(MAKE) -C $(patsubst _mod_%, %, $@) CFLAGS="$(CFLAGS) $(MODFLAGS)" MAKING_MODULES=1 modules
@@ -380,6 +381,31 @@
 	@exit 1
 endif
 
+include/linux/config.mak: ./Makefile
+	@echo "VERSION		= $(VERSION)" > .mak
+	@echo "PATCHLEVEL	= $(PATCHLEVEL)" >> .mak
+	@echo "SUBLEVEL	= $(SUBLEVEL)" >> .mak
+	@echo "EXTRAVERSION	= $(EXTRAVERSION)" >> .mak
+	@echo "ARCH		= $(ARCH)" >> .mak
+	@echo "HOSTCC		= $(HOSTCC)" >> .mak
+	@echo "HOSTCFLAGS	= $(HOSTCFLAGS)" >> .mak
+	@echo "CROSS_COMPILE	= $(CROSS_COMPILE)" >> .mak
+	@echo "AS		= $(AS)" >> .mak
+	@echo "LD		= $(LD)" >> .mak
+	@echo "CC		= $(CC)" >> .mak
+	@echo "CPP		= $(CPP)" >> .mak
+	@echo "AR		= $(AR)" >> .mak
+	@echo "NM		= $(NM)" >> .mak
+	@echo "STRIP		= $(STRIP)" >> .mak
+	@echo "OBJCOPY		= $(OBJCOPY)" >> .mak
+	@echo "OBJDUMP		= $(OBJDUMP)" >> .mak
+	@echo "MAKE		= $(MAKE)" >> .mak
+	@echo "GENKSYMS	= $(GENKSYMS)" >> .mak
+	@echo "CFLAGS		= $(CFLAGS)" >> .mak
+	@echo "AFLAGS		= $(AFLAGS)" >> .mak
+	@echo "MODFLAGS	= $(MODFLAGS)" >> .mak
+	@mv -f .mak $@
+
 clean:	archclean
 	rm -f kernel/ksyms.lst include/linux/compile.h
 	rm -f core `find . -name '*.[oas]' ! \( -regex '.*lxdialog/.*' \
@@ -398,6 +424,7 @@
 
 mrproper: clean archmrproper
 	rm -f include/linux/autoconf.h include/linux/version.h
+	rm -f include/linux/config.mak
 	rm -f drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h
 	rm -f drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h
 	rm -f drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h


Mike.

