Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUKCOsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUKCOsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKCOsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:48:47 -0500
Received: from alog0386.analogic.com ([208.224.222.162]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261608AbUKCOsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:48:42 -0500
Date: Wed, 3 Nov 2004 09:48:20 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: "H. Wiese" <7.e.Q@syncro-community.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IP Layer on VME-Bus
In-Reply-To: <33093.192.35.17.30.1099489553.squirrel@config.hostunreachable.de>
Message-ID: <Pine.LNX.4.61.0411030920180.12549@chaos.analogic.com>
References: <33093.192.35.17.30.1099489553.squirrel@config.hostunreachable.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, H. Wiese wrote:

> Hello,
>
> we develop a driver which enables us to use an ip layer on top of the vme-bus
> technology. Now we got some problems with coding the driver. We already have
> an old version of this driver (called "dpn") which works well but has no use
> for us anymore since we upgraded our system from kernel 2.2.14 to 2.6.7. So
> now we have to create a new driver.
>
> The old driver established the ip layer by accessing the dual port ram of
> the VME bus, which is based on a Tundra Universe II Chipset. This enables
> us to transfer data, ping etc. between active VME-modules using the
> VME-bus. Very useful.
>
> Well, the problem we will surely run into is: will the driver work as fine as
> the old one if we only recreate the initialization functions working with the
> new kernel function set (e.g. wait_event_interruptible instead of
> interruptible_sleep_on etc.), copy the essential functions from the old
> driver
> to the new one and alter them a little to work with the new kernel functions?
> Or is there anything else to put an eye on?
>
>
> Thankx a lot
>
> kind regards
> Hendrik

I had a lot of 2.4.x drivers I had to convert to 2.6.x. It is
possible to re-do the source code so that the two drivers will
compile and run on both versions. There have been several
important changes, but it's not too hard.

If your old driver is in good shape, I'd suggest you just
try to compile it using:

LD = ld
VER := $(shell uname -r)
TOP = /usr/src/linux-$(VER)/include
INC = -I$(TOP) -I/usr/src/linux-$(VER)/include/asm/mach-default
DEF = -D__KERNEL__ -DMODULE -DCONFIG_SMP
OPT = -fomit-frame-pointer -pipe -nostartfiles -Wstrict-prototypes \
       -fno-strict-aliasing
CC = gcc -Wall -O2 -I. $(INC) $(DEF) $(OPT)

... for the Makefile $(CC). This will not get you a module type
of module.ko, that's another step that uses the new kernel build
procedure (takes 60 seconds to modify your Makefile to do the
build).  The important thing it to get everything to compile
first. Any code that uses "#include <myfile.h>" where myfile
is in the local directory, needs to be changed to "myfile.h"
because the kernel build procedure doesn't propagate -I. for
include search paths.

Note the additional search path, above....

When you encounter an error, check with the new drivers in
the kernel to see what the new parameters are.

(1) ISR now takes a return value.
(2) mmap() is slightly different, requires additional parameter.
(3) MOD_INC/MOD_DEC  macros go away.
(4) Some PCI stuff, slightly different, need to check some return values
     even when it's implicit.
(5) struct file_operations has new member(s) first is 'owner',
     use macro THIS_MODULE.
(6) Kernel daemon start code is slightly different, daemonize() takes
     parameters and does most everything.
(7) Timer-queues slightly different, macros provided (easier).
(N) A few other kinks. I would guess that if the previous module
     was written properly, it would take less than an hour to
     update it.

FYI, I also used the Tundra chip for some VXI stuff. It
requires you to select an area in memory with no RAM for its
address area so its not very straight-forward. If your
previous stuff worked okay, you won't have problems with
the new kernels because they, too, allow you to hard-code
address-space that the kernel isn't using. You need to
make sure that there is such address-space available, i.e.,
you can't use 4 gigs (or more) of RAM!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
