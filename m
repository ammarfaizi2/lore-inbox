Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267080AbTAFQ7V>; Mon, 6 Jan 2003 11:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTAFQ7V>; Mon, 6 Jan 2003 11:59:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267102AbTAFQ7F>;
	Mon, 6 Jan 2003 11:59:05 -0500
Date: Mon, 6 Jan 2003 09:04:14 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Documentation/kbuild/makefiles.txt
In-Reply-To: <20030105215137.GA3659@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.33L2.0301051619210.13623-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

This is very good.  Thanks for doing it.

Comments below.


On Sun, 5 Jan 2003, Sam Ravnborg wrote:

| This is the second version of makefiles.txt.
| This is nearly the full version, only a few TODO's left over.
|
| There has been complains about lacking documentation at
| several occasions - this should close that issue.
|
| I would like feedback on:
| - errors in content
| - missing content
| - language
| - spelling etc.
|
| The latter two are important since they can
| distract the reader form the actual content.
Absolutely.

| Attached as plain text to make it readable, I will submit
| a diff for inclusion sometime next week.
|
| Note 1: $(head-y) as descibed is not yet introduced.
|         I have pending patches for this, and the text
|          will be reverted if patch are not accepted.
|
| Note 2: Likewise for optional archclean target. Today
| 	archclean is mandatory.
|
| TODO's
| - Describe how kbuild support shipped files with _shipped.
| - Generating offset header files.
| - Add more variables to section 7?

Can you add a section about building non-kernel-tree drivers etc.?
I.e., building from source files that are not resident in the
kernel tree?

And do you have a section on building in $objtree with
$srctree != $objtree?  I didn't see it.  Or is this not the right
document for that topic?

|
| 	Sam
|
|
| Linux Kernel Makefiles
|
| This document describes the Linux kernel Makefiles.
|
| === Table of Contents
|
| 	=== 1 Overview
| 	=== 2 Who does what
| 	=== 3 The kbuild Makefiles
| 	   --- 3.1 Goal definitions
| 	   --- 3.2 Built-in object goals - obj-y
| 	   --- 3.3 Loadable module goals - obj-m
| 	   --- 3.4 Objects which export symbols - export-objs
| 	   --- 3.5 Library file goals - L_TARGET
| 	   --- 3.6 Descending down in directories
| 	   --- 3.7 Compilation flags
| 	   --- 3.8 Command line dependency
| 	   --- 3.9 Dependency tracking
| 	   --- 3.10 Special Rules
|
| 	=== 4 Host Program support
| 	   --- 4.1 Simple Host Program
| 	   --- 4.2 Composite Host Programs
| 	   --- 4.3 Defining shared libraries
| 	   --- 4.4 Using C++ for host programs
| 	   --- 4.5 Controlling compiler options for host programs
|
| 	=== 5 Kbuild clean infrastructure
|
| 	=== 6 Architecture Makefiles
| 	   --- 6.1 Set variables to tweak the build to the architecture
| 	   --- 6.2 Add prerequisites to prepare:
| 	   --- 6.3 List directories to visit when descending
| 	   --- 6.4 Architecture specific boot images
| 	   --- 6.5 Building non-kbuild targets
| 	   --- 6.6 Commands useful for building a boot image
| 	   --- 6.7 Custom kbuild commands
|
| 	=== 7 Kbuild Variables
| 	=== 8 Makefile language
| 	=== 9 Credits
| 	=== 10 TODO
|
| === 1 Overview
|
| The Makefiles have five parts:
|
| 	Makefile		the top Makefile.
| 	.config			the kernel configuration file.
| 	arch/$(ARCH)/Makefile	the arch Makefile.
| 	scripts/Makefile.*	common rules etc. for all kbuild Makefiles.
| 	kbuild Makefiles	there are about 500 of these.
|
| The top Makefile reads the .config file, which comes from the kernel
| configuration process.
|
| The top Makefile is responsible for building two major products: vmlinux
| (the resident kernel image) and modules (any module files).
| It builds these goals by recursively descending into the subdirectories of
| the kernel source tree.
| The list of subdirectories which are visited depends upon the kernel
| configuration. The top Makefile textually includes an arch Makefile
| with the name arch/$(ARCH)/Makefile. The arch Makefile supplies
| architecture-specific information to the top Makefile.
|
| Each subdirectory has a kbuild Makefile which carries out the commands
| passed down from above. The kbuild Makefile uses information from the
| .config file to construct various file lists used by kbuild to build
| any built-in or modular targets.
|
| scripts/Makefile.* contains all the definitions/rules etc. that
| are used to build the kernel based on the kbuild makefiles.
|
|
| === 2 Who does what
|
| People have four different relationships with the kernel Makefiles.
|
| *Users* are people who build kernels.  These people type commands such as
| "make menuconfig" or "make".  They usually do not read or edit
| any kernel Makefiles (or any other source files).
|
| *Normal developers* are people who work on features such as device
| drivers, file systems, and network protocols.  These people need to
| maintain the kbuild Makefiles for the subsystem that they are
| working on.  In order to do this effectively, they need some overall
| knowledge about the kernel Makefiles, plus detailed knowledge about the
| public interface for kbuild.
|
| *Arch developers* are people who work on an entire architecture, such
| as sparc or ia64.  Arch developers need to know about the arch Makefile
| as well as kbuild Makefiles.
|
| *Kbuild developers* are people who work on the kernel build system itself.
| These people need to know about all aspects of the kernel Makefiles.
|
| This document is aimed towards normal developers and arch developers.
|
|
| === 3 The kbuild Makefiles
|
| Most Makefiles within the kernel is kbuild Makefiles that uses
                                  are                       use
