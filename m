Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRDHXBg>; Sun, 8 Apr 2001 19:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRDHXB0>; Sun, 8 Apr 2001 19:01:26 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:57616 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131275AbRDHXBL>;
	Sun, 8 Apr 2001 19:01:11 -0400
Date: Mon, 9 Apr 2001 01:01:03 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build -->/usr/src/linux
Message-ID: <20010409010103.A16562@pcep-jamie.cern.ch>
In-Reply-To: <3AD079EA.50DA97F3@rcn.com> <20010408161620.A21660@flint.arm.linux.org.uk> <3AD0A029.C17C3EFC@rcn.com> <9aqmci$gn2$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9aqmci$gn2$1@ncc1701.cistron.net>; from miquels@cistron-office.nl on Sun, Apr 08, 2001 at 09:49:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> .. but there should be a cleaner way to get at the CFLAGS used
> to compile the kernel.

There is a way though I'd not call it clean.  Here is an extract from
the Makefile I am using for separately-distributed modules.  It should
work with kernels 2.0 to 2.4, all supported architectures.

include $(KERNEL_SOURCE)/.config

CPPFLAGS := -DMODULE -D__KERNEL__ -nostdinc -I$(KERNEL_SOURCE)/include
CPPFLAGS += -I$(shell gcc -print-file-name=include)
CFLAGS	 := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
AFLAGS	 := -D__ASSEMBLY__ $(CPPFLAGS)

# For older kernels.
ifneq (,$(strip $(shell grep '^[ 	]*SMP[ 	]*:\?=[ 	]*[^ 	]' $(KERNEL_SOURCE)/Makefile)))
CONFIG_SMP=y
endif
ifdef CONFIG_SMP
CFLAGS += -D__SMP__
AFLAGS += -D__SMP__
endif

include $(KERNEL_SOURCE)/arch/$(ARCH)/Makefile

CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)
