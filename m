Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTIJHxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTIJHxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:53:18 -0400
Received: from dp.samba.org ([66.70.73.150]:5609 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264988AbTIJHwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:52:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: kernel-janitors@osdl.org, Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] Remove modules.txt
Date: Wed, 10 Sep 2003 17:45:43 +1000
Message-Id: <20030910075240.F17CB2C75C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Stephen Hemminger for pointing out how obsolete modules.txt is.

modules.txt contains mainly ancient information which is replicated
in the kconfig help message, README, makefile.txt or the modprobe manual
page.  The only part which is not covered elsewhere is the "building
external modules" which is still being debated (and belongs under the
kbuild docs).  kmod.txt reference removed from index, too.

Please sent patches to update Kconfig files which referred to
modules.txt in small pieces to trivial at rustcorp.com.au.
Please abbreviate wording, too, as follows:
  
 -	  To compile this driver as a module ( = code which can be inserted in
 -	  and removed from the running kernel whenever you want), say M here
 -	  and read <file:Documentation/modules.txt>. The module will be called
 -	  apm.
 +	  To compile this driver as a module, say M here: the
 +	  module will be called apm.

Thanks!
Rusty.

Name: Remove obsolete modules.txt, update module help
Author: Rusty Russell
Status: Trivial

D: Thanks to Stephen Hemminger for pointing out how obsolete modules.txt is.
D: 
D: modules.txt contains mainly ancient information which is replicated
D: in the kconfig help message, README, makefile.txt or the modprobe manual
D: page.  The only part which is not covered elsewhere is the "building
D: external modules" which is still being debated (and belongs under the
D: kbuild docs).  kmod.txt reference removed from index, too.
D: 
D: Please sent patches to update Kconfig files which referred to
D: modules.txt in small pieces to trivial at rustcorp.com.au.
D: Please abbreviate wording, too, as follows:
D:   
D: -	  To compile this driver as a module ( = code which can be inserted in
D: -	  and removed from the running kernel whenever you want), say M here
D: -	  and read <file:Documentation/modules.txt>. The module will be called
D: -	  apm.
D: +	  To compile this driver as a module, say M here: the
D: +	  module will be called apm.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7926-linux-2.6.0-test5/Documentation/00-INDEX .7926-linux-2.6.0-test5.updated/Documentation/00-INDEX
--- .7926-linux-2.6.0-test5/Documentation/00-INDEX	2003-08-25 11:58:09.000000000 +1000
+++ .7926-linux-2.6.0-test5.updated/Documentation/00-INDEX	2003-09-10 17:41:25.000000000 +1000
@@ -116,8 +116,6 @@ kernel-docs.txt
 	- listing of various WWW + books that document kernel internals.
 kernel-parameters.txt
 	- summary listing of command line / boot prompt args for the kernel.
-kmod.txt
-	- info on the kernel module loader/unloader (kerneld replacement).
 ldm.txt
 	- a brief description of LDM (Windows Dynamic Disks).
 locks.txt
@@ -144,8 +142,6 @@ mkdev.cciss
 	- script to make /dev entries for SMART controllers (see cciss.txt)
 mkdev.ida
 	- script to make /dev entries for Intelligent Disk Array Controllers.
