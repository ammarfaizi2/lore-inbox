Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWABOxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWABOxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWABOxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:53:15 -0500
Received: from mclmx.mail.saic.com ([149.8.64.10]:59049 "EHLO
	mclmx.mail.saic.com") by vger.kernel.org with ESMTP
	id S1750700AbWABOxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:53:14 -0500
Message-Id: <1136213489.3483.18.camel@hadji>
From: "Puvvada, Vijay B." <VIJAY.B.PUVVADA@saic.com>
Reply-To: "Puvvada, Vijay B." <vijay.b.puvvada@saic.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Make system and linking static libraries on kernel version
	s2.6.14+
Date: Mon, 2 Jan 2006 09:51:29 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

This is a "I'm stumped kind of problem" and desperately need some
guidance with regards to the kernel make system..

I had also started a thread at 
http://forums.fedoraforum.org/showthread.php?p=428551#post428551 with
regards to this, where I describe the context of the problem.  

In a nutshell, I am trying to compile the Nortel VPN client (which is
written as part driver and part app) against the 2.6.14 kernel and I am
getting the following warning. 

Warning: could not
find /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../.libmishim-2.6.a.cmd
for /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../libmishim-2.6.a

For some reason, the kernel make system does not seem to know what to do
with static libraries.  It doesn't seem to create a .cmd for these
files.

1.  Is this a normal warning when trying to link in static libraries
with the kernel make system?  ie, the kernel make system does not create
a .cmd file for static libraries/archives.

2.  Do they all still get linked in or is this a real problem?  It seems
to warn on the first static library so I am assuming the rest of the
line is just abandoned.  Is this a correct interpretation?

3.  How can I clean up the warning?  Is there a proper way to specify
static libraries to the kernel make system?

So far as I can tell, this is an interaction between the kernel make
system and the application I have and not distro-specific.  

If you require any information, please do not hesitate to ask.

Vij

The full makefile for the kernel driver portion is below:


Makefile:
obj-m         += mishim.o nlvcard.o
mishim-libs   += ../libmishim-2.6.a ../libnlcmp.a ../libz.a ../liblzs.a
mishim-c-objs += linux_wrapper.o
mishim-objs   += $(mishim-c-objs) $(mishim-libs)

EXTRA_CFLAGS += -fno-common -w

ifeq ($(KERNELRELEASE),)

KVER            = $(shell uname -r)

ifeq (1,1)
KDIR            = /lib/modules/$(KVER)/build
else
KDIR            = /usr/src/linux-$(KVER)
endif

PWD             = $(shell pwd)

mishim-cfiles = ${mishim-c-objs:.o=.c}


kmod_build:: $(mishim-libs) $(mishim-cfiles)
        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
        @cp mishim.ko ../mishim.o
        @cp nlvcard.ko ../nlvcard.o

%.c:
        @ln -s ../linux_wrapper.c

clean:
        -rm -rf *.o *.ko *.mod.* .??*

install: all
        @echo "Installing VPN agent."
        cd .. &&  ./install.sh

uninstall: 
        @echo "Uninstalling VPN agent."
        cd .. && ./uninstall.sh

endif
