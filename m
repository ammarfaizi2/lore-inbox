Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVEUUlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVEUUlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 16:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVEUUlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 16:41:47 -0400
Received: from rgminet01.oracle.com ([148.87.122.30]:24781 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261557AbVEUUlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 16:41:37 -0400
Date: Sat, 21 May 2005 13:41:29 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, Christopher Li <lkml@chrisli.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kbuild trick
Message-ID: <20050521204129.GP22946@ca-server1.us.oracle.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Timur Tabi <timur.tabi@ammasso.com>,
	Christopher Li <lkml@chrisli.org>, linux-kernel@vger.kernel.org
References: <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com> <20050518132417.GA14488@64m.dyndns.org> <428B7143.4090607@ammasso.com> <20050518182250.GB8130@mars.ravnborg.org> <428B8809.8060406@ammasso.com> <20050520193706.GA8225@mars.ravnborg.org> <20050520234353.GM22946@ca-server1.us.oracle.com> <20050521051217.GA8191@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20050521051217.GA8191@mars.ravnborg.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 21, 2005 at 07:12:17AM +0200, Sam Ravnborg wrote:
> > svn cat -r 2205 http://oss.oracle.com/projects/ocfs2/src/trunk/Kbuild-24.make
> 
> Care to post a copy?

	That would be too logical.  Here you go.  The first file is a
sample Makefile for both 2.6 and 2.4, stripped out of our history.  Any
mistakes are mine.  The second is Kbuild-24.make.  The files expect
KERNELDIR and KERNELINC to be set, and a 2.4 build needs to set GCCINC
as well.  Use your favorite autoconf/anti-autoconf system.

Joel

-- 

"Well-timed silence hath more eloquence than speech."  
         - Martin Fraquhar Tupper

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile


obj-m	+= myfs.o
myfs-objs := inode.o super.o

EXTRA_CFLAGS += -DSOMETHING

ifeq ($(KERNELRELEASE),)
# Called as "make" part of makefile.  This executes kbuild

all: build-myfs

clean: clean-myfs

install: install-myfs

ifneq ($(KERNEL_26),)
# This is a 2.6 kenrel, forward to kbuild

build-myfs:
	$(MAKE) -C $(KERNELDIR) M=`pwd` modules

clean-myfs:
	$(MAKE) -C $(KERNELDIR) M=`pwd` clean

install-myfs:
	$(MAKE) -C $(KERNELDIR) M=`pwd` modules_install
else
# This is a 2.4 kernel, use our own

include Kbuild-24.make

endif

else
# Called from 2.6 kbuild

STAMP_DIR = `pwd`

endif

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Kbuild-24.make"


#
# This is a Makefile for 2.4 external module builds.  Red Hat
# Enterprise Linux does not support the usual:
#
#     make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules
#
# So we must hand-roll our compile lines.  This is in a seperate
# file to keep the regular Makefile readable.
#
# This uses the Makebo schema.  So, the compile parts are filled in.
# All Makefiles using this code should set MODULE_CFLAGS and
# MODULE_DEFINES for any extra cflags/defines needed.
#

WARNINGS = -Wall -Wstrict-prototypes
OPTIMIZE = -O2

KERNEL_DEFINES = -D__KERNEL__ -DMODULE -DLINUX -DEXPORT_SYMTAB
KERNEL_CFLAGS = -pipe -nostdinc -fno-strict-aliasing -fno-common \
	-fomit-frame-pointer
KERNEL_LDADD = -nostdlib

#
# These arch-specific flags would normally be provided by the
# kbuild system.  Hope we got them right.
#

ifeq ($(PROCESSOR),ppc64)
  MACH_CFLAGS += -m64 -fsigned-char -fno-builtin -msoft-float \
	-mminimal-toc
  MACH_LDADD += -m elf64ppc
endif
ifeq ($(PROCESSOR),x86_64)
  MACH_CFLAGS += -m64 -mcmodel=kernel
endif
ifeq ($(PROCESSOR),s390x)
  MACH_CFLAGS += -fno-strength-reduce -fpic
  MACH_LDADD += -m elf64_s390
endif



INCLUDES = -I. -I$(KERNELINC) -I$(GCCINC)
DEFINES = $(KERNEL_DEFINES)
CFLAGS = $(OPTIMIZE) $(KERNEL_CFLAGS) $(MACH_CFLAGS) $(MODVERSIONS) \
	$(WARNINGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
LDADD = $(KERNEL_LDADD) $(MACH_LDADD)

#
# Ripping off some kbuild 2.6 tricks
#

# Modules that have multiple parts.
multi-used-m := $(sort $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs))), $(m))))
multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)))

# Modules that don't.
single-used-m := $(sort $(filter-out $(multi-used-m), $(obj-m)))
link_multi_deps = $($(@:.o=-objs))

#
# It's impossible, AFAICT, to generate the dependancies for each
# individual object:parts set.  In fact, kbuild 2.6 doesn't try either.
# They use a simpler trick...they force the rebuild like this, but
# call if_changed on each target to avoid the useless rebuilds.
# This is a 2.4 hack, so I don't care that much :-)
#
$(multi-used-m): $(multi-objs-m)
	$(CC) -Wl,-r -o $@ $(LDADD) $(link_multi_deps)

build-modules: $(single-used-m) $(multi-used-m)


# Kbuild uses INSTALL_MOD_PATH for rooted installs.  Makebo uses
# DESTDIR.  Folks really should set INSTALL_MOD_PATH, but in case they
# don't...
INSTALL_MOD_PATH ?= $(DESTDIR)
MODLIB = $(INSTALL_MOD_PATH)$(MODULEDIR)

install-modules: $(obj-m)
	$(TOPDIR)/mkinstalldirs $(MODLIB)/$(INSTALL_MOD_DIR)
	for file in $(obj-m); do \
	  $(INSTALL_DATA) $$file $(MODLIB)/$(INSTALL_MOD_DIR)/$$file; \
	done

clean-modules:
	rm -f *.o *.p *.s


--u3/rZRmxL6MmkK24--