| the kbuild infrastructure. This chapter introduce the syntax used in the
| kbuild makefiles.
|
| Section 3.1 "Goal definitions" is a quick intro, further chapters provide
| more details, with real examples.
|
| --- 3.1 Goal definitions
|
| 	The goal definitions is the main part heart of the kbuild Makefile.
I'd say:
    Goal definitions are the main part (heart) of the kbuild Makefile.
| 	These lines define the files to be built, any special compilation
| 	options, and any subdirectories to be recursively entered.
                                        to be entered recursively.
|
| 	The most simple kbuild makefile contains one line:
|
| 	Example:
| 		obj-y += foo.o
|
| 	This tell kbuild that there is one object in that directory named
| 	foo.o. foo.o will be build from foo.c or foo.s.
                                            Not  foo.S ?
|
| 	If foo.o shall be build as a module, the variable obj-m is used.
                          built
| 	Therefore the following pattern is often used:
|
| 	Example:
| 		obj-$(CONFIG_FOO) += foo.o
|
| 	$(CONFIG_FOO) evaluates to either y (for built-in) or m (for module).
| 	If CONFIG_FOO is neither y nor m, then the file will not be compiled
| 	nor linked.
|
| --- 3.2 Built-in object goals - obj-y
|
| 	The kbuild Makefile specifies object files for vmlinux
| 	in the lists $(obj-y).  These lists depend on the kernel
| 	configuration.
|
| 	Rules.make compiles all the $(obj-y) files.  It then calls
Where is Rules.make nowadays?

| 	"$(LD) -r" to merge these files into one built-in.o file.
| 	built-in.o is later linked into vmlinux by the parent Makefile.
|
| 	The order of files in $(obj-y) is significant.  Duplicates in
| 	the lists are allowed: the first instance will be linked into
| 	built-in.o and succeeding instances will be ignored.
|
| 	Link order is significant, because certain functions
| 	(module_init() / __initcall) will be called during boot in the
| 	order they appear. So keep in mind that changing the link
| 	order may e.g.  change the order in which your SCSI
| 	controllers are detected, and thus you disks are renumbered.
|
| 	Example:
| 		#drivers/isdn/i4l/Makefile
| 		# Makefile for the kernel ISDN subsystem and device drivers.
| 		# Each configuration option enables a list of files.
| 		obj-$(CONFIG_ISDN)             += isdn.o
| 		obj-$(CONFIG_ISDN_PPP_BSDCOMP) += isdn_bsdcomp.o
|
| --- 3.3 Loadable module goals - obj-m
|
| 	$(obj-m) specify object files which are built as loadable
| 	kernel modules.
|
| 	A module may be built from one source file or several source
| 	files. In the case of one source file, the kbuild makefile
| 	simply adds the file to $(obj-m).
|
| 	Example:
| 		#drivers/isdn/i4l/Makefile
| 		obj-$(CONFIG_ISDN_PPP_BSDCOMP) += isdn_bsdcomp.o
|
| 	Note: In this example $(CONFIG_ISDN_PPP_BSDCOMP) evaluates to 'm'
|
| 	If a kernel module is built from several source files, you specify
| 	that you want to build a module in the same way as above.
|
| 	Kbuild needs to know which the parts that you want to build your
| 	module of, so you have to tell it by setting an
              from,
