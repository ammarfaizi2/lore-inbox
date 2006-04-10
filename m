Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWDJTM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWDJTM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWDJTM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:12:58 -0400
Received: from spirit.analogic.com ([204.178.40.4]:1034 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932120AbWDJTM5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:12:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060410182421.GA22440@mars.ravnborg.org>
x-originalarrivaltime: 10 Apr 2006 19:12:56.0578 (UTC) FILETIME=[C6429E20:01C65CD2]
Content-class: urn:content-classes:message
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Date: Mon, 10 Apr 2006 15:12:55 -0400
Message-ID: <Pine.LNX.4.61.0604101506430.26625@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The assemble file under the driver folder can not be recognized when the driver is built as module
Thread-Index: AcZc0sZOy5PB4LpaQ4SB33cEmbAPag==
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com> <20060410112817.GE12896@harddisk-recovery.com> <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com> <20060410174252.GD2408@stusta.de> <Pine.LNX.4.61.0604101402400.26129@chaos.analogic.com> <20060410182421.GA22440@mars.ravnborg.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Adrian Bunk" <bunk@stusta.de>, "Aubrey" <aubreylee@gmail.com>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Apr 2006, Sam Ravnborg wrote:

> On Mon, Apr 10, 2006 at 02:04:59PM -0400, linux-os (Dick Johnson) wrote:
>
>> Can't he just put his own private compile definition in his
>> own Makefile?
>>
>> %.o:	%.S
>>  	as -o $@ $<
>
> That would never generate a module anyway. And kbuild support building
> .o from .S with all the kbuild argument chechking etc.
> Doing it so would be wrong.
>
> 	Sam
>


Really?? Here is a Makefile that has been known to work for sometime.
As you can clearly see, it has lots of ".S" files. The last compile
was on Linux-2.6.15.4. If current kernel building procedures prevents
the assembly of assembly-language files and requires that the kernel
modules be written entirely in 'C', then it is broken beyond all
belief and must be fixed.


#
#    Copyright(c) 2004  Analogic Corporation
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
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
