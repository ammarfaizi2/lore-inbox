Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSKYWGP>; Mon, 25 Nov 2002 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSKYWGP>; Mon, 25 Nov 2002 17:06:15 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:61825 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265711AbSKYWGN>; Mon, 25 Nov 2002 17:06:13 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 25 Nov 2002 14:11:59 -0800
Message-Id: <200211252211.OAA02085@baldur.yggdrasil.com>
To: rusty@rustcorp.com.au, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Subject: Modules with list
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here is a list of changes that I'm thinking about trying to
make to modules, in case anyone is interested or wants to show me the
error of my ways.  Most of these changes do not depend on whether the
module loader is in the kernel or a user level program.  I've labelled
the items that are only applicable to user level modules with "user
level version:".

	1. Allow multiple MODULE_DEVICE_TABLE's of the same type in the
	   same .c file instead of the combined_dev_id_table hack that
	   is now used by modules that really need to load separate
	   but related drivers.

	2. Eventually have the same build command for modules and
	   compiled in objects so that distribution makes can ship an
	   "all modules" build and link script to allow much more
	   customization by users who do not want to recompile kernel code.

		2a. Compile module_init, subsys_init, etc. by the
		    same mechanism used by kernel objects.

		2b. Pass module parameter by __setup() rather than
		    MODULE_PARM().

		2c. Eliminate "#ifdef MODULE" init.h, module.h, and,
		    eventually, almost everywhere.

		2d. In the core kernel, THIS_MODULE would point to
		    a struct module rather than being NULL (eliminating
		    many little banches).

	3. To prevent rmmod's during modprobe, have
	    rmmod do flock(/proc/modules, LOCK_EX) and
	    modprobe do flock(/proc/modules, LOCK_SH).  Yes, you can
	    detect this already, but this way you it does not cause
	    failure and you do not need retry code.

	Other wishes that probably do not effect module-init-tools,
	at least when the module loader is in the kernel:

	4. failureless raceless module unloading by the module->rwsem_list
	   system that I described toward the bottom of this message:
	   http://marc.theaimsgroup.com/?l=linux-kernel&m=103773401411324&w=2

	5. At modprobe time, being able to decide to load a module
	   as non-removable to avoid loading .exit{,data} for a smaller
	   kernel footprint.  This might only require insmod changes
	   for the user level insmod.

	6. kmalloc'ing small modules for less memory consumption and
	   perhaps so that they can avoid using TLB entries on certain
	   architectures (412 of 1129 modules on my system have
	   .text + .data < 4096).

		5a. maybe load .text and .data separately for modules where
		    .text + .data >= 4096 && .text < 4096 && .data < 4096
		    (26 of 1129 modules have this property on my system).
		    Probably not worth it.

	7. User level version: optionally be able to move all symbols
	   to user land at the expense of losing kksymoops (would save
	   ~100kB on my system).

	8. User level version (already done in kernel loader version):
	   eliminate dependence on struct module using a module-start.o
	   based on what Roman Zippel proposed at
	   http://marc.theaimsgroup.com/?l=linux-kernel&m=103740379811285&w=2
	   (but using a module-end.o file and eliminating the linker script).

	9. User level version: load module contents with mmap(/dev/kmem),
	   reducing initial memory requirements by avoiding a malloc
	   and copy.

	10. Move tracking of dependencies among loaded modules to
	    user land (and be able to reconstruct in some cases
	    from modules.dep).

	Hopefully, posting this list will reduce the chances of
duplication of effort or help expose a problem or potential
improvement I hadn't considered.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
