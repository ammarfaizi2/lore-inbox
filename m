Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUKIBsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUKIBsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUKIBsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:48:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28940 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261347AbUKIBk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:40:56 -0500
Date: Tue, 9 Nov 2004 02:40:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Len Brown <len.brown@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill acpi_ksyms.c
Message-ID: <20041109014021.GB15077@stusta.de>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de> <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099933263.13831.9547.camel@d845pe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 12:01:03PM -0500, Len Brown wrote:

> Thanks for the suggestion.
> 
> I'd certainly accept patches using ACPI_FUTURE_USAGE and moving
> EXPORT_KSYMS to where they're more easily tracked.
> 
> If the motivation is kernel static size reduction, then I'll be
> interested in seeing a before/after kernel size measurements.

Static size reduction is an important reason.
I'll send you the measurements when I'll have a patch ready.

Below is as a preparation a patch that removes acpi_ksyms.c .

It shouldn't make any practical difference.

The function acpi_db_user_commands that wasn't available in the whole 
kernel sources was EXPORT_SYMBOL'ed. The patch removes this bogus 
export.


diffstat output:
 drivers/acpi/Makefile             |    2 
 drivers/acpi/acpi_ksyms.c         |  165 ------------------------------
 drivers/acpi/bus.c                |   10 +
 drivers/acpi/ec.c                 |    2 
 drivers/acpi/events/evxface.c     |   10 +
 drivers/acpi/events/evxfevnt.c    |    8 +
 drivers/acpi/events/evxfregn.c    |    4 
 drivers/acpi/hardware/hwregs.c    |    4 
 drivers/acpi/hardware/hwsleep.c   |    4 
 drivers/acpi/hardware/hwtimer.c   |    5 
 drivers/acpi/namespace/nsxfeval.c |    4 
 drivers/acpi/namespace/nsxfname.c |    4 
 drivers/acpi/namespace/nsxfobj.c  |    5 
 drivers/acpi/osl.c                |   18 +++
 drivers/acpi/pci_irq.c            |    2 
 drivers/acpi/pci_root.c           |    2 
 drivers/acpi/resources/rsxface.c  |    7 +
 drivers/acpi/scan.c               |    6 -
 drivers/acpi/tables/tbconvrt.c    |    2 
 drivers/acpi/tables/tbxface.c     |    3 
 drivers/acpi/tables/tbxfroot.c    |    2 
 drivers/acpi/utilities/utdebug.c  |    7 +
 drivers/acpi/utilities/utglobal.c |    4 
 drivers/acpi/utilities/utxface.c  |    2 
 drivers/acpi/utils.c              |    4 
 include/acpi/acdebug.h            |    5 
 26 files changed, 112 insertions(+), 179 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/acpi/acdebug.h.old	2004-11-09 00:58:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/acpi/acdebug.h	2004-11-09 00:58:18.000000000 +0100
@@ -386,11 +386,6 @@
 acpi_db_execute_thread (
 	void                            *context);
 
-acpi_status
-acpi_db_user_commands (
-	char                            prompt,
-	union acpi_parse_object         *op);
-
 void
 acpi_db_display_help (
 	char                            *help_type);
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/osl.c.old	2004-11-09 00:55:43.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/osl.c	2004-11-09 01:28:54.000000000 +0100
@@ -26,6 +26,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -61,8 +62,11 @@
 
 #ifdef ENABLE_DEBUGGER
 #include <linux/kdb.h>
+
 /* stuff for debugger support */
 int acpi_in_debugger;
+EXPORT_SYMBOL(acpi_in_debugger);
+
 extern char line_buf[80];
 #endif /*ENABLE_DEBUGGER*/
 
@@ -117,6 +121,7 @@
 	acpi_os_vprintf(fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL(acpi_os_printf);
 
 void
 acpi_os_vprintf(const char *fmt, va_list args)
@@ -147,6 +152,7 @@
 {
 	kfree(ptr);
 }
+EXPORT_SYMBOL(acpi_os_free);
 
 acpi_status
 acpi_os_get_root_pointer(u32 flags, struct acpi_pointer *addr)
@@ -311,6 +317,7 @@
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(((signed long) ms * HZ) / 1000);
 }
