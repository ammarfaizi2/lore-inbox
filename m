Return-Path: <linux-kernel-owner+w=401wt.eu-S932417AbXAPG1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbXAPG1v (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAPG1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:27:51 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44247 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417AbXAPG1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:27:48 -0500
Message-Id: <20070116063028.375290000@bull.net>
References: <20070116061516.899460000@bull.net>
User-Agent: quilt/0.45-1
Date: Tue, 16 Jan 2007 07:15:17 +0100
From: Nadia.Derbey@bull.net
To: linux-kernel@vger.kernel.org
Cc: Nadia Derbey <Nadia.Derbey@bull.net>
Subject: [RFC][PATCH 1/6] Tunable structure and registration routines
Content-Disposition: inline; filename=tunables_registration.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 01/06]

Defines the auto_tune structure: this is the structure that contains the
information needed by the adjustment routine for a given tunable.
Also defines the registration routines.

The fork kernel component defines a tunable structure for the threads-max
tunable and registers it.


Signed-off-by: Nadia Derbey <Nadia.Derbey@bull.net>


---
 Documentation/00-INDEX      |    2 
 Documentation/auto_tune.txt |  333 ++++++++++++++++++++++++++++++++++++++++++++
 fs/Kconfig                  |    2 
 include/linux/akt.h         |  186 ++++++++++++++++++++++++
 include/linux/akt_ops.h     |  186 ++++++++++++++++++++++++
 init/main.c                 |    2 
 kernel/Makefile             |    1 
 kernel/autotune/Kconfig     |   30 +++
 kernel/autotune/Makefile    |    7 
 kernel/autotune/akt.c       |  123 ++++++++++++++++
 kernel/fork.c               |   18 ++
 11 files changed, 890 insertions(+)

Index: linux-2.6.20-rc4/Documentation/00-INDEX
===================================================================
--- linux-2.6.20-rc4.orig/Documentation/00-INDEX	2007-01-15 13:08:13.000000000 +0100
+++ linux-2.6.20-rc4/Documentation/00-INDEX	2007-01-15 14:17:22.000000000 +0100
@@ -52,6 +52,8 @@ applying-patches.txt
 	- description of various trees and how to apply their patches.
 arm/
 	- directory with info about Linux on the ARM architecture.
+auto_tune.txt
+	- info on the Automatic Kernel Tunables (AKT) feature.
 basic_profiling.txt
 	- basic instructions for those who wants to profile Linux kernel.
 binfmt_misc.txt
