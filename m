Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbUDPUoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUDPUoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:44:54 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39234 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263701AbUDPUnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:43:20 -0400
Date: Fri, 16 Apr 2004 22:51:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Axel Weiss <aweiss@informatik.hu-berlin.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: compiling external modules
Message-ID: <20040416205157.GD2697@mars.ravnborg.org>
Mail-Followup-To: Axel Weiss <aweiss@informatik.hu-berlin.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200404161741.07824.aweiss@informatik.hu-berlin.de> <20040416165420.GA2387@mars.ravnborg.org> <200404162209.56651.aweiss@informatik.hu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404162209.56651.aweiss@informatik.hu-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:09:56PM +0200, Axel Weiss wrote:
> 
> Sure, but compilation with 2.6.5 would fail again, missing export-objs.
export-objs has not been needed by 2.6.*, only during earlier 2.5.*

> If I got you right, we should simplify things so that 2.6 means >= 2.6.6?
Yup.

> #  Template Makefile for external module compilation
> 
> KDIR      := /lib/modules/$(shell uname -r)/build
> PWD       := $(shell pwd)
> KERNEL_24 := $(if $(wildcard $(KDIR)/Rules.make),1,0)
> 


> ifneq ($(KERNELRELEASE),)
> 
> obj-m                    := <mod-name>.o
> <mod-name>-objs := <mod-object-list>
> 
> endif  # ifneq ($(KERNELRELEASE),)
I do not see why you need to wrap this in KERNELRELEASE.


> .PHONY: all clean
> 
> ifeq ($(KERNEL_24),1)

Hide the backward compatibility stuff in the bottom (= 2.4 stuff).
Just MO.

> ifneq ($(KERNELRELEASE),)
> 
> export-objs := <mod-export-list>
> 
> include $(KDIR)/Rules.make
> adc64_bm.o: $(<mod-name>-objs)
> 	$(Q)$(LD) $(LD_RFLAG) -r -o $@ $(<mod-name>-objs)
> else  # ifneq ($(KERNELRELEASE),)
> all:
> 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> clean:
> 	rm -f *.ko *.o .*.cmd .*.o.flags *.mod.c
> endif # ifneq ($(KERNELRELEASE),)
> 
> else  #################### ifeq ($(KERNEL_24),1)
> 
> ifeq ($(KERNELRELEASE),)
> all:
> 	$(MAKE) -C $(KDIR) M=$(PWD)
> clean:
Here you should add modules_install also.

> 	$(MAKE) -C $(KDIR) M=$(PWD) $@
> endif # ifeq ($(KERNELRELEASE),)
> 
> endif #################### ifeq ($(KERNEL_24),1)
> 
> # end of Makefile Template
> 
> I reordered the cases a bit so that
> 1. kernel-version dependend branches stay together
> 2. <mod-object-list> needs only be written once
> 
> Now everything fits on a single screen-page :)
Good!

> 
> Sam, please note two things:
> 1. the clean rule must be explicit to be recognized (GNU Make 3.80).
I had some problems with this, but I do not remeber how i solved it.


> 2. 2.6 compilation requires root privileges for compilation, 2.4 does not. 
I never ever compile as root - so something is broken here.

> Can we relax some file accesses (e.g. $(KDIR)/.__modpost.cmd and the
> local .tmp_versions) to allow non-privileged users to compile external
> modules and to be able to make clean?
I do not have a file named .__modpost.cmd???
And root should not be required??

	Sam