-modules.txt
-	- short guide on how to make kernel parts into loadable modules
 moxa-smartio
 	- info on installing/using Moxa multiport serial driver.
 mtrr.txt
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7926-linux-2.6.0-test5/Documentation/modules.txt .7926-linux-2.6.0-test5.updated/Documentation/modules.txt
--- .7926-linux-2.6.0-test5/Documentation/modules.txt	2003-02-11 14:25:50.000000000 +1100
+++ .7926-linux-2.6.0-test5.updated/Documentation/modules.txt	1970-01-01 10:00:00.000000000 +1000
@@ -1,264 +0,0 @@
-This file describes the strategy for dynamically loadable modules
-in the Linux kernel. This is not a technical description on
-the internals of module, but mostly a sample of how to compile
-and use modules.
-
-Note: You should ensure that the module-init-tools-X.Y.Z.tar.gz you
-are using is the most up to date one for this kernel.  Some older
-modules packages aren't aware of some of the newer modular features
-that the kernel now supports.  The current required version is listed
-in the file linux/Documentation/Changes.
-
-In the beginning...
--------------------
-
-Anyway, your first step is to compile the kernel, as explained in the
-file linux/README.  It generally goes like:
-
-	make *config <= usually menuconfig or xconfig
-	make clean
-	make zImage or make zlilo
-
-In "make config", you select what you want to include in the "resident"
-kernel and what features you want to have available as loadable modules.
-You will generally select the minimal resident set that is needed to boot:
-
-	The filesystem of your root partition
-	A scsi driver, but see below for a list of SCSI modules!
-	Normal hard drive support
-	Net support (CONFIG_NET)
-	TCP/IP support (CONFIG_INET), but no drivers!
-
-	plus those things that you just can't live without...
-
-The set of modules is constantly increasing, and you will be able to select
-the option "m" in "make menuconfig" for those features that the current kernel
-can offer as loadable modules.
-
-You also have a possibility to create modules that are less dependent on
-the kernel version.  This option can be selected during "make *config", by
-enabling CONFIG_MODVERSIONS, and is most useful on "stable" kernel versions,
-such as the kernels from the 2.<even number> series.
-If you have modules that are based on sources that are not included in
-the official kernel sources, you will certainly like this option...
-See below how to compile modules outside the official kernel.
-
-Here is a sample of the available modules included in the kernel sources:
-
-	Most filesystems: minix, msdos, umsdos, sysv, isofs, hpfs,
-			  smbfs, nfs
-
-	Mid-level SCSI support (required by top and low level scsi drivers).
-	Most low-level SCSI drivers: (i.e. aha1542, in2000)
-	All SCSI high-level drivers: disk, tape, cdrom, generic.
-
-	Most Ethernet drivers: (too many to list, please see the file
-				./Documentation/networking/net-modules.txt)
-
-	Most CDROM drivers:
-		aztcd:     Aztech,Orchid,Okano,Wearnes
-		cm206:     Philips/LMS CM206
-		gscd:      Goldstar GCDR-420
-		mcd, mcdx: Mitsumi LU005, FX001
-		optcd:     Optics Storage Dolphin 8000AT
-		sjcd:      Sanyo CDR-H94A
-		sbpcd:     Matsushita/Panasonic CR52x, CR56x, CD200,
-		           Longshine LCS-7260, TEAC CD-55A
-		sonycd535: Sony CDU-531/535, CDU-510/515
-
-	And a lot of misc modules, such as:
-		lp: line printer
-		binfmt_elf: elf loader
-		binfmt_java: java loader
-		isp16: cdrom interface
-		serial: the serial (tty) interface
-
-When you have made the kernel, you create the modules by doing:
-
-	make modules
-
-This will compile all modules. A module is identified by the
-extension .ko, for kernel object.
-Now, after you have created all your modules, you should also do:
-
-	make modules_install
-
-This will copy all newly made modules into subdirectories under
-"/lib/modules/kernel_release/", where "kernel_release" is something
-like 2.5.54, or whatever the current kernel version is.
-Note: Installing modules may require root privileges.
-
-As soon as you have rebooted the newly made kernel, you can install
-and remove modules at will with the utilities: "insmod" and "rmmod".
-After reading the man-page for insmod, you will also know how easy
-it is to configure a module when you do "insmod" (hint: symbol=value).
-
-Installing modules in a non-standard location
----------------------------------------------
-When the modules needs to be installed under another directory
-the INSTALL_MOD_PATH can be used to prefix "/lib/modules" as seen
-in the following example:
-
-make INSTALL_MOD_PATH=/frodo modules_install
-
-This will install the modules in the directory /frodo/lib/modules.
-/frodo can be a NFS mounted filesystem on another machine, allowing
-out-of-the-box support for installation on remote machines.
-
-
-Compiling modules outside the official kernel
----------------------------------------------
-Often modules are developed outside the official kernel.
-To keep up with changes in the build system the most portable way
-to compile a module outside the kernel is to use the following command-line:
-
-make -C path/to/kernel/src SUBDIRS=$PWD modules
-
-This requires that a makefile exits made in accordance to
-Documentation/kbuild/makefiles.txt.
-
-Nifty features:
----------------
-
-You also have access to two utilities: "modprobe" and "depmod", where
-modprobe is a "wrapper" for (or extension to) "insmod".
-These utilities use (and maintain) a set of files that describe all the
-modules that are available for the current kernel in the /lib/modules
-hierarchy as well as their interdependencies.
-
-Using the modprobe utility, you can load any module like this:
-
-	/sbin/modprobe module
-
-without paying much attention to which kernel you are running, or what
-other modules this module depends on.
-
-With the help of the modprobe configuration file: "/etc/modules.conf"
-you can tune the behaviour of modprobe in many ways, including an
-automatic setting of insmod options for each module.
-And, yes, there _are_ man-pages for all this...
-
-To use modprobe successfully, you generally place the following
-command in your /etc/rc.d/rc.S script.  (Read more about this in the
-"rc.hints" file in the module utilities package,
-"module-init-tools-x.y.z.tar.gz".)
-
-	/sbin/depmod -a
-
-This computes the dependencies between the different modules.
-Then if you do, for example
-
-	/sbin/modprobe umsdos
-
-you will automatically load _both_ the msdos and umsdos modules,
-since umsdos runs piggyback on msdos.
-
-
-Using modinfo:
---------------
-
-Sometimes you need to know what parameters are accepted by a
-module or you've found a bug and want to contact the maintainer.
-Then modinfo comes in very handy.
-
-Every module (normally) contains the author/maintainer,
-a description and a list of parameters.
-
-For example "modinfo -a eepro100" will return:
-
-	Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>
-
-and "modinfo -d eepro100" will return a description:
-
-	Intel i82557/i82558 PCI EtherExpressPro driver
-
-and more important "modinfo -p eepro100" will return this list:
-
-	debug int
-	options int array (min = 1, max = 8)
-	full_duplex int array (min = 1, max = 8)
-	congenb int
-	txfifo int
-	rxfifo int
-	txdmacount int
-	rxdmacount int
-	rx_copybreak int
-	max_interrupt_work int
-	multicast_filter_limit int
-
-
-The "ultimate" utility:
------------------------
-
-OK, you have read all of the above, and feel amply impressed...
-Now, we tell you to forget all about how to install and remove
-loadable modules...
-With the kerneld daemon, all of these chores will be taken care of
-automatically.  Just answer "Y" to CONFIG_KERNELD in "make config",
-and make sure that /sbin/kerneld is started as soon as possible
-after boot and that "/sbin/depmod -a" has been executed for the
-current kernel. (Read more about this in the module utilities package.)
-
-Whenever a program wants the kernel to use a feature that is only
-available as a loadable module, and if the kernel hasn't got the
-module installed yet, the kernel will ask the kerneld daemon to take
-care of the situation and make the best of it.
-
-This is what happens:
-
-	- The kernel notices that a feature is requested that is not
-	  resident in the kernel.
-	- The kernel sends a message to kerneld, with a symbolic
-	  description of the requested feature.
-	- The kerneld daemon asks e.g. modprobe to load a module that
-	  fits this symbolic description.
-	- modprobe looks into its internal "alias" translation table
-	  to see if there is a match.  This table can be reconfigured
-	  and expanded by having "alias" lines in "/etc/modules.conf".
-	- insmod is then asked to insert the module(s) that modprobe
-	  has decided that the kernel needs.  Every module will be
-	  configured according to the "options" lines in "/etc/modules.conf".
-	- modprobe exits and kerneld tells the kernel that the request
-	  succeeded (or failed...)
-	- The kernel uses the freshly installed feature just as if it
-	  had been configured into the kernel as a "resident" part.
-
-The icing of the cake is that when an automatically installed module
-has been unused for a period of time (usually 1 minute), the module
-will be automatically removed from the kernel as well.
-
-This makes the kernel use the minimal amount of memory at any given time,
-making it available for more productive use than as just a placeholder for
-unused code.
-
-Actually, this is only a side-effect from the _real_ benefit of kerneld:
-You only have to create a minimal kernel, that is more or less independent
-of the actual hardware setup.  The setup of the "virtual" kernel is
-instead controlled by a configuration file as well as the actual usage
-pattern of the current machine and its kernel.
-This should be good news for maintainers of multiple machines as well as
-for maintainers of distributions.
-
-To use kerneld with the least amount of "hassle", you need modprobe from
-a release that can be considered "recent" w.r.t. your kernel, and also
-a configuration file for modprobe ("/etc/modules.conf").
-Since modprobe already knows about most modules, the minimal configuration
-file could look something like this:
-
-	alias scsi_hostadapter aha1542  # or whatever SCSI adapter you have
-	alias eth0 3c509	# or whatever net adapter you have
-	# you might need an "options" line for some net adapters:
-	options 3c509 io=0x300 irq=10
-	# you might also need an "options" line for some other module:
-	options cdu31a cdu31a_port=0x1f88 sony_pas_init=1
-
-You could add these lines as well, but they are only "cosmetic":
-
-	alias net-pf-3 off	# no ax25 module available (yet)
-	alias net-pf-4 off	# if you don't use the ipx module
-	alias net-pf-5 off	# if you don't use the appletalk module
-
-
-Written by:
-	Jacques Gelinas <jacques@solucorp.qc.ca>
-	Bjorn Ekwall <bj0rn@blox.se>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7926-linux-2.6.0-test5/init/Kconfig .7926-linux-2.6.0-test5.updated/init/Kconfig
--- .7926-linux-2.6.0-test5/init/Kconfig	2003-09-09 10:35:05.000000000 +1000
+++ .7926-linux-2.6.0-test5.updated/init/Kconfig	2003-09-10 17:41:16.000000000 +1000
@@ -204,15 +204,22 @@ menu "Loadable module support"
 config MODULES
 	bool "Enable loadable module support"
 	help