Index: linux-2.6.20-rc4/Documentation/auto_tune.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc4/Documentation/auto_tune.txt	2007-01-15 14:19:18.000000000 +0100
@@ -0,0 +1,333 @@
+			Automatic Kernel Tunables
+                        =========================
+
+		   Nadia Derbey (Nadia.Derbey@bull.net)
+
+
+
+This feature aims at making the kernel automatically change the tunables
+values as it sees resources running out.
+
+The AKT framework is made of 2 parts:
+
+1) Kernel part:
+Interfaces are provided to the kernel subsystems, to (un)register the
+tunables that might be automatically tuned in the future.
+
+Registering a tunable consists in the following steps:
+- a structure is declared and filled by the kernel subsystem for the
+registered tunable
+- that tunable structure is registered into sysfs
+
+Registration should be done during the kernel subsystem initialization step.
+
+Unregistering a tunable is the reverse operation. It should not be necessary
+for the kernel subsystems: it is only useful when unloading modules that would
+have registered a tunable during their loading step.
+
+The routines interfaces are the following:
+
+1.1) Declaring a tunable:
+
+A tunable structure should be declared and defined by the kernel subsystems as
+follows:
+
+DEFINE_TUNABLE(structure_name, threshold, min, max,
+		tunable_variable_ptr, checked_variable_ptr,
+		tunable_variable_type);
+
+Parameters:
+- structure_name: this is the name of the tunable structure
+
+- threshold: percentage to apply to the tunable value to detect if adjustment
+is needed
+
+- min: minimum value the tunable can ever reach (needed when adjusting down
+the tunable)
+
+- max: maximum value the tunable can ever reach (needed when adjusting up the
+tunable)
+
+- tunable_variable_ptr: address of the tunable that will be adjusted if
+needed.
+(ex: in kernel/fork.c it is max_threads's address)
+
+- checked_variable_ptr: address of the variable that is controlled by the
+tunable. This is the calling subsystem's object counter.
+(ex: in kernel/fork.c it is nr_threads's address: nr_threads should
+always remain < max_threads)
+
+- tunable_variable_type: this type is important since it helps choosing the
+appropriate automatic tuning routine.
+It can be one of short / ushort / int / uint / size_t / long / ulong
+
+The automatic tuning routine (i.e. the routine that should be called when
+automatic tuning is activated) is set to the default one:
+default_auto_tuning_<type>().
+<type> is chosen according to the tunable_variable_type parameters.
+All the previously listed parameters are useful to this routine.
+Refer to the description of the automatic adjustment routine to see how
+these parameters are actually used.
+
+Refer to "Updating the auto-tuning function pointer" to know how to set
+this routine to another one.
+
+
+1.2) Updating a tunable's characteristics
+
+1.2.1) Updating min / max values:
+
+Sometimes, when calling DEFINE_TUNABLE(), the min and max values are not
+exactly known, yet. In that case, the following routine should be called
+once these values are known:
+
+set_tunable_min_max(structure_name, new_min, new_max)
+
+Parameters:
+- structure_name: this is the name of the tunable structure
+
+- new_min: minimum value the tunable can ever reach
+
+- new_max: maximum value the tunable can ever reach
+
+1.2.2) Updating the auto-tuning function pointer:
+
+If the default auto-tuning routine doesn't fit your needs, you can define
+another one and associate it to the tunable using the following routine:
+
+set_autotuning_routine(structure_name, auto_tune)
+
+Parameters:
+- structure_name: this is the name of the tunable structure
+
+- auto_tune: routine that should be called when automatic tuning is activated.
+If this parameter is not NULL, it should be set to a function pointer defined
+by the kernel subsystem caller. See 1.5) for the routine prototype. See also
+maxfiles_auto_tuning() in fs/file_table.c for an example.
+
+
+1.3) Registering a tunable:
+
+Once declared and its min / max / auto_tuning routine updated, the tunable
+structure should be registered using the following routine:
+
+int register_tunable(struct auto_tune *tunable_addr);
+
+Parameters:
+- tunable_addr: address of the tunable structure previsouly declared.
+
+Return value:
+- 0 : successful
+- < 0 : failure
+
+
+Registering a tunable makes it potentially automatically adjustable:
+the tunable is viewed as a kobject with 3 attributes (i.e. 3 files at sysfs
+level):
+- autotune (rw): enables to (de)activate the auto tuning for that tunable
+- min (rw): enables to play with the min tunable value
+- max (rw): enables to play with the max tunable value
+
+The only way to make a registered tunable automatically adjustable is through
+sysfs (see the sysfs part for more details).
+
+
+
+1.4) Unregistering a tunable:
+
+int unregister_tunable(struct auto_tune *reg_tun_addr);
+
+Parameters:
+- reg_tun_addr: address of the tunable structure to unregister
+
+
+This routine is only useful for modules: when unloading, they should
+unregister any previously registered tunable.
+
+
+
+1.5) Automatic tuning routine:
+
+The 2nd main service provided by the kernel part is a function pointer
+(auto_tune_func): it points to the routine that actually automatically
+adjusts the tunable passed in as a parameter.
+
+This is accomplished by one of the following:
+- if an automatic tuning routine has been provided during the tunable
+declaration, that routine will actually be called.
+- if no automatic tuning routine has been provided, the default one is called.
+NOTE: it can process one of the following types, depending on the type used
+	when declaring the tunable (see DEFINE_TUNABLE above): short, ushort,
+	int, uint, size-t, long, ulong.
+
+
+If the automatic tuning routine is provided by the kernel subsystem caller,
+it should be declared as follows:
+
+int <routine_name>(int cmd, struct auto_tune *params);
+
+Parameters:
+- cmd: tuning direction
+	. AKT_UP: the tunable will be adjusted upwards (i.e. its value is
+		increased if needed)
+	. AKT_DOWN: the tunable is adjusted downwards (i.e. its value is
+		decreased if needed)
+- params: pointer to the previously registered tunable structure
+
+
+Any kernel subsystem that has registered a tunable should call
+auto_tune_func() as follows:
+
++-------------------------+--------------------------------------------+
+| Step                    | Routine to call                            |
++-------------------------+--------------------------------------------+
+| Declaration phase       | DEFINE_TUNABLE(name, values...);           |
++-------------------------+--------------------------------------------+
+| Initialization routine  | set_tunable_min_max(name, min, max);       |
+|                         | set_autotuning_routine(name, routine);     |
+|                         | register_tunable(&name);                   |
+| Note: the 1st 2 calls   |                                            |
+|       are optional      |                                            |
++-------------------------+--------------------------------------------+
+| Alloc                   | activate_auto_tuning(AKT_UP, &name);       |
++-------------------------+--------------------------------------------+
+| Free                    | activate_auto_tuning(AKT_DOWN, &name);     |
++-------------------------+--------------------------------------------+
+| module_exit() routine   | unregister_tunable(&name);                 |
++-------------------------+--------------------------------------------+
+
+activate_auto_tuning is a static inline defined in akt.h, that does the
+following:
+. if <tunable is registered> and <auto tuning is allowd for tunable>
+.   call the routine stored in tunable->auto_tune
+
+
+The effect of the default automatic tuning routine is the following:
+
+           +----------------------------------------------------------------+
+           |                 Tunable automatically adjustable               |
+           +---------------+------------------------------------------------+
+           |      NO       |                      YES                       |
++----------+---------------+------------------------------------------------+
+| AKT_UP   | No effect     | If the tunable value exceeds the specified     |
+|          |               | threshold, that value is increased up to a     |
+|          |               | maximum value.                                 |
+|          |               | The maximum value is specified during the      |
+|          |               | tunable declaration and can be changed at any  |
+|          |               | time through sysfs                             |
++----------+---------------+------------------------------------------------+
+| AKT_DOWN | No effect     | If the tunable value falls under the specified |
+|          |               | threshold, that value is decreased down to a   |
+|          |               | minimum value.                                 |
+|          |               | The minimum value is specified during the      |
+|          |               | tunable declaration and can be changed at any  |
+|          |               | time through sysfs                             |
++----------+---------------+------------------------------------------------+
+
+
+1.6. Default automatic adjustment routine
+
+The last service provided by AKT at the kernel level is the default automatic
+adjustment routine. As seen, above, this routine supports various tunables
+types. It works as follows (only the AKT_UP direction is described here -
+AKT_DOWN does the reverse operation):
+
+The 2nd parameter passed in to this routine is a pointer to a previously
+registerd tunable structure. That structure contains the following fields (see
+1.1 for the detailed description):
+- threshold
+- key
+- min
+- max
+- tunable
+- checked
+
+When this routine is entered, it does the following:
+1. <*checked> is compared to <*tunable> * threshold
+2. if <*checked> is greater, <*tunable> is set to:
+	<*tunable> + (<*tunable> * (100 - threshold) / 100)
+
+
+
+1.6) akt and sysfs:
+
+AKT uses sysfs to enable the tunables management from the user world (mainly
+making them automatic or manual).
+
+akt uses sysfs in the following way:
+- a tunables subsystem (tunables_subsys) is declared and registered during akt
+initialization.
+- registering a tunable is equivalent to registering the corresponding kobject
+within that subsystem.
+- each tunable kobject has 3 associated attributes, all with a RW mode (i.e.
+the show() and store() methods are provided for them):
+	. autotune: enables to (de)activate automatic tuning for the tunable
+	. max: enables to set a new maximum value for the tunable
+	. min: enables to set a new minimum value for the tunable
+
+
+1.7) tunables that are namespace dependent
+
+In this paragraph, the particular case of tunables that are namespace
+dependent is presented.
+
+1.7.1) Declaring a tunable:
+
+The tunable structure for such tunables should be declared in the namespace
+structure that contains the associated tunable (ex: the tunable structure for
+msg_ctlmni should be declared in the ipc_namespace structure).
+
+The tunable structure should be declared as follows:
+
+DECLARE_TUNABLE(structure_name);
+
+Parameters:
+- structure_name: this is the name of the tunable structure
+
+1.7.2) Initializing the tunable structure
+
+Then the tunable structure should be initialized by calling the following
+routine:
+
+init_tunable_ipcns(namespace_ptr, structure_name, threshold, min, max,
+		tunable_variable_ptr, checked_variable_ptr,
+		tunable_variable_type);
+
+Parameters:
+- namespace_ptr: pointer to the namespace the tunable belongs to.
+
+See DEFINE_TUNABLE for the other parameters
+
+1.7.3) Registering the tunable structure
+
+register_tunable should be called, giving it the tunable structure address
+that belongs to the init namespace.
+
+This applies to activate_auto_tuning too.
+
+All the routines that show/store attributes or that do the auto tuning are
+namespace dependent.
+
+
+2) User part:
+
+As seen above, the only way to activate automatic tuning is from user side:
+- the directory /sys/tunables is created during the init phase.
+- each time a tunable is registered by a kernel subsystem, a directory is
+created for it under /sys/tunables.
+- This directory contains 1 file for each tunable kobject attribute:
++-----------+---------------+-------------------+----------------------------+
+| attribute | default value | how to set it     | effect                     |
++-----------+---------------+-------------------+----------------------------+
+| autotune  | 0             | echo 1 > autotune | makes the tunable automatic|
+|           |               | echo 0 > autotune | makes the tunable manual   |
++-----------+---------------+-------------------+----------------------------+
+| max       | max value set | echo <M> > max    | sets the tunable max value |
+|           | during tunable|                   | to <M>                     |
+|           | definition    |                   |                            |
++-----------+---------------+-------------------+----------------------------+
+| min       | min value set | echo <m> > min    | sets the tunable min value |
+|           | during tunable|                   | to <m>                     |
+|           | definition    |                   |                            |
++-----------+---------------+-------------------+----------------------------+
+
Index: linux-2.6.20-rc4/fs/Kconfig
===================================================================
--- linux-2.6.20-rc4.orig/fs/Kconfig	2007-01-15 13:08:14.000000000 +0100
+++ linux-2.6.20-rc4/fs/Kconfig	2007-01-15 14:20:20.000000000 +0100
@@ -925,6 +925,8 @@ config PROC_KCORE
 	bool "/proc/kcore support" if !ARM
 	depends on PROC_FS && MMU
 
