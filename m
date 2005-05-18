Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVERS3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVERS3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVERS2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:28:24 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:10368 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262308AbVERSXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:23:10 -0400
Message-ID: <428B8809.8060406@ammasso.com>
Date: Wed, 18 May 2005 13:23:05 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Christopher Li <lkml@chrisli.org>, linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com> <20050518132417.GA14488@64m.dyndns.org> <428B7143.4090607@ammasso.com> <20050518182250.GB8130@mars.ravnborg.org>
In-Reply-To: <20050518182250.GB8130@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> Can you post a copy of you makefile. Then I may be able to tell you why.

Ok, but it's really huge and ugly:

# Set some global variables

ifndef SOFTWARE
     # Specifying 'export' turns SOFTWARE into a real environment variable,
     # not just a makefile variable.  This means that when make calls itself
     # recursively in Section 1, the child process will already have SOFTWARE
     # defined, and won't try to re-define it.  In Section 2, the current
     # directory is ${KERNEL_SOURCE}, so calculating SOFTWARE is impossible.
     export SOFTWARE = ${shell cd ../../../..; /bin/pwd}
endif

# Only if the Config.mk file exists will the next line include it.
# (Inside Ammasso, the needed information is derived differently.)
ifneq (${wildcard ${SOFTWARE}/../Config.mk},)
     include ${SOFTWARE}/../Config.mk
endif

ifndef KERNEL_SOURCE
     ${error KERNEL_SOURCE environment variable not defined.}
endif

# O points to where a 2.6 kernel tree put its build targets.  Normally, the
# targets are placed in the same directory as the source, but you can use the
# "O=" option on the 'make' command line to override that.  If the kernel is
# built with the "O=" option, then all external modules must also be built
# with that option.  However, we also use the O= path here to determine where
# to find certain files.

ifdef O
     KERNEL_BUILD=${O}
else
     KERNEL_BUILD=${KERNEL_SOURCE}
endif

# Determine the kernel version.  We only really care about 2.4 vs 2.6, so this
# simple code will work with version.h files that have multiple UTS_RELEASEs.
# Fail if version.h doesn't exist.

ifeq (${wildcard ${KERNEL_BUILD}/include/linux/version.h},)
     ${error ${KERNEL_BUILD}/include/linux/version.h does not exist.}
endif

KERNEL_VERSION=${shell grep -m 1 UTS_RELEASE ${KERNEL_BUILD}/include/linux/version.h | cut 
-f 2 -d'"'}

ifndef KERNEL_VERSION
     ${error Kernel version not found in ${KERNEL_BUILD}/include/linux/version.h.}
endif

ifndef KERNEL_CODE
     ${error KERNEL_CODE environment variable not defined.}
endif

# This makefile is divided into three sections.
# Section 1 is the first pass of a kbuild-style makefile
# Section 2 is the second pass of a kbuild-style makefile
# Section 3 is the tradition 2.4-compatible makefile

# The concept of a two-pass kbuild-style makefile is taken from
# "Driver porting: compiling external modules" http://lwn.net/Articles/21823/

ifneq (${shell expr ${KERNEL_VERSION} : '2.4'}, 0)
     SECTION = 3
else
     ifeq (${KERNELRELEASE},)
         SECTION = 1
     else
         SECTION = 2
     endif
endif

# Check which type of build we want: release, debug, or trace.

ifeq (${CCRELEASE}, 1)
     # Release build
     BUILD_VERSION=release
     EXTRA_CFLAGS += -DCCNOPRINTF
else
     ifeq (${CCDEBUGFAST}, 1)
         # Trace build
         BUILD_VERSION=trace
         EXTRA_CFLAGS += -DCCDEBUG -DCCNOPRINTF
     else
         # Debug build
         BUILD_VERSION=debug
         EXTRA_CFLAGS += -g -DCCDEBUG
     endif
endif

# Set the target directory for output files

TARGET_DIR = obj_${KERNEL_CODE}_${BUILD_VERSION}

# --------------------------  SECTION 1  -----------------------------

# Kbuild pass #1

ifeq (${SECTION}, 1)

# If O= is specified on the make command line, then you must have write
# access to KERNEL_SOURCE, otherwise the build will fail.  So we only pass
# O= if it is specified in Config.mk.

