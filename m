Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUDOVRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUDOVRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:17:51 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:16126 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262382AbUDOVPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:15:16 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: compiling external modules
Date: Thu, 15 Apr 2004 23:05:49 +0200
User-Agent: KMail/1.5.4
Organization: Humboldt-Universitaet zu Berlin
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404152305.49456.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after some study of kernel Makefiles, I'm able now to compile externel modules 
for both, 2.4 and 2.6 kernels correctly. I'd like to share my Makefiles here, 
maybe somebody finds them useful.

Starting point was http://lwn.net/Articles/driver-porting/ which provides very 
good and useful information. But there were some difficulties which I briefly 
describe:

2.6-compilation of drivers consisting of more than one module leaded to very 
ugly warnings from scripts/Makefile.modpost, when make was invoked after 
'make clean'. The reason were lying-around objects in .tmp_versions directory 
which were not deleted by 'make clean'. Solution: clean must explicitly 
delete the version-object in .tmp_versions.

2.4-compilation requires inclusion of Rules.make and an additional rule for 
module-object linkage. In 2.6 Rules.make does not exist, and the linking rule 
would conflict with an already defined one. Solution: distinct current kernel 
version.

When I gave the rule:
clean:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
the whole kernel tree was cleaned. This is not my intention, when I'm working 
on external modules and want to make clean e.g. for cvs commits. So I defined 
my own clean rule, kicking away everything but source files.

So far the difficulties. Next I propose an assumption about filenames, when a 
module consists of several objects which will be linked together. Let 
<module-name> be a basic name for the module, so <module-name>.(k)o (with k 
for 2.6, without for 2.4) will be the final target. I assume that all 
elementary object-filenames begin with <module-name>, for clarification. E.g. 
the module adc64.ko is composed of adc64_module.o, adc64_device.o, adc64_io.o 
and so on. Generally, the name of an object is <module-name>_<object-name>.o,
and the object-names can be collected in a symbol <module-name>-obj-names. 
Some objects may export symbols to other modules, they can be collected in a 
<module-name>-exp-names list.

Finally, all the modules' Makefiles were very similar, so I split them into 
two files: one Makefile for every module and a common Makefile.module which 
is included by each Makefile. Each module-specific Makefile contains the 
definition of
- <module-name>
- <module-name>-obj-names
- <module-name>-exp-names
- EXTRA_CFLAGS
which makes up all information Makfile.module needs.

Here is my solution:

Module-specific Makefile example: adc64-Makefile

#/***************************************************************************
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# ***************************************************************************/
#
#/*
# *  (C) 2004 by Axel Weiss (aweiss@informatik.hu-berlin.de)
# */

MOD_NAME := adc64

ifeq ($($(MOD_NAME)_PWD),)
export $(MOD_NAME)_PWD := $(shell pwd)
endif

$(MOD_NAME)-obj-names := device io mailbox module ringbuffer talker
#$(MOD_NAME)-exp-names := not defined (no symbols exported here)
EXTRA_CFLAGS  := -I$($(MOD_NAME)_PWD)/../include \
		$(if $(ADC64_DEBUG),-DADC64_DEBUG,)

include ../../Makefile.module	#Path to Makefile.module

#*****************************************************************************

Makefile.module:

#/***************************************************************************
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# ***************************************************************************/
#
#/*
# *  (C) 2004 by Axel Weiss (aweiss@informatik.hu-berlin.de)
# */

KERNELVERSION := $(shell uname -r)
KDIR          := /lib/modules/$(KERNELVERSION)/build
PWD           := $(shell pwd)

KERNELBASE    := $(basename $(KERNELVERSION))
KERNELMINOR   := $(suffix $(KERNELBASE))
KERNELMAJOR   := $(basename $(KERNELBASE))
KERNELMINOR_0_3   := $(strip $(foreach V, .0 .1 .2 .3, $(shell [ "$(V)" = \ 
			"$(KERNELMINOR)" ] && echo yes)))
KERNELMINOR_4_5   := $(strip $(foreach V, .4 .5, $(shell [ "$(V)" = \ 
			"$(KERNELMINOR)" ] && echo yes)))

.PHONY: all clean

ifeq ($(KERNELMAJOR),2)
ifeq ($(KERNELMINOR_0_3),yes)

all:
	@echo *** kernel $(KERNELVERSION) not supported
	@echo     please upgrade to kernel 2.4 or newer

else  # ifeq ($(KERNELMINOR_0_3),yes)

ifneq ($(KERNELRELEASE),)

obj-m      = $(MOD_NAME).o
$(MOD_NAME)-objs := $($(MOD_NAME)-obj-names:%=$(MOD_NAME)_%.o)
export-objs := $($(MOD_NAME)-exp-names:%=$(MOD_NAME)_%.o)

ifeq ($(KERNELMINOR_4_5),yes)

include $(KDIR)/Rules.make

$(MOD_NAME).o: $($(MOD_NAME)-objs)
	$(Q)$(LD) $(LD_RFLAG) -r -o $@ $($(MOD_NAME)-objs)

endif # ifeq ($(KERNELMINOR_4_5),yes)
else  # ifneq ($(KERNELRELEASE),)

all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
#	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
	rm -f $(MOD_NAME).ko *.o .*.cmd .*.o.flags $(MOD_NAME).mod.c 
$(KDIR)/.tmp_versions/$(MOD_NAME).mod

endif # ifneq ($(KERNELRELEASE),)
endif # ifeq ($(KERNELMINOR_0_3),yes)
else  # ifeq ($(KERNELMAJOR),2)

all:
	@echo *** kernel $(KERNELVERSION) not supported
	@echo     please upgrade to kernel 2.4 or newer

endif #ifeq ($(KERNELMAJOR),2)

#*****************************************************************************

Regards,
Axel



