Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbTCMJ7c>; Thu, 13 Mar 2003 04:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbTCMJ7c>; Thu, 13 Mar 2003 04:59:32 -0500
Received: from ims21.stu.nus.edu.sg ([137.132.14.228]:49043 "EHLO
	ims21.stu.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S262214AbTCMJ7a> convert rfc822-to-8bit; Thu, 13 Mar 2003 04:59:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] module_init_tools 0.9.10
Date: Thu, 13 Mar 2003 18:10:03 +0800
Message-ID: <720FB032F37C0D45A11085D881B03368A2B4BA@MBXSRV24.stu.nus.edu.sg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] module_init_tools 0.9.10
Thread-Index: AcLgJazH2S1FBKJYTw6yMgPsk/imhgJImkWg
From: "Eng Se-Hsieng" <g0202512@nus.edu.sg>
To: "Kai Germaschewski" <kai-germaschewski@uiowa.edu>
X-OriginalArrivalTime: 13 Mar 2003 10:10:04.0291 (UTC) FILETIME=[B75B0D30:01C2E948]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kai,

This is in relation to your suggestions to get a module working in 2.5
kernels.

After tweaking my Makefile, I managed to get it working for 2.5.59 but
now it no longer compiles under 2.5.64! 

Here is my "tweaked" Makefile which compiled and loaded fine for 2.5.59.
Grateful if you could kindly suggest how to adapt it to 2.5.64 as I
really need to get it working. When compiling, vermagic.o can no longer
be found.

Many thanks.

Regards,
Se-Hsieng

# Start of Makefile
include ../config.mk

# Options
# -DD_DEBUG enables debug messages
OPTIONS = -DD_DEBUG

#CFLAGS = -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe
CFLAGS = -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe
-DKBUILD_MODNAME=nokia_cs

MODFLAGS = -D__KERNEL__ -DMODULE

INCDIRS  = -I../include -I$(LINUX)/include $(DBE) $(DBM) 

L_TARGET := nokia_cs.a

# Module settings

MODULE = nokia_cs.o
MODDIR = $(ROOTDIR)/lib/modules/$(OS_RELEASE)

# Locations ##############################################

srcs = dllc.c dmodule.c dtools.c dserial.c
hdrs = $(wildcard *.h)
objs = dllc.o dmodule.o dtools.o dserial.o

# ALL_O := $(objs) $(L_TARGET)
ALL_O := $(objs) $(L_TARGET) $(LINUX)/init/vermagic.o

# helps ##################################################

REALOPTS = $(CFLAGS) $(MODFLAGS) $(INCDIRS) $(OPTIONS)

# Targets ################################################

all : $(MODULE) 

run : install
	/etc/rc.d/init.d/pcmcia restart

$(srcs) : $(hdrs)

$(objs) : $(srcs)
	$(CC) $(REALOPTS) -c $(patsubst %.o, %.c, $@)
	chmod -x $@

$(MODULE) : $(objs) $(L_TARGET)
	$(LD) -m elf_i386 -r -o $@ $(ALL_O)
	chmod -x $@

install : $(MODULE)
	echo "Installing module ("$(MODULE)" to "$(MODDIR)"/pcmcia)"
	mkdir -p $(MODDIR)/pcmcia
	cp -p $(MODULE) $(MODDIR)/pcmcia
	mkdir -p $(ROOTDIR)/etc/pcmcia/bin
	cp ../bin/$(SMAC2) $(ROOTDIR)/etc/pcmcia/bin/smac2.bin

uninstall :
	echo "Uninstalling module ("$(MODULE)" from "$(MODDIR)"/pcmcia)"
	rm $(MODDIR)/pcmcia/$(MODULE) 
	rm $(ROOTDIR)/etc/pcmcia/bin/smac2.bin

clean: 
	rm -f core *.o *~

-----Original Message-----
From: Kai Germaschewski [mailto:kai-germaschewski@uiowa.edu] 
Sent: Sunday, March 02, 2003 3:06 AM
To: Eng Se-Hsieng
Subject: Re: [BUG] module_init_tools 0.9.10


On Fri, 28 Feb 2003, Eng Se-Hsieng wrote:

> I'm afraid I don't understand how to apply the solution you gave 
> below.
> Could you please help advise me on how I may modify my Makefile in
order
> to allow the driver and module and work?

Put something like the following into your your_driver/Makefile

---
KERNELSRC=/lib/modules/`uname -r`/build

all:
        make -C $(KERNELSRC) SUBDIRS=$$PWD modules

obj-m           := test.o

test-objs       := test1.o test2.o
---


and then just do "make".

If your kernel source isn't pointed to by /lib/modules/`uname -r`/build,
override with "make KERNELSRC=/where/the/source/is"


HTH,

--Kai