ifdef O
     KO=O=${KERNEL_BUILD}
endif

all:
# We need to manually copy files to the object directory
# because kbuild always dumps the targets in the current directory
	@rm -rf .tmp_versions ${TARGET_DIR}
	@mkdir -p ${TARGET_DIR}
	@${MAKE} -C ${KERNEL_SOURCE} SUBDIRS=${shell pwd} ${KO}
	@mv *.o *.ko *.lst ${TARGET_DIR}
	@rm -f .*.cmd *.mod.c

clean:
	@rm -rf .tmp_versions ${TARGET_DIR}

endif # Section 1

# ----------------------------  COMMON  ------------------------------

# Here we calculate variables that are common to sections 2 and 3

ifneq (${SECTION}, 1)

# Determine where include/asm points to.

TEMP_KERNEL_ARCHDIR=$(subst -, ,${shell cd ${KERNEL_BUILD}/include/asm && pwd -P})
KERNEL_ARCHDIR=${word ${words ${TEMP_KERNEL_ARCHDIR}}, ${TEMP_KERNEL_ARCHDIR}}

# Specify the gcc parameters for this hardware platform.

ifeq (${PLATFORM}, x86_64)
     EXTRA_CFLAGS += -DX86_64 -mno-red-zone -mcmodel=kernel
else
     ifeq (${PLATFORM}, x86_32)
         EXTRA_CFLAGS += -DX86_32
     else
         ${error Unsupported platform}
     endif
endif

# Set the compiler paramaters. AMSO_CFLAGS is an environment variable

EXTRA_CFLAGS += -DEXPORT_SYMTAB -Wall ${AMSO_CFLAGS}
EXTRA_CFLAGS += -I${SOFTWARE}/host/linux/include -I${SOFTWARE}/host/common/include
EXTRA_CFLAGS += -I${SOFTWARE}/common/include -I${SOFTWARE}/common/include/clustercore
EXTRA_CFLAGS += -I${SOFTWARE}/host/linux/common -I${SOFTWARE}/host/linux/sys/devccil

# Define DO_MUNMAP_API_CHANGE if this kernel uses the version of do_unmap()
# that has four parameters instead of just three.

ifneq (${shell grep -c -m 1 do_munmap.*acct ${KERNEL_SOURCE}/include/linux/mm.h}, 0)
     EXTRA_CFLAGS += -DDO_MUNMAP_API_CHANGE
endif

# Define REMAP_API_CHANGE if this kernel uses the version of remap_page_range()
# that has five parameters

ifneq (${shell grep -c -m 1 remap_page_range.*vm_area_struct 
${KERNEL_SOURCE}/include/linux/mm.h}, 0)
     EXTRA_CFLAGS += -DREMAP_API_CHANGE
endif

# Define REMAP_PFN_RANGE if the function remap_pfn_range() exists in mm.h
# This function deprecates remap_page_range().  remap_pfn_range() uses a page
# index rather than a physical address, which allows it to support >4GB of RAM
# on 32-bit systems.

ifneq (${shell grep -c -m 1 remap_pfn_range ${KERNEL_SOURCE}/include/linux/mm.h}, 0)
     EXTRA_CFLAGS += -DREMAP_PFN_RANGE
endif

# Define INCLUDE_SYSCALL if linux/syscall.h exists.

ifneq (${wildcard ${KERNEL_SOURCE}/include/linux/syscall.h},)
     EXTRA_CFLAGS += -DINCLUDE_SYSCALL
endif

# Define INCLUDE_SYSTEM if interrupt.h does not include asm/system.h
# Red Hat 8.0 (and maybe others) has a bug in interrupt.h where it forgets
# to include this header file.

ifeq (${shell grep -c asm/system\.h ${KERNEL_SOURCE}/include/linux/interrupt.h}, 0)
     EXTRA_CFLAGS += -DINCLUDE_SYSTEM
endif

# Define INCLUDE_CURRENT if hw_irq.h does not include sched.h and current.h
# Red Hat 7.3 (and maybe others) has a bug in hw_irq.h where it forgets
# to include these header files.