+source "kernel/autotune/Kconfig"
+
 config PROC_VMCORE
         bool "/proc/vmcore support (EXPERIMENTAL)"
         depends on PROC_FS && EXPERIMENTAL && CRASH_DUMP
Index: linux-2.6.20-rc4/include/linux/akt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc4/include/linux/akt.h	2007-01-15 14:26:24.000000000 +0100
@@ -0,0 +1,186 @@
+/*
+ * linux/include/akt.h
+ *
+ * Automatic Kernel Tunables support for Linux.
+ * This file contains structures definitions and prototypes needed for AKT
+ * support.
+ *
+ * Copyright (C) 2006 Bull S.A.S
+ *
+ * Author: Nadia Derbey <Nadia.Derbey@bull.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef AKT_H
+#define AKT_H
+
+#include <linux/types.h>
+#include <linux/kobject.h>
+
+
+
+/*
+ * First parameter passed to the adjustment routine
+ */
+#define AKT_UP   0   /* adjustment "up" */
+#define AKT_DOWN 1   /* adjustment "down" */
+
+
+struct auto_tune;
+/*
+ * Automatic adjustment routine.
+ * Returns 0, if the tunable value has not been changed, 1 else
+ */
+typedef int (*auto_tune_fn)(int, struct auto_tune *);
+
+
+/*
+ * Structure used to describe the min / max values for a tunable inside the
+ * auto_tune structure.
+ * These values are type dependent and are used as high / low boundaries when
+ * tuning up or down.
+ * The type is known when the tunable is defined (see DEFINE_TUNABLE macro).
+ */
+struct typed_value {
+	union {
+		short  val_short;
+		ushort val_ushort;
+		int    val_int;
+		uint   val_uint;
+		size_t val_size_t;
+		long   val_long;
+		ulong  val_ulong;
+	} value;
+};
+
+
+
+/*
+ * This is the structure that describes a tunable. One of these structures is
+ * allocated for each registered tunable, and the associated kobject exported
+ * via sysfs.
+ *
+ * The structure lock (tunable_lck) protects
+ * against concurrent accesses to tunable and checked pointers
+ *
+ * A pointer to this structure is passed in to  the automatic adjustment
+ * routine.
+ * automatic adjustment principle is the following:
+ *    AKT_UP:
+ *       1. *checked is compared to *tunable * threshold
+ *       2. if *checked is greater, the tunable is adjusted up
+ *    AKT_DOWN: reverse operation
+ */
+struct auto_tune {
+	spinlock_t tunable_lck; /* serializes access to the stucture fields */
+	auto_tune_fn auto_tune; /* auto tuning routine registered by the */
+				/* calling kernel susbsystem. If NULL, the */
+				/* auto tuning routine that will be called */
+				/* is the default one that processes uints */
+	int (*check_parms)(struct auto_tune *);	/* min / max checking */
+						/* routine ptr: points to */
+						/* the appropriate routine */
+						/* depending on the */
+						/* tunable type */
+	const char *name;
+	char flags;	/* Only 2 bits are meaningful: */
+			/* bit 0: set to 1 if the associated tunable can */
+			/*        be automatically adjusted */
+			/* bits 1: set to 1 if the tunable has been */
+			/*         registered */
+			/* bits 2-7: useless */
+	char threshold;	/* threshold to enable the adjustment expressed as */
+			/* a %age */
+	struct typed_value min;	/* min value the tunable can ever reach */
+				/* and associated show / store routines) */
+	struct typed_value max;	/* max value the tunable can ever reach */
+				/* and associated show / store routines) */
+	void *tunable;	/* address of the tunable to adjust */
+	void *checked;	/* address of the variable that is controlled by */
+			/* the tunable. This is the calling subsystem's */
+			/* object counter */
+};
+
+
+/*
+ * Flags for a registered tunable
+ */
+#define TUNABLE_REGISTERED  0x02
+
+
+/*
+ * When calling this routine the tunable lock should be held
+ */
+static inline int is_tunable_registered(struct auto_tune *tunable)
+{
+	return (tunable->flags & TUNABLE_REGISTERED) == TUNABLE_REGISTERED;
+}
+
+
+#ifdef CONFIG_AKT
+
+
+
+#define TUNABLE_INIT(_name, _thresh, _min, _max, _tun, _chk, type)	\
+	{								\
+		.tunable_lck	= SPIN_LOCK_UNLOCKED,			\
+		.auto_tune	= default_auto_tuning_##type,		\
+		.check_parms	= check_parms_##type,			\
+		.name		= (_name),				\
+		.flags		= 0,					\
+		.threshold	= (_thresh),				\
+		.min	= {						\
+			.value		= { .val_##type = (_min), },	\
+		},							\
+		.max	= {						\
+			.value		= { .val_##type = (_max), },	\
+		},							\
+		.tunable	= (_tun),				\
+		.checked	= (_chk),				\
+	}
+
+
+#define DEFINE_TUNABLE(s, thr, min, max, tun, chk, type)		\
+	struct auto_tune s = TUNABLE_INIT(#s, thr, min, max, tun, chk, type)
+
+#define set_tunable_min_max(s, _min, _max, type)	\
+	do {						\
+		(s).min.value.val_##type = _min;	\
+		(s).max.value.val_##type = _max;	\
+	} while (0)
+
+
+
+extern int register_tunable(struct auto_tune *);
+extern int unregister_tunable(struct auto_tune *);
+
+
+#else	/* CONFIG_AKT */
+
+
+#define DEFINE_TUNABLE(s, thresh, min, max, tun, chk, type)
+#define set_tunable_min_max(s, min, max, type)   do { } while (0)
+
+
+#define register_tunable(a)                 0
+#define unregister_tunable(a)               0
+
+
+#endif	/* CONFIG_AKT */
+
+extern void fork_late_init(void);
+
+#endif /* AKT_H */
Index: linux-2.6.20-rc4/include/linux/akt_ops.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc4/include/linux/akt_ops.h	2007-01-15 14:28:16.000000000 +0100
@@ -0,0 +1,186 @@
+/*
+ * linux/include/akt_ops.h
+ *
+ * Automatic Kernel Tunables support for Linux.
+ * This file contains the definitions for the type dependent routines
+ * needed for AKT support.
+ *
+ * Copyright (C) 2006 Bull S.A.S
+ *
+ * Author: Nadia Derbey <Nadia.Derbey@bull.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef AKT_OPS_H
+#define AKT_OPS_H
+
+#include <linux/errno.h>
+
+
+/*
+ * Checks that min and max values are coherent
+ * Called by register_tunable()
+ * Type independent - can be one of short / ushort / int / uint / long /
+ * ulong / size_t
+ */
+#define __check_parms(p, type)						\
+( {									\
+	int __rc;							\
+	type _min = p->min.value.val_##type;				\
+	type _max = p->max.value.val_##type;				\
+									\
+	if (_min > _max)						\
+		__rc = 1;						\
+	else								\
+		__rc = 0;						\
+	__rc;								\
+} )
+
+static inline int check_parms_short(struct auto_tune *p)
+{
+	return __check_parms(p, short);
+}
+
+static inline int check_parms_ushort(struct auto_tune *p)
+{
+	return __check_parms(p, ushort);
+}
+
+static inline int check_parms_int(struct auto_tune *p)
+{
+	return __check_parms(p, int);
+}
+
+static inline int check_parms_uint(struct auto_tune *p)
+{
+	return __check_parms(p, uint);
+}
+
+static inline int check_parms_size_t(struct auto_tune *p)
+{
+	return __check_parms(p, size_t);
+}
+
+static inline int check_parms_long(struct auto_tune *p)
+{
+	return __check_parms(p, long);
+}
+
+static inline int check_parms_ulong(struct auto_tune *p)
+{
+	return __check_parms(p, ulong);
+}
+
+
+/*
+ * FUNCTION:    This is the routine called to accomplish auto tuning if none
+ *              has been specified for a tunable.
+ *              It can be called by any kernel subsystem that is allocating or
+ *              freeing an object whose maximum value is controlled by a
+ *              tunable.
+ *              ex: max # of semaphore ids is controlled by sc_semmni
+ *              ==> this routine might be called by sys_semget() to "adjust up"
+ *                  and by semctl_down() to "adjust down"
+ *
+ *              Upwards adjustment:
+ *                  Adjustment is needed if the checked variable has reached
+ *                  (threshold / 100 * tunable)
+ *                  In that case, tunable is set to
+ *                  (tunable + tunable * (100 - threshold) / 100)
+ *
+ *              Downards adjustment:
+ *                   Adjustment is needed if the checked variable has fallen
+ *                   under (threshold / 100 * tunable previous value)
+ *                   In that case tunable is set back to its previous value,
+ *                   i.e. to (tunable * 100 / (200 - threshold))
+ *
+ * PARAMETERS:  direction: controls the adjustment direction (up / down)
+ *              p: pointer to the registered tunable structure
+ *
+ * EXECUTION ENVIRONMENT: This routine should be called with the
+ *                        p->tunable_lck lock held
+ *
+ * Type independent - can be one of short / ushort / int / uint / long /
+ * ulong / size_t
+ *
+ * RETURN VALUE: 1 if tunable has been adjusted
+ *               0 else
+ */
+#define __default_auto_tuning(direction, p, type)			\
+( {									\
+	int __rc;							\
+	type _chk = *((type *) p->checked);				\
+	type _tun = *((type *) p->tunable);				\
+	type _thr = (type) p->threshold;				\
+	type _min = (type) p->min.value.val_##type;			\
+	type _max = (type) p->max.value.val_##type;			\
+									\
+	if (direction == AKT_UP) {					\
+		if ((_chk >= (_tun * _thr) / 100) && (_tun < _max)) {	\
+			type ___x = (_tun * (200 - _thr)) / 100;	\
+			*((type *) p->tunable) = min(_max, ___x);	\
+			__rc = 1;					\
+		} else							\
+			__rc = 0;					\
+	} else {							\
+		if ((_chk < (_tun * _thr) / (200 - _thr)) && (_tun>_min)) { \
+			type ___x = (_tun * 100) / (200 - _thr);	\
+			*((type *) p->tunable) = max(_min, ___x);	\
+			__rc = 1;					\
+		} else							\
+			__rc = 0;					\
+	}								\
+	__rc;								\
+} )
+
+static inline int default_auto_tuning_short(int dir, struct auto_tune *p)
+{
+	return __default_auto_tuning(dir, p, short);
+}
+
+static inline int default_auto_tuning_ushort(int dir, struct auto_tune *p)
+{
+	return __default_auto_tuning(dir, p, ushort);
+}
+
+static inline int default_auto_tuning_int(int dir, struct auto_tune *p)
+{
+	return __default_auto_tuning(dir, p, int);
+}
+
+static inline int default_auto_tuning_uint(int dir, struct auto_tune *p)
+{
+	return __default_auto_tuning(dir, p, uint);
+}
+
+static inline int default_auto_tuning_size_t(int dir, struct auto_tune *p)
+{
+	return __default_auto_tuning(dir, p, size_t);
+}
+
+static inline int default_auto_tuning_long(int dir, struct auto_tune *p)
+{
+	return __default_auto_tuning(dir, p, long);
+}
+
+static inline int default_auto_tuning_ulong(int dir, struct auto_tune *p)
+{
+	return __default_auto_tuning(dir, p, ulong);
+}
+
+
+
+#endif /* AKT_OPS_H */
Index: linux-2.6.20-rc4/init/main.c
===================================================================
--- linux-2.6.20-rc4.orig/init/main.c	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/init/main.c	2007-01-15 14:29:17.000000000 +0100
@@ -54,6 +54,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/compile.h>
 #include <linux/device.h>
+#include <linux/akt.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -613,6 +614,7 @@ asmlinkage void __init start_kernel(void
 	signals_init();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
+	fork_late_init();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
Index: linux-2.6.20-rc4/kernel/Makefile
===================================================================
--- linux-2.6.20-rc4.orig/kernel/Makefile	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/kernel/Makefile	2007-01-15 14:30:43.000000000 +0100
@@ -50,6 +50,7 @@ obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
+obj-$(CONFIG_AKT) += autotune/
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.20-rc4/kernel/autotune/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc4/kernel/autotune/Kconfig	2007-01-15 14:31:25.000000000 +0100
@@ -0,0 +1,30 @@
+#
+# Automatic Kernel Tunables
+#
+
+menu "Automatic Kernel Tunables"
+
+config AKT
+	bool "Automatic kernel tunable (kernel support)"
+	depends on PROC_FS && SYSFS
+	help
+	  This is a functionality that enables automatic adjustment of kernel
+	  tunables: when this feature is enabled the kernel can automatically
+	  change the tunables values as it sees resources running out.
+
+	  The list of kernel tunables that can potentially be automatically
+	  adjusted can found under /sys/tunables.
+
+	  In order to make a tunable actually automatic, issue the following
+	  command:
+	  echo 1 > /sys/tunables/<tunable_name>/autotune
+
+	  In order to make it manual, issue the following command:
+	  echo 0 > /sys/tunables/<tunable_name>/autotune
+
+	  See Documentation/auto_tune.txt for more details.
+
+	  If unsure, say N.
+
+endmenu
+
Index: linux-2.6.20-rc4/kernel/autotune/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc4/kernel/autotune/Makefile	2007-01-15 14:31:57.000000000 +0100
@@ -0,0 +1,7 @@
+#
+# Makefile for akt
+#
+
+obj-y := akt.o
+
+
Index: linux-2.6.20-rc4/kernel/autotune/akt.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc4/kernel/autotune/akt.c	2007-01-15 14:51:54.000000000 +0100
@@ -0,0 +1,123 @@
+/*
+ * linux/kernel/autotune/akt.c
+ *
+ * Automatic Kernel Tunables for Linux - Kernel support
+ *
+ * Copyright (C) 2006 Bull S.A.S
+ *
+ * Author: Nadia Derbey <Nadia.Derbey@bull.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ *   FUNCTIONS:
+ *              register_tunable           (exported)
+ *              unregister_tunable         (exported)
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/akt.h>
+
+
+
+
+
+
+
+/*
+ * FUNCTION:    Inserts a tunable structure into sysfs
+ *              This routine serves also as a checker for the tunable
+ *              structure fields.
+ *              This routine is called by any kernel subsystem that wants to
+ *              use akt services (automatic tunables adjustment) in the future
+ *
+ * NOTE: when calling this routine, the tunable structure should have already
+ *       been filled by defining it with DEFINE_TUNABLE()
+ *
+ * RETURN VALUE: 0: successful
+ *               <0 if failure
+ */
+int register_tunable(struct auto_tune *tun)
+{
+	if (tun == NULL) {
+		printk(KERN_ERR "\tBad tunable structure pointer (NULL)\n");
+		return -EINVAL;
+	}
+
+	if (tun->threshold <= 0 || tun->threshold >= 100) {
+		printk(KERN_ERR "\tBad threshold (%d) value "
+			"- should be in the [1-99] interval\n",
+			tun->threshold);
+		return -EINVAL;
+	}
+
+	if (tun->tunable == NULL) {
+		printk(KERN_ERR "\tBad tunable pointer (NULL)\n");
+		return -EINVAL;
+	}
+
+	if (tun->checked == NULL) {
+		printk(KERN_ERR "\tBad checked value pointer (NULL)\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Check the min / max value
+	 */
+	if (tun->check_parms(tun)) {
+		printk(KERN_ERR "\tBad min / max values\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+/*
+ * FUNCTION:    Removes a tunable structure from sysfs.
+ *              This routine is called by any kernel subsystem that doesn't
+ *              need the akt services anymore
+ *
+ * NOTE:  reg_tun should point to a previously registered tunable
+ *
+ * RETURN VALUE: 0: successful
+ *               <0 if failure
+ */
+int unregister_tunable(struct auto_tune *reg_tun)
+{
+	if (reg_tun == NULL) {
+		printk(KERN_ERR "\tBad tunable address (NULL)\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&reg_tun->tunable_lck);
+
+	BUG_ON(!is_tunable_registered(reg_tun));
+
+	reg_tun->flags = 0;
+
+	spin_unlock(&reg_tun->tunable_lck);
+
+	return 0;
+}
+
+
+
+
+EXPORT_SYMBOL_GPL(register_tunable);
+EXPORT_SYMBOL_GPL(unregister_tunable);
Index: linux-2.6.20-rc4/kernel/fork.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/fork.c	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/kernel/fork.c	2007-01-15 14:36:48.000000000 +0100
@@ -49,6 +49,8 @@
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
 #include <linux/random.h>
+#include <linux/akt.h>
+#include <linux/akt_ops.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -65,6 +67,13 @@ int nr_threads; 		/* The idle threads do
 
 int max_threads;		/* tunable limit on nr_threads */
 
+#define THREADTHRESH 80
+/*
+ * The actual values for min and max will be known during fork_init
+ */
+DEFINE_TUNABLE(max_threads_akt, THREADTHRESH, 0, 0, &max_threads,
+		&nr_threads, int);
+
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
@@ -152,12 +161,21 @@ void __init fork_init(unsigned long memp
 	if(max_threads < 20)
 		max_threads = 20;
 
+	set_tunable_min_max(max_threads_akt, max_threads, mempages / 2, int);
+
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 }
 
+void __init fork_late_init(void)
+{
+	if (register_tunable(&max_threads_akt))
+		printk(KERN_WARNING
+			"Failed registering tunable max_threads\n");
+}
+
 static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
 	struct task_struct *tsk;

--