| 	$(<module_name>-objs) variable.
|
| 	Example:
| 		#drivers/isdn/i4l/Makefile
| 		obj-$(CONFIG_ISDN) += isdn.o
| 		isdn-objs := isdn_net_lib.o isdn_v110.o isdn_common.o
|
| 	In this example, the module name will be isdn.o. Kbuild will
| 	compile the objects listed in $(isdn-objs) and then run
| 	"$(LD) -r" on the list of these files to generate isdn.o.
|
| 	Kbuild recognises objects used for composite objects by the suffix
| 	-objs, and the suffix -y. This allows the Makefiles to use
| 	the value of a CONFIG_ symbol to determine if an object is part
| 	of a composite object.
|
| 	Example:
| 		#fs/ext2/Makefile
| 	        obj-$(CONFIG_EXT2_FS)        += ext2.o
| 	 	ext2-y                       := balloc.o bitmap.o
| 	        ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o
|
| 	In this example xattr.o is only part of the composite object
| 	ext2.o, if $(CONFIG_EXT2_FS_XATTR) evaluates to 'y'.
|
| 	Note: Of course, when you are building objects into the kernel,
| 	the syntax above will also work. So, if you have CONFIG_EXT2_FS=y,
| 	kbuild will build an ext2.o file for you out of the individual
| 	parts and then link this into built-in.o, as you would expect.
|
| --- 3.4 Objects which export symbols - export-objs
|
| 	When using loadable modules, not every global symbol in the
| 	kernel / other modules is automatically available, only those
| 	explicitly exported are available for your module.
|
| 	To make a symbol available for use in modules, to "export" it,
| 	use the EXPORT_SYMBOL(<symbol>) directive in your source. In
| 	addition, you need to list all object files which export symbols
| 	(i.e. their source contains an EXPORT_SYMBOL() directive) in the
| 	Makefile variable $(export-objs).
|
| 	Example:
| 		#drivers/isdn/i4l/Makefile
| 		# Objects that export symbols.
| 		export-objs     := isdn_common.o
|
| 	since isdn_common.c contains
|
| 	    EXPORT_SYMBOL(register_isdn);
|
| 	which makes the function register_isdn available to
| 	low-level ISDN drivers.
| 	There exist a EXPORT_SYMBOL_GPLi() variant with similar functionality,
          typo:              remove    i
| 	but more restrictive with what may use that symbol. The requirement
| 	to list the .o file in export-objs is the same.
|
| --- 3.5 Library file goals - L_TARGET
|
| 	Instead of building a built-in.o file, you may also
| 	build an archive which again contains objects listed in $(obj-y).
| 	This is normally not necessary and only used in lib/ and
| 	arch/$(ARCH)/lib directories.
| 	Only the name lib.a is allowed.
|
| 	Example:
| 		#arch/i386/lib/Makefile
| 		L_TARGET := lib.a
| 		obj-y    := checksum.o delay.o
|
| 	This will create a library lib.a based on checksum.o and delay.o.
|
| --- 3.6 Descending down in directories
|
| 	A Makefile is only responsible for building objects in its own
| 	directory. Files in subdirectories should be taken care of by
| 	Makefiles in these subdirs. The build system will automatically
| 	invoke make recursively in subdirectories, provided you let it know of
| 	them.
|
| 	To do so obj-y and obj-m is used.
                                are
| 	ext2 lives in a separate directory, and the Makefile present in fs/
| 	tell kbuild to descend down using the following assignment.
        tells
|
| 	Example:
| 		#fs/Makefile
| 		obj-$(CONfIG_EXT2_FS) += ext2/
|
| 	If CONFIG_EXT2_FS is set to either 'y' (built-in) or 'm' (modular)
| 	the corresponding obj- variable will be set, and kbuild will descend
| 	down in the ext2 directory.
| 	Kbuild only uses this information to decide that it needs to visit
| 	the directory, it is the Makefile in the subdirectory that
| 	specify what is modules and what is built-in.
        specifies
|
| 	It is good practice to use a CONFIG_ variable when assigning direcotory
                                                                    directory
| 	names. This allow kbuild to totally skip the directory if the
                    allows
| 	corresponding CONFIG_ option is neither 'y' nor 'm'.
|
| --- 3.7 Compilation flags
|
|     EXTRA_CFLAGS, EXTRA_AFLAGS, EXTRA_LDFLAGS, EXTRA_ARFLAGS
|
| 	All the EXTRA_ variables apply only to the kbuild makefile
| 	where they are assigned. The EXTRA_ variables apply to all
| 	commands executed in the kbuild makefile.
|
| 	$(EXTRA_CFLAGS) specifies options for compiling C files with
| 	$(CC).
|
| 	Example:
| 		# drivers/sound/emu10k1/Makefile
| 		EXTRA_CFLAGS += -I$(obj)
| 		ifdef DEBUG
| 		    EXTRA_CFLAGS += -DEMU10K1_DEBUG
| 		endif
|
|
| 	This variable is necessary because the top Makefile owns the
| 	variable $(CFLAGS) and uses it for compilation flags for the
| 	entire tree.
|
| 	$(EXTRA_AFLAGS) is a similar string for per-directory options
| 	when compiling assembly language source.
|
| 	Example:
| 		#arch/x86_64/kernel/Makefile
| 		EXTRA_AFLAGS := -traditional
|
|
| 	$(EXTRA_LDFLAGS) and $(EXTRA_ARFLAGS) are similar strings for
| 	per-directory options to $(LD) and $(AR).
|
| 	Example:
| 		#arch/m68k/fpsp040/Makefile
| 		EXTRA_LDFLAGS := -x
|
|     CFLAGS_$@, AFLAGS_$@
|
| 	CFLAGS_$@ and AFLAGS_$@ only apply to commands in current
| 	kbuild makefile.
|
| 	$(CFLAGS_$@) specifies per-file options for $(CC).  The $@
| 	part has a literal value which specifies the file that it is for.
|
| 	Example:
| 		# drivers/scsi/Makefile
| 		CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
| 		CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ \
| 				     -DGDTH_STATISTICS
| 		CFLAGS_seagate.o =   -DARBITRATE -DPARITY -DSEAGATE_USE_ASM
|
| 	These three lines specify compilation flags for aha152x.o,
| 	gdth.o, and seagate.o
|
| 	$(AFLAGS_$@) is a similar feature for source files in assembly
| 	languages.
|
| 	Example:
| 		# arch/arm/kernel/Makefile
| 		AFLAGS_head-armv.o := -DTEXTADDR=$(TEXTADDR) -traditional
| 		AFLAGS_head-armo.o := -DTEXTADDR=$(TEXTADDR) -traditional
|
| --- 3.9 Dependency tracking
|
| 	Kbuild track dependencies on the following:
| 	1) All prerequisite files (both *.c and *.h)
| 	2) CONFIG_ options used in all prerequisite files
| 	3) Command-line used to compile target
|
| 	Thus, if you change an option to $(CC) all affected files will
| 	be re-compiled.
|
| --- 3.10 Special Rules
|
| 	Special rules are used when the kbuild infrastructure does
| 	not provide the required support. A typical example is
| 	header files generated during the build process.
| 	Another example is the architecture specific Makefiles which
| 	needs special rules to prepare boot images etc.
|
| 	Special rules are written as normal Make rules.
| 	Kbuild is not executing in the directory where the Makefile is
| 	located, so all special rules shall provide a relative
| 	path to prerequisite files and target files.
|
| 	Two variables are used when defining special rules:
|
|     $(src)
| 	$(src) is a relative path which point to the directory
                                        points
