Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313766AbSDPQtK>; Tue, 16 Apr 2002 12:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313767AbSDPQtJ>; Tue, 16 Apr 2002 12:49:09 -0400
Received: from air-2.osdl.org ([65.201.151.6]:55689 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S313766AbSDPQtI>;
	Tue, 16 Apr 2002 12:49:08 -0400
Date: Tue, 16 Apr 2002 09:46:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8
In-Reply-To: <200204161555.g3GFtmH03317@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0204160911200.848-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I haven't done anything about the other half of i386/arch reform which is 
> splitting the PC directory up into bus types, but I believe Patrick Mochel is 
> thinking about this.

Not necessarily bus types, but close. 

I've done three sets of cleanups in the arch/i386/kernel/ directory:

- x86 CPU
- mtrr
- PCI 

Each one does similar things to those drivers: moves the support into 
subdirectories, and splits the monolithic files into platform-specific 
modules. 

Doing this has several advantages:

- Only the code for your platform gets compiled in
- Resulting code has fewer conditional compilation constructs 
- Resulting code is more extensible and modular 
- Fewer confliciting changes in files with mulitple contributors.
- It's easier to figure out what the heck is going on


The main motivation behind this has been the PCI driver, especially with 
the numerous conflicting changes that I've seen both personally, and with 
the various ACPI and NUMA changes.  I've been wanting to do something like 
this for about a year. About a month ago, I finally just sat down and did 
it. 

The patches can all be found at 

http://kernel.org/pub/linux/kernel/people/mochel/patches/

Unfortunately, maintaining these massive changes is time consuming, and 
conflicting with other goals and timelines. The only one I really care 
about is the PCI driver. I've had a chance to up-port it to 2.5.8, and 
should work for most people (though I've only tested it on single and dual 
x86 boxes w/o ACPI support)

The CPU cleanups are against ~2.5.6, and most likely won't apply to the 
current tree. Conflicts tend to be obvious, and easily fixable, if anyone 
is willing to up-port it. 

Ditto for the mtrr driver, though it's pretty stale (~1 month old), and 
likely to have more conflicts. 

If there is serious interest, I'll up-port them to the latest kernel and 
export BK trees. 


One issue that I encountered along the way was arch/i386/kernel/Makefile. 
I found that you can't easily build multiple targets in the same 
directory, and have dependencies for one target in subdirectories. 
Typically, target objects have one or the other. 

In order to make this work, I had to do:

-all: kernel.o head.o init_task.o
+all: first_rule kernel.o head.o init_task.o

...

+kernel-subdir-$(CONFIG_PCI)    += pci
+subdir-y                       := $(kernel-subdir-y)
+obj-y                          += $(foreach dir,$(subdir-y),$(dir)/$(dir).o)


The last part is decent, but the explicit dependency on the first_rule 
target is kinda gross. Is there a better way to do this? Will kbuild 2.5 
make this nicer?


	-pat



