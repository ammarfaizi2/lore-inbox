Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbUDPPnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUDPPnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:43:15 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:14313 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S263361AbUDPPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:43:05 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: compiling external modules
Date: Fri, 16 Apr 2004 17:41:07 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404161741.07824.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 23:59, Sam Ravnborg wrote:
> The general feedback is that it looks like you have
> made it less simple than it ought to be.
>
> You should also consider that you end up with files
> that does not look like ordinary kbuild makefiles.

Hi, Sam,

seems you don't like my style putting things into variables ;)

Here's my latest work, I have tested this Makefile with vanilla-2.6.5, -2.6.6-rc1 and  suse-2.4.21-199 (SuSE 9.0).

Regards,
Axel

#/***************************************************************************
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# ***************************************************************************/
#
#  Template Makefile for external module compilation
#
#  (C) 2004 by Axel Weiss (aweiss@informatik.hu-berlin.de)
#

KDIR          := /lib/modules/$(shell uname -r)/build
PWD           := $(shell pwd)

K_MAJOR := $(shell uname -r | sed -e "s/\..*//")
K_MINOR := $(shell uname -r | sed -e "s/$(K_MAJOR)\.//" -e "s/\..*//")
K_REV   := $(shell uname -r | sed -e "s/$(K_MAJOR)\.$(K_MINOR)\.//" -e "s/-.*//")

NEED_EXPORT := $(strip $(shell [[ "$(K_MAJOR)" = "2" \
                               && "$(K_MINOR)" < "7" \
                               && "$(K_REV)"   < "6" ]] && echo yes || echo no))

NEED_CLEAN  := $(strip $(shell [[ "$(K_MAJOR)" = "2" \
                               && "$(K_MINOR)" < "7" \
                               && "$(K_REV)"   < "6" ]] && echo yes))

.PHONY: all clean


ifneq ($(KERNELRELEASE),)

obj-m         := <mod-name>.o
<mod-name>-objs := <mod-object-list>
ifeq ($(NEED_EXPORT),yes)
export-objs := <mod-export-list>
endif # ifeq ($(NEED_EXPORT),yes)

-include $(KDIR)/Rules.make

<mod-name>.o: $(<mod-name>-objs)
	$(Q)$(LD) $(LD_RFLAG) -r -o $@ $(<mod-name>-objs)


else  # ifneq ($(KERNELRELEASE),)

all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
ifeq ($(NEED_CLEAN),yes)
	rm -f <mod-name>.ko *.o .*.cmd .*.o.flags <mod-name>.mod.c $(KDIR)/.tmp_versions/<mod-name>.mod
else
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
endif # ifeq ($(NEED_CLEAN),yes)
endif # ifneq ($(KERNELRELEASE),)