| 	where the Makefile is located. Always use $(src) when
| 	referring to files located in the src tree.
|
|     $(obj)
| 	$(obj) is a relative path which point to the directory
                                        points
| 	where the Makefile is located. Always use $(obj) when
        where the target is located. (??)
| 	referring to generated files.
|
| 	Example:
| 		#drivers/scsi/Makefile
| 		$(obj)/53c8xx_d.h: $(src)/53c7,8xx.scr $(src)/script_asm.pl
| 			$(CPP) -DCHIP=810 - < $< | ... $(src)/script_asm.pl
|
| 	This is a special rule, following the normal syntax
| 	required by make.
| 	The target file depends on two prerequisite files. References
| 	to the target file are prefixed with $(obj), references
| 	to prerequisites are referenced with $(src) (because they are not
| 	generated files).
|
|
| === 4 Host Program support
|
| Kbuild supports building executable on the host for use during the
                           executables
| compilation stage.
| Two steps is required in order to use a host executable.
            are
|
| First step is to tell kbuild that a host program exits. This is done utilising
 The first step                                ... exists.
| the variable host-prog.
|
| Second step is to add an explicit dependency to the executable.
 The second step ...
| This can be done in two ways. Either add the dependency in a rule, or utilise
| the variable build-targets.
| Both possibilities are described in the following.
|
| --- 4.1 Simple Host Program
|
| 	In some cases there is a need to compile and run a program on the
| 	computer where the build is running.
| 	The following line tell kbuild that the program bin2hex shall be
                           tells
| 	build on the build host.
        built
|
| 	Example:
| 		host-progs := bin2hex
|
| 	Kbuild assume in the above example that bin2hex is made from a single
               assumes
| 	c-source file named bin2hex.c located in the same directory as
| 	the Makefile.
|
| --- 4.2 Composite Host Programs
|
| 	Host programs can be made up based on composite objects.
| 	The syntax used to define composite objetcs for host programs is
| 	similar to the syntax used for kernel objects.
| 	$(<executeable>-objs) list all objects used to link the final
| 	executable.
|
| 	Example:
| 		#scripts/lxdialog/Makefile
| 		host-progs   := lxdialog
| 		hex2bin-objs := checklist.o lxdialog.o
|
| 	Objects with extension .o is compiled from the corresponding .c file.
                                  are               ...                 files.
| 	In the above example checklist.c is compiled to checklist.o and
| 	lxdialog.c is compiled to lxdialog.o.
| 	Finally the two .o files are linked to the executable, lxdialog.
| 	Note: The syntax <executable>-y is not permitted for host-programs.
|
| --- 4.3 Defining shared libraries
|
| 	Objects with extension .so is considered shared libraries, and will
                                   are
| 	be compiled as position independent objects.
| 	Kbuild provide support for shared libraries, but the usage
               provides
| 	shall be restricted.
| 	In the following example the libkconfig.so shared library is used
| 	to link the executable conf.
|
| 	Example:
| 		#scripts/kconfig/Makefile
| 		host-progs      := conf
| 		conf-objs       := conf.o libkconfig.so
| 		libkconfig-objs := expr.o type.o
|
| 	Shared libraries always requires a corresponding -objs line, and
                                require
| 	in the example above the shared library libkconfig are composed by
                                                           is
| 	the two objects expr.o and type.o.
| 	expr.o and type.o will be build as position independent code and
                                  built
| 	linked as a shared library libkconfig.so. C++ is not supported for
| 	shared libraries.
|
| --- 4.4 Using C++ for host programs
|
| 	kbuild offer support for host programs written in C++. This were
               offers                                               was
