Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUDTWba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUDTWba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUDTWb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:31:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:26696 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264571AbUDTVlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:41:05 -0400
Date: Tue, 20 Apr 2004 23:51:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] kbuild: Documentation - how to build external modules
Message-ID: <20040420215131.GB2098@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just first wrap-up of some text about building external modules.
There are a few unfinished chapters - but's too late today.

Please let me know what you expect to see in here - which is not covered
eiter direct or via an empty heading.

	Sam

Building external modules
=========================
kbuild offers functionality to build external modules, with the
prerequisite that there is a pre-built kernel avialable with full source.
A subset of the targets available when building the kernel is available
when building an external module.


Building the module
-------------------
The command looks like his:

	make -C <path to kernel src> M=$PWD

For the above command to succeed the kernel must have been built with
modules enabled.

To install the modules just being built:

	make -C <path to kernel src> M=$PWD modules_install

More complex examples later, the above should get you going in most cases.


Available targets:
- - - - - - - - - 
make -C $KDIR M=$PWD
	Same as if 'modules' was specified. See description of
	modules target below.

make -C $KDIR M=$PWD modules
	Will build the module(s) located in current directory. All output
	files will be located in the same directory as the module source.
	No attemps are made to update the kernel source, and it is
	expected that a successfully make has been executed
	for the kernel.

make -C $KDIR M=$PWD modules_install
	Install the external module(s)

make -C $KDIR M=$PWD clean
	Remove all generated files in current directory

Available options:
- - - - - - - - - 
make -C $KDIR
	Used to specify where to find the kernel source.
	'$KDIR' represent the directory where the kernel source is.
	Make will actually change directory to the specified directory
	when executed.

make -C $KDIR M=$PWD
	M= is used to tell kbuild that an external module is being built.
	The option given to M= is the directory where the external
	module is located.
	When an external module is being built only a subset of the
	usual targets are avialable.

make -C $KDIR SUBDIRS=$PWD
	Same as M=. The SUBDIRS= syntax is kept for backwards compatibility.

make -C $KDIR M=$PWD help
	help will list the available target when building external
	modules.


A more advanced example
- - - - - - - - - - - -
This example shows a setup where a distribution has wisely decided
to separate kernel source and output files:

Kernel src:
/usr/src/linux-<kernel-version>/

Output from a kernel compile, including .config:
/lib/modules/linux-<kernel-version>/build/

External module to be compiled:
/home/user/module/src/

To compile the module located in the directory above use the
following command:

	cd /home/user/module/src
	make -C /usr/src/linux-<kernel-version> \
	O=/lib/modules/linux-<kernel-version>/build \
	M=$PWD

Then to install the module use the following command:

	make -C /usr/src/linux-<kernel-version> \
		O=/lib/modules/linux-<kernel-version>/build \
		M=$PWD modules_install

The above are rather long commands, and the following chapter
lists a few tricks to make it all easier.

Tricks to make it easy
---------------------
TODO: .... This need to be rewritten......

A make line with several parameters becomes tiresome and errorprone
and what follows here is a little trick to make it possible to build
a module only using a single 'make' command.

Create a makefile named 'Makefile' with the following content:
---> Makefile:

all:
	$(MAKE) -C /home/sam/src/kernel/v2.6 M=$(PWD) \
			$(filter-out all,$(MAKECMDGOALS))

obj-m := module.o
---> End of Makefile

When make is invoked it will see the all: rule, and simply call make again with the right parameters.

If a driver is being developed that is targeted for inclusion in the main kernel, an idea is to seperate out the all: rule to a Makefile nemed makefile (lower capital m) like this:

---> makefile
all:
	$(MAKE) -f Makefile -C /home/sam/src/kernel/v2.6 \
	        M=$(PWD) $(MAKECMDGOALS)

---> End of makefile

The kbuild makefile will include only a single statement:
---> Makefile:

obj-m := module.o

---> End of Makefile
When executing make, it looks for a file named makefile, before a
file named Makefile. Therefor make will pick up the file named with lower capital 'm'.


Prepare the kernel for building external modules
------------------------------------------------
When building external modules the kernel is expected to be prepared.
This includes the precense of certain binaries, the kernel configuration
and the symlink to include/asm.
To do this a convinient target is made:

	make modules_prepare

For a typical distribution this would look like the follwoing:

	make modules_prepare O=/lib/modules/linux-<kernel version>/build


TODO: Fill out the following chapters

Module versioning
-----------------

Local include files
-------------------
CLFAGS := include ...

Binary only .o files
--------------------
Use _shipped ...