ifeq (${shell grep -c asm/current\.h 
${KERNEL_SOURCE}/include/asm-${KERNEL_ARCHDIR}/hw_irq.h}, 0)
     EXTRA_CFLAGS += -DINCLUDE_CURRENT
endif

# Define NET_DEVICE_HAS_IW if the net_device structure has a field called "wireless_handlers"

ifneq (${shell grep -cw wireless_handlers ${KERNEL_SOURCE}/include/linux/netdevice.h}, 0)
     EXTRA_CFLAGS += -DNET_DEVICE_HAS_IW
endif

# Define PCI_SAVE_STATE_BUFFER if function pci_save_state() has a parameter called "buffer"

ifneq (${shell grep -c pci_save_state.*buffer ${KERNEL_SOURCE}/include/linux/pci.h}, 0)
     EXTRA_CFLAGS += -DPCI_SAVE_STATE_BUFFER
endif

# Define QDISC_LIST_HEAD if the net_device.qdisc_list structure is of type
# "struct list_head" instead of "struct Qdisc *".  This change was made in 2.6.8

ifneq (${shell grep -cw list_head.*qdisc_list ${KERNEL_SOURCE}/include/linux/netdevice.h}, 0)
     EXTRA_CFLAGS += -DQDISC_LIST_HEAD
endif

# Define PCI_DMA_CPU if the function pci_dma_sync_single_for_cpu() exists.
# If so, then we need to call this function instead of pci_dma_sync_single().

ifneq (${wildcard ${KERNEL_SOURCE}/include/asm-generic/pci-dma-compat.h},)
     ifneq (${shell grep -c pci_dma_sync_single_for_cpu 
${KERNEL_SOURCE}/include/asm-generic/pci-dma-compat.h}, 0)
         EXTRA_CFLAGS += -DPCI_DMA_CPU
     endif
endif

# Define SIGNAL_RLIM if rlim[] is a member of signal_struct instead of
# task_struct.  Since both signal_struct and task_struct are defined in
# sched.h, we need to grep the code for an actual usage of rlim[], i.e.
# "current->signal->rlim[]" as opposed to "current->rlim[]".  It looks like
# mm.h is a good candidate for this check.
ifneq (${shell grep -c -m 1 "signal->rlim" ${KERNEL_SOURCE}/include/linux/mm.h}, 0)
     EXTRA_CFLAGS += -DSIGNAL_RLIM
endif

# Define USE_GUP if get_user_pages() truly pins down pages.  Kernels prior to
# 2.6.7 had a bug in get_user_pages() that would unpin a page under extreme
# memory pressure.
ifneq (${wildcard ${KERNEL_SOURCE}/mm/rmap.c},)
     ifneq (${shell grep -c -m 1 try_to_unmap_one.*vm_area_struct 
${KERNEL_SOURCE}/mm/rmap.c}, 0)
         EXTRA_CFLAGS += -DUSE_GUP
         USE_GUP=1
     endif
endif

ifndef USE_GUP
     # If we can't use get_user_pages(), then we should use mlock().  Normally,
     # we would need a kernel that support non-root mlock(), but the driver
     # actually overrides any limitiations on mlock().
     EXTRA_CFLAGS += -DUSE_MLOCK
     USE_MLOCK=1

     # Define USE_MLOCK if this kernel supports mlock for non-root processes.
     # If so, then we libccil needs to call mlock instead of having the driver
     # do it.  We also skip all the code to determine the sys_mlock() calling method.
#    ifneq (${shell grep -c -m 1 can_do_mlock ${KERNEL_SOURCE}/include/linux/mm.h}, 0)
#        EXTRA_CFLAGS += -DUSE_MLOCK
#        USE_MLOCK=1
#    endif
endif

# If neither USE_MLOCK nor USE_GUP is defined, then we want the driver to
# call sys_mlock for us.
ifndef USE_MLOCK
     ifndef USE_GUP
         EXTRA_CFLAGS += -DUSE_SYSCALL
         USE_SYSCALL=1
     endif
endif

ifdef USE_MLOCK
     SYSCALL_METHOD = "Using mlock() system call"
endif
ifdef USE_GUP
     SYSCALL_METHOD = "Using get_user_pages()"
