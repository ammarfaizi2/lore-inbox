Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSBULZ3>; Thu, 21 Feb 2002 06:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292341AbSBULZV>; Thu, 21 Feb 2002 06:25:21 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:34293 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292339AbSBULZC>; Thu, 21 Feb 2002 06:25:02 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020221105612.F12BEF5B@acolyte.hack.org> 
In-Reply-To: <20020221105612.F12BEF5B@acolyte.hack.org>  <20020221000202.363E6F5B@acolyte.hack.org> 
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: SC1200 support? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Feb 2002 11:24:39 +0000
Message-ID: <14409.1014290679@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


wingel@acolyte.hack.org said:
>  Is it still possible to build modules outside of the kernel tree?  I
> really like the MTD model of building some modules where the Makefile
> looks like this: 

> ifndef TOPDIR
> TOPDIR:=$(shell cd ../linux && pwd)
> endif

Er, that's not mine, is it?

My CVS tree has no hacks in the Makefiles, but has GNUmakefiles which look
something like the one below.

The hacking of TOPDIR is for compiling in old kernels without having 
compatibility hacks in the Makefile - in the GNUmakefile I set TOPDIR to a 
directory in which I have a hacked Rules.make which sets M_OBJS from obj-m, 
sets TOPDIR back to OLDTOPDIR and includes the proper $(TOPDIR)/Rules.make.

Making this work with kbuild-2.5 so that I can just check stuff out from my 
CVS tree and type 'make' as I do at the moment is something I haven't tried 
yet.

# $Id: GNUmakefile,v 1.10 2002/01/03 15:00:54 dwmw2 Exp $

LINUXDIR=/lib/modules/$(shell uname -r)/build

ifndef VERSION

# Someone just typed 'make'

modules:
	make -C $(LINUXDIR) SUBDIRS=`pwd` modules

dep:
	make -C $(LINUXDIR) SUBDIRS=`pwd` dep

clean:
	rm -f *.o */*.o

else



ifndef CONFIG_MTD

# We're being invoked outside a normal kernel build. Fake it

# We add to $CC rather than setting EXTRA_CFLAGS because the local 
# header files _must_ appear before the in-kernel ones. 
CC += -I$(shell pwd)/../../include

CONFIG_MTD := m
CONFIG_MTD_PARTITIONS := m
CONFIG_MTD_REDBOOT_PARTS := m
#CONFIG_MTD_BOOTLDR_PARTS := m
CONFIG_MTD_AFS_PARTS := m
CONFIG_MTD_CHAR := m
CONFIG_MTD_BLOCK := m
CONFIG_FTL := m
CONFIG_NFTL := m

CFLAGS_nftl.o := -DCONFIG_NFTL_RW

endif

# Normal case - build in-kernel

ifeq ($(VERSION),2)
 ifneq ($(PATCHLEVEL),4)
  ifneq ($(PATCHLEVEL),5)
   OLDTOPDIR := $(TOPDIR)
   TOPDIR := $(shell pwd)
  endif
 endif
endif

ifeq ($(VERSION),2)
 ifeq ($(PATCHLEVEL),0)
   obj-y += initcalls.o
  endif
endif

include Makefile

endif

--
dwmw2


