Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTACTwE>; Fri, 3 Jan 2003 14:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTACTwE>; Fri, 3 Jan 2003 14:52:04 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:37903 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267636AbTACTv6>;
	Fri, 3 Jan 2003 14:51:58 -0500
Date: Fri, 3 Jan 2003 21:00:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [RFC] Documentation/kbuild/makefiles.txt
Message-ID: <20030103200016.GA3941@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for the kbbuild makefiles has lacked behind a little.
Entering the feature freeze it was about time to get it updated.
I have started updated the sections describing the normal makefiles,
in this description called "kbuild makefiles".

On purpose not as a diff, since I have reshuffled the original document.
The info people seeks is now closer to the beginning of the document.

What I post here is what I plan to provide for the kbuild makefiles,
if you need more/other info let me know.

Any input regarding detail level, structure, spelling and language
appreciated.

I'm planning to add the following:

  kbuild variables
	- Short intro to all public variables not covered so far

  Adding a new architecture
	- What requirements needs to be fulfilled
	- Typical directory structure
    [This section will be brief, since noone does this without
    looking into whats done so far, especially for i386].

	Sam



Linux Kernel Makefiles


=== Table of Contents

This document describes the Linux kernel Makefiles.

	1 Overview
	2 Who does what
	3 The kbuild Makefile
	  3.1 Goal definitions
	  3.2 Built-in object goals - obj-y
	  3.3 Loadable module goals - obj-m
	  3.4 Objects which export symbols - export-objs
	  3.5 Library file goals - L_TARGET
	  3.6 Descending down in directories
	  3.7 Compilation flags
	  3.8 Command line dependency


=== 1 Overview

The Makefiles have five parts:

	Makefile		the top Makefile.
	.config			the kernel configuration file.
	arch/$(ARCH)/Makefile	the arch Makefile.
	scripts/Makefile.*	common rules etc. for all kbuild Makefiles.
	kbuild Makefiles	there are about 500 of these.

The top Makefile reads the .config file, which comes from the kernel
configuration process.

The top Makefile is responsible for building two major products: vmlinux
(the resident kernel image) and modules (any module files).
It builds these goals by recursively descending into the subdirectories of
the kernel source tree.
The list of subdirectories which are visited depends upon the kernel
configuration. The top Makefile textually includes an arch Makefile
with the name arch/$(ARCH)/Makefile. The arch Makefile supplies
architecture-specific information to the top Makefile.

Each subdirectory has a kbuild Makefile which carries out the commands
passed down from above. The kbuild Makefile uses information from the
.config file to construct various file lists used by kbuild to build 
any built-in or modular targets.

scripts/Makefile.* contains all the definitions/rules etc. that
is used to build the kernel based on the kbuild makefiles.


=== 2 Who does what

People have four different relationships with the kernel Makefiles.

*Users* are people who build kernels.  These people type commands such as
"make menuconfig" or "make bzImage".  They usually do not read or edit
any kernel Makefiles (or any other source files).

*Normal developers* are people who work on features such as device
drivers, file systems, and network protocols.  These people need to
maintain the kbuild Makefiles for the subsystem that they are
working on.  In order to do this effectively, they need some overall
knowledge about the kernel Makefiles, plus detailed knowledge about the
public interface for kbuild.

*Arch developers* are people who work on an entire architecture, such
as sparc or ia64.  Arch developers need to know about the arch Makefile
as well as kbuild Makefiles.

*Kbuild developers* are people who work on the kernel build system itself.
These people need to know about all aspects of the kernel Makefiles.

This document is aimed towards normal developers and arch developers.


=== 3 The kbuild Makefile

Most Makefiles within the kernel is kbuild Makefiles, that uses
the kbuild infrastructure. This chapter introduce the syntax used in the
kbuild makefiles, and in the end list some common constructions.

Section 4.1 "Goal definitions" is a quick intro, further chapters provide
more details, with real examples.

--- 3.1 Goal definitions

	The goal definitions is the main part heart of the kbuild Makefile.
	These lines define the files to be built, any special compilation
	options, and any subdirectories to be recursively entered.

	The most simple kbuild makefile contains one line:

		obj-y += foo.o

	This tell kbuild that there is one object in that directory named
	foo.o. foo.o will be build from foo.c or foo.s.

	If foo.o is to be build as a module, the variable obj-m is used.
	Therefore the following pattern is often used:

		obj-$(CONFIG_FOO) += foo.o

	$(CONFIG_FOO) evaluates to either y (for built-in) or m (for module).
	If CONFIG_FOO is neither y nor m, then the file will not be compiled
	nor linked.