+EXPORT_SYMBOL(acpi_os_sleep);
 
 void
 acpi_os_stall(u32 us)
@@ -325,6 +332,7 @@
 		us -= delay;
 	}
 }
+EXPORT_SYMBOL(acpi_os_stall);
 
 /*
  * Support ACPI 3.0 AML Timer operand
@@ -377,6 +385,7 @@
 
 	return AE_OK;
 }
+EXPORT_SYMBOL(acpi_os_read_port);
 
 acpi_status
 acpi_os_write_port(
@@ -401,6 +410,7 @@
 
 	return AE_OK;
 }
+EXPORT_SYMBOL(acpi_os_write_port);
 
 acpi_status
 acpi_os_read_memory(
@@ -519,6 +529,7 @@
 
 	return (result ? AE_ERROR : AE_OK);
 }
+EXPORT_SYMBOL(acpi_os_read_pci_configuration);
 
 acpi_status
 acpi_os_write_pci_configuration (struct acpi_pci_id *pci_id, u32 reg, acpi_integer value, u32 width)
@@ -712,6 +723,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_os_queue_for_execution);
 
 void
 acpi_os_wait_events_complete(
@@ -719,6 +731,7 @@
 {
 	flush_workqueue(kacpid_wq);
 }
+EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
 /*
  * Allocate the memory for a spinlock and initialize it.
@@ -830,6 +843,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+EXPORT_SYMBOL(acpi_os_create_semaphore);
 
 
 /*
@@ -856,6 +870,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+EXPORT_SYMBOL(acpi_os_delete_semaphore);
 
 
 /*
@@ -945,6 +960,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_os_wait_semaphore);
 
 
 /*
@@ -971,6 +987,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+EXPORT_SYMBOL(acpi_os_signal_semaphore);
 
 u32
 acpi_os_get_line(char *buffer)
@@ -1045,6 +1062,7 @@
 
 	return AE_OK;
 }
+EXPORT_SYMBOL(acpi_os_signal);
 
 int __init
 acpi_os_name_setup(char *str)
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utglobal.c.old	2004-11-09 00:59:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utglobal.c	2004-11-09 01:11:56.000000000 +0100
@@ -43,6 +43,8 @@
 
 #define DEFINE_ACPI_GLOBALS
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
@@ -143,10 +145,12 @@
 
 /* Debug switch - level and trace mask */
 u32                                 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
+EXPORT_SYMBOL(acpi_dbg_level);
 
 /* Debug switch - layer (component) mask */
 
 u32                                 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
+EXPORT_SYMBOL(acpi_dbg_layer);
 u32                                 acpi_gbl_nesting_level = 0;
 
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utdebug.c.old	2004-11-09 01:00:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utdebug.c	2004-11-09 01:12:33.000000000 +0100
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 
@@ -178,6 +179,7 @@
 	va_start (args, format);
 	acpi_os_vprintf (format, args);
 }
