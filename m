Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTGKR0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTGKR0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:26:10 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:40846 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S264476AbTGKRZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:25:56 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
Subject: [RFC] KBUILD 2.5 issues/regressions
Date: Fri, 11 Jul 2003 18:40:31 +0100
User-Agent: KMail/1.5.9
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org, kai@tp1.ruhr-uni-bochum.de
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PavD/4FQnry5FQX"
Message-Id: <200307111840.31225.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PavD/4FQnry5FQX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

The new kbuild architecture included as part of Linux 2.5 has a number of
problems that I would consider 2.5 show-stoppers and which must be resolved.
I believe the issues listed below are all regressions from 2.4; some are
easier to fix than others.

All of the issues relate to the building of kernel modules external to the
kernel source tree. Using kbuild to construct kernel modules instead of using
Makefile "hacks" has been rasied by the kbuild developers repeatedly on this
list and is, I believe, the preferred way to do it.

In my opinion, for kbuild to be a viable method of constructing kernel
modules external to the shipped source tree, the following conditions must
be met:

o The state of kbuild in shipped (distribution) kernels must be such that the
   construction of external modules can be done without having to modify the
   shipped kernel-source package.

This can be seen in almost all of today's distributions. Generally, you find
that the kernel-source package ships with a .config and the tree has had make
dep done. Effectively, the kernel source package matches the installed
binary. In the case of kbuild 2.4, this is excellent, as kbuild is in a ready
state to compile external modules against this kernel-source tree, and
perhaps more importantly, against the running kernel.

However, in 2.5, conditions are different depending on whether you are
building against a CONFIG_MODVERSIONS kernel or not. The preparation of the
tree in either case is also more complicated, though this does not seem
unreasonable.

I have determined that the kernel tree must have the following things done to
it before modules can be built against it (without modification to the tree).

make mrproper				# ensure tree is completely tidied
cp -a /etc/kernelops-2.5 .config	# copy of your default config
make oldconfig					# configure tree to work with this config

So far, this matches the behaviour in 2.4. However, in 2.4 you need only do a
"make dep" (and, I believe, some distros also touch a couple of other files).

kbuild 2.4 is now ready to build kernel modules against the running kernel,
irrespective of kernel configuration. Module symbol CRCs are computed as
demanded by CONFIG_MODVERSIONS, so this is not a problem under 2.4.

In 2.5, I determined that the steps below were required instead of make dep.

make prepare					# builds supporting utilities, links asm
							# directory, creates vermagic.h and version.h
make scripts					# seems to be required, not sure why (should
							# already be called by prepare, right?)

This tree now seems prepared to build external modules against it, as the
headers are now complete and the compile-time utilities are built. When
CONFIG_MODVERSIONS is set, this even builds genksyms for us.

So far, so good. In fact, just doing this much allows traditional Makefile
"hacks" like NVIDIA's driver Makefile to build quite happily against this
tree. However, trying to use kbuild 2.5 now presents the following problems:

/bin/sh: line 1: .tmp_version/foo.mod: Permission denied

And later:

/bin/sh: line 1: ./.__modpost.cmd: Permission denied

These issues are *only* apparent when you attempt to build external modules
as an unprivileged user. Building as the user owning the source tree (in
distributions, I'd imagine this is ordinarily user "src" or "rpm" or even
"root", in certain cases) causes no such errors.

o KBUILD 2.5 creates temporary files inside the kernel source tree.

	- .__modpost.cmd is hardcoded by Makefile and cannot be redirected;
	- .tmp_version seems also to be hardcoded, but I am not sure.
	- there is no obvious (or documented) way to manipulate the $srctree or
	  $objtree variables.

Doing a simple:

$ mkdir -p .tmp_versions;
$ touch .__modpost.cmd
$ chmod 1777 .tmp_versions .__modpost.cmd

Allows me to build external modules against a kernel tree as an unprivileged
user. I only need read-access to the tree.

Again, under 2.4, kbuild does not require such hacks. It does not seem to
create ANY temporary files in the source tree and works fine for building as
a non-privileged user.

