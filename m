Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269846AbRHDKa7>; Sat, 4 Aug 2001 06:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269849AbRHDKai>; Sat, 4 Aug 2001 06:30:38 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:24845 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269846AbRHDKaf>;
	Sat, 4 Aug 2001 06:30:35 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: sjhill@cotw.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Building multipart modules with subdirectories... 
In-Reply-To: Your message of "Fri, 03 Aug 2001 13:40:14 EST."
             <3B6AF00E.C66F69DE@cotw.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Aug 2001 20:30:37 +1000
Message-ID: <32336.996921037@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001 13:40:14 -0500, 
"Steven J. Hill" <sjhill@cotw.com> wrote:
>I have driver that is rather complex and in order to maintain it, the
>module is broke up into 17 different subdirectories. I am maintaining it
>and I am trying to integrate it into the kernel build system.

I had the same problem with XFS.  Code split over multiple directories,
code in the sub directories had to be compiled for modules but not be
installed as a module, instead the sub directory objects are linked
into the parent directory then the whole is installed as one module.
Is that your problem?

In the parent Makefile

--------

O_TARGET := foo.o
obj-m := $(O_TARGET)
foo_subdirs := sub directory list
subdir-$(CONFIG_FOO_DRV) += $(foo_subdirs)
obj-y += $(foreach dir,$(foo_subdirs),$(dir)/$(dir).o)
....
include $(TOPDIR)/Rules.make

# This is really nasty, but Rules.make was never designed for multi directory
# modules and it can race on parallel build.  Keith Owens.
foo.o: $(patsubst %,_modsubdir_%,$(subdir-m))

--------

In each sub directory

--------

O_TARGET := $(notdir $(CURDIR)).o
ifneq ($(MAKECMDGOALS),modules_install)
  obj-m := $(O_TARGET)
endif
obj-y += list of sub directory objects

--------

This is so much easier in kbuild 2.5 :).