| 	introduced solely to support kconfig, and is not recommended
| 	for general use.
|
| 	Example:
| 		#scripts/kconfig/Makefile
| 		host-progs    := qconf
| 		qconf-cxxobjs := qconf.o
|
| 	In the example above the executable is composed the the C++ file
                                                        of
| 	qconf.cc - identified by $(qconf-cxxobjs).
|
| 	If qconf are composed by a mixture of .c and .cc files, then an
                 is
| 	additional line can be used to identify this.
|
| 	Example:
| 		#scripts/kconfig/Makefile
| 		host-progs    := qconf
| 		qconf-cxxobjs := qconf.o
| 		qconf-objs    := check.o
|
| --- 4.5 Controlling compiler options for host programs
|
| 	When compiling host programs there exist a possibility to set
	When compiling host programs, it is possible to set specific
	flags.
| 	specific flags.
| 	The programs will always be compiled utilising $(HOSTCC) passed
| 	the options specified in $(HOSTCFLAGS).
| 	To set flags that will take effect for all host programs created
| 	in that Makefile use the variable HOST_EXTRACFLAGS.
|
| 	Example:
| 		#scripts/lxdialog/Makefile
| 		HOST_EXTRACFLAGS += -I/usr/include/ncurses
|
| 	To set specific flags for a single file the following construction
| 	is used:
|
| 	Example:
| 		#arch/ppc64/boot/Makefile
| 		HOSTCFLAGS_piggyback.o := -DKERNELBASE=$(KERNELBASE)
|
| 	It is also possible to specify additional options to the linker.
|
| 	Example:
| 		#scripts/kconfig/Makefile
| 		HOSTLOADLIBES_qconf := -L$(QTDIR)/lib
|
| 	When linking qconf it will be passed the extra option "-L$(QTDIR)/lib".
|
| --- 4.6 When host programs are actually build
                                          built
|
| 	Kbuild will only build host-programs when they are referenced
| 	as a prerequisite.
| 	This is possible in two ways. Either list the prerequisite explicit
                                      (1) List the prerequisite explicitly
| 	in a special rule.
|
| 	Example:
| 		#drivers/pci/Makefile
| 		host-progs := gen-devlist
| 		$(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
| 			( cd $(obj); ./gen-devlist ) < $<
|
| 	The target $(obj)/devlist.h will not be build before
| 	$(obj)/gen-devlist is updated. Note that references to
| 	the host programs in a special rules must be prefixed with $(obj).
                             X(delete)
|
        (2)
| 	When there is no suitable special rule, and the host program
| 	shall be build when a makefile is entered, the $(build-targets)
                 built
| 	variable shall be used.
|
| 	Example:
| 		#scripts/lxdialog/Makefile
| 		host-progs    := lxdialog
| 		build-targets := $(host-progs)
|
| 	This will tell kbuild to build lxdialog even if not referenced in
| 	any rule.
|
| === 5 Kbuild clean infrastructure
|
| "make clean" deletes most generated files in the src tree where the kernel
| is compiled. This includes generated files such as host programs.
| Kbuild knows targets listed in $(host-progs) and $(EXTRA_TARGETS) and
| they are all deleted during "make clean".
| Files matching the patterns "*.[oas]", "*.ko", plus some additional files
| generated by kbuild are delted all over the kernel src tree when "make clean"
                          deleted
| is executed.
|
| Additional files can be specified by means of "clean-files".
|
| 	Example:
| 		#drivers/pci/Makefile
| 		clean-files := devlist.h classlist.h
|
| When executing "make clean", the two files "devlist.h classlist.h" will
| be deleted. Kbuild knows that files specified by $(clean-files) are
| located in the same directory as the makefile.
|
| Usually kbuild descend down in subdirectories due to "obj-* := dir/",
                 descneds
| but in the architecture makefiles where the kbuild infrastructure
| is not sufficent this sometimes needs to be explicit.
|
| 	Example:
| 		#arch/i386/boot/Makefile
| 		subdir- := compressed/
|
 The above assignment...
| Above assignment instructs kbuild to descend down in the directory compressed/
| when "make clean" is executed.
|
| To support the clean infrastructure in the Makefiles that builds the
| final bootimage there is an optional target named archclean:
|
| 	Example:
| 		#arch/i386/Makefile
| 		archclean:
| 			$(Q)$(MAKE) $(clean)=arch/i386/boot
|
| When "make clean" is executed, make will descend down in arch/i386/boot,
| and clean as usual. The Makefile located in arch/i386/boot/ may use
| the subdir- trick to descend further down.
|
| Note 1: arch/$(ARCH)/Makefile cannot use "subdir-", because that file is
| included in the top level makefile, and the kbuild infrastructure
| is not operational at that point.
|
| Note 2: All directories listed in core-y, libs-y, drivers-y and net-y will
| be visited during "make clean".
|
| === 6 Architecture Makefiles
|
| The top level Makefile set up the environment and do the preparation,
                         sets                       does
| before starting to descend down in the individual directories.
| The top level makefile contain the generic part, whereas the
                         contains
| arch/$(ARCH)/Makefile contains what is required to set-up kbuild
| to the said architecture.
| To do so arch/$(ARCH)/Makefile set a number of variables, and define
                                 sets                           defines
| a few targets.
|
| When kbuild executes the following steps are followed (roughly):
| 1) Configuration of the kernel => produced .config
| 2) Store kernel version in include/linux/version.h
| 3) Symlink include/asm to include/asm-$(ARCH)
| 4) Updating all other prerequisites to the target prepare:
|    - Additional prerequisites are specified in arch/$(ARCH)/Makefile
| 5) Recursively descend down in all directories listed in
|    init-* core* drivers-* net-* libs-* and build all targets.
|    - The value of the above variables are extended in arch/$(ARCH)/Makefile.
| 6) All object files are then linked and the resulting file vmlinux are
                                                                     is