--- 3.2 Built-in object goals - obj-y

	The kbuild Makefile specifies object files for vmlinux
	in the lists $(obj-y).  These lists depend on the kernel
	configuration.

	Rules.make compiles all the $(obj-y) files.  It then calls
	"$(LD) -r" to merge these files into one built-in.o file.
	built-in.o is later linked into vmlinux by the parent Makefile.

	The order of files in $(obj-y) is significant.  Duplicates in
	the lists are allowed: the first instance will be linked into
	built-in.o and succeeding instances will be ignored.

	Link order is significant, because certain functions
	(module_init() / __initcall) will be called during boot in the
	order they appear. So keep in mind that changing the link
	order may e.g.  change the order in which your SCSI
	controllers are detected, and thus you disks are renumbered.

	Example:

		# Makefile for the kernel ISDN subsystem and device drivers.
		# Each configuration option enables a list of files.
		obj-$(CONFIG_ISDN)                      += isdn.o
		obj-$(CONFIG_ISDN_PPP_BSDCOMP)          += isdn_bsdcomp.o


--- 3.3 Loadable module goals - obj-m

	$(obj-m) specify object files which are built as loadable
	kernel modules.

	A module may be built from one source file or several source
	files. In the case of one source file, the kbuild
	Makefile simply adds the file to $(obj-m).

	Example:

		obj-$(CONFIG_ISDN_PPP_BSDCOMP) += isdn_bsdcomp.o

	Note: In this example $(CONFIG_ISDN_PPP_BSDCOMP) evaluates to 'm'

	If a kernel module is built from several source files, you specify
	that you want to build a module in the same way as above.

	Kbuild needs to know which the parts that you want to build your
	module of, so you have to tell it by setting an
	$(<module_name>-objs) variable.

	Example:

		obj-$(CONFIG_ISDN) += isdn.o

		isdn-objs := isdn_net.o isdn_tty.o isdn_v110.o isdn_common.o

	In this example, the module name will be isdn.o. Kbuild will
	compile the objects listed in $(isdn-objs) and then run
	"$(LD) -r" on the list of these files to generate isdn.o.

	Kbuild recognises objects used for composite objects by the prefix
	-objs, and the prefix -y. 

	        obj-$(CONFIG_EXT2_FS)        += ext2.o
        	ext2-y                       := balloc.o bitmap.o
	        ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o
	
	In this example xattr.o is only part of the composite object
	ext2.o, if $(CONFIG_EXT2_FS_XATTR) evaluates to 'y'.

	Note: Of course, when you are building objects into the kernel,
	the syntax above will also work. So, if you have CONFIG_ISDN=y,
	the build system will build an isdn.o for you out of the individual
	parts and then link this into built-in.o, as you'd expect.


--- 3.4 Objects which export symbols - export-objs

	When using loadable modules, not every global symbol in the
	kernel / other modules is automatically available, only those
	explicitly exported are available for your module.

	To make a symbol available for use in modules, to "export" it,
	use the EXPORT_SYMBOL(<symbol>) directive in your source. In
	addition, you need to list all object files which export symbols
	(i.e. their source contains an EXPORT_SYMBOL() directive) in the
	Makefile variable $(export-objs).

	Example:

	    # Objects that export symbols.

	    export-objs     := isdn_common.o

        since isdn_common.c contains

	    EXPORT_SYMBOL(register_isdn);

	which makes the function register_isdn available to
	low-level ISDN drivers.
	There exist a EXPORT_SYMBOL_GPL whit similar functionality, but
	more restrictive with what may use that symbol.

--- 3.5 Library file goals - L_TARGET

        Instead of building a built-in.o file, you may also
	build an archive which again contains objects listed in
	$(obj-y). This is normally not necessary and only used in
	the lib, arch/$(ARCH)/lib directories.
	Only the name lib.a is allowed.

		L_TARGET := lib.a
		obj-y    := checksum.o delay.o

	This will create a library based on checksum.o and delay.o.


--- 3.6 Descending down in directories

	A Makefile is only responsible for building objects in its own
	directory. Files in subdirectories should be taken care of by
	Makefiles in these subdirs. The build system will automatically
	invoke make recursively in subdirectories, provided you let it know of
	them.

	To do so obj-y and obj-m is used.
	ext2 lives in a separate directory, and the Makefile present in fs/
	tell kbuild to descend down using the following assignment.

		obj-$(CONfIG_EXT2_FS) += ext2/

	If CONFIG_EXT2_FS is set to either 'y' (built-in) or 'm' (modular)
	the corresponding obj- variable will be set, and kbuild will descend
	down in the ext2 directory.
	Kbuild only uses this information to decide that it needs to visit
	the directory, it is the Makefile in the subdirectory that
	specify what is modules and what is built-in.

	It is good practice to use the above type of assignment where a
	CONFIG_ variable is used. This allow kbuild to totally skip the
	directory if the corresponding CONFIG_ option is neither 'y' nor 'm'.

