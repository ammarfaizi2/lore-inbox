Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRACJkd>; Wed, 3 Jan 2001 04:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbRACJkY>; Wed, 3 Jan 2001 04:40:24 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:47969 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129752AbRACJkM>; Wed, 3 Jan 2001 04:40:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Udo A. Steinberg" <sorisor@hell.wh8.tu-dresden.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: [patch] 2.4.0-prerelease acpi exported symbols
In-Reply-To: Your message of "Wed, 03 Jan 2001 04:39:50 BST."
             <3A529F06.5BFA4229@Hell.WH8.TU-Dresden.De> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jan 2001 20:09:27 +1100
Message-ID: <12597.978512967@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2001 04:39:50 +0100, 
"Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De> wrote:
>Keith, I've read the FAQ about having been bitten by Makefile bugs
>with certain symbols and such, yet I still get these symbol warnings
>even after a mrproper rebuild. Any clues?
>Warning (compare_maps): ksyms_base symbol acpi_clear_event_R__ver_acpi_clear_event not found in System.map.  Ignoring ksyms_base entry

Two separate problems.

(1) acpi used a file called ksyms.c which conflicted with the kernel's
    export file of the same name.  The symbol version code uses a flat
    namespace for its files so drivers/acpi/ksyms.c has to be renamed
    to acpi_ksyms.c.

(2) Even with the rename, symbol generation for acpi fails because the
    genksyms pass does not honour EXTRA_CFLAGS.  The correct fix is to
    add EXTRA_CFLAGS to the genksyms pass in Rules.make.  However that
    hits every single compile and has with unknown side effects.  I do
    not have time to test a kernel wide change and at this late stage
    in the release cycle I am not going to risk it, especially since
    only acpi has a problem.  So this patch includes a bandaid to fix
    just acpi.  After 2.4.0 is released I will look at doing and
    verifying the correct fix.

Most of the patch is caused by the rename from ksyms.c to acpi_ksyms.c,
91 deletes and 91 inserts.

Index: 0-prerelease.1/drivers/acpi/Makefile
--- 0-prerelease.1/drivers/acpi/Makefile Fri, 22 Dec 2000 15:44:33 +1100 kaos (linux-2.4/Q/c/28_Makefile 1.2.3.1.2.2 644)
+++ 0-prerelease.1(w)/drivers/acpi/Makefile Wed, 03 Jan 2001 19:43:52 +1100 kaos (linux-2.4/Q/c/28_Makefile 1.2.3.1.2.2 644)
@@ -4,7 +4,7 @@
 
 O_TARGET := acpi.o
 
-export-objs := ksyms.o
+export-objs := acpi_ksyms.o
 
 export ACPI_CFLAGS
 ACPI_CFLAGS := -D_LINUX
@@ -20,18 +20,26 @@
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
+# genksyms only reads $(CFLAGS), it should really read $(EXTRA_CFLAGS) as well.
+# Without EXTRA_CFLAGS the gcc pass for genksyms fails, resulting in an empty
+# include/linux/modules/acpi_ksyms.ver.  Changing genkyms to use EXTRA_CFLAGS
+# will hit everything, too risky in 2.4.0-prerelease.  Bandaid by tweaking
+# CFLAGS only for .ver targets.  Review after 2.4.0 release.  KAO
+
+$(MODINCL)/%.ver: CFLAGS = -I./include $(CFLAGS)
+
 acpi-subdirs := common dispatcher events hardware \
 		interpreter namespace parser resources tables
 
 subdir-$(CONFIG_ACPI) += $(acpi-subdirs)
 
 obj-$(CONFIG_ACPI) := $(patsubst %,%.o,$(acpi-subdirs))
-obj-$(CONFIG_ACPI) += os.o ksyms.o
+obj-$(CONFIG_ACPI) += os.o acpi_ksyms.o
 
 ifdef CONFIG_ACPI_KERNEL_CONFIG
   obj-$(CONFIG_ACPI) += acpiconf.o osconf.o
 else