|    located at the root of the src tree.
|    The very first objects linked are listed in head-y, assigned by
|    arch/$(ARCH)/Makefile.
Example?  arch/i386/Makefile in 2.5.54 doesn't contain "head-y".

| 7) Finally the architecture specific part does any required post processing
|    and build the final bootimage.
         builds
|    - This includes building boot recoreds,
                                   records
|    - Preparing initrd images and the like
|
|
| --- 6.1 Set variables to tweak the build to the architecture
|
|     LDFLAGS		Linker flags
|
| 	Flags used for all invocations of the linker.
| 	Often specifying the emulation is sufficient.
|
| 	Example:
| 		#arch/s390/Makefile
| 		LDFLAGS         := -m elf_s390
| 	Note: EXTRA_LDFLAGS and LDFLAGS_$@ can be used to further customise
| 	the flags used. See chater 7.
                            chapter
|
|     LDFLAGS_vmlinux	Flags used when linking vmlinux
|
| 	LDFLAGS_vmlinux is used to specify additional flags to pass to
| 	the linker when linking the final vmlinux.
| 	LDFLAGS_vmlinux uses th LDFLAGS_$@ support.
                             the
|
| 	Example:
| 		#arch/i386/Makefile
| 		LDFLAGS_vmlinux := -e stext
|
|     OBJCOPYFLAGS	objcopy flags
|
| 	When $(call if_changed,objcopy) is used to translate a .o file,
| 	then the flags specified in OBJCOPYFLAGS will be used.
| 	$(call if_changed,objcopy) is often used to generate raw binaries on
| 	vmlinux.
|
| 	Example:
| 		#arch/s390/Makefile
| 		OBJCOPYFLAGS := -O binary
|
| 		#arch/s390/boot/Makefile
| 		$(obj)/image: vmlinux FORCE
| 			$(call if_changed,objcopy)
|
| 	In this example the binary $(obj)/image is a binary version of
| 	vmlinux. The usage of $(call if_changed,xxx) will be described later.
|
|
|     LDFLAGS_BLOB	initramfs linker flags
|
| 	The image used for initramfs is made during the build process.
| 	LDFLAGS_BLOB is used to specify additional flags to be used when
| 	creating the initramfs_data.o file.
| 	Example:
| 		#arch/i386/Makefile
| 		LDFLAGS_BLOB := --format binary --oformat elf32-i386
|
|     AFLAGS		$(AS) assembler flags
|
| 	Default value - see top level Makefile
| 	Append or modify as required pr. architecture.
                                     per (?)
|
| 	Example:
| 		#arch/sparc64/Makefile
| 		AFLAGS += -m64 -mcpu=ultrasparc
|
|     CFLAGS		$(CC) compiler flags
|
| 	Default value - see top level Makefile
| 	Append or modify as required pr. architecture.
                                     per (?)
|
| 	Often the CFLAGS variable depends on the configuration.
|
| 	Example:
| 		#arch/i386/Makefile
| 		cflags-$(CONFIG_M386) += -march=i386
| 		CFLAGS += $(cflags-y)
|
| 	Many arch Makefiles dynamically run the target C compiler to
| 	probe supported options:
|
| 		#arch/i386/Makefile
| 		check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc \
| 		            /dev/null\ > /dev/null 2>&1; then echo "$(1)"; \
| 		            else echo "$(2)"; fi)
| 		cflags-$(CONFIG_MCYRIXIII) += $(call check_gcc,\
| 		                                     -march=c3,-march=i486)
|
| 		CFLAGS += $(cflags-y)
|
| 	The above examples both utilise the trick that a config option expands
| 	to 'y' when selected.
|
|     CFLAGS_KERNEL	$(CC) options specific for build-in
                                                   built-in
|
| 	$(CFLAGS_KERNEL) contains extra C compiler flags used to compile
| 	resident kernel code.
|
|     CFLAGS_MODULE	$(CC) options specific for modules
|
| 	$(CFLAGS_MODULE) contains extra C compiler flags used to compile code
| 	for loadable kernel modules.
|
|
| --- 6.2 Add prerequisites to prepare:
|
| 	The prepare: rule is used to list prerequisites that needs to be
| 	build before starting to descend down in the subdirectories.
        built
