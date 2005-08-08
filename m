Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVHHOSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVHHOSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVHHOSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:18:07 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:26385 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932076AbVHHOSH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:18:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050808130246.58431.qmail@web60517.mail.yahoo.com>
References: <20050808130246.58431.qmail@web60517.mail.yahoo.com>
X-OriginalArrivalTime: 08 Aug 2005 14:18:05.0447 (UTC) FILETIME=[FE518170:01C59C23]
Content-class: urn:content-classes:message
Subject: Re: I can not  build a new kernel image with a assembly module
Date: Mon, 8 Aug 2005 10:17:13 -0400
Message-ID: <Pine.LNX.4.61.0508080956220.18723@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: I can not  build a new kernel image with a assembly module
thread-index: AcWcI/5Y9+eB9dBQQ/OZ5p/mDNq9Mw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "mhb" <badrpayam@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Aug 2005, mhb wrote:

> Hi
>
> I had added an assembly program to the networking
> section of kernel linux 2.2.16 without any problem.
> But when I add it to kerenel 2.4.1 I could build that
> kernel, but I faced with kernel panic error when I
> boot
> system with new builded image. I use the following
> Make file to build It in the 2.4.1 kernel.
>
> /*--------------------------------*/
> L_TARGET := libtest.a
>
> obj-$(CONFIG_TEST)		+= test.o
>
> override CFLAGS += -Wpointer-arith
> override CFLAGS += -Wbad-function-cast
> override CFLAGS += -DTERMIO
>
>
> #-----------------------------------------------------------------------------
> # Section 3 - Conversion routines from new style to
> old style for Rules.make
>
> #-----------------------------------------------------------------------------
> # Section 4 - Rules.make section
> include $(TOPDIR)/Rules.make
> #-----------------------------------------------------------------------------
> # Section 5
>
> $(obj-y):  $(TOPDIR)/include/linux/config.h\
>
> $(TOPDIR)/include/linux/autoconf.h
>
> clean:
> 	-rm -f *.o
> tags:
> 	ctags libtest.a
>
> tar:
> 	tar -cvf /dev/f1 .
>
> test.o: test1.o test2.o test3.o
> 	$(LD) -r -o $@ test1.o test2.o test3.o
>
> test3.o: test3.s
> 	$(AS) -o $@ $<
> #-----------------------------------------------------------------------------
> As you can see test3.s is an assembly file.
> I guess this problem is related to this Makefile.
> Is this Make file true?
> How can I win over this problem?
>
> thanks
>

The newer kernels may pass parameters in registers instead of
on the stack. If you haven't done this in the past, you need
to declare your assembly-language modules as:

extern asmlinkage int function(params,...);
        |_________ Parameters on the stack.


To prevent experimental kernels from redefining asmlinkage, I
suggest:

#define OnStack __attribute__((regparm(0)))  // Some header somewhere

extern OnStack int function(params,...);


Here is a typical Makefile to build a module outside the source-code
tree. It has many assembly-language source files.

#
#    This program may be distributed under the GNU Public License
#    version 2, as published by the Free Software Foundation, Inc.,
#    59 Temple Place, Suite 330 Boston, MA, 02111.
#
#    Project Makefile for kernel versions over 6
#    Created 05-OCT-2004    Richard B. Johnson
#
#    Note that macro "obj" refers to this directory when
#    make is executing from the kernel directory.
#

%.o:%.S
 		as -o $@ $<

VERS := $(shell uname -r)
CDIR := $(shell pwd)
MKNOD = /usr/bin/mknodp
FNAM = HeavyLink
EXTRA_CFLAGS += -DKVER6 -DMAJOR_NR=178 -DMODNAME="\"$(FNAM)"\"

OBJS =	datalink.o	min_size_t.o	license.o	ram_test.o\
 	rwcheck.o	seeprom.o	rwreg.o		rnd.o\
 	rdtsc.o		dma_buffer.o	ioctltxt.o

all:		chkhdrs
 		@./chkhdrs
 		@make V=1 -C /usr/src/linux-$(VERS) SUBDIRS=$(CDIR) modules
 		strip -x -R .note -R .comment $(FNAM).ko

obj-m		:= 	$(FNAM).o
$(FNAM)-objs	:=	$(OBJS)
$(obj)/min_size_t.o:	$(obj)/min_size_t.S	$(obj)/Makefile
$(obj)/license.o:	$(obj)/license.c	$(obj)/Makefile
$(obj)/ram_test.o:	$(obj)/ram_test.c	$(obj)/Makefile
$(obj)/rwcheck.o:	$(obj)/rwcheck.S	$(obj)/Makefile
$(obj)/rwreg.o:		$(obj)/rwreg.S		$(obj)/Makefile
$(obj)/rnd.o:		$(obj)/rnd.S		$(obj)/Makefile
$(obj)/rdtsc.o:		$(obj)/rdtsc.S		$(obj)/Makefile
$(obj)/ioctltxt.o:	$(obj)/ioctltxt.s
$(obj)/datalink.o:	$(obj)/datalink.c	$(obj)/datalink.h\
 			$(obj)/config.h		$(obj)/types.h\
 			$(obj)/plx.h		$(obj)/dlb.h\
 			$(obj)/ver.h		$(obj)/Makefile\
 			$(SUBDIRS)/bool.h	$(SUBDIRS)/kver.h
$(obj)/dma_buffer.o:	$(obj)/dma_buffer.c	$(obj)/datalink.h\
 			$(obj)/config.h		$(obj)/Makefile\
 			$(SUBDIRS)/bool.h
$(obj)/seeprom.o:	$(obj)/seeprom.c	$(obj)/plx.h\
 			$(obj)/types.h		$(obj)/Makefile

chkhdrs:	../tools/chkhdrs.c
 	gcc -O2 -Wall -o chkhdrs ../tools/chkhdrs.c

$(SUBDIRS)/chktrue:	$(SUBDIRS)/../tools/chktrue.c
 	gcc -O2 -Wall -o $(SUBDIRS)/chktrue $(SUBDIRS)/../tools/chktrue.c

$(SUBDIRS)/bool.h:	$(SUBDIRS)/chktrue
 	cd $(SUBDIRS) ; $(SUBDIRS)/chktrue

$(SUBDIRS)/mkioctltxt:	$(SUBDIRS)/mkioctltxt.c
 	gcc -O2 -Wall -o $(SUBDIRS)/mkioctltxt $(SUBDIRS)/mkioctltxt.c

$(SUBDIRS)/ioctltxt.s:	$(SUBDIRS)/mkioctltxt $(SUBDIRS)/datalink.h
 	cd $(SUBDIRS) ; $(SUBDIRS)/mkioctltxt

$(SUBDIRS)/chkver:	$(SUBDIRS)/../tools/chkver.c
 	gcc -O2 -Wall -o $(SUBDIRS)/chkver $(SUBDIRS)/../tools/chkver.c

$(SUBDIRS)/kver.h:	$(SUBDIRS)/chkver
 	cd $(SUBDIRS) ; $(SUBDIRS)/chkver $(VERS)


install:	install.sh $(MKNOD)
 	@sh install.sh install


$(MKNOD):	../tools/mknodp.c
 	make -C ../tools

clean:
 	rm -rf $(OBJS) $(FNAM).ko $(FNAM).mod.c $(FNAM)*.o \.*.cmd \
chkhdrs \.tmp_versions chktrue bool.h kver.h *.s mkioctltxt chkver
 		@sh install.sh clean



Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