--- 3.7 Compilation flags

    EXTRA_CFLAGS, EXTRA_AFLAGS, EXTRA_LDFLAGS, EXTRA_ARFLAGS

	$(EXTRA_CFLAGS) specifies options for compiling C files with
	$(CC).	The options in this variable apply to all $(CC) commands
	for files in the current directory.

	Example:

		# drivers/sound/emu10k1/Makefile
		EXTRA_CFLAGS += -I$(obj)
		ifdef DEBUG
		    EXTRA_CFLAGS += -DEMU10K1_DEBUG
		endif

	$(EXTRA_CFLAGS) does not apply to subdirectories of the current
	directory.

	This variable is necessary because the top Makefile owns the
	variable $(CFLAGS) and uses it for compilation flags for the
	entire tree.

	$(EXTRA_AFLAGS) is a similar string for per-directory options
	when compiling assembly language source.

	Example:
		#arch/x86_64/kernel/Makefile
		EXTRA_AFLAGS := -traditional


	$(EXTRA_LDFLAGS) and $(EXTRA_ARFLAGS) are similar strings for
	per-directory options to $(LD) and $(AR).

	Example:
		#arch/m68k/fpsp040/Makefile
		EXTRA_LDFLAGS := -x

    CFLAGS_$@, AFLAGS_$@

	$(CFLAGS_$@) specifies per-file options for $(CC).  The $@
	part has a literal value which specifies the file that it's for.

	Example:
		# drivers/scsi/Makefile
		CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
		CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ \
				     -DGDTH_STATISTICS
		CFLAGS_seagate.o =   -DARBITRATE -DPARITY -DSEAGATE_USE_ASM

	These three lines specify compilation flags for aha152x.o,
	gdth.o, and seagate.o

	$(AFLAGS_$@) is a similar feature for source files in assembly
	languages.

	Example:
		# arch/arm/kernel/Makefile
		AFLAGS_head-armv.o := -DTEXTADDR=$(TEXTADDR) -traditional
		AFLAGS_head-armo.o := -DTEXTADDR=$(TEXTADDR) -traditional

--- 3.8 Command line dependency

	Kbuild has a feature where an object file depends on the
	command used to compile it.
	Thus, if you change an option to $(CC) all affected files will
	be re-compiled.

=== 4 Host Program support

	Kbuild supports building executable on the host for use during
	the compilation stage.
	Two steps is required in order to use a host executable.

	First step is to tell kbuild that a host program exits. This is done
	utilising the variable host-prog.

	Second step is to add an explicit dependency to the executable.
	This can be done in two ways. Either add the dependency in a rule,
	or utilise the variable build-targets.
	Both possibilities are defined in the following.

--- 4.1 Simple Host Program

	In some cases there is a need to compile and run a program on the
	computer where the build is running.
	The following line tell kbuild that the program bin2hex shall be
	build on the build host.

		host-progs := bin2hex

	Kbuild assume in the above example that bin2hex is made from a single
	c-source file named bin2hex.c located in the same directory as
	the Makefile.
  
--- 4.2 Composite Host Programs

	Host programs can be made up based on composite objects.
	The syntax used to define composite objetcs for host programs is
	similar to the syntax used for kernel objects.

		host-progs   := lxdialog  
		hex2bin-objs := checklist.o lxdialog.o

	Objects with extension .o is compiled from the corresponding .c file.
	In the above example checklist.c is compiled to checklist.o and
	lxdialog.c is compiled to lxdialog.o.
	Finally the two .o files are linked to the final executable, lxdialog.

--- 4.3 Defining shared libraries  
  
	Objects with extension .so is considered shared libraries, and will
	be compiled as position independent (-PIC) objects.
	Kbuild provide support for shared libraries, but the usage
	shall be restricted.
	In the following example the libkconfig.so shared library is used
	to link the executable conf.

		host-progs      := conf
		conf-objs       := conf.o libkconfig.so
		libkconfig-objs := expr.o type.o
  
	Shared libraries always requires a corresponding -objs line, and
	in the example above the shared library libkconfig are composed by
	the two objects expr.o and type.o.
	expr.o and type.o will be build as position independent code and
	linked as a shared library libkconfig.so.

--- 4.4 Using C++ for host programs

	kbuild offer support for host programs written in C++. This were
	introduced solely to support kconfig, and is not recommended
	for general use.

		host-progs    := qconf
		qconf-cxxobjs := qconf.o

	In the example above the executable is composed the the C++ file
	qconf.cc - identified by $(qconf-cxxobjs).
	
	If qconf were composed by a mixture of .c and .cc files, then an
	additional line can be used to identify this.

		qconf-objs    := check.o
	
--- 4.5 Controlling compiler options for host programs

	When compiling host programs there exist a possibility to set
	specific flags.
	The programs will always be compiled utilising $(HOSTCC) passed
	the options specified in $(HOSTCFLAGS).
	To set flags that will take effect for all host programs created
	in that Makefile use the variable HOST_EXTRACFLAGS.

		HOST_EXTRACFLAGS := -DLinux
  
	To set specific flags for a single file the following construction
	is used:

		HOSTCFLAGS_object.o := -DENDIAN=LITTLE_ENDIAN
  
	It is also possible to specify additional options to the linker.
  
		HOSTLOADLIBES_qconf := -L/lib

	When linking qconf it will be passed the extra option "-L/lib".
  
