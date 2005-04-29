Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVD2Vnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVD2Vnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbVD2Vnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:43:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49422 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263014AbVD2VmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:42:21 -0400
Date: Fri, 29 Apr 2005 22:42:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
Subject: Re: [PATCH] preserve ARCH and CROSS_COMPILE in the build directory generated Makefile
Message-ID: <20050429224212.G30010@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kai@germaschewski.name
References: <200504291335.34210.pisa@cmp.felk.cvut.cz> <20050429210053.GC8699@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050429210053.GC8699@mars.ravnborg.org>; from sam@ravnborg.org on Fri, Apr 29, 2005 at 11:00:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 11:00:53PM +0200, Sam Ravnborg wrote:
> On Fri, Apr 29, 2005 at 01:35:33PM +0200, Pavel Pisa wrote:
> > This patch ensures, that architecture and target cross-tools prefix
> > is preserved in the Makefile generated in the build directory for
> > out of source tree kernel compilation. This prevents accidental
> > screwing of configuration and builds for the case, that make without
> > full architecture specific options is invoked in the build
> > directory. It is secure use accustomed "make", "make xconfig",
> > etc. without fear and special care now.
> 
> Hi Pavel.
> I will not apply this path because it introduce a difference when
> building usign a separate output direcory compared to an in-tree build.
> 
> I have briefly looked into a solution where I could add this information
> in .config but was sidetracked by other stuff so I newer got it working.
> 
> The build system for the kernel needs to be as predictable as possible
> and introducing functionality that is only valid when using a separate
> output directory does not help here.

Without it, folk will then do (and this is taken from someone elses
example):

  cd /usr/src
  tar -xjf /path/to/linux-2.6.x.tar.bz
  cd linux-2.6.x
  mkdir -p _build/arm
  cd _build/arm
  cat >GNUmakefile <<EOF
VERSION = 2
PATCHLEVEL = 6
                                                                                
KERNELSRC    := /usr/src/linux-2.6.x
KERNELOUTPUT := /usr/src/linux-2.6.x/_build/arm
                                                                                
MAKEFLAGS += --no-print-directory
                                                                                
ARCH            = arm
#CROSS_COMPILE  = arm-unknown-linux-gnu-
CROSS_COMPILE   = arm-linux-
                                                                                
all:
        $(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNELSRC) O=$(KERNELOUTPUT)
                                                                                
%::
        $(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNELSRC) O=$(KERNELOUTPUT) $@
EOF
  make xconfig
  make

which I think you'll agree is far worse.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