| 	This is usual header files containing assembler constants.
|
| 		Example:
| 		#arch/s390/Makefile
| 		prepare: include/asm-$(ARCH)/offsets.h
|
| 	In this example the file include/asm-$(ARCH)/offsets.h will
| 	be build before descending down in the subdirectories.
           built
| 	See also chapter XXX-TODO that describe how kbuild supports
| 	generating offset header files.
|
|
| --- 6.3 List directories to visit when descending
|
| 	An arch Makefile cooperates with the top Makefile to define variables
| 	which specify how to build the vmlinux file.  Note that there is no
| 	corresponding arch-specific section for modules; the module-building
| 	machinery is all architecture-independent.
|
|
|     head-y, init-y, core-y, libs-y, drivers-y, net-y
|
| 	$(head-y) list objects to be linked first in vmlinux.
| 	$(libs-y) list directories where a libs.a archieve can be located.
                                                  archive
| 	The rest list directories where a built-in.o object file can be located.
|
| 	$(init-y) objects will be located after $(head-y).
| 	Then the rest follows in this order:
| 	$(core-y), $(libs-y), $(drivers-y) and $(net-y).
|
| 	The top level Makefile define values for all generic directories,
| 	and arch/$(ARCH)/Makefile only adds architecture specific directories.
|
| 	Example:
| 		#arch/sparc64/Makefile
| 		core-y += arch/sparc64/kernel/
| 		libs-y += arch/sparc64/prom/ arch/sparc64/lib/
| 		drivers-$(CONFIG_OPROFILE)  += arch/sparc64/oprofile/
|
|
| --- 6.4 Architecture specific boot images
|
| 	An arch Makefile specifies goals that take the vmlinux file, compress
| 	it, wrap it in bootstrapping code, and copy the resulting files
| 	somewhere. This includes various kinds of installation commands.
| 	The actual goals are not standardized across architectures.
|
| 	It is common to locate any additional processing in a boot/
| 	directory below arch/$(ARCH)/.
|
| 	Kbuild does not provide any smart way to support building a
| 	target specified in boot/ therefore arch/$(ARCH)/Makefile shall
                            boot/.  Therefore
| 	call make manually to build a target in boot/.
|
| 	The recommended approach is to include shortcuts in
| 	arch/$(ARCH)/Makefile, and use the full path when calling down
| 	into the arch/$(ARCH)/boot/Makefile.
|
| 	Example:
| 		#arch/i386/Makefile
| 		boot := arch/i386/boot
| 		bzImage: vmlinux
| 			$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
|
| 	"$(Q)$(MAKE) $(build)=<dir>" is the recommended way to invoke
| 	make in a subdirectory.
|
| 	There is no rules for naming of the architecture specific targets,
              are
| 	but executing "make help" will list all relevant targets.
| 	To support this $(archhelp) must be defined.
|
| 	Example:
| 		#arch/i386/Makefile
| 		define archhelp
| 		  echo  '* bzImage      - Image (arch/$(ARCH)/boot/bzImage)'
| 		endef
|
| 	When make is executed without arguments, the first goal encountered
| 	will be build. In the top level Makefile the first goal present
                built.
| 	is all:.
| 	An architecture shall always per default build a bootable image.
| 	In "make help" the default goal is high-lighted with a '*'.
                                           highlighted
| 	Add a new prerequisite to all: to select a default goal
| 	different from vmlinux.
|
| 	Example:
| 		#arch/i386/Makefile
| 		all: bzImage
|
| 	When "make" is executed without arguments, bzImage will be build.
                                                                   built.
|
| --- 6.5 Building non-kbuild targets
|
|     EXTRA_TARGETS
|
| 	EXTRA_TARGETS specify additionally targets created in current
                              additional
| 	directory, in addition to any target specified by obj-*.
|
| 	Listing all targets in EXTRA_TARGETS are required for three purposes:
                                             is
| 	1) Avoid that the target is linked in as part of built-in.o
| 	2) Enable kbuild to check changes in commandlines
                                             command lines
| 	   - When $(call if_changed,xxx) is used
| 	3) kbuild knows what file to delete during "make clean"
|
| 	Example:
| 		#arch/i386/kernel/Makefile
| 		EXTRA_TARGETS := head.o init_task.o
|
| 	In this example EXTRA_TARGETS is used to list objects files that
                                                      object
| 	shall be built, but shall not be linked as part of built-in.o.
|
| 	Example:
| 		#arch/i386/boot/Makefile
| 		EXTRA_TARGETS := vmlinux.bin bootsect bootsect.o
|
| 	In this example EXTRA_TARGETS is used to list all intermidiate
                                                          intermediate
| 	targets, and all final targets.
| 	The targets are added to EXTRA_TARGETS to enable 2) and 3) above.
|
| --- 6.6 Commands useful for building a boot image
|
| 	Kbuild provide a few macros that are useful when building a
| 	boot image.
|
|     if_changed
|
| 	if_changed is the infrastructure used for the following commands.
|
| 	Usage:
| 		target: source(s) FORCE
| 			$(call if_changed,ld/objcopy/gzip)
|
| 	When the rule is evaluated it is checked if any files needs an update,
 	                                         to see if any files need an update,