The second major issue is that under 2.4, CONFIG_MODVERSIONS did not require
vmlinux to have been built in order to generate symbol CRCs. Building driver
foo against a kbuild 2.4 tree can even utilise modversions, simply by
including modversions.h.

Under 2.5, considerable improvements to the module system has made it so that
CONFIG_MODVERSIONS can only be utilised by modules in or out of the kernel
tree after vmlinux has been constructed. In the kbuild output I clearly see:

  scripts/modpost vmlinux <list of all modules> /blah/dir/here/foo.o

Which correctly adds the required symbol CRCs to the module. A quick look at
scripts/modpost.c shows me that int modversions is not set to 1 unless
vmlinux is passed into it. Indeed, this makes sense, but it does mean that if
I build driver foo against an uncompiled kernel tree (as ordinarily would be
shipped by a distribution), the resulting driver does not have symbol CRCs
added to it, as was the case in 2.4.

To summarise, for kbuild 2.5 to be a viable platform for building external
modules in distribution kernels, the following improvements must be made:

o If it is considered important that users should be able to compile kernel
   drivers (not install them) as an unprivileged user, the tree must desist
   from creating temporary files and directories in the $srctree. Instead, the
   utilisation of /tmp where suitable would be better;

o If distribution trees are to be shipped with CONFIG_MODVERSIONS set, kbuild
   2.5 needs to have some way other than vmlinux of providing symbol CRCs. I
   certainly am not sufficiently versed in the intricacies of the new module
   system to comment on a solution, but I'm sure somebody here is.

As a developer, these concerns do not affect me at all. A portable kbuild
solution surpasses the inherent inflexibility of Makefile hacks and I can
already use it with moderate success on 2.4 and 2.5 platforms, as I always
build and install all modules as root, and always have a vmlinux hanging
around.

I do not use a linux "distribution", but I appreciate that the end user
typically will, and ultimately these kbuild solutions will be utilised by the
end user, for building both fully free drivers and proprietary kits including
kernel glue (e.g., the NVIDIA driver).

As some of you may be aware, I have been working with Christian Zander for
some time now, maintaining the NVIDIA driver (through UNOFFICIAL patches)
against the linux 2.5 mainline. Recently I rewrote NVIDIA's Makefile to use
kbuild on 2.4 and 2.5, and with the exception of the noted issues, it seems
 to work properly for the majority of people. You can see these patches at
 http://minion.de/ , Christian's site.

For your convenience, I have attached a sample Makefile which could easily be
adapted to be the module foo I have mentioned. In reality, this is a Makefile
for the proprietary NVIDIA module, although I am sure sensible people will
appreciate the global ramifications of these issues and how they will affect
the building of any module, free or non-free.

I'm open to suggestions if there are solutions or workarounds I have not
considered. If there are, however, it might be sensible to document these.

Cheers,
Alistair Strachan.

--Boundary-00=_PavD/4FQnry5FQX
Content-Type: text/x-makefile;
  charset="iso-8859-1";
  name="Makefile.kbuild"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile.kbuild"

#
# KBUILD Makefile for the NVIDIA Linux kernel module.
#
# The motivation for replacing the original Makefile is the hope that this
# version will simplify the build and installation process. In the past,
# many architectural and cosmetic changes to the Linux kernel have made it
# difficult to maintain compatibility or required duplication of logic.
#
# Linux 2.5 introduces numerous such changes, many of which impact modules.
# Relying on KBUILD, some aspects of the build system otherwise difficult
# to support (for example, module versioning) are abstracted away and dealt
# with elsewhere, making life significantly easier here.
#
# The new approach currently has its own share of problems, some of which
# are architectural difficulties with KBUILD, others minor annoyances. For
# this reason, an improved version of the NVIDIA Makefile is available to
# those experiencing difficulties.
#
# Please report any problems you may be experiencing with this experimental
# Makefile to either one (or, preferably, both) of us:
#
# Alistair J Strachan (alistair@devzero.co.uk) (first pass, enhancements)
# Christian Zander (zander@email.minion.de) (enhancements)
#

all: install
install: package-install

