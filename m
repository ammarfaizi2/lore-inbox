Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUDLPCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUDLPCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:02:35 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:12503 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262257AbUDLPBj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:01:39 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: linux-kernel@vger.kernel.org
Subject: Re: kernelversion distinction
Date: Mon, 12 Apr 2004 16:51:39 +0200
User-Agent: KMail/1.5.4
References: <20040412132009.0D15415C20@post1.dk>
In-Reply-To: <20040412132009.0D15415C20@post1.dk>
Cc: sam@ravnborg.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404121651.39075.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 12. April 2004 15:20 schrieb sam@ravnborg.org:
> Date: Man, 12 Apr 2004 12:21:44 +0200 skrev Axel Weiss <aweiss@informatik.hu-berlin.de> :
> Why you cannot use the same Makefile for 2.4 and 2.6?
On SuSE-9.0 the build simply fails:

rantanplan:/home/axel/freeSP-1.0.3 # make -C drivers/linux/harmonie/
make: Entering directory `/home/axel/freeSP-1.0.3/drivers/linux/harmonie'
make -C driver all
make[1]: Entering directory `/home/axel/freeSP-1.0.3/drivers/linux/harmonie/driver'
make -C /lib/modules/2.4.21-199-axel/build SUBDIRS=/home/axel/freeSP-1.0.3/drivers/linux/harmonie/driver modules
make[2]: Entering directory `/usr/src/linux-2.4.21-199'
make -C  /home/axel/freeSP-1.0.3/drivers/linux/harmonie/driver CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.21-199/include  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -fno-unit-at-a-time -pipe -msoft-float -mpreferred-stack-boundary=2 -march=athlon -DMODULE" MAKING_MODULES=1 modules
make[3]: Entering directory `/home/axel/freeSP-1.0.3/drivers/linux/harmonie/driver'
make[3]: *** Keine Regel, um »modules« zu erstellen.  Schluss.
make[3]: Leaving directory `/home/axel/freeSP-1.0.3/drivers/linux/harmonie/driver'
make[2]: *** [_mod_/home/axel/freeSP-1.0.3/drivers/linux/harmonie/driver] Fehler 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-199'
make[1]: *** [all] Fehler 2
make[1]: Leaving directory `/home/axel/freeSP-1.0.3/drivers/linux/harmonie/driver'
make: *** [module] Fehler 2
make: Leaving directory `/home/axel/freeSP-1.0.3/drivers/linux/harmonie'

>
> A simple Makefile like you outline:
> >EXTRA_CFLAGS := -I/usr/include
> >obj-m	       += <my_module>.o
> ><my_module>-objs = <my module object files>
>
> Will work flawlessly with both 2.4 and 2.6.
> I know people for a long time have hardcoded the gcc commandline
> to build modules for 2.4 - but thats just wrong.
> In this way you do not catch differences in gcc options.
> For 2.4 we have seen only few of these config related flags to gcc,
> in 2.6 we have a lot.
>
> Please next time post the full Makefile.
(see eom)
>
> Btw, a module that is dependent on /usr/include looks wrong...
This is because I include the ioctl-definitions, and I put them to /usr/include/dsp, so the kernel module and user-space-lib see the identical file.
Perhaps it would be better to include the local source (in this case ../system_include), I will think over it.

> >clean:
> >	 rm -f *.o *.ko .*.cmd <my_module>.mod.c
>
> For the new external module support implemented in -mc4 you
> do not have to hardcode the clean: target, and no attempts will
> be made to update the kernel stuff.
> Documentation soon to arrive...
Do you think, it would be better to write
clean:
	$(MAKE) -C  $(KDIR) SUBDIRS=$(PWD) clean
?

There are still some inconsistencies, especially when I try to compile a second module. I will investigate this tonight and post cognitions here.

The next problem arises when I have to ditinguish the kernel version within C source. For now I do it like this:
// fw-declaration of /proc-read functions:
#ifdef LINUX_VERSION_CODE
#if LINUX_VERSION_CODE <= KERNEL_VERSION(2, 4, 18)
int harmonie_read_proc(char *buf, char **start, off_t offset, int len, int unused);
#else	// 2.4.19 ... < 2.5
int harmonie_read_proc(char *buf, char **start, off_t offset, int cnt, int *eof, void *data);
#endif
#else	// >= 2.5
int harmonie_read_proc(char *buf, char **start, off_t offset, int cnt, int *eof, void *data);
#endif

This looks really ugly, so what is the recommended way to get kernel version information? As the interface for ISRs has changed, too, there is a need for getting kernel version at compile time.

For now, I have a running module for 2.2 - 2.6 :)

Now the complete Makefile:

# ***************************************************************************
#                          makefile  -  description
#
#   This is the harmonie device driver makefile.
#
#                             -------------------
#    begin                : Wed May 29 2002
#    copyright            : (C) 2002 by Axel Weiss
#    email                : aweiss@informatik.hu-berlin.de
# ***************************************************************************/
#
# ***************************************************************************
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# ***************************************************************************/


KERNELVERSION := $(shell uname -r)
KERNELBASE    := $(basename $(KERNELVERSION))
KERNELMINOR   := $(suffix $(KERNELBASE))
KERNELMAJOR   := $(basename $(KERNELBASE))

OLD_MODULES := $(strip $(foreach V, .0 .1 .2 .3 .4, $(shell [ "$(V)" = "$(KERNELMINOR)" ] && echo yes)))

ifeq ($(KERNELMAJOR),2)
ifeq ($(OLD_MODULES),yes)	# old style make

DEBUG := yes

CC := gcc

SOURCES := $(wildcard *.c)
HEADERS := $(wildcard *.h)
OBJS := $(SOURCES:%.c=%.o)

CC_FLAGS := -c -Wall -I/lib/modules/`uname -r`/build/include -DMODULE -D__KERNEL__
ifeq ($(DEBUG),yes)
	CC_FLAGS += -DHARMONIE_DEBUG
endif

all: harmonie.o

harmonie.o: $(OBJS)
	$(LD) -r -o $@ $(OBJS)

$(OBJS): %.o:%.c
	$(CC) $(CC_FLAGS) $<

$(OBJS): $(HEADERS) $(SYSTEM_HEADERS_INSTALL)

clean:
	@rm -f $(OBJS) *% *.bak harmonie.o

else #ifeq ($(OLD_MODULES),yes)	new style make

ifneq ($(KERNELRELEASE),)

EXTRA_CFLAGS := -I/usr/include
obj-m         += harmonie.o
harmonie-objs = harmonie_buffer.o harmonie_device.o harmonie_module.o harmonie_procio.o harmonie_io.o

else #ifneq ($(KERNELRELEASE),)

KDIR        := /lib/modules/$(shell uname -r)/build
PWD         := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -f *.o *.ko .*.cmd harmonie.mod.c

endif #ifneq ($(KERNELRELEASE),)
endif #ifeq ($(OLD_MODULES),yes)

else #ifeq ($(KERNELMAJOR),2)	# kernel 1.x ?

all:
	@echo kernel $(KERNELVERSION) not supported

endif #ifeq ($(KERNELMAJOR),2)