-  obj-$(CONFIG_ACPI) += driver.o cmbatt.o cpu.o ec.o ksyms.o sys.o table.o power.o
+  obj-$(CONFIG_ACPI) += driver.o cmbatt.o cpu.o ec.o acpi_ksyms.o sys.o table.o power.o
 endif
 
 include $(TOPDIR)/Rules.make
Index: 0-prerelease.1(w)/drivers/acpi/ksyms.c
--- 0-prerelease.1/drivers/acpi/ksyms.c Sat, 30 Dec 2000 13:21:14 +1100 kaos (linux-2.4/o/d/49_ksyms.c 1.2 644)
+++ 0-prerelease.1(w)/drivers/acpi/ksyms.c Wed, 03 Jan 2001 20:05:59 +1100 kaos ()
@@ -1,91 +0,0 @@
-/*
- *  ksyms.c - ACPI exported symbols
- *
- *  Copyright (C) 2000 Andrew Grover
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/acpi.h>
-#include "acpi.h"
-#include "acdebug.h"
-
-extern int acpi_in_debugger;
-
-#define _COMPONENT	OS_DEPENDENT
-	MODULE_NAME	("symbols")
-
-#ifdef ENABLE_DEBUGGER
-EXPORT_SYMBOL(acpi_in_debugger);
-EXPORT_SYMBOL(acpi_db_user_commands);
-#endif
-
-EXPORT_SYMBOL(acpi_os_free);
-EXPORT_SYMBOL(acpi_os_breakpoint);
-EXPORT_SYMBOL(acpi_os_printf);
-EXPORT_SYMBOL(acpi_os_callocate);
-EXPORT_SYMBOL(acpi_os_sleep);
-EXPORT_SYMBOL(acpi_os_sleep_usec);
-EXPORT_SYMBOL(acpi_os_in8);
-EXPORT_SYMBOL(acpi_os_out8);
-EXPORT_SYMBOL(acpi_os_queue_for_execution);
-
-EXPORT_SYMBOL(acpi_dbg_layer);
-EXPORT_SYMBOL(acpi_dbg_level);
-EXPORT_SYMBOL(function_exit);
-EXPORT_SYMBOL(function_trace);
-EXPORT_SYMBOL(function_status_exit);
-EXPORT_SYMBOL(function_value_exit);
-EXPORT_SYMBOL(debug_print_raw);
-EXPORT_SYMBOL(debug_print_prefix);
-
-EXPORT_SYMBOL(acpi_cm_strncmp);
-EXPORT_SYMBOL(acpi_cm_memcpy);
-EXPORT_SYMBOL(acpi_cm_memset);
-
-EXPORT_SYMBOL(acpi_get_handle);
-EXPORT_SYMBOL(acpi_get_parent);
-EXPORT_SYMBOL(acpi_get_type);
-EXPORT_SYMBOL(acpi_get_name);
-EXPORT_SYMBOL(acpi_get_object_info);
-EXPORT_SYMBOL(acpi_get_next_object);
-EXPORT_SYMBOL(acpi_evaluate_object);
-
-EXPORT_SYMBOL(acpi_install_notify_handler);
-EXPORT_SYMBOL(acpi_remove_notify_handler);
-EXPORT_SYMBOL(acpi_install_gpe_handler);
-EXPORT_SYMBOL(acpi_remove_gpe_handler);
-EXPORT_SYMBOL(acpi_install_address_space_handler);
-EXPORT_SYMBOL(acpi_remove_address_space_handler);
-
-EXPORT_SYMBOL(acpi_get_current_resources);
-EXPORT_SYMBOL(acpi_get_possible_resources);
-EXPORT_SYMBOL(acpi_set_current_resources);
-
-EXPORT_SYMBOL(acpi_enable_event);
-EXPORT_SYMBOL(acpi_disable_event);
-EXPORT_SYMBOL(acpi_clear_event);
-
-EXPORT_SYMBOL(acpi_get_processor_throttling_info);
-EXPORT_SYMBOL(acpi_get_processor_throttling_state);
-EXPORT_SYMBOL(acpi_set_processor_throttling_state);
-
-EXPORT_SYMBOL(acpi_get_processor_cx_info);
-EXPORT_SYMBOL(acpi_set_processor_sleep_state);
-EXPORT_SYMBOL(acpi_processor_sleep);
Index: 0-prerelease.1/drivers/acpi/acpi_ksyms.c
--- 0-prerelease.1/drivers/acpi/acpi_ksyms.c Wed, 03 Jan 2001 20:05:59 +1100 kaos ()
+++ 0-prerelease.1(w)/drivers/acpi/acpi_ksyms.c Sat, 30 Dec 2000 13:21:14 +1100 kaos (linux-2.4/t/d/19_acpi_ksyms  644)
@@ -0,0 +1,91 @@
+/*
+ *  ksyms.c - ACPI exported symbols
+ *
+ *  Copyright (C) 2000 Andrew Grover
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include "acpi.h"
+#include "acdebug.h"
+
+extern int acpi_in_debugger;
+
+#define _COMPONENT	OS_DEPENDENT
+	MODULE_NAME	("symbols")
+
+#ifdef ENABLE_DEBUGGER
+EXPORT_SYMBOL(acpi_in_debugger);
+EXPORT_SYMBOL(acpi_db_user_commands);
+#endif
+
+EXPORT_SYMBOL(acpi_os_free);
+EXPORT_SYMBOL(acpi_os_breakpoint);
+EXPORT_SYMBOL(acpi_os_printf);
+EXPORT_SYMBOL(acpi_os_callocate);
+EXPORT_SYMBOL(acpi_os_sleep);
+EXPORT_SYMBOL(acpi_os_sleep_usec);
+EXPORT_SYMBOL(acpi_os_in8);
+EXPORT_SYMBOL(acpi_os_out8);
+EXPORT_SYMBOL(acpi_os_queue_for_execution);
+
+EXPORT_SYMBOL(acpi_dbg_layer);
+EXPORT_SYMBOL(acpi_dbg_level);
+EXPORT_SYMBOL(function_exit);
+EXPORT_SYMBOL(function_trace);
+EXPORT_SYMBOL(function_status_exit);
+EXPORT_SYMBOL(function_value_exit);
+EXPORT_SYMBOL(debug_print_raw);
+EXPORT_SYMBOL(debug_print_prefix);
+
+EXPORT_SYMBOL(acpi_cm_strncmp);
+EXPORT_SYMBOL(acpi_cm_memcpy);
+EXPORT_SYMBOL(acpi_cm_memset);
+
+EXPORT_SYMBOL(acpi_get_handle);
+EXPORT_SYMBOL(acpi_get_parent);
+EXPORT_SYMBOL(acpi_get_type);
+EXPORT_SYMBOL(acpi_get_name);
+EXPORT_SYMBOL(acpi_get_object_info);
+EXPORT_SYMBOL(acpi_get_next_object);
+EXPORT_SYMBOL(acpi_evaluate_object);
+
+EXPORT_SYMBOL(acpi_install_notify_handler);
+EXPORT_SYMBOL(acpi_remove_notify_handler);
+EXPORT_SYMBOL(acpi_install_gpe_handler);
+EXPORT_SYMBOL(acpi_remove_gpe_handler);
+EXPORT_SYMBOL(acpi_install_address_space_handler);
+EXPORT_SYMBOL(acpi_remove_address_space_handler);
+
+EXPORT_SYMBOL(acpi_get_current_resources);
+EXPORT_SYMBOL(acpi_get_possible_resources);
+EXPORT_SYMBOL(acpi_set_current_resources);
+
+EXPORT_SYMBOL(acpi_enable_event);
+EXPORT_SYMBOL(acpi_disable_event);
+EXPORT_SYMBOL(acpi_clear_event);
+
+EXPORT_SYMBOL(acpi_get_processor_throttling_info);
+EXPORT_SYMBOL(acpi_get_processor_throttling_state);
+EXPORT_SYMBOL(acpi_set_processor_throttling_state);
+
+EXPORT_SYMBOL(acpi_get_processor_cx_info);
+EXPORT_SYMBOL(acpi_set_processor_sleep_state);
+EXPORT_SYMBOL(acpi_processor_sleep);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