#
# The NVIDIA kernel module base name and static file names. KBUILD will go
# ahead and append ".o" or ".ko" to form the final module name.
#

MODULE_NAME := nvidia
VERSION_HEADER := nv_compiler.h

#
# List of object files to link into NVIDIA kernel module; make sure KBUILD
# understands that we want a module.
#

RESMAN_CORE_OBJS := nv-kernel.o
RESMAN_GLUE_OBJS := nv.o os-agp.o os-interface.o os-registry.o

$(MODULE_NAME)-objs := $(RESMAN_CORE_OBJS) $(RESMAN_GLUE_OBJS)

#
# A bug in KBUILD 2.4 means that leaving obj-m set in top-level context
# will cause Rules.make to call pathdown.sh, which is wrong. So, we only
# set this conditional of a kernel-level instance.
#

ifdef TOPDIR
obj-m += $(MODULE_NAME).o
endif

#
# Include local source directory in $(CC)'s include path and set disable any
# warning types that are of little interest to us.
#

EXTRA_CFLAGS += -I$(src)
EXTRA_CFLAGS += -Wno-cast-qual -Wno-strict-prototypes

#
# Determine location of the Linux kernel source tree. Allow users to override
# the default (i.e. automatically determined) kernel source location with the
# KERNDIR directive; this new directive replaces NVIDIA's SYSINCLUDE.
#

ifdef KERNDIR
  KERNEL_SOURCES := $(KERNDIR)
  KERNEL_HEADERS := -I$(KERNEL_SOURCES)/include
  MODULE_ROOT    := /lib/modules/$(shell uname -r)/kernel/drivers # XXX
else
  KERNEL_SOURCES := /lib/modules/$(shell uname -r)/build
  KERNEL_HEADERS := -I$(KERNEL_SOURCES)/include
  MODULE_ROOT    := /lib/modules/$(shell uname -r)/kernel/drivers
endif

#
# We rely on these two definitions below; if they aren't set, we set them to
# reasonable defaults (Linux 2.4's KBUILD, and top-level passes will not set
# these).
#

src ?= .
obj ?= .

#
# Sets any internal variables left unset by KBUILD (e.g. this happens during
# a top-level run).
#

TOPDIR ?= $(KERNEL_SOURCES)
PATCHLEVEL ?= $(shell sh $(src)/conftest.sh kernel_patch_level $(TOPDIR))

#
# Linux 2.4 uses the .o module extension. Linux 2.5, however, uses the .ko
# module extension. Handle these gracefully.
#

ifeq ($(PATCHLEVEL), 4)
  MODULE_OBJECT := $(MODULE_NAME).o
else
  MODULE_OBJECT := $(MODULE_NAME).ko
endif

#
# NVIDIA specific CFLAGS and #define's. The remap_page_range check has become
# necessary with the introduction of the five argument version to Linux 2.4
# distribution kernels; this conflicting change cannot be detected at compile
# time.
#

EXTRA_CFLAGS += -DNTRM -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=4348  -DNV_UNIX   -DNV_LINUX   -DNV_INT64_OK   -DNVCPU_X86

ifeq ($(shell echo $(NVDEBUG)),1)
  ifeq ($(shell test -z $(RMDEBUG) && echo yes),yes)
    RMDEBUG=1
  endif
endif

ifeq ($(shell echo $(RMDEBUG)),1)
  EXTRA_CFLAGS += -DDEBUG -g -fno-common
endif

ifeq ($(shell sh $(src)/conftest.sh remap_page_range $(KERNEL_HEADERS)), 5)
  EXTRA_CFLAGS += -DREMAP_PAGE_RANGE_5
endif

ifeq ($(shell sh $(src)/conftest.sh remap_page_range $(KERNEL_HEADERS)), 4)
  EXTRA_CFLAGS += -DREMAP_PAGE_RANGE_4
endif

#
# NVIDIA binary object file includes .common section.
#

EXTRA_LDFLAGS := -d

#
# Miscellaneous NVIDIA kernel module build support targets. They are needed
# to satisfy KBUILD requirements and to support NVIDIA specifics.
#

