Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbUDPQp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUDPQp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:45:57 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:9487 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263379AbUDPQpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:45:52 -0400
Date: Fri, 16 Apr 2004 18:54:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Axel Weiss <aweiss@informatik.hu-berlin.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: compiling external modules
Message-ID: <20040416165420.GA2387@mars.ravnborg.org>
Mail-Followup-To: Axel Weiss <aweiss@informatik.hu-berlin.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200404161741.07824.aweiss@informatik.hu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404161741.07824.aweiss@informatik.hu-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 05:41:07PM +0200, Axel Weiss wrote:
> On Thursday 15 April 2004 23:59, Sam Ravnborg wrote:
> > The general feedback is that it looks like you have
> > made it less simple than it ought to be.
> >
> > You should also consider that you end up with files
> > that does not look like ordinary kbuild makefiles.
> 
> Hi, Sam,
> 
> seems you don't like my style putting things into variables ;)
> 
> Here's my latest work, I have tested this Makefile with vanilla-2.6.5, -2.6.6-rc1 and  suse-2.4.21-199 (SuSE 9.0).
> 
> Regards,
> Axel
> 
> #/***************************************************************************
> # *                                                                         *
> # *   This program is free software; you can redistribute it and/or modify  *
> # *   it under the terms of the GNU General Public License as published by  *
> # *   the Free Software Foundation; either version 2 of the License, or     *
> # *   (at your option) any later version.                                   *
> # *                                                                         *
> # ***************************************************************************/
> #
> #  Template Makefile for external module compilation
> #
> #  (C) 2004 by Axel Weiss (aweiss@informatik.hu-berlin.de)
> #
> 
> KDIR          := /lib/modules/$(shell uname -r)/build
> PWD           := $(shell pwd)
> 
> K_MAJOR := $(shell uname -r | sed -e "s/\..*//")
> K_MINOR := $(shell uname -r | sed -e "s/$(K_MAJOR)\.//" -e "s/\..*//")
> K_REV   := $(shell uname -r | sed -e "s/$(K_MAJOR)\.$(K_MINOR)\.//" -e "s/-.*//")
> 
> NEED_EXPORT := $(strip $(shell [[ "$(K_MAJOR)" = "2" \
>                                && "$(K_MINOR)" < "7" \
>                                && "$(K_REV)"   < "6" ]] && echo yes || echo no))
> 
> NEED_CLEAN  := $(strip $(shell [[ "$(K_MAJOR)" = "2" \
>                                && "$(K_MINOR)" < "7" \
>                                && "$(K_REV)"   < "6" ]] && echo yes))

What about testing for the precense of Rules.make.
If present we know it is 2.4, if not it's 2.6.

Something like:
KERNEL_26 := $(if $(wildcard $(TOPDIR)/Rules.make),0,1)
Much simpler than all the above.

Then your test would look like this:

ifeq ($(KERNEL_26),0)

export-objs := <mod-export-list>

include $(KDIR)/Rules.make

<mod-name>.o: $(<mod-name>-objs)
	$(Q)$(LD) $(LD_RFLAG) -r -o $@ $(<mod-name>-objs)
endif


And later:

> else  # ifneq ($(KERNELRELEASE),)

ifeq ($(KERNEL_26),1)

all:
	$(MAKE) -C $(KDIR) M=$(PWD)
%:
	$(MAKE) -C $(KDIR) M=$(PWD) $@

else
 
clean:
 	rm -f <mod-name>.ko *.o .*.cmd .*.o.flags <mod-name>.mod.c


Care to try mix something working out of these clues.

Thanks,
	Sam