+EXPORT_SYMBOL(acpi_ut_debug_print);
 
 
 /*****************************************************************************
@@ -219,6 +221,7 @@
 	va_start (args, format);
 	acpi_os_vprintf (format, args);
 }
+EXPORT_SYMBOL(acpi_ut_debug_print_raw);
 
 
 /*****************************************************************************
@@ -250,6 +253,7 @@
 	acpi_ut_debug_print (ACPI_LV_FUNCTIONS, line_number, dbg_info,
 			"%s\n", acpi_gbl_fn_entry_str);
 }
+EXPORT_SYMBOL(acpi_ut_trace);
 
 
 /*****************************************************************************
@@ -378,6 +382,7 @@
 
 	acpi_gbl_nesting_level--;
 }
+EXPORT_SYMBOL(acpi_ut_exit);
 
 
 /*****************************************************************************
@@ -418,6 +423,7 @@
 
 	acpi_gbl_nesting_level--;
 }
+EXPORT_SYMBOL(acpi_ut_status_exit);
 
 
 /*****************************************************************************
@@ -451,6 +457,7 @@
 
 	acpi_gbl_nesting_level--;
 }
+EXPORT_SYMBOL(acpi_ut_value_exit);
 
 
 /*****************************************************************************
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/namespace/nsxfname.c.old	2004-11-09 01:02:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/namespace/nsxfname.c	2004-11-09 01:12:41.000000000 +0100
@@ -42,6 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -129,6 +130,7 @@
 
 	return (status);
 }
+EXPORT_SYMBOL(acpi_get_handle);
 
 
 /******************************************************************************
@@ -210,6 +212,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return (status);
 }
+EXPORT_SYMBOL(acpi_get_name);
 
 
 /******************************************************************************
@@ -359,4 +362,5 @@
 	}
 	return (status);
 }
+EXPORT_SYMBOL(acpi_get_object_info);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/namespace/nsxfobj.c.old	2004-11-09 01:03:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/namespace/nsxfobj.c	2004-11-09 01:12:46.000000000 +0100
@@ -42,6 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -106,6 +107,7 @@
 	status = acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return (status);
 }
+EXPORT_SYMBOL(acpi_get_type);
 
 
 /*******************************************************************************
@@ -171,6 +173,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return (status);
 }
+EXPORT_SYMBOL(acpi_get_parent);
 
 
 /*******************************************************************************
@@ -255,5 +258,5 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return (status);
 }
-
+EXPORT_SYMBOL(acpi_get_next_object);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/namespace/nsxfeval.c.old	2004-11-09 01:04:58.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/namespace/nsxfeval.c	2004-11-09 01:32:30.000000000 +0100
@@ -42,6 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -354,6 +355,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_evaluate_object);
 
 
 /*******************************************************************************
@@ -426,6 +428,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_walk_namespace);
 
 
 /*******************************************************************************
@@ -599,6 +602,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_get_devices);
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/tables/tbxface.c.old	2004-11-09 01:06:25.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/tables/tbxface.c	2004-11-09 01:46:04.000000000 +0100
@@ -42,6 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -439,5 +440,5 @@
 	ACPI_MEMCPY ((void *) ret_buffer->pointer, (void *) tbl_ptr, table_length);
 	return_ACPI_STATUS (AE_OK);
 }
-
+EXPORT_SYMBOL(acpi_get_table);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/tables/tbxfroot.c.old	2004-11-09 01:07:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/tables/tbxfroot.c	2004-11-09 01:46:09.000000000 +0100
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/actables.h>
@@ -321,6 +322,7 @@
 	}
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_get_firmware_table);
 
 
 /* TBD: Move to a new file */
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxface.c.old	2004-11-09 01:07:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxface.c	2004-11-09 01:46:13.000000000 +0100
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -166,6 +167,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_EVENTS);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_install_fixed_event_handler);
 
 
 /*******************************************************************************
@@ -223,6 +225,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_EVENTS);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_remove_fixed_event_handler);
 
 
 /*******************************************************************************
@@ -392,6 +395,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_install_notify_handler);
 
 
 /*******************************************************************************
@@ -550,6 +554,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_remove_notify_handler);
 
 
 /*******************************************************************************
@@ -647,6 +652,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_EVENTS);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_install_gpe_handler);
 
 
 /*******************************************************************************
@@ -749,6 +755,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_EVENTS);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_remove_gpe_handler);
 
 
 /*******************************************************************************
@@ -791,6 +798,7 @@
 
 	return (status);
 }
+EXPORT_SYMBOL(acpi_acquire_global_lock);
 
 
 /*******************************************************************************
@@ -819,5 +827,5 @@
 	status = acpi_ev_release_global_lock ();
 	return (status);
 }
-
+EXPORT_SYMBOL(acpi_release_global_lock);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxfregn.c.old	2004-11-09 01:09:47.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxfregn.c	2004-11-09 01:46:18.000000000 +0100
@@ -42,6 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -116,6 +117,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_install_address_space_handler);
 
 
 /*******************************************************************************
@@ -241,5 +243,5 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
-
+EXPORT_SYMBOL(acpi_remove_address_space_handler);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxfevnt.c.old	2004-11-09 01:16:39.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxfevnt.c	2004-11-09 01:46:23.000000000 +0100
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
@@ -200,6 +201,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_enable_event);
 
 
 /*******************************************************************************
@@ -248,6 +250,7 @@
 unlock_and_exit:
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_set_gpe_type);
 
 
 /*******************************************************************************
@@ -305,6 +308,7 @@
 	}
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_enable_gpe);
 
 
 /*******************************************************************************
@@ -417,6 +421,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_disable_event);
 
 
 /*******************************************************************************
@@ -456,6 +461,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_clear_event);
 
 
 /*******************************************************************************
@@ -705,6 +711,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_install_gpe_block);
 
 
 /*******************************************************************************
@@ -765,4 +772,5 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_remove_gpe_block);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/resources/rsxface.c.old	2004-11-09 01:18:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/resources/rsxface.c	2004-11-09 01:46:27.000000000 +0100
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acresrc.h>
@@ -156,6 +157,7 @@
 	status = acpi_rs_get_crs_method_data (device_handle, ret_buffer);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_get_current_resources);
 
 
 /*******************************************************************************
@@ -208,6 +210,7 @@
 	status = acpi_rs_get_prs_method_data (device_handle, ret_buffer);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_get_possible_resources);
 
 
 /*******************************************************************************
@@ -310,6 +313,7 @@
 	acpi_os_free (buffer.pointer);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_walk_resources);
 
 
 /*******************************************************************************
@@ -354,6 +358,7 @@
 	status = acpi_rs_set_srs_method_data (device_handle, in_buffer);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_set_current_resources);
 
 
 #define ACPI_COPY_FIELD(out, in, field)  ((out)->field = (in)->field)
@@ -427,3 +432,5 @@
 
 	return (AE_OK);
 }
+EXPORT_SYMBOL(acpi_resource_to_address64);
+
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/hwregs.c.old	2004-11-09 01:22:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/hwregs.c	2004-11-09 01:46:31.000000000 +0100
@@ -43,6 +43,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
@@ -211,6 +212,7 @@
 	acpi_ut_remove_reference (info.return_object);
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_get_sleep_type_data);
 
 
 /*******************************************************************************
@@ -307,6 +309,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_get_register);
 
 
 /*******************************************************************************
@@ -457,6 +460,7 @@
 			value, register_value, bit_reg_info->parent_register));
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_set_register);
 
 
 /******************************************************************************
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/hwsleep.c.old	2004-11-09 01:23:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/hwsleep.c	2004-11-09 01:46:36.000000000 +0100
@@ -42,6 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -391,6 +393,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+EXPORT_SYMBOL(acpi_enter_sleep_state);
 
 
 /******************************************************************************
@@ -456,6 +459,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
 
 
 /******************************************************************************
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utxface.c.old	2004-11-09 01:24:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utxface.c	2004-11-09 01:46:40.000000000 +0100
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
@@ -455,6 +456,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+EXPORT_SYMBOL(acpi_get_system_info);
 
 
 /*****************************************************************************
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/utils.c.old	2004-11-09 01:29:13.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/utils.c	2004-11-09 01:29:51.000000000 +0100
@@ -233,6 +233,7 @@
 
 	return_ACPI_STATUS(AE_OK);
 }
+EXPORT_SYMBOL(acpi_extract_package);
 
 
 acpi_status
@@ -268,6 +269,7 @@
 
 	return_ACPI_STATUS(AE_OK);
 }
+EXPORT_SYMBOL(acpi_evaluate_integer);
 
 
 #if 0
@@ -409,5 +411,5 @@
 
 	return_ACPI_STATUS(status);
 }
-
+EXPORT_SYMBOL(acpi_evaluate_reference);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/bus.c.old	2004-11-09 01:30:28.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/bus.c	2004-11-09 01:46:49.000000000 +0100
@@ -22,6 +22,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
@@ -44,8 +45,11 @@
 #endif
 
 FADT_DESCRIPTOR			acpi_fadt;
+EXPORT_SYMBOL(acpi_fadt);
+
 struct acpi_device		*acpi_root;
 struct proc_dir_entry		*acpi_root_dir;
+EXPORT_SYMBOL(acpi_root_dir);
 
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 
@@ -76,6 +80,7 @@
 
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_get_device);
 
 int
 acpi_bus_get_status (
@@ -121,6 +126,7 @@
 
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_get_status);
 
 
 /* --------------------------------------------------------------------------
@@ -178,6 +184,7 @@
 
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_get_power);
 
 
 int
@@ -266,6 +273,7 @@
 
 	return_VALUE(result);
 }
+EXPORT_SYMBOL(acpi_bus_set_power);
 
 
 
@@ -315,6 +323,7 @@
 
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_generate_event);
 
 int
 acpi_bus_receive_event (
@@ -360,6 +369,7 @@
 
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_receive_event);
 
 
 /* --------------------------------------------------------------------------
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/tables/tbconvrt.c.old	2004-11-09 01:31:07.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/tables/tbconvrt.c	2004-11-09 01:46:54.000000000 +0100
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 
 #include <acpi/acpi.h>
 #include <acpi/actables.h>
@@ -51,6 +52,7 @@
 
 
 u8 acpi_fadt_is_v1;
+EXPORT_SYMBOL(acpi_fadt_is_v1);
 
 /*******************************************************************************
  *
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/scan.c.old	2004-11-09 01:34:12.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/scan.c	2004-11-09 01:35:29.000000000 +0100
@@ -609,6 +609,7 @@
 
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_register_driver);
 
 
 /**
@@ -635,6 +636,7 @@
 	}
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_unregister_driver);
 
 /**
  * acpi_bus_find_driver 
@@ -1107,7 +1109,7 @@
 
 	return_VALUE(result);
 }
-
+EXPORT_SYMBOL(acpi_bus_add);
 
 
 int acpi_bus_scan (struct acpi_device	*start)
@@ -1211,6 +1213,7 @@
 
 	return_VALUE(0);
 }
+EXPORT_SYMBOL(acpi_bus_scan);
 
 
 int
@@ -1268,6 +1271,7 @@
 	}
 	return err;
 }
+EXPORT_SYMBOL(acpi_bus_trim);
 
 static int
 acpi_bus_scan_fixed (
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/pci_irq.c.old	2004-11-09 01:35:50.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/pci_irq.c	2004-11-09 01:36:08.000000000 +0100
@@ -426,3 +426,5 @@
 
 	return_VALUE(dev->irq);
 }
+EXPORT_SYMBOL(acpi_pci_irq_enable);
+
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/pci_root.c.old	2004-11-09 01:36:27.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/pci_root.c	2004-11-09 01:36:54.000000000 +0100
@@ -90,6 +90,7 @@
 
 	return n;
 }
+EXPORT_SYMBOL(acpi_pci_register_driver);
 
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver)
 {
@@ -112,6 +113,7 @@
 		driver->remove(root->handle);
 	}
 }
+EXPORT_SYMBOL(acpi_pci_unregister_driver);
 
 static acpi_status
 get_root_bridge_busnr_callback (struct acpi_resource *resource, void *data)
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/ec.c.old	2004-11-09 01:37:08.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/ec.c	2004-11-09 01:37:28.000000000 +0100
@@ -262,6 +262,7 @@
 	else
 		return err;
 }
+EXPORT_SYMBOL(ec_read);
 
 int
 ec_write(u8 addr, u8 val)
@@ -278,6 +279,7 @@
 
 	return err;
 }
+EXPORT_SYMBOL(ec_write);
 
 
 static int
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/hwtimer.c.old	2004-11-09 01:21:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/hwtimer.c	2004-11-09 02:24:13.000000000 +0100
@@ -42,6 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -112,6 +114,7 @@
 
 	return_ACPI_STATUS (status);
 }
+EXPORT_SYMBOL(acpi_get_timer);
 
 
 /******************************************************************************
@@ -196,5 +199,5 @@
 	*time_elapsed = (u32) quotient;
 	return_ACPI_STATUS (status);
 }
-
+EXPORT_SYMBOL(acpi_get_timer_duration);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/Makefile.old	2004-11-09 01:38:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/Makefile	2004-11-09 01:39:09.000000000 +0100
@@ -12,8 +12,6 @@
 
 EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
 
-obj-$(CONFIG_ACPI)		:= acpi_ksyms.o 
-
 #
 # ACPI Boot-Time Table Parsing
 #
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/acpi_ksyms.c	2004-11-09 01:14:55.000000000 +0100
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,165 +0,0 @@
-/*
- *  acpi_ksyms.c - ACPI Kernel Symbols ($Revision: 16 $)
- *
- *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
- *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or (at
- *  your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-
-#include <linux/module.h>
-#include <linux/acpi.h>
-#include <acpi/acpi.h>
-#include <acpi/acpi_bus.h>
-
-
-#ifdef CONFIG_ACPI_INTERPRETER
-
-/* ACPI Debugger */
-
-#ifdef ENABLE_DEBUGGER
-
-extern int			acpi_in_debugger;
-
-EXPORT_SYMBOL(acpi_in_debugger);
-EXPORT_SYMBOL(acpi_db_user_commands);
-
-#endif /* ENABLE_DEBUGGER */
-
-/* ACPI Core Subsystem */
-
-#ifdef ACPI_DEBUG_OUTPUT
-EXPORT_SYMBOL(acpi_dbg_layer);
-EXPORT_SYMBOL(acpi_dbg_level);
-EXPORT_SYMBOL(acpi_ut_debug_print_raw);
-EXPORT_SYMBOL(acpi_ut_debug_print);
-EXPORT_SYMBOL(acpi_ut_status_exit);
-EXPORT_SYMBOL(acpi_ut_value_exit);
-EXPORT_SYMBOL(acpi_ut_exit);
-EXPORT_SYMBOL(acpi_ut_trace);
-#endif /*ACPI_DEBUG_OUTPUT*/
-
-EXPORT_SYMBOL(acpi_get_handle);
-EXPORT_SYMBOL(acpi_get_parent);
-EXPORT_SYMBOL(acpi_get_type);
-EXPORT_SYMBOL(acpi_get_name);
-EXPORT_SYMBOL(acpi_get_object_info);
-EXPORT_SYMBOL(acpi_get_next_object);
-EXPORT_SYMBOL(acpi_evaluate_object);
-EXPORT_SYMBOL(acpi_get_table);
-EXPORT_SYMBOL(acpi_get_firmware_table);
-EXPORT_SYMBOL(acpi_install_notify_handler);
-EXPORT_SYMBOL(acpi_remove_notify_handler);
-EXPORT_SYMBOL(acpi_install_gpe_handler);
-EXPORT_SYMBOL(acpi_remove_gpe_handler);
-EXPORT_SYMBOL(acpi_install_address_space_handler);
-EXPORT_SYMBOL(acpi_remove_address_space_handler);
-EXPORT_SYMBOL(acpi_install_fixed_event_handler);
-EXPORT_SYMBOL(acpi_remove_fixed_event_handler);
-EXPORT_SYMBOL(acpi_acquire_global_lock);
-EXPORT_SYMBOL(acpi_release_global_lock);
-EXPORT_SYMBOL(acpi_install_gpe_block);
-EXPORT_SYMBOL(acpi_remove_gpe_block);
-EXPORT_SYMBOL(acpi_get_current_resources);
-EXPORT_SYMBOL(acpi_get_possible_resources);
-EXPORT_SYMBOL(acpi_walk_resources);
-EXPORT_SYMBOL(acpi_set_current_resources);
-EXPORT_SYMBOL(acpi_resource_to_address64);
-EXPORT_SYMBOL(acpi_enable_event);
-EXPORT_SYMBOL(acpi_disable_event);
-EXPORT_SYMBOL(acpi_clear_event);
-EXPORT_SYMBOL(acpi_set_gpe_type);
-EXPORT_SYMBOL(acpi_enable_gpe);
-EXPORT_SYMBOL(acpi_get_timer_duration);
-EXPORT_SYMBOL(acpi_get_timer);
-EXPORT_SYMBOL(acpi_get_sleep_type_data);
-EXPORT_SYMBOL(acpi_get_register);
-EXPORT_SYMBOL(acpi_set_register);
-EXPORT_SYMBOL(acpi_enter_sleep_state);
-EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
-EXPORT_SYMBOL(acpi_get_system_info);
-EXPORT_SYMBOL(acpi_get_devices);
-
-/* ACPI OS Services Layer (acpi_osl.c) */
-
-EXPORT_SYMBOL(acpi_os_free);
-EXPORT_SYMBOL(acpi_os_printf);
-EXPORT_SYMBOL(acpi_os_sleep);
-EXPORT_SYMBOL(acpi_os_stall);
-EXPORT_SYMBOL(acpi_os_read_port);
-EXPORT_SYMBOL(acpi_os_write_port);
-EXPORT_SYMBOL(acpi_os_signal);
-EXPORT_SYMBOL(acpi_os_queue_for_execution);
-EXPORT_SYMBOL(acpi_os_signal_semaphore);
-EXPORT_SYMBOL(acpi_os_create_semaphore);
-EXPORT_SYMBOL(acpi_os_delete_semaphore);
-EXPORT_SYMBOL(acpi_os_wait_semaphore);
-EXPORT_SYMBOL(acpi_os_wait_events_complete);
-EXPORT_SYMBOL(acpi_os_read_pci_configuration);
-
-/* ACPI Utilities (acpi_utils.c) */
-
-EXPORT_SYMBOL(acpi_extract_package);
-EXPORT_SYMBOL(acpi_evaluate_integer);
-EXPORT_SYMBOL(acpi_evaluate_reference);
-
-#endif /*CONFIG_ACPI_INTERPRETER*/
-
-
-/* ACPI Bus Driver (acpi_bus.c) */
-
-#ifdef CONFIG_ACPI_BUS
-
-EXPORT_SYMBOL(acpi_fadt);
-EXPORT_SYMBOL(acpi_fadt_is_v1);
-EXPORT_SYMBOL(acpi_walk_namespace);
-EXPORT_SYMBOL(acpi_root_dir);
-EXPORT_SYMBOL(acpi_bus_get_device);
-EXPORT_SYMBOL(acpi_bus_get_status);
-EXPORT_SYMBOL(acpi_bus_get_power);
-EXPORT_SYMBOL(acpi_bus_set_power);
-EXPORT_SYMBOL(acpi_bus_generate_event);
-EXPORT_SYMBOL(acpi_bus_receive_event);
-EXPORT_SYMBOL(acpi_bus_register_driver);
-EXPORT_SYMBOL(acpi_bus_unregister_driver);
-EXPORT_SYMBOL(acpi_bus_scan);
-EXPORT_SYMBOL(acpi_bus_trim);
-EXPORT_SYMBOL(acpi_bus_add);
-
-#endif /*CONFIG_ACPI_BUS*/
-
-
-/* ACPI PCI Driver (pci_irq.c) */
-
-#ifdef CONFIG_ACPI_PCI
-
-#include <linux/pci.h>
-extern int acpi_pci_irq_enable(struct pci_dev *dev);
-EXPORT_SYMBOL(acpi_pci_irq_enable);
-EXPORT_SYMBOL(acpi_pci_register_driver);
-EXPORT_SYMBOL(acpi_pci_unregister_driver);
-#endif /*CONFIG_ACPI_PCI */
-
-#ifdef CONFIG_ACPI_EC
-/* ACPI EC driver (ec.c) */
-
-EXPORT_SYMBOL(ec_read);
-EXPORT_SYMBOL(ec_write);
-#endif
-