$(obj)/nv-kernel.o:
	cp $(src)/$(RESMAN_CORE_OBJS) $(obj)/$(RESMAN_CORE_OBJS)

$(obj)/$(VERSION_HEADER):
	echo \#define NV_COMPILER \"`$(CC) -v 2>&1 | tail -1`\" > $@

$(obj)/nv.o: $(obj)/$(VERSION_HEADER)

#
# More quirks for Linux 2.4 KBUILD, which doesn't link automatically.
#

ifeq ($(PATCHLEVEL), 4)
$(obj)/$(MODULE_NAME).o: $($(MODULE_NAME)-objs)
	$(LD) $(EXTRA_LDFLAGS) -r -o $@ $($(MODULE_NAME)-objs)
endif

#
# KBUILD build parameters.
#

KBUILD_PARAMS := -C $(KERNEL_SOURCES) SUBDIRS=$(PWD)

#
# NVIDIA sanity checks.
#

suser-sanity-check:
	@if ! sh conftest.sh suser_sanity_check; then \
	  echo; \
	  echo "You have insufficient privileges for this operation. Please "; \
	  echo "run \"make install\" as root!                               "; \
	  echo; \
	  exit 1; \
	fi

rmmod-sanity-check:
	@if ! sh conftest.sh rmmod_sanity_check $(MODULE_NAME); then \
	  echo; \
	  echo "Unable to unload the currently loaded NVIDIA kernel module! "; \
	  echo "Please be certain that you have exited X before attempting  "; \
	  echo "to install this version.                                    "; \
	  echo; \
	  exit 1; \
	fi

cc-sanity-check:
	@if ! sh conftest.sh cc_sanity_check $(CC); then \
	  echo; \
	  echo "You appear to be building the NVIDIA kernel module with a  "; \
	  echo "compiler different from the one that was used to build the "; \
	  echo "running kernel. This may be perfectly fine, but there are  "; \
	  echo "cases where this can lead to unexpected behaviour and      "; \
	  echo "system crashes.                                            "; \
	  echo; \
	  echo "If you know what you are doing and want to override this   "; \
	  echo "check, you can do so by setting IGNORE_CC_MISMATCH.        "; \
	  echo; \
	  echo "In any other case, set the CC environment variable to the  "; \
	  echo "name of the compiler that was used to build the kernel.    "; \
	  echo; \
	  exit 1; \
	fi

#
# Build the NVIDIA kernel module using Linux KBUILD. This target is used by
# the "package-install" target below.
#

module: cc-sanity-check
	@make $(KBUILD_PARAMS) modules; \
	if ! [ -f $(MODULE_OBJECT) ]; then \
	  echo "$(MODULE_OBJECT) failed to build!"; \
	  exit 1; \
	fi

#
# Build the NVIDIA kernel module with KBUILD. Verify that the user posesses
# sufficient privileges. Rebuild the module dependency file.
#

module-install: suser-sanity-check module
	@mkdir -p $(MODULE_ROOT)/video; \
	install -m 0664 -o root -g root $(MODULE_OBJECT) $(MODULE_ROOT)/video; \
	/sbin/depmod -ae;

#
# This target builds, then installs, then creates device nodes and inserts
# the module, if successful.
#

package-install: module-install rmmod-sanity-check
	@sh makedevices.sh; \
	/sbin/modprobe $(MODULE_NAME) && \
	echo "$(MODULE_OBJECT) installed successfully.";

#
# Support hack, KBUILD isn't prepared to clean up after external modules.
#

clean:
	@rm -f $(RESMAN_GLUE_OBJS) .*.{cmd,flags}
	@rm -f $(MODULE_NAME).{o,ko,mod.{o,c}} built-in.o $(VERSION_HEADER) *~

#
# Linux 2.4 KBUILD requires the inclusion of Rules.make; Linux 2.5's KBUILD
# includes dependencies automatically.
#

ifeq ($(PATCHLEVEL), 4)
include $(KERNEL_SOURCES)/Rules.make
endif

--Boundary-00=_PavD/4FQnry5FQX--
