Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbUDPUPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUDPUPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:15:23 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:451 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S263675AbUDPULw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:11:52 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: compiling external modules
Date: Fri, 16 Apr 2004 22:09:56 +0200
User-Agent: KMail/1.5.4
References: <200404161741.07824.aweiss@informatik.hu-berlin.de> <20040416165420.GA2387@mars.ravnborg.org>
In-Reply-To: <20040416165420.GA2387@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404162209.56651.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. April 2004 18:54 schrieb Sam Ravnborg:
> On Fri, Apr 16, 2004 at 05:41:07PM +0200, Axel Weiss wrote:
> What about testing for the precense of Rules.make.
> If present we know it is 2.4, if not it's 2.6.
>
> Something like:
> KERNEL_26 := $(if $(wildcard $(TOPDIR)/Rules.make),0,1)
> Much simpler than all the above.

Sure, but compilation with 2.6.5 would fail again, missing export-objs.
If I got you right, we should simplify things so that 2.6 means >= 2.6.6?

So, the following is tested on 2.6.6-rc1 and suse-2.4.21-199:

#  Template Makefile for external module compilation

KDIR      := /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)
KERNEL_24 := $(if $(wildcard $(KDIR)/Rules.make),1,0)

ifneq ($(KERNELRELEASE),)

obj-m                    := <mod-name>.o
<mod-name>-objs := <mod-object-list>

endif  # ifneq ($(KERNELRELEASE),)

.PHONY: all clean

ifeq ($(KERNEL_24),1)
ifneq ($(KERNELRELEASE),)

export-objs := <mod-export-list>

include $(KDIR)/Rules.make
adc64_bm.o: $(<mod-name>-objs)
	$(Q)$(LD) $(LD_RFLAG) -r -o $@ $(<mod-name>-objs)
else  # ifneq ($(KERNELRELEASE),)
all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
clean:
	rm -f *.ko *.o .*.cmd .*.o.flags *.mod.c
endif # ifneq ($(KERNELRELEASE),)

else  #################### ifeq ($(KERNEL_24),1)

ifeq ($(KERNELRELEASE),)
all:
	$(MAKE) -C $(KDIR) M=$(PWD)
clean:
	$(MAKE) -C $(KDIR) M=$(PWD) $@
endif # ifeq ($(KERNELRELEASE),)

endif #################### ifeq ($(KERNEL_24),1)

# end of Makefile Template

I reordered the cases a bit so that
1. kernel-version dependend branches stay together
2. <mod-object-list> needs only be written once

Now everything fits on a single screen-page :)

Sam, please note two things:
1. the clean rule must be explicit to be recognized (GNU Make 3.80).
2. 2.6 compilation requires root privileges for compilation, 2.4 does not. 
Can we relax some file accesses (e.g. $(KDIR)/.__modpost.cmd and the
local .tmp_versions) to allow non-privileged users to compile external
modules and to be able to make clean?

Regards,
Axel