-	  Kernel modules are small pieces of compiled code which can be
-	  inserted in or removed from the running kernel, using the programs
-	  insmod and rmmod. This is described in the file
-	  <file:Documentation/modules.txt>, including the fact that you have
-	  to say "make modules" in order to compile the modules that you chose
-	  during kernel configuration.  Modules can be device drivers, file
-	  systems, binary executable formats, and so on. If you think that you
-	  may want to make use of modules with this kernel in the future, then
-	  say Y here.  If unsure, say Y.
+	  Kernel modules are small pieces of compiled code which can
+	  be inserted in the running kernel, rather than being
+	  permanently built into the kernel.  You use the "modprobe"
+	  tool to add (and sometimes remove) them.  If you say Y here,
+	  many parts of the kernel can be built as modules (by
+	  answering M instead of Y where indicated): this is most
+	  useful for infrequently used options which are not required
+	  for booting.  For more information, see the man pages for
+	  modprobe, lsmod, modinfo, insmod and rmmod.
+
+	  If you say Y here, you will need to run "make
+	  modules_install" to put the modules under /lib/modules/
+	  where modprobe can find them (you may need to be root to do
+	  this).
+
+	  If unsure, say Y.
 
 config MODULE_UNLOAD
 	bool "Module unloading"
@@ -251,21 +258,18 @@ config MODVERSIONS
 	  compiled for different kernels, by adding enough information
 	  to the modules to (hopefully) spot any changes which would
 	  make them incompatible with the kernel you are running.  If
-	  you say Y here, you will need a copy of genksyms.  If
 	  unsure, say N.
 
 config KMOD
-	bool "Kernel module loader"
+	bool "Automatic kernel module loading"
 	depends on MODULES
 	help
-	  Normally when you have selected some drivers and/or file systems to
-	  be created as loadable modules, you also have the responsibility to
-	  load the corresponding modules (using the programs insmod or
-	  modprobe) before you can use them. If you say Y here however, the
-	  kernel will be able to load modules for itself: when a part of the
-	  kernel needs a module, it runs modprobe with the appropriate
-	  arguments, thereby loading the module if it is available. (This is a
-	  replacement for kerneld.) Say Y here and read about configuring it
-	  in <file:Documentation/kmod.txt>.
+	  Normally when you have selected some parts of the kernel to
+	  be created as kernel modules, you must load them (using the
+	  "modprobe" command) before you can use them. If you say Y
+	  here, some parts of the kernel will be able to load modules
+	  automatically: when a part of the kernel needs a module, it
+	  runs modprobe with the appropriate arguments, thereby
+	  loading the module if it is available.  If unsure, say Y.
 
 endmenu
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