| 	or the commandline has changed since last invocation. The latter will
               command line
| 	force a rebuild if any options to the executable has changed.
                                                         have
| 	Any target that utilise if_changed must be listed in EXTRA_TARGETS,
                        utilises
| 	otherwise the commandline check will fail, and the target will always
| 	be build.
           built.
| 	if_changed may be used in conjunction with custom commands as
| 	defined in 6.7 "Custom kbuild commands".
| 	Note: It is a typical mistake to forget the FORCE prerequisite.
|
|     ld
| 	Link target. Often LDFLAGS_$@ is used to set specific options to ld.
|
|     objcopy
| 	Copy binary. Uses OBJCOPYFLAGS usual specified in arch/$(ARCH)/Makefile
                                       usually
|
|     gzip
| 	Compress target. Use maximum compression to compress target.
|
|
| --- 6.7 Custom kbuild commands
|
| 	When kbuild is executing with KBUILD_VERBOSE=0 then only a shorthand
| 	of a command is normally displayed.
| 	To enable this behaviour for custom commands kbuild requires
| 	two variables to be set:
| 	quiet_cmd_<command>	- what shall be echoed
| 	      cmd_<command>	- the command to execute
|
| 	Example:
| 		#
| 		quiet_cmd_image = BUILD   $@
| 		      cmd_image = $(obj)/tools/build $(BUILDFLAGS) \
| 		                                     $(obj)/vmlinux.bin > $@
|
| 		$(obj)/bzImage: $(obj)/vmlinux.bin $(obj)/tools/build FORCE
| 			$(call if_changed,image)
| 			@echo 'Kernel: $@ is ready'
|
| 	When updating the $(obj)/bzImage target the line:
|
| 	BUILD    arch/i386/boot/bzImage
|
| 	will be displayed with "make KBUILD_VERBOSE=0".
It would be nice to have a shorthand notation for this, like -s
means "silent".
|
|
| === 7 Kbuild Variables
|
| The top Makefile exports the following variables:
|
|     VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION
|
| 	These variables define the current kernel version.  A few arch
| 	Makefiles actually use these values directly; they should use
| 	$(KERNELRELEASE) instead.
|
| 	$(VERSION), $(PATCHLEVEL), and $(SUBLEVEL) define the basic
| 	three-part version number, such as "2", "4", and "0".  These three
| 	values are always numeric.
|
| 	$(EXTRAVERSION) defines an even tinier sublevel for pre-patches
| 	or additional patches.	It is usually some non-numeric string
| 	such as "-pre4", and is often blank.
|
|     KERNELRELEASE
|
| 	$(KERNELRELEASE) is a single string such as "2.4.0-pre4", suitable
| 	for constructing installation directory names or showing in
| 	version strings.  Some arch Makefiles use it for this purpose.
|
|     ARCH
|
| 	This variable defines the target architecture, such as "i386",
| 	"arm", or "sparc". Some kbuild Makefiles test $(ARCH) to
| 	determine which files to compile.
|
| 	By default, the top Makefile sets $(ARCH) to be the same as the
| 	host system system architecture.  For a cross build, a user may
             ^I think that it's safe to delete one of these "system"s.
| 	override the value of $(ARCH) on the command line:
|
| 	    make ARCH=m68k ...
|
Move variable name up, before its description, to be like above:
|     INSTALL_MOD_PATH, MODLIB
|
| 	This variable defines a place for the arch Makefiles to install
| 	the resident kernel image and System.map file.
|
|
| 	$(INSTALL_MOD_PATH) specifies a prefix to $(MODLIB) for module
| 	installation.  This variable is not defined in the Makefile but
| 	may be passed in by the user if desired.
|
| 	$(MODLIB) specifies the directory for module installation.
| 	The top Makefile defines $(MODLIB) to
| 	$(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE).  The user may
| 	override this value on the command line if desired.
|
| === 8 Makefile language
|
| The kernel Makefiles are designed to run with GNU Make.  The Makefiles
| uses only the documented features of GNU Make, but they do use many
  use
| GNU extensions.
|
| GNU Make supports elementary list-processing functions.  The kernel
| Makefiles use a novel style of list building and manipulation with few
| "if" statements.
|
| GNU Make has two assignment operators, ":=" and "=".  ":=" performs
| immediate evaluation of the right-hand side and stores an actual string
| into the left-hand side.  "=" is like a formula definition; it stores the
| right-hand side in an unevaluated form and then evaluates this form each
| time the left-hand side is used.
|
| There are some cases where "=" is appropriate.  Usually, though, ":="
| is the right choice.
|
| === 9 Credits
|
| Original version made by Michael Elizabeth Chastain, <mailto:mec@shout.net>
| Updates by Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
| Updates by Sam Ravnborg <sam@ravnborg.org>
|
| === 10 TODO
|
| - Describe how kbuild support shipped files with _shipped.
| - Generating offset header files.
| - Add more variables to section 7?
| -

HTH.
-- 
~Randy