endif
ifdef USE_SYSCALL
     # Here we determine which method we will use to call sys_mlock().
     # The rule is:

     # If /proc/k[all]syms exists, then scan it for a list of syscalls
     # If /proc/k[all]syms doesn't exists or we can't find at least 2 syscalls,
     #    then scan the kernel source tree for a list of syscalls
     # If that doesn't work either, then look up the sys_mlock entry point in
     #    /boot/System.map-`uname -r`
     # If that also doesn't work, and if we're x86-32, then use KERNEL_SYSCALLS
     # Otherwise, we can't call sys_mlock().  Exit with failure.

     ifneq (${wildcard /proc/ksyms},)
         SYMFILE = /proc/ksyms
     else
         ifneq (${wildcard /proc/kallsyms},)
             SYMFILE = /proc/kallsyms
         endif
     endif

     # A list of system calls we look for
     SYSCALLS = open close read write lseek wait4

     ifdef SYMFILE
         # The kernel symbol file is readable, so let's use it
         SYMLIST = ${shell x=1; for i in ${SYSCALLS}; do if [ "`grep -sh -m 1 --mmap 
\"[^t] sys_$$i\(_R[_[:alnum:]]*\|\)$$\" ${SYMFILE}`" ]; then echo "-DSYSCALL$$x=$$i"; 
x=`expr $$x + 1`; fi; done}
     else
         # The kernel symbol file is not readable, so we need to scan the source tree
         # We also need to search the architecture-specific trees
         ARCH=${KERNEL_SOURCE}/arch/${KERNEL_ARCHDIR}/kernel/*
         SYMLIST = ${shell x=1; for i in ${SYSCALLS}; do if [ "`grep -sh -m 1 --mmap 
EXPORT_SYMBOL[_GPL]*\(sys_$$i ${KERNEL_SOURCE}/fs/* ${KERNEL_SOURCE}/kernel/* ${ARCH}`" ]; 
then echo "-DSYSCALL$$x=$$i"; x=`expr $$x + 1`; fi; done}
     endif
     ifeq (${shell expr `echo ${SYMLIST} | wc -w` \>= 2}, 1)
         # There are enough syscalls, so let's use the list
         EXTRA_CFLAGS += ${SYMLIST}
         SYSCALL_METHOD = "Using system call table method"
     else
         SYMFILE = /boot/System.map-${shell uname -r}
         # There aren't enough syscalls, so let's try System.map-`uname -r
         ifeq (${shell grep -cw "\(sys_mlock\|sys_munlock\)" ${SYMFILE}}, 2)
             # We found sys_mlock and sys_munlock, so we'll use their addresses.
             # The addresses will be passed in on the insmod command-line,
             # by our loader script.
             EXTRA_CFLAGS += -DSYSTEM_MAP
             SYSCALL_METHOD = "Using System.map method"
         else
             # We couldn't find sys_m[un]lock, so search for other syscalls in
             # System.map.  We are assuming that System.map contains entries
             # only for exported functions, not every function in the kernel.
             SYMLIST = ${shell x=1; for i in ${SYSCALLS}; do if [ "`grep -sh -m 1 --mmap 
\"[^t] sys_$$i\(_R[_[:alnum:]]*\|\)$$\" ${SYMFILE}`" ]; then echo "-DSYSCALL$$x=$$i"; 
x=`expr $$x + 1`; fi; done}
             ifeq (${shell expr `echo ${SYMLIST} | wc -w` \>= 2}, 1)
                 # There are enough syscalls, so let's use the list
                 EXTRA_CFLAGS += ${SYMLIST}
                 SYSCALL_METHOD = "Using system call table method from System.map"
             else
                 # Nothing so far has worked, so if we're x86-32 we can use
                 # kernel syscalls, otherwise we give up.
                 ifeq (${PLATFORM}, x86_32)
                     EXTRA_CFLAGS += -DKERNEL_SYSCALLS
                     SYSCALL_METHOD = "Using kernel syscall method"
                 else
                     # None of our options are going to work, so just give up
                     ${error Could not determine system call method}
                 endif
             endif
         endif
     endif
endif

# Support for KDAPL
EXTRA_CFLAGS += -DCCIL_KDAPL -DCCTHREADSAFE

# Source files

CFILES = \
         devnet.c \
         ccilnet.c \
         devccil.c \
         devccil_adapter.c \
         devccil_rnic.c \
         devccil_mem.c \
         devccil_vq.c \
         devccil_eh.c \
         devccil_cq.c \
         devccil_mq.c \
         devccil_pd.c \
         devccil_srq.c \
         devccil_qp.c \
         devccil_mm.c \
         devccil_ep.c \
         devccil_wrappers.c \
         devccil_ae.c \
         devccil_logging.c

COMMON_CFILES   = \
		cc_cq_common.c \
                 cc_mq_common.c \
                 cc_qp_common.c

# --------------------------  SECTION 2  -----------------------------

# Kbuild pass #2

ifeq (${SECTION}, 2)

SOFTWARE = ${shell cd ${SUBDIRS}/../../../..; pwd}

# Generate an assembly listing for each file

EXTRA_CFLAGS += -Wa,-aldh=$*.lst

# Fix the paths for the common .c files
CFILES += $(addprefix ../../common/, ${COMMON_CFILES})

# Linker parameters

obj-m := ccil.o

ccil-objs := ${CFILES:.c=.o}

syscall:
	@echo ${SYSCALL_METHOD}

endif # Section 2

# --------------------------  SECTION 3  -----------------------------

# Kernel 2.4-compatible makefile

ifeq (${SECTION}, 3)

include ${SOFTWARE}/header_gcc.mk

COMMON_OFILES:=$(patsubst %.c, ${SOFTWARE}/host/linux/sys/devccil/${TARGET_DIR}/%.o, 
${COMMON_CFILES})
COMMON_CFILES:=$(addprefix ${SOFTWARE}/host/linux/common/,${COMMON_CFILES})

# Here we try to identify the Scyld kernel, because it has peculiarities.
# If linux/fs.h does not have a prototype for sys_read, but asm/unistd.h does,
# and it's X86_64, then we assume that this is the Scyld kernel.
# This kernel needs to have __KERNEL_SYSCALLS__ defined in order to pick up
# the sys_xxx prototypes.  It also needs MODVERSIONS defined and modversions.h
# needs to be included in every source file.

ifeq (${PLATFORM}, x86_64)
     ifeq (${shell grep -cw sys_read ${KERNEL_SOURCE}/include/linux/fs.h}, 0)
         ifeq (${shell grep -cw -m 1 sys_read 
${KERNEL_SOURCE}/include/asm-${KERNEL_ARCHDIR}/unistd.h}, 1)
             EXTRA_CFLAGS += -D__KERNEL_SYSCALLS__ -DMODVERSIONS -include linux/modversions.h
         endif
     endif
endif

# Reset CFLAGS because we don't like the way header_gcc.mk initializes it

CFLAGS = ${EXTRA_CFLAGS} -O2 -fno-strict-aliasing -D__KERNEL__ -DMODULE 
-I${KERNEL_SOURCE}/include

# Generate an assembly listing for each file

COMMON_CFLAGS := ${CFLAGS}
CFLAGS += -Wa,-aldh=${TARGET_DIR}/$*.lst

# Linker parameters

LDFLAGS += -r -E -d --whole-archive

all: syscall ${TARGET_DIR} ${COMMON_OFILES} ${TARGET_DIR}/ccil.o

syscall:
	@echo ${SYSCALL_METHOD}

${COMMON_OFILES}: ${COMMON_CFILES}
	${CC} -c ${COMMON_CFLAGS} -Wa,-aldh=/$*.lst -o $@ ${SOFTWARE}/host/linux/common/$(notdir 
$*).c

include ${SOFTWARE}/footer_gcc.mk

${TARGET_DIR}/ccil.o: ${OBJECTS} ${COMMON_OFILES}
	${LD} ${LDFLAGS} -o $@ ${OBJECTS} ${COMMON_OFILES}

clean::
	@rm -fr ${TARGET_DIR}

unload:
	@echo "Unloading ccil.o"
	-@rmmod ccil

load: unload
	@echo "Loading ${TARGET_DIR}/ccil.o"
	@./loadccil.bash ${TARGET_DIR}/ccil.o

endif # Section 3

endif # ifneq (${SECTION}, 1)


-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
