Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUDLKbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUDLKbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:31:42 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:26362 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262766AbUDLKbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:31:39 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: linux-kernel@vger.kernel.org
Subject: Re: kernelversion distinction
Date: Mon, 12 Apr 2004 12:21:44 +0200
User-Agent: KMail/1.5.4
References: <200404111327.19744.aweiss@informatik.hu-berlin.de> <200404112033.20025.aweiss@informatik.hu-berlin.de> <20040411203315.GA2170@mars.ravnborg.org>
In-Reply-To: <20040411203315.GA2170@mars.ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404121221.44431.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 April 2004 22:33, Sam Ravnborg wrote:
> > Any improvements? Up to which kernel version should old style make be
> > used?
>
> You cannot use same Makefile for both 2.4 and 2.6?
>
> Using the syntax:
> make -C $KERNELSRC SUBDIRS=$PWD modules
>
> should allow you to do that if there is no special requirements.
> The Makefile should be an ordinary kbuild Makefile in this case:
>
> obj-m := module.o
> module-objs := mod1.o mod2.o
> etc..
>
> Another approach would be to keep two Makefiles, one for 2.4, another
> for 2.6. Default could be Makefile (for 2.6) and Makefile.24 for older
> kernels. This makes much less conditionals.

Ok, maybe there's some misunderstanding due to copy-n-paste-mistakes I made in 
my former mail.

As I suppose my device drivers will not become part of the official kernel, I 
keep them with my project. My opinion now is to use one Makefile for both, 
2.2-2.4 and 2.6 kernels, and to keep this Makefile simple.

Maybe, I'm not the first one who tries this, or maybe others would find it 
useful - that's the reason why I want to discuss this topic here. (If I'm OT, 
please let me know).

Ok, to become more detailed, I repost my current solution (which seems to work 
for both, 2.4 and 2.6). My question here focusses on the beginning, where I 
distinguish the kernel versions by evaluating 'uname -r' and defining five 
symbols. Is there a more effective way to do it, or is there a danger to 
conflict with the symbol names I chose?

# Makefile
KERNELVERSION := $(shell uname -r)
KERNELBASE    := $(basename $(KERNELVERSION))
KERNELMINOR   := $(suffix $(KERNELBASE))
KERNELMAJOR   := $(basename $(KERNELBASE))

OLD_MODULES := $(strip $(foreach V, .0 .1 .2 .3 .4, $(shell [ "$(V)" = 
"$(KERNELMINOR)" ] && echo yes)))

ifeq ($(KERNELMAJOR),2)
ifeq ($(OLD_MODULES),yes)
#	old style here:
# ...
all:	# ...
clean:
#...
else #ifeq ($(OLD_MODULES),yes)
#	new style here:

ifneq ($(KERNELRELEASE),)
EXTRA_CFLAGS := -I/usr/include
obj-m         += <my_module>.o
<my_module>-objs = <my module object files>

else #ifneq ($(KERNELRELEASE),)

KDIR        := /lib/modules/$(shell uname -r)/build
PWD         := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -f *.o *.ko .*.cmd <my_module>.mod.c

endif #ifneq ($(KERNELRELEASE),)
endif #ifeq ($(OLD_MODULES),yes)
else #ifeq ($(KERNELMAJOR),2)
#	don't want to support 1.x
all:
	@echo kernel $(KERNELVERSION) not supported
endif #ifeq ($(KERNELMAJOR),2)

BTW: I get a warning:
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
(which I silently ignore...)

Regards,
Axel Weiss

