Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUDPX0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUDPX0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:26:43 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:62967 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S261186AbUDPX0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:26:40 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: compiling external modules
Date: Sat, 17 Apr 2004 01:24:33 +0200
User-Agent: KMail/1.5.4
References: <200404161741.07824.aweiss@informatik.hu-berlin.de> <200404162209.56651.aweiss@informatik.hu-berlin.de> <20040416205157.GD2697@mars.ravnborg.org>
In-Reply-To: <20040416205157.GD2697@mars.ravnborg.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404170124.33903.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 22:51, Sam Ravnborg wrote:
> On Fri, Apr 16, 2004 at 10:09:56PM +0200, Axel Weiss wrote:
> > 2. 2.6 compilation requires root privileges for compilation, 2.4 does
> > not.
>
> I never ever compile as root - so something is broken here.

Oh, yes! This is the old weird thing! SuSE uses to install kernel sources
in /usr/src, and I blindly followed :( fixed now :).

So, finally, we have a nice Makefile suitable for 2.4 and 2.6 (>= 2.6.6) kernels:

#/***************************************************************************
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# ***************************************************************************/
#
#  (C) 2004 by Axel Weiss (aweiss@informatik.hu-berlin.de)
#
#
#  Template Makefile for external module compilation
#
#  replace <mod-name> with the prefix of the target module
#  replace <mod-object-list> with the list of object files to be linked together
#  replace <mod-export-list> with all symbol-exporting object filenames
#  additionally specify EXTRA_CFLAGS, if needed
#

KDIR      := /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)
KERNEL_24 := $(if $(wildcard $(KDIR)/Rules.make),1,0)

obj-m           := <mod-name>.o
<mod-name>-objs := <mod-object-list>

.PHONY: all clean modules_install

ifeq ($(KERNEL_24),0)
ifeq ($(KERNELRELEASE),)
all:
	$(MAKE) -C $(KDIR) M=$(PWD)
clean modules_install:
	$(MAKE) -C $(KDIR) M=$(PWD) $@
endif # ifeq ($(KERNELRELEASE),)

else  ### ifeq ($(KERNEL_24),0)

ifneq ($(KERNELRELEASE),)

export-objs := <mod-export-list>

include $(KDIR)/Rules.make
adc64_bm.o: $(<mod-name>-objs)
	$(Q)$(LD) $(LD_RFLAG) -r -o $@ $(<mod-name>-objs)
else  # ifneq ($(KERNELRELEASE),)
all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
modules_install:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) $@
clean:
	rm -f *.ko *.o .*.cmd .*.o.flags *.mod.c
endif # ifneq ($(KERNELRELEASE),)
endif ### ifeq ($(KERNEL_24),0)
# end of Makefile Template

Regards, thanks for your helpful advice and

have a nice weekend,

Axel

