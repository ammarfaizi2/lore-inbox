Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUG1Wvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUG1Wvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUG1WvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:51:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:55800 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266902AbUG1Whd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:37:33 -0400
Subject: [announce][draft4] HVCS for inclusion in 2.6 tree
From: Ryan Arnold <rsa@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <20040728131257.1fedf56d.rddunlap@osdl.org>
References: <1089819720.3385.66.camel@localhost>
	 <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	 <1090528007.3161.7.camel@localhost> <20040722191637.52ab515a.akpm@osdl.org>
	 <1090958938.14771.35.camel@localhost>
	 <20040727155011.77897e68.rddunlap@osdl.org>
	 <1091032768.14771.283.camel@localhost>
	 <20040728131257.1fedf56d.rddunlap@osdl.org>
Content-Type: multipart/mixed; boundary="=-iVKXtnpHlaL1Hde2pIuv"
Organization: IBM
Message-Id: <1091045896.14771.342.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 15:18:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iVKXtnpHlaL1Hde2pIuv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

I implemented some changes that Randy suggested to clean up the hvcs
code and make it more stylistically conformant in this final draft.

This patch was made against Linux kernel 2.6.8-rc2

HVCS changelog:

* include/asm-ppc64/hvcserver.h
	New file added to wrap ppc64 architecture specific firmware calls for
use by HVCS.  This file provides a struct hvcs_partner_info definition,
headers for partner info gathering and vterm connection and termination
interfaces.

* arch/ppc64/kernel/Makefile
	Added build directive for hvcserver.o when HVCS is configured.

* arch/ppc64/kernel/hvconsole.c
	Exported hvc_put_chars() and hvc_get_chars() for use by HVCS.

* arch/ppc64/kernel/hvcserver.c
	Body of hvcserver module which accompanies the hvcs module and provides
ppc64 architecture firmware calls for use by HVCS.  This file provides
function bodies for partner info gathering and vterm connection and
termination interfaces.

* drivers/char/Kconfig
	Added CONFIG_HVCS option for both built-in version and module version
of hvcs.

* drivers/char/Makefile
	Added build directive for hvcs.o when CONFIG_HVCS is configured.

* drivers/char/hvcs.c
	This is the device driver for the IBM Hypervisor Virtual Console
Server, "hvcs".  The IBM hvcs provides a tty driver interface to allow
Linux user space applications access to the system consoles of logically
partitioned operating systems, e.g. Linux, running on the same
partitioned Power5 ppc64 system.  Physical hardware consoles per
partition are not practical on this hardware so system consoles are
accessed by this driver using inter-partition firmware interfaces to
virtual terminal devices.

* Documentation/powerpc/hvcs.txt
	HVCS installation and usage documentation.

Thanks everyone for all the help with this driver [Andrew Morton, Paul
Mackerras, Ben Herrenschmidt, Dave Hansen, Paul Mackerras, Dave
Boutcher, Hollis Blanchard, Santiago Leon, Brian King, Randy Dunlap].

note: I will be out until Monday, August 2nd.  Paul Mackerras has said
he'll handle any issues that arise with this patch until I return.

Ryan S. Arnold
IBM Linux Technology Center

--=-iVKXtnpHlaL1Hde2pIuv
Content-Disposition: attachment; filename=hvcs_to_mainline_draft4.patch
Content-Type: text/x-patch; name=hvcs_to_mainline_draft4.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Signed-off-by: Ryan S. Arnold <rsa@us.ibm.com>

diff -uNr linux-2.6.8-rc2/include/asm-ppc64/hvcserver.h hvcs_working-linux-2.6.8-rc2/include/asm-ppc64/hvcserver.h
--- linux-2.6.8-rc2/include/asm-ppc64/hvcserver.h	Wed Dec 31 18:00:00 1969
+++ hvcs_working-linux-2.6.8-rc2/include/asm-ppc64/hvcserver.h	Wed Jul 28 12:50:16 2004
@@ -0,0 +1,44 @@
+/*
+ * hvcserver.h
+ * Copyright (C) 2004 Ryan S Arnold, IBM Corporation
+ *
+ * PPC64 virtual I/O console server support.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef _PPC64_HVCSERVER_H
+#define _PPC64_HVCSERVER_H
+
+#include <linux/list.h>
+
+/* Converged Location Code length */
+#define HVCS_CLC_LENGTH	79
+
+struct hvcs_partner_info {
+	struct list_head node;
+	unsigned int unit_address;
+	unsigned int partition_ID;
+	char location_code[HVCS_CLC_LENGTH + 1]; /* CLC + 1 null-term char */
+};
+
+extern int hvcs_free_partner_info(struct list_head *head);
+extern int hvcs_get_partner_info(unsigned int unit_address,
+		struct list_head *head, unsigned long *pi_buff);
+extern int hvcs_register_connection(unsigned int unit_address,
+		unsigned int p_partition_ID, unsigned int p_unit_address);
+extern int hvcs_free_connection(unsigned int unit_address);
+
+#endif /* _PPC64_HVCSERVER_H */
diff -uNr linux-2.6.8-rc2/arch/ppc64/kernel/Makefile hvcs_working-linux-2.6.8-rc2/arch/ppc64/kernel/Makefile
--- linux-2.6.8-rc2/arch/ppc64/kernel/Makefile	Wed Jul 28 16:42:31 2004
+++ hvcs_working-linux-2.6.8-rc2/arch/ppc64/kernel/Makefile	Wed Jul 28 12:37:44 2004
@@ -46,6 +46,7 @@
 obj-$(CONFIG_LPARCFG)		+= lparcfg.o
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
+obj-$(CONFIG_HVCS)		+= hvcserver.o
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o \
diff -uNr linux-2.6.8-rc2/arch/ppc64/kernel/hvconsole.c hvcs_working-linux-2.6.8-rc2/arch/ppc64/kernel/hvconsole.c
--- linux-2.6.8-rc2/arch/ppc64/kernel/hvconsole.c	Wed Jun 16 00:19:23 2004
+++ hvcs_working-linux-2.6.8-rc2/arch/ppc64/kernel/hvconsole.c	Wed Jul 28 12:37:44 2004
@@ -20,6 +20,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <asm/hvcall.h>
 #include <asm/prom.h>
 #include <asm/hvconsole.h>
@@ -50,6 +51,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(hvc_get_chars);
+
 int hvc_put_chars(int index, const char *buf, int count)
 {
 	unsigned long *lbuf = (unsigned long *) buf;
@@ -63,6 +66,8 @@
 		return 0;
 	return -1;
 }
+
+EXPORT_SYMBOL(hvc_put_chars);
 
 /* return the number of client vterms present */
 /* XXX this requires an interface change to handle multiple discontiguous
diff -uNr linux-2.6.8-rc2/arch/ppc64/kernel/hvcserver.c hvcs_working-linux-2.6.8-rc2/arch/ppc64/kernel/hvcserver.c
--- linux-2.6.8-rc2/arch/ppc64/kernel/hvcserver.c	Wed Dec 31 18:00:00 1969
+++ hvcs_working-linux-2.6.8-rc2/arch/ppc64/kernel/hvcserver.c	Wed Jul 28 16:05:22 2004
@@ -0,0 +1,219 @@
+/*
+ * hvcserver.c
+ * Copyright (C) 2004 Ryan S Arnold, IBM Corporation
+ *
+ * PPC64 virtual I/O console server support.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <asm/hvcall.h>
+#include <asm/hvcserver.h>
+#include <asm/io.h>
+
+#define HVCS_ARCH_VERSION "1.0.0"
+
+MODULE_AUTHOR("Ryan S. Arnold <rsa@us.ibm.com>");
+MODULE_DESCRIPTION("IBM hvcs ppc64 API");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(HVCS_ARCH_VERSION);
+
+/*
+ * Convert arch specific return codes into relevant errnos.  The hvcs
+ * functions aren't performance sensitive, so this conversion isn't an
+ * issue.
+ */
+int hvcs_convert(long to_convert)
+{
+	switch (to_convert) {
+		case H_Success:
+			return 0;
+		case H_Parameter:
+			return -EINVAL;
+		case H_Hardware:
+			return -EIO;
+		case H_Busy:
+		case H_LongBusyOrder1msec:
+		case H_LongBusyOrder10msec:
+		case H_LongBusyOrder100msec:
+		case H_LongBusyOrder1sec:
+		case H_LongBusyOrder10sec:
+		case H_LongBusyOrder100sec:
+			return -EBUSY;
+		case H_Function: /* fall through */
+		default:
+			return -EPERM;
+	}
+}
+
+int hvcs_free_partner_info(struct list_head *head)
+{
+	struct hvcs_partner_info *pi;
+	struct list_head *element;
+
+	if (!head) {
+		return -EINVAL;
+	}
+
+	while (!list_empty(head)) {
+		element = head->next;
+		pi = list_entry(element, struct hvcs_partner_info, node);
+		list_del(element);
+		kfree(pi);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(hvcs_free_partner_info);
+
+/* Helper function for hvcs_get_partner_info */
+int hvcs_next_partner(unsigned int unit_address,
+		unsigned long last_p_partition_ID,
+		unsigned long last_p_unit_address, unsigned long *pi_buff)
+
+{
+	long retval;
+	retval = plpar_hcall_norets(H_VTERM_PARTNER_INFO, unit_address,
+			last_p_partition_ID,
+				last_p_unit_address, virt_to_phys(pi_buff));
+	return hvcs_convert(retval);
+}
+
+/*
+ * The unit_address parameter is the unit address of the vty-server vdevice
+ * in whose partner information the caller is interested.  This function
+ * uses a pointer to a list_head instance in which to store the partner info.
+ * This function returns non-zero on success, or if there is no partner info.
+ *
+ * Invocation of this function should always be followed by an invocation of
+ * hvcs_free_partner_info() using a pointer to the SAME list head instance
+ * that was used to store the partner_info list.
+ */
+int hvcs_get_partner_info(unsigned int unit_address, struct list_head *head,
+		unsigned long *pi_buff)
+{
+	/*
+	 * This is a page sized buffer to be passed to hvcall per invocation.
+	 * NOTE: the first long returned is unit_address.  The second long
+	 * returned is the partition ID and starting with pi_buff[2] are
+	 * HVCS_CLC_LENGTH characters, which are diff size than the unsigned
+	 * long, hence the casting mumbojumbo you see later.
+	 */
+	unsigned long	last_p_partition_ID;
+	unsigned long	last_p_unit_address;
+	struct hvcs_partner_info *next_partner_info = NULL;
+	int more = 1;
+	int retval;
+
+	memset(pi_buff, 0x00, PAGE_SIZE);
+	/* invalid parameters */
+	if (!head)
+		return -EINVAL;
+
+	last_p_partition_ID = last_p_unit_address = ~0UL;
+	INIT_LIST_HEAD(head);
+
+	if (!pi_buff)
+		return -ENOMEM;
+
+	do {
+		retval = hvcs_next_partner(unit_address, last_p_partition_ID,
+				last_p_unit_address, pi_buff);
+		if (retval) {
+			/*
+			 * Don't indicate that we've failed if we have
+			 * any list elements.
+			 */
+			if (!list_empty(head))
+				return 0;
+			return retval;
+		}
+
+		last_p_partition_ID = pi_buff[0];
+		last_p_unit_address = pi_buff[1];
+
+		/* This indicates that there are no further partners */
+		if (last_p_partition_ID == ~0UL
+				&& last_p_unit_address == ~0UL)
+			break;
+
+		/* This is a very small struct and will be freed soon in
+		 * hvcs_free_partner_info(). */
+		next_partner_info = kmalloc(sizeof(struct hvcs_partner_info),
+				GFP_ATOMIC);
+
+		if (!next_partner_info) {
+			printk(KERN_WARNING "HVCONSOLE: kmalloc() failed to"
+				" allocate partner info struct.\n");
+			hvcs_free_partner_info(head);
+			return -ENOMEM;
+		}
+
+		next_partner_info->unit_address
+			= (unsigned int)last_p_unit_address;
+		next_partner_info->partition_ID
+			= (unsigned int)last_p_partition_ID;
+
+		/* copy the Null-term char too */
+		strncpy(&next_partner_info->location_code[0],
+			(char *)&pi_buff[2],
+			strlen((char *)&pi_buff[2]) + 1);
+
+		list_add_tail(&(next_partner_info->node), head);
+		next_partner_info = NULL;
+
+	} while (more);
+
+	return 0;
+}
+EXPORT_SYMBOL(hvcs_get_partner_info);
+
+/*
+ * If this function is called once and -EINVAL is returned it may
+ * indicate that the partner info needs to be refreshed for the
+ * target unit address at which point the caller must invoke
+ * hvcs_get_partner_info() and then call this function again.  If,
+ * for a second time, -EINVAL is returned then it indicates that
+ * there is probably already a partner connection registered to a
+ * different vty-server@ vdevice.  It is also possible that a second
+ * -EINVAL may indicate that one of the parms is not valid, for
+ * instance if the link was removed between the vty-server@ vdevice
+ * and the vty@ vdevice that you are trying to open.  Don't shoot the
+ * messenger.  Firmware implemented it this way.
+ */
+int hvcs_register_connection( unsigned int unit_address,
+		unsigned int p_partition_ID, unsigned int p_unit_address)
+{
+	long retval;
+	retval = plpar_hcall_norets(H_REGISTER_VTERM, unit_address,
+				p_partition_ID, p_unit_address);
+	return hvcs_convert(retval);
+}
+EXPORT_SYMBOL(hvcs_register_connection);
+
+/*
+ * If -EBUSY is returned continue to call this function
+ * until 0 is returned.
+ */
+int hvcs_free_connection(unsigned int unit_address)
+{
+	long retval;
+	retval = plpar_hcall_norets(H_FREE_VTERM, unit_address);
+	return hvcs_convert(retval);
+}
+EXPORT_SYMBOL(hvcs_free_connection);
diff -uNr linux-2.6.8-rc2/drivers/char/Kconfig hvcs_working-linux-2.6.8-rc2/drivers/char/Kconfig
--- linux-2.6.8-rc2/drivers/char/Kconfig	Wed Jul 28 16:42:47 2004
+++ hvcs_working-linux-2.6.8-rc2/drivers/char/Kconfig	Wed Jul 28 12:39:21 2004
@@ -570,6 +570,23 @@
 	  console. This driver allows each pSeries partition to have a console
 	  which is accessed via the HMC.
 
+config HVCS
+	tristate "IBM Hypervisor Virtual Console Server support"
+	depends on PPC_PSERIES
+	help
+	  Partitionable IBM Power5 ppc64 machines allow hosting of
+	  firmware virtual consoles from one Linux partition by
+	  another Linux partition.  This driver allows console data
+	  from Linux partitions to be accessed through TTY device
+	  interfaces in the device tree of a Linux partition running
+	  this driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hvcs.ko.  Additionally, this module
+	  will depend on arch specific APIs exported from hvcserver.ko
+	  which will also be compiled when this driver is built as a
+	  module.
+
 config QIC02_TAPE
 	tristate "QIC-02 tape support"
 	help
diff -uNr linux-2.6.8-rc2/drivers/char/Makefile hvcs_working-linux-2.6.8-rc2/drivers/char/Makefile
--- linux-2.6.8-rc2/drivers/char/Makefile	Wed Jul 28 16:42:47 2004
+++ hvcs_working-linux-2.6.8-rc2/drivers/char/Makefile	Wed Jul 28 12:37:44 2004
@@ -43,6 +43,7 @@
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_VIOCONS) += viocons.o
 obj-$(CONFIG_VIOTAPE)		+= viotape.o
+obj-$(CONFIG_HVCS)		+= hvcs.o
 
 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
diff -uNr linux-2.6.8-rc2/drivers/char/hvcs.c hvcs_working-linux-2.6.8-rc2/drivers/char/hvcs.c
--- linux-2.6.8-rc2/drivers/char/hvcs.c	Wed Dec 31 18:00:00 1969
+++ hvcs_working-linux-2.6.8-rc2/drivers/char/hvcs.c	Wed Jul 28 14:47:40 2004
@@ -0,0 +1,1579 @@
+/*
+ * IBM eServer Hypervisor Virtual Console Server Device Driver
+ * Copyright (C) 2003, 2004 IBM Corp.
+ *  Ryan S. Arnold (rsa@us.ibm.com)
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Author(s) :  Ryan S. Arnold <rsa@us.ibm.com>
+ *
+ * This is the device driver for the IBM Hypervisor Virtual Console Server,
+ * "hvcs".  The IBM hvcs provides a tty driver interface to allow Linux
+ * user space applications access to the system consoles of logically
+ * partitioned operating systems, e.g. Linux, running on the same partitioned
+ * Power5 ppc64 system.  Physical hardware consoles per partition are not
+ * practical on this hardware so system consoles are accessed by this driver
+ * using inter-partition firmware interfaces to virtual terminal devices.
+ *
+ * A vty is known to the HMC as a "virtual serial server adapter".  It is a
+ * virtual terminal device that is created by firmware upon partition creation
+ * to act as a partitioned OS's console device.
+ *
+ * Firmware dynamically (via hotplug) exposes vty-servers to a running ppc64
+ * Linux system upon their creation by the HMC or their exposure during boot.
+ * The non-user interactive backend of this driver is implemented as a vio
+ * device driver so that it can receive notification of vty-server lifetimes
+ * after it registers with the vio bus to handle vty-server probe and remove
+ * callbacks.
+ *
+ * Many vty-servers can be configured to connect to one vty, but a vty can
+ * only be actively connected to by a single vty-server, in any manner, at one
+ * time.  If the HMC is currently hosting the console for a target Linux
+ * partition; attempts to open the tty device to the partition's console using
+ * the hvcs on any partition will return -EBUSY with every open attempt until
+ * the HMC frees the connection between its vty-server and the desired
+ * partition's vty device.  Conversely, a vty-server may only be connected to
+ * a single vty at one time even though it may have several configured vty
+ * partner possibilities.
+ *
+ * Firmware does not provide notification of vty partner changes to this
+ * driver.  This means that an HMC Super Admin may add or remove partner vtys
+ * from a vty-server's partner list but the changes will not be signaled to
+ * the vty-server.  Firmware only notifies the driver when a vty-server is
+ * added or removed from the system.  To compensate for this deficiency, this
+ * driver implements a sysfs update attribute which provides a method for
+ * rescanning partner information upon a user's request.
+ *
+ * Each vty-server, prior to being exposed to this driver is reference counted
+ * using the 2.6 Linux kernel kobject construct.  This kobject is also used by
+ * the vio bus to provide a vio device sysfs entry that this driver attaches
+ * device specific attributes to, including partner information.  The vio bus
+ * framework also provides a sysfs entry for each vio driver.  The hvcs driver
+ * provides driver attributes in this entry.
+ *
+ * For direction on installation and usage of this driver please reference
+ * Documentation/powerpc/hvcs.txt.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/major.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/stat.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <asm/hvconsole.h>
+#include <asm/hvcserver.h>
+#include <asm/uaccess.h>
+#include <asm/vio.h>
+
+/*
+ * 1.0.0 -> 1.1.0 Added kernel_thread scheduling methodology to driver to
+ * replace wait_task constructs.
+ *
+ * 1.1.0 -> 1.2.0 Moved pi_buff initialization out of arch code into driver code
+ * and added locking to share this buffer between hvcs_struct instances.  This
+ * is because the page_size kmalloc can't be done with a spin_lock held.
+ *
+ * Also added sysfs attribute to manually disconnect the vty-server from the vty
+ * due to stupid firmware behavior when opening the connection then sending data
+ * then then quickly closing the connection would cause data loss on the
+ * receiving side.  This required some reordering of the termination code.
+ *
+ * Fixed the hangup scenario and fixed memory leaks on module_exit.
+ *
+ * 1.2.0 -> 1.3.0 Moved from manual kernel thread creation & execution to
+ * kthread construct which replaced in-kernel IPC for thread termination with
+ * kthread_stop and kthread_should_stop.  Explicit wait_queue handling was
+ * removed because kthread handles this.  Minor bug fix to postpone partner_info
+ * clearing on hvcs_close until adapter removal to preserve context data for
+ * printk on partner connection free.  Added lock to protect hvcs_structs so
+ * that hvcs_struct instances aren't added or removed during list traversal.
+ * Cleaned up comment style, added spaces after commas, and broke function
+ * declaration lines to be under 80 columns.
+ */
+#define HVCS_DRIVER_VERSION "1.3.0"
+
+MODULE_AUTHOR("Ryan S. Arnold <rsa@us.ibm.com>");
+MODULE_DESCRIPTION("IBM hvcs (Hypervisor Virtual Console Server) Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(HVCS_DRIVER_VERSION);
+
+/*
+ * Since the Linux TTY code does not currently (2-04-2004) support dynamic
+ * addition of tty derived devices and we shouldn't allocate thousands of
+ * tty_device pointers when the number of vty-server & vty partner connections
+ * will most often be much lower than this, we'll arbitrarily allocate
+ * HVCS_DEFAULT_SERVER_ADAPTERS tty_structs and cdev's by default when we
+ * register the tty_driver. This can be overridden using an insmod parameter.
+ */
+#define HVCS_DEFAULT_SERVER_ADAPTERS	64
+
+/*
+ * The user can't insmod with more than HVCS_MAX_SERVER_ADAPTERS hvcs device
+ * nodes as a sanity check.  Theoretically there can be over 1 Billion
+ * vty-server & vty partner connections.
+ */
+#define HVCS_MAX_SERVER_ADAPTERS	1024
+
+/*
+ * We let Linux assign us a major number and we start the minors at zero.  There
+ * is no intuitive mapping between minor number and the target partition.  The
+ * mapping of minor number is related to the order the vty-servers are exposed
+ * to this driver via the hvcs_probe function.
+ */
+#define HVCS_MINOR_START	0
+
+/*
+ * The hcall interface involves putting 8 chars into each of two registers.
+ * We load up those 2 registers (in arch/ppc64/hvconsole.c) by casting char[16]
+ * to long[2].  It would work without __ALIGNED__, but a little (tiny) bit
+ * slower because an unaligned load is slower than aligned load.
+ */
+#define __ALIGNED__	__attribute__((__aligned__(8)))
+
+/* Converged location code string length + 1 null terminator */
+#define CLC_LENGTH		80
+
+/*
+ * How much data can firmware send with each hvc_put_chars()?  Maybe this
+ * should be moved into an architecture specific area.
+ */
+#define HVCS_BUFF_LEN	16
+
+/*
+ * This is the maximum amount of data we'll let the user send us (hvcs_write) at
+ * once in a chunk as a sanity check.
+ */
+#define HVCS_MAX_FROM_USER	4096
+
+/*
+ * Be careful when adding flags to this line discipline.  Don't add anything
+ * that will cause echoing or we'll go into recursive loop echoing chars back
+ * and forth with the console drivers.
+ */
+static struct termios hvcs_tty_termios = {
+	.c_iflag = IGNBRK | IGNPAR,
+	.c_oflag = OPOST,
+	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
+	.c_cc = INIT_C_CC
+};
+
+/*
+ * This value is used to take the place of a command line parameter when the
+ * module is inserted.  It starts as -1 and stays as such if the user doesn't
+ * specify a module insmod parameter.  If they DO specify one then it is set to
+ * the value of the integer passed in.
+ */
+static int hvcs_parm_num_devs = -1;
+module_param(hvcs_parm_num_devs, int, 0);
+
+char hvcs_driver_name[] = "hvcs";
+char hvcs_device_node[] = "hvcs";
+char hvcs_driver_string[]
+	= "IBM hvcs (Hypervisor Virtual Console Server) Driver";
+
+/* Status of partner info rescan triggered via sysfs. */
+static int hvcs_rescan_status = 0;
+
+static struct tty_driver *hvcs_tty_driver;
+
+/*
+ * This is used to associate a vty-server, as it is exposed to this driver, with
+ * a preallocated tty_struct.index.  The dev node and hvcs index numbers are not
+ * re-used after device removal otherwise removing and adding a new one would
+ * link a /dev/hvcs* entry to a different vty-server than it did before the
+ * removal.  Incidentally, a newly exposed vty-server will always map to an
+ * incrementally higher /dev/hvcs* entry than the last exposed vty-server.
+ */
+static int hvcs_struct_count = -1;
+
+/*
+ * Used by the khvcsd to pick up I/O operations when the kernel_thread is
+ * already awake but potentially shifted to TASK_INTERRUPTIBLE state.
+ */
+static int hvcs_kicked = 0;
+
+/* Used the the kthread construct for task operations */
+static struct task_struct *hvcs_task;
+
+/*
+ * We allocate this for the use of all of the hvcs_structs when they fetch
+ * partner info.
+ */
+static unsigned long *hvcs_pi_buff;
+
+static spinlock_t hvcs_pi_lock;
+
+/* One vty-server per hvcs_struct */
+struct hvcs_struct {
+	spinlock_t lock;
+
+	/*
+	 * This index identifies this hvcs device as the complement to a
+	 * specific tty index.
+	 */
+	unsigned int index;
+
+	struct tty_struct *tty;
+	unsigned int open_count;
+
+	/*
+	 * Used to tell the driver kernel_thread what operations need to take
+	 * place upon this hvcs_struct instance.
+	 */
+	int todo_mask;
+
+	/*
+	 * This buffer is required so that when hvcs_write_room() reports that
+	 * it can send HVCS_BUFF_LEN characters that it will buffer the full
+	 * HVCS_BUFF_LEN characters if need be.  This is essential for opost
+	 * writes since they do not do high level buffering and expect to be
+	 * able to send what the driver commits to sending buffering
+	 * [e.g. tab to space conversions in n_tty.c opost()].
+	 */
+	char buffer[HVCS_BUFF_LEN];
+	int chars_in_buffer;
+
+	/*
+	 * Any variable below the kobject is valid before a tty is connected and
+	 * stays valid after the tty is disconnected.  These shouldn't be
+	 * whacked until the koject refcount reaches zero though some entries
+	 * may be changed via sysfs initiatives.
+	 */
+	struct kobject kobj; /* ref count & hvcs_struct lifetime */
+	int connected; /* is the vty-server currently connected to a vty? */
+	unsigned int p_unit_address; /* partner unit address */
+	unsigned int p_partition_ID; /* partner partition ID */
+	char p_location_code[CLC_LENGTH];
+	struct list_head next; /* list management */
+	struct vio_dev *vdev;
+};
+
+/* Required to back map a kobject to its containing object */
+#define from_kobj(kobj) container_of(kobj, struct hvcs_struct, kobj)
+
+static struct list_head hvcs_structs = LIST_HEAD_INIT(hvcs_structs);
+static spinlock_t hvcs_structs_lock;
+
+static void hvcs_unthrottle(struct tty_struct *tty);
+static void hvcs_throttle(struct tty_struct *tty);
+static irqreturn_t hvcs_handle_interrupt(int irq, void *dev_instance,
+		struct pt_regs *regs);
+
+static int hvcs_write(struct tty_struct *tty, int from_user,
+		const unsigned char *buf, int count);
+static int hvcs_write_room(struct tty_struct *tty);
+static int hvcs_chars_in_buffer(struct tty_struct *tty);
+
+static int hvcs_has_pi(struct hvcs_struct *hvcsd);
+static void hvcs_set_pi(struct hvcs_partner_info *pi,
+		struct hvcs_struct *hvcsd);
+static int hvcs_get_pi(struct hvcs_struct *hvcsd);
+static int hvcs_rescan_devices_list(void);
+
+static int hvcs_partner_connect(struct hvcs_struct *hvcsd);
+static void hvcs_partner_free(struct hvcs_struct *hvcsd);
+
+static int hvcs_enable_device(struct hvcs_struct *hvcsd,
+		uint32_t unit_address, unsigned int irq, struct vio_dev *dev);
+static void hvcs_final_close(struct hvcs_struct *hvcsd);
+
+static void destroy_hvcs_struct(struct kobject *kobj);
+static int hvcs_open(struct tty_struct *tty, struct file *filp);
+static void hvcs_close(struct tty_struct *tty, struct file *filp);
+static void hvcs_hangup(struct tty_struct * tty);
+
+static void hvcs_create_device_attrs(struct hvcs_struct *hvcsd);
+static void hvcs_remove_device_attrs(struct vio_dev *vdev);
+static void hvcs_create_driver_attrs(void);
+static void hvcs_remove_driver_attrs(void);
+
+static int __devinit hvcs_probe(struct vio_dev *dev,
+		const struct vio_device_id *id);
+static int __devexit hvcs_remove(struct vio_dev *dev);
+static int __init hvcs_module_init(void);
+static void __exit hvcs_module_exit(void);
+
+#define HVCS_SCHED_READ	0x00000001
+#define HVCS_QUICK_READ	0x00000002
+#define HVCS_TRY_WRITE	0x00000004
+#define HVCS_READ_MASK	(HVCS_SCHED_READ | HVCS_QUICK_READ)
+
+static void hvcs_kick(void)
+{
+	hvcs_kicked = 1;
+	wmb();
+	wake_up_process(hvcs_task);
+}
+
+static void hvcs_unthrottle(struct tty_struct *tty)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	hvcsd->todo_mask |= HVCS_SCHED_READ;
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	hvcs_kick();
+}
+
+static void hvcs_throttle(struct tty_struct *tty)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	vio_disable_interrupts(hvcsd->vdev);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+}
+
+/*
+ * If the device is being removed we don't have to worry about this interrupt
+ * handler taking any further interrupts because they are disabled which means
+ * the hvcs_struct will always be valid in this handler.
+ */
+static irqreturn_t hvcs_handle_interrupt(int irq, void *dev_instance,
+		struct pt_regs *regs)
+{
+	struct hvcs_struct *hvcsd = dev_instance;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	vio_disable_interrupts(hvcsd->vdev);
+	hvcsd->todo_mask |= HVCS_SCHED_READ;
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	hvcs_kick();
+
+	return IRQ_HANDLED;
+}
+
+/* This function must be called with the hvcsd->lock held */
+static void hvcs_try_write(struct hvcs_struct *hvcsd)
+{
+	unsigned int unit_address = hvcsd->vdev->unit_address;
+	struct tty_struct *tty = hvcsd->tty;
+	int sent;
+
+	if (hvcsd->todo_mask & HVCS_TRY_WRITE) {
+		/* won't send partial writes */
+		sent = hvc_put_chars(unit_address,
+				&hvcsd->buffer[0],
+				hvcsd->chars_in_buffer );
+		if (sent > 0) {
+			hvcsd->chars_in_buffer = 0;
+			wmb();
+			hvcsd->todo_mask &= ~(HVCS_TRY_WRITE);
+			wmb();
+
+			/*
+			 * We are still obligated to deliver the data to the
+			 * hypervisor even if the tty has been closed because
+			 * we commited to delivering it.  But don't try to wake
+			 * a non-existent tty.
+			 */
+			if (tty) {
+				if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP))
+						&& tty->ldisc.write_wakeup)
+					(tty->ldisc.write_wakeup) (tty);
+				wake_up_interruptible(&tty->write_wait);
+			}
+		}
+	}
+}
+
+static int hvcs_io(struct hvcs_struct *hvcsd)
+{
+	unsigned int unit_address;
+	struct tty_struct *tty;
+	char buf[HVCS_BUFF_LEN] __ALIGNED__;
+	unsigned long flags;
+	int got;
+	int i;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	unit_address = hvcsd->vdev->unit_address;
+	tty = hvcsd->tty;
+
+	hvcs_try_write(hvcsd);
+
+	if (!tty || test_bit(TTY_THROTTLED, &tty->flags)) {
+		hvcsd->todo_mask &= ~(HVCS_READ_MASK);
+		goto bail;
+	} else if (!(hvcsd->todo_mask & (HVCS_READ_MASK)))
+		goto bail;
+
+	/* remove the read masks */
+	hvcsd->todo_mask &= ~(HVCS_READ_MASK);
+
+	if ((tty->flip.count + HVCS_BUFF_LEN) < TTY_FLIPBUF_SIZE) {
+		got = hvc_get_chars(unit_address,
+				&buf[0],
+				HVCS_BUFF_LEN);
+		for (i=0;got && i<got;i++)
+			tty_insert_flip_char(tty, buf[i], TTY_NORMAL);
+	}
+
+	/* Give the TTY time to process the data we just sent. */
+	if (got)
+		hvcsd->todo_mask |= HVCS_QUICK_READ;
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	if (tty->flip.count) {
+		/* This is synch because tty->low_latency == 1 */
+		tty_flip_buffer_push(tty);
+	}
+
+	if (!got) {
+		/* Do this _after_ the flip_buffer_push */
+		spin_lock_irqsave(&hvcsd->lock, flags);
+		vio_enable_interrupts(hvcsd->vdev);
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+	}
+
+	return hvcsd->todo_mask;
+
+ bail:
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return hvcsd->todo_mask;
+}
+
+static int khvcsd(void *unused)
+{
+	struct hvcs_struct *hvcsd = NULL;
+	struct list_head *element;
+	struct list_head *safe_temp;
+	int hvcs_todo_mask;
+	unsigned long structs_flags;
+
+	__set_current_state(TASK_RUNNING);
+
+	do {
+		hvcs_todo_mask = 0;
+		hvcs_kicked = 0;
+		wmb();
+
+		spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
+		list_for_each_safe(element, safe_temp, &hvcs_structs) {
+			hvcsd = list_entry(element, struct hvcs_struct, next);
+				hvcs_todo_mask |= hvcs_io(hvcsd);
+		}
+		spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+
+		/*
+		 * If any of the hvcs adapters want to try a write or quick read
+		 * don't schedule(), yield a smidgen then execute the hvcs_io
+		 * thread again for those that want the write.
+		 */
+		 if (hvcs_todo_mask & (HVCS_TRY_WRITE | HVCS_QUICK_READ)) {
+			yield();
+			continue;
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!hvcs_kicked)
+			schedule();
+		__set_current_state(TASK_RUNNING);
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static struct vio_device_id hvcs_driver_table[] __devinitdata= {
+	{"serial-server", "hvterm2"},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(vio, hvcs_driver_table);
+
+/* callback when the kboject ref count reaches zero */
+static void destroy_hvcs_struct(struct kobject *kobj)
+{
+	struct hvcs_struct *hvcsd = from_kobj(kobj);
+	struct vio_dev *vdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	/* the list_del poisons the pointers */
+	list_del(&(hvcsd->next));
+
+	if (hvcsd->connected == 1) {
+		hvcs_partner_free(hvcsd);
+		printk(KERN_INFO "HVCS: Closed vty-server@%X and"
+				" partner vty@%X:%d connection.\n",
+				hvcsd->vdev->unit_address,
+				hvcsd->p_unit_address,
+				(unsigned int)hvcsd->p_partition_ID);
+	}
+	printk(KERN_INFO "HVCS: Destroyed hvcs_struct for vty-server@%X.\n",
+			hvcsd->vdev->unit_address);
+
+	vdev = hvcsd->vdev;
+	hvcsd->vdev = NULL;
+
+	hvcsd->p_unit_address = 0;
+	hvcsd->p_partition_ID = 0;
+	memset(&hvcsd->p_location_code[0], 0x00, CLC_LENGTH);
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+	hvcs_remove_device_attrs(vdev);
+
+	kfree(hvcsd);
+}
+
+/* This function must be called with hvcsd->lock held. */
+static void hvcs_final_close(struct hvcs_struct *hvcsd)
+{
+	vio_disable_interrupts(hvcsd->vdev);
+	free_irq(hvcsd->vdev->irq, hvcsd);
+
+	hvcsd->todo_mask = 0;
+
+	/* These two may be redundant if the operation was a close. */
+	if (hvcsd->tty) {
+		hvcsd->tty->driver_data = NULL;
+		hvcsd->tty = NULL;
+	}
+
+	hvcsd->open_count = 0;
+
+	memset(&hvcsd->buffer[0], 0x00, HVCS_BUFF_LEN);
+	hvcsd->chars_in_buffer = 0;
+}
+
+static struct kobj_type hvcs_kobj_type = {
+	.release = destroy_hvcs_struct,
+};
+
+static int __devinit hvcs_probe(
+	struct vio_dev *dev,
+	const struct vio_device_id *id)
+{
+	struct hvcs_struct *hvcsd;
+	unsigned long structs_flags;
+
+	if (!dev || !id) {
+		printk(KERN_ERR "HVCS: probed with invalid parameter.\n");
+		return -EPERM;
+	}
+
+	hvcsd = kmalloc(sizeof(*hvcsd), GFP_KERNEL);
+	if (!hvcsd) {
+		return -ENODEV;
+	}
+
+	/* hvcsd->tty is zeroed out with the memset */
+	memset(hvcsd, 0x00, sizeof(*hvcsd));
+
+	hvcsd->lock = SPIN_LOCK_UNLOCKED;
+	/* Automatically incs the refcount the first time */
+	kobject_init(&hvcsd->kobj);
+	/* Set up the callback for terminating the hvcs_struct's life */
+	hvcsd->kobj.ktype = &hvcs_kobj_type;
+
+	hvcsd->vdev = dev;
+	dev->dev.driver_data = hvcsd;
+
+	hvcsd->index = ++hvcs_struct_count;
+	hvcsd->chars_in_buffer = 0;
+	hvcsd->todo_mask = 0;
+	hvcsd->connected = 0;
+
+	/*
+	 * This will populate the hvcs_struct's partner info fields for the
+	 * first time.
+	 */
+	if (hvcs_get_pi(hvcsd)) {
+		printk(KERN_ERR "HVCS: Failed to fetch partner"
+			" info for vty-server@%X on device probe.\n",
+			hvcsd->vdev->unit_address);
+	}
+
+	/*
+	 * If a user app opens a tty that corresponds to this vty-server before
+	 * the hvcs_struct has been added to the devices list then the user app
+	 * will get -ENODEV.
+	 */
+
+	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
+
+	list_add_tail(&(hvcsd->next), &hvcs_structs);
+
+	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+
+	hvcs_create_device_attrs(hvcsd);
+
+	printk(KERN_INFO "HVCS: Added vty-server@%X.\n", dev->unit_address);
+
+	/*
+	 * DON'T enable interrupts here because there is no user to receive the
+	 * data.
+	 */
+	return 0;
+}
+
+static int __devexit hvcs_remove(struct vio_dev *dev)
+{
+	struct hvcs_struct *hvcsd = dev->dev.driver_data;
+	unsigned long flags;
+	struct kobject *kobjp;
+	struct tty_struct *tty;
+
+	if (!hvcsd)
+		return -ENODEV;
+
+	/* By this time the vty-server won't be getting any more interrups */
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	tty = hvcsd->tty;
+
+	kobjp = &hvcsd->kobj;
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+	/*
+	 * Let the last holder of this object cause it to be removed, which
+	 * would probably be tty_hangup below.
+	 */
+	kobject_put (kobjp);
+
+	/*
+	 * The hangup is a scheduled function which will auto chain call
+	 * hvcs_hangup.  The tty should always be valid at this time unless a
+	 * simultaneous tty close already cleaned up the hvcs_struct.
+	 */
+	if (tty)
+		tty_hangup(tty);
+
+	printk(KERN_INFO "HVCS: vty-server@%X removed from the"
+			" vio bus.\n", dev->unit_address);
+	return 0;
+};
+
+static struct vio_driver hvcs_vio_driver = {
+	.name		= hvcs_driver_name,
+	.id_table	= hvcs_driver_table,
+	.probe		= hvcs_probe,
+	.remove		= hvcs_remove,
+};
+
+/* Only called from hvcs_get_pi please */
+static void hvcs_set_pi(struct hvcs_partner_info *pi, struct hvcs_struct *hvcsd)
+{
+	int clclength;
+
+	hvcsd->p_unit_address = pi->unit_address;
+	hvcsd->p_partition_ID  = pi->partition_ID;
+	clclength = strlen(&pi->location_code[0]);
+	if (clclength > CLC_LENGTH - 1)
+		clclength = CLC_LENGTH - 1;
+
+	/* copy the null-term char too */
+	strncpy(&hvcsd->p_location_code[0],
+			&pi->location_code[0], clclength + 1);
+}
+
+/*
+ * Traverse the list and add the partner info that is found to the hvcs_struct
+ * struct entry. NOTE: At this time I know that partner info will return a
+ * single entry but in the future there may be multiple partner info entries per
+ * vty-server and you'll want to zero out that list and reset it.  If for some
+ * reason you have an old version of this driver but there IS more than one
+ * partner info then hvcsd->p_* will hold the last partner info data from the
+ * firmware query.  A good way to update this code would be to replace the three
+ * partner info fields in hvcs_struct with a list of hvcs_partner_info
+ * instances.
+ *
+ * This function must be called with the hvcsd->lock held.
+ */
+static int hvcs_get_pi(struct hvcs_struct *hvcsd)
+{
+	/* struct hvcs_partner_info *head_pi = NULL; */
+	struct hvcs_partner_info *pi = NULL;
+	unsigned int unit_address = hvcsd->vdev->unit_address;
+	struct list_head head;
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcs_pi_lock, flags);
+	if (!hvcs_pi_buff) {
+		spin_unlock_irqrestore(&hvcs_pi_lock, flags);
+		return -EFAULT;
+	}
+	retval = hvcs_get_partner_info(unit_address, &head, hvcs_pi_buff);
+	spin_unlock_irqrestore(&hvcs_pi_lock, flags);
+	if (retval) {
+		printk(KERN_ERR "HVCS: Failed to fetch partner"
+			" info for vty-server@%x.\n", unit_address);
+		return retval;
+	}
+
+	/* nixes the values if the partner vty went away */
+	hvcsd->p_unit_address = 0;
+	hvcsd->p_partition_ID = 0;
+
+	list_for_each_entry(pi, &head, node)
+		hvcs_set_pi(pi, hvcsd);
+
+	hvcs_free_partner_info(&head);
+	return 0;
+}
+
+/*
+ * This function is executed by the driver "rescan" sysfs entry.  It shouldn't
+ * be executed elsewhere, in order to prevent deadlock issues.
+ */
+static int hvcs_rescan_devices_list(void)
+{
+	struct hvcs_struct *hvcsd = NULL;
+	unsigned long flags;
+	unsigned long structs_flags;
+
+	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
+
+	list_for_each_entry(hvcsd, &hvcs_structs, next) {
+		spin_lock_irqsave(&hvcsd->lock, flags);
+		hvcs_get_pi(hvcsd);
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+
+	return 0;
+}
+
+/*
+ * Farm this off into its own function because it could be more complex once
+ * multiple partners support is added. This function should be called with
+ * the hvcsd->lock held.
+ */
+static int hvcs_has_pi(struct hvcs_struct *hvcsd)
+{
+	if ((!hvcsd->p_unit_address) || (!hvcsd->p_partition_ID))
+		return 0;
+	return 1;
+}
+
+/*
+ * NOTE: It is possible that the super admin removed a partner vty and then
+ * added a different vty as the new partner.
+ *
+ * This function must be called with the hvcsd->lock held.
+ */
+static int hvcs_partner_connect(struct hvcs_struct *hvcsd)
+{
+	int retval;
+	unsigned int unit_address = hvcsd->vdev->unit_address;
+
+	/*
+	 * If there wasn't any pi when the device was added it doesn't meant
+	 * there isn't any now.  This driver isn't notified when a new partner
+	 * vty is added to a vty-server so we discover changes on our own.
+	 * Please see comments in hvcs_register_connection() for justification
+	 * of this bizarre code.
+	 */
+	retval = hvcs_register_connection(unit_address,
+			hvcsd->p_partition_ID,
+			hvcsd->p_unit_address);
+	if (!retval) {
+		hvcsd->connected = 1;
+		return 0;
+	} else if (retval != -EINVAL)
+		return retval;
+
+	/*
+	 * As per the spec re-get the pi and try again if -EINVAL after the
+	 * first connection attempt.
+	 */
+	if (hvcs_get_pi(hvcsd))
+		return -ENOMEM;
+
+	if (!hvcs_has_pi(hvcsd))
+		return -ENODEV;
+
+	retval = hvcs_register_connection(unit_address,
+			hvcsd->p_partition_ID,
+			hvcsd->p_unit_address);
+	if (retval != -EINVAL) {
+		hvcsd->connected = 1;
+		return retval;
+	}
+
+	/*
+	 * EBUSY is the most likely scenario though the vty could have been
+	 * removed or there really could be an hcall error due to the parameter
+	 * data but thanks to ambiguous firmware return codes we can't really
+	 * tell.
+	 */
+	printk(KERN_INFO "HVCS: vty-server or partner"
+			" vty is busy.  Try again later.\n");
+	return -EBUSY;
+}
+
+/* This function must be called with the hvcsd->lock held */
+static void hvcs_partner_free(struct hvcs_struct *hvcsd)
+{
+	int retval;
+	do {
+		retval = hvcs_free_connection(hvcsd->vdev->unit_address);
+	} while (retval == -EBUSY);
+	hvcsd->connected = 0;
+}
+
+/* This helper function must be called WITHOUT the hvcsd->lock held */
+static int hvcs_enable_device(struct hvcs_struct *hvcsd, uint32_t unit_address,
+		unsigned int irq, struct vio_dev *vdev)
+{
+	unsigned long flags;
+
+	/*
+	 * It is possible that the vty-server was removed between the time that
+	 * the conn was registered and now.
+	 */
+	if (!request_irq(irq, &hvcs_handle_interrupt,
+				SA_INTERRUPT, "ibmhvcs", hvcsd)) {
+		/*
+		 * It is possible the vty-server was removed after the irq was
+		 * requested but before we have time to enable interrupts.
+		 */
+		if (vio_enable_interrupts(vdev) == H_Success)
+			return 0;
+		else {
+			printk(KERN_ERR "HVCS: int enable failed for"
+					" vty-server@%X.\n", unit_address);
+			free_irq(irq, hvcsd);
+		}
+	} else
+		printk(KERN_ERR "HVCS: irq req failed for"
+				" vty-server@%X.\n", unit_address);
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	hvcs_partner_free(hvcsd);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+	return -ENODEV;
+
+}
+
+/*
+ * This always increments the kobject ref count if the call is successful.
+ * Please remember to dec when you are done with the instance.
+ *
+ * NOTICE: Do NOT hold either the hvcs_struct.lock or hvcs_structs_lock when
+ * calling this function or you will get deadlock.
+ */
+struct hvcs_struct *hvcs_get_by_index(int index)
+{
+	struct hvcs_struct *hvcsd = NULL;
+	struct list_head *element;
+	struct list_head *safe_temp;
+	unsigned long flags;
+	unsigned long structs_flags;
+
+	spin_lock_irqsave(&hvcs_structs_lock, structs_flags);
+	/* We can immediately discard OOB requests */
+	if (index >= 0 && index < HVCS_MAX_SERVER_ADAPTERS) {
+		list_for_each_safe(element, safe_temp, &hvcs_structs) {
+			hvcsd = list_entry(element, struct hvcs_struct, next);
+			spin_lock_irqsave(&hvcsd->lock, flags);
+			if (hvcsd->index == index) {
+				kobject_get(&hvcsd->kobj);
+				spin_unlock_irqrestore(&hvcsd->lock, flags);
+				spin_unlock_irqrestore(&hvcs_structs_lock,
+						structs_flags);
+				return hvcsd;
+			}
+			spin_unlock_irqrestore(&hvcsd->lock, flags);
+		}
+		hvcsd = NULL;
+	}
+
+	spin_unlock_irqrestore(&hvcs_structs_lock, structs_flags);
+	return hvcsd;
+}
+
+/*
+ * This is invoked via the tty_open interface when a user app connects to the
+ * /dev node.
+ */
+static int hvcs_open(struct tty_struct *tty, struct file *filp)
+{
+	struct hvcs_struct *hvcsd = NULL;
+	int retval = 0;
+	unsigned long flags;
+	unsigned int irq;
+	struct vio_dev *vdev;
+	unsigned long unit_address;
+
+	if (tty->driver_data)
+		goto fast_open;
+
+	/*
+	 * Is there a vty-server that shares the same index?
+	 * This function increments the kobject index.
+	 */
+	if (!(hvcsd = hvcs_get_by_index(tty->index))) {
+		printk(KERN_WARNING "HVCS: open failed, no index.\n");
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	if (hvcsd->connected == 0)
+		if ((retval = hvcs_partner_connect(hvcsd)))
+			goto error_release;
+
+	hvcsd->open_count = 1;
+	hvcsd->tty = tty;
+	tty->driver_data = hvcsd;
+
+	/*
+	 * Set this driver to low latency so that we actually have a chance at
+	 * catching a throttled TTY after we flip_buffer_push.  Otherwise the
+	 * flush_to_async may not execute until after the kernel_thread has
+	 * yielded and resumed the next flip_buffer_push resulting in data
+	 * loss.
+	 */
+	tty->low_latency = 1;
+
+	memset(&hvcsd->buffer[0], 0x3F, HVCS_BUFF_LEN);
+
+	/*
+	 * Save these in the spinlock for the enable operations that need them
+	 * outside of the spinlock.
+	 */
+	irq = hvcsd->vdev->irq;
+	vdev = hvcsd->vdev;
+	unit_address = hvcsd->vdev->unit_address;
+
+	hvcsd->todo_mask |= HVCS_SCHED_READ;
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+	/*
+	 * This must be done outside of the spinlock because it requests irqs
+	 * and will grab the spinlcok and free the connection if it fails.
+	 */
+	if ((hvcs_enable_device(hvcsd, unit_address, irq, vdev))) {
+		kobject_put(&hvcsd->kobj);
+		printk(KERN_WARNING "HVCS: enable device failed.\n");
+		return -ENODEV;
+	}
+
+	goto open_success;
+
+fast_open:
+	hvcsd = tty->driver_data;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	if (!kobject_get(&hvcsd->kobj)) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		printk(KERN_ERR "HVCS: Kobject of open"
+			" hvcs doesn't exist.\n");
+		return -EFAULT; /* Is this the right return value? */
+	}
+
+	hvcsd->open_count++;
+
+	hvcsd->todo_mask |= HVCS_SCHED_READ;
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+open_success:
+	hvcs_kick();
+
+	printk(KERN_INFO "HVCS: vty-server@%X opened.\n",
+		hvcsd->vdev->unit_address );
+
+	return 0;
+
+error_release:
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	kobject_put(&hvcsd->kobj);
+
+	printk(KERN_WARNING "HVCS: HVCS partner connect failed.\n");
+	return retval;
+}
+
+static void hvcs_close(struct tty_struct *tty, struct file *filp)
+{
+	struct hvcs_struct *hvcsd;
+	unsigned long flags;
+	struct kobject *kobjp;
+
+	/*
+	 * Is someone trying to close the file associated with this device after
+	 * we have hung up?  If so tty->driver_data wouldn't be valid.
+	 */
+	if (tty_hung_up_p(filp))
+		return;
+
+	/*
+	 * No driver_data means that this close was probably issued after a
+	 * failed hvcs_open by the tty layer's release_dev() api and we can just
+	 * exit cleanly.
+	 */
+	if (!tty->driver_data)
+		return;
+
+	hvcsd = tty->driver_data;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	if (--hvcsd->open_count == 0) {
+
+		/*
+		 * This line is important because it tells hvcs_open that this
+		 * device needs to be re-configured the next time hvcs_open is
+		 * called.
+		 */
+		hvcsd->tty->driver_data = NULL;
+
+		/*
+		 * NULL this early so that the kernel_thread doesn't try to
+		 * execute any operations on the TTY even though it is obligated
+		 * to deliver any pending I/O to the hypervisor.
+		 */
+		hvcsd->tty = NULL;
+
+		/*
+		 * Block the close until all the buffered data has been
+		 * delivered.
+		 */
+		while(hvcsd->chars_in_buffer) {
+			spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+			/*
+			 * Give the kernel thread the hvcs_struct so that it can
+			 * try to deliver the remaining data but block the close
+			 * operation by spinning in this function so that other
+			 * tty operations have to wait.
+			 */
+			yield();
+			spin_lock_irqsave(&hvcsd->lock, flags);
+		}
+
+		hvcs_final_close(hvcsd);
+
+	} else if (hvcsd->open_count < 0) {
+		printk(KERN_ERR "HVCS: vty-server@%X open_count: %d"
+				" is missmanaged.\n",
+			hvcsd->vdev->unit_address, hvcsd->open_count);
+	}
+	kobjp = &hvcsd->kobj;
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+	kobject_put(kobjp);
+}
+
+static void hvcs_hangup(struct tty_struct * tty)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+	unsigned long flags;
+	int temp_open_count;
+	struct kobject *kobjp;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	/* Preserve this so that we know how many kobject refs to put */
+	temp_open_count = hvcsd->open_count;
+
+	/*
+	 * Don't kobject put inside the spinlock because the destruction
+	 * callback may use the spinlock and it may get called before the
+	 * spinlock has been released.  Get a pointer to the kobject and
+	 * kobject_put on that instead.
+	 */
+	kobjp = &hvcsd->kobj;
+
+	/* Calling this will drop any buffered data on the floor. */
+	hvcs_final_close(hvcsd);
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+
+	/*
+	 * We need to kobject_put() for every open_count we have since the
+	 * tty_hangup() function doesn't invoke a close per open connection on a
+	 * non-console device.
+	 */
+	while(temp_open_count) {
+		--temp_open_count;
+		/*
+		 * The final put will trigger destruction of the hvcs_struct.
+		 * NOTE:  If this hangup was signaled from user space then the
+		 * final put will never happen.
+		 */
+		kobject_put(kobjp);
+	}
+}
+
+/*
+ * NOTE: This is almost always from_user since user level apps interact with the
+ * /dev nodes. I'm trusting that if hvcs_write gets called and interrupted by
+ * hvcs_remove (which removes the target device and executes tty_hangup()) that
+ * tty_hangup will allow hvcs_write time to complete execution before it
+ * terminates our device.
+ */
+static int hvcs_write(struct tty_struct *tty, int from_user,
+		const unsigned char *buf, int count)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+	unsigned int unit_address;
+	unsigned char *charbuf;
+	unsigned long flags;
+	int total_sent = 0;
+	int tosend = 0;
+	int result = 0;
+
+	/*
+	 * If they don't check the return code off of their open they may
+	 * attempt this even if there is no connected device.
+	 */
+	if (!hvcsd)
+		return -ENODEV;
+
+	/* Reasonable size to prevent user level flooding */
+	if (count > HVCS_MAX_FROM_USER) {
+		printk(KERN_WARNING "HVCS write: count being truncated to"
+				" HVCS_MAX_FROM_USER.\n");
+		count = HVCS_MAX_FROM_USER;
+	}
+
+	if (!from_user)
+		charbuf = (unsigned char *)buf;
+	else {
+		charbuf = kmalloc(count, GFP_KERNEL);
+		if (!charbuf) {
+			printk(KERN_WARNING "HVCS: write -ENOMEM.\n");
+			return -ENOMEM;
+		}
+
+		if (copy_from_user(charbuf, buf, count)) {
+			kfree(charbuf);
+			printk(KERN_WARNING "HVCS: write -EFAULT.\n");
+			return -EFAULT;
+		}
+	}
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	/*
+	 * Somehow an open succedded but the device was removed or the
+	 * connection terminated between the vty-server and partner vty during
+	 * the middle of a write operation?  This is a crummy place to do this
+	 * but we want to keep it all in the spinlock.
+	 */
+	if (hvcsd->open_count <= 0) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		if (from_user)
+			kfree(charbuf);
+		return -ENODEV;
+	}
+
+	unit_address = hvcsd->vdev->unit_address;
+
+	while (count > 0) {
+		tosend = min(count, (HVCS_BUFF_LEN - hvcsd->chars_in_buffer));
+		/*
+		 * No more space, this probably means that the last call to
+		 * hvcs_write() didn't succeed and the buffer was filled up.
+		 */
+		if (!tosend)
+			break;
+
+		memcpy(&hvcsd->buffer[hvcsd->chars_in_buffer],
+				&charbuf[total_sent],
+				tosend);
+
+		hvcsd->chars_in_buffer += tosend;
+
+		result = 0;
+
+		/*
+		 * If this is true then we don't want to try writing to the
+		 * hypervisor because that is the kernel_threads job now.  We'll
+		 * just add to the buffer.
+		 */
+		if (!(hvcsd->todo_mask & HVCS_TRY_WRITE))
+			/* won't send partial writes */
+			result = hvc_put_chars(unit_address,
+					&hvcsd->buffer[0],
+					hvcsd->chars_in_buffer);
+
+		/*
+		 * Since we know we have enough room in hvcsd->buffer for
+		 * tosend we record that it was sent regardless of whether the
+		 * hypervisor actually took it because we have it buffered.
+		 */
+		total_sent+=tosend;
+		count-=tosend;
+		if (result == 0) {
+			hvcsd->todo_mask |= HVCS_TRY_WRITE;
+			hvcs_kick();
+			break;
+		}
+
+		hvcsd->chars_in_buffer = 0;
+		/*
+		 * Test after the chars_in_buffer reset otherwise this could
+		 * deadlock our writes if hvc_put_chars fails.
+		 */
+		if (result < 0)
+			break;
+	}
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	if (from_user)
+		kfree(charbuf);
+
+	if (result == -1)
+		return -EIO;
+	else
+		return total_sent;
+}
+
+/*
+ * This is really asking how much can we guarentee that we can send or that we
+ * absolutely WILL BUFFER if we can't send it.  This driver MUST honor the
+ * return value, hence the reason for hvcs_struct buffering.
+ */
+static int hvcs_write_room(struct tty_struct *tty)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+	unsigned long flags;
+	int retval;
+
+	if (!hvcsd || hvcsd->open_count <= 0)
+		return 0;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = HVCS_BUFF_LEN - hvcsd->chars_in_buffer;
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static int hvcs_chars_in_buffer(struct tty_struct *tty)
+{
+	struct hvcs_struct *hvcsd = tty->driver_data;
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = hvcsd->chars_in_buffer;
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static struct tty_operations hvcs_ops = {
+	.open = hvcs_open,
+	.close = hvcs_close,
+	.hangup = hvcs_hangup,
+	.write = hvcs_write,
+	.write_room = hvcs_write_room,
+	.chars_in_buffer = hvcs_chars_in_buffer,
+	.unthrottle = hvcs_unthrottle,
+	.throttle = hvcs_throttle,
+};
+
+static int __init hvcs_module_init(void)
+{
+	int rc;
+	int num_ttys_to_alloc;
+
+	printk(KERN_INFO "Initializing %s\n", hvcs_driver_string);
+
+	/* Has the user specified an overload with an insmod param? */
+	if (hvcs_parm_num_devs <= 0 ||
+		(hvcs_parm_num_devs > HVCS_MAX_SERVER_ADAPTERS)) {
+		num_ttys_to_alloc = HVCS_DEFAULT_SERVER_ADAPTERS;
+	} else
+		num_ttys_to_alloc = hvcs_parm_num_devs;
+
+	hvcs_tty_driver = alloc_tty_driver(num_ttys_to_alloc);
+	if (!hvcs_tty_driver)
+		return -ENOMEM;
+
+	hvcs_tty_driver->owner = THIS_MODULE;
+
+	hvcs_tty_driver->driver_name = hvcs_driver_name;
+	hvcs_tty_driver->name = hvcs_device_node;
+
+	/*
+	 * We'll let the system assign us a major number, indicated by leaving
+	 * it blank.
+	 */
+
+	hvcs_tty_driver->minor_start = HVCS_MINOR_START;
+	hvcs_tty_driver->type = TTY_DRIVER_TYPE_SYSTEM;
+
+	/*
+	 * We role our own so that we DONT ECHO.  We can't echo because the
+	 * device we are connecting to already echoes by default and this would
+	 * throw us into a horrible recursive echo-echo-echo loop.
+	 */
+	hvcs_tty_driver->init_termios = hvcs_tty_termios;
+	hvcs_tty_driver->flags = TTY_DRIVER_REAL_RAW;
+
+	tty_set_operations(hvcs_tty_driver, &hvcs_ops);
+
+	/*
+	 * The following call will result in sysfs entries that denote the
+	 * dynamically assigned major and minor numbers for our devices.
+	 */
+	if (tty_register_driver(hvcs_tty_driver)) {
+		printk(KERN_ERR "HVCS: registration "
+			" as a tty driver failed.\n");
+		put_tty_driver(hvcs_tty_driver);
+		return rc;
+	}
+
+	hvcs_structs_lock = SPIN_LOCK_UNLOCKED;
+
+	hvcs_pi_lock = SPIN_LOCK_UNLOCKED;
+	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
+	if (IS_ERR(hvcs_task)) {
+		printk("khvcsd creation failed.  Driver not loaded.\n");
+		kfree(hvcs_pi_buff);
+		put_tty_driver(hvcs_tty_driver);
+		return -EIO;
+	}
+
+	rc = vio_register_driver(&hvcs_vio_driver);
+
+	/*
+	 * This needs to be done AFTER the vio_register_driver() call or else
+	 * the kobjects won't be initialized properly.
+	 */
+	hvcs_create_driver_attrs();
+
+	printk(KERN_INFO "HVCS: driver module inserted.\n");
+
+	return rc;
+}
+
+static void __exit hvcs_module_exit(void)
+{
+	unsigned long flags;
+
+	/*
+	 * This driver receives hvcs_remove callbacks for each device upon
+	 * module removal.
+	 */
+
+	/*
+	 * This synchronous operation  will wake the khvcsd kthread if it is
+	 * asleep and will return when khvcsd has terminated.
+	 */
+	kthread_stop(hvcs_task);
+
+	spin_lock_irqsave(&hvcs_pi_lock, flags);
+	kfree(hvcs_pi_buff);
+	hvcs_pi_buff = NULL;
+	spin_unlock_irqrestore(&hvcs_pi_lock, flags);
+
+	hvcs_remove_driver_attrs();
+
+	vio_unregister_driver(&hvcs_vio_driver);
+
+	tty_unregister_driver(hvcs_tty_driver);
+
+	put_tty_driver(hvcs_tty_driver);
+
+	printk(KERN_INFO "HVCS: driver module removed.\n");
+}
+
+module_init(hvcs_module_init);
+module_exit(hvcs_module_exit);
+
+static inline struct hvcs_struct *from_vio_dev(struct vio_dev *viod)
+{
+	return viod->dev.driver_data;
+}
+/* The sysfs interface for the driver and devices */
+
+static ssize_t hvcs_partner_vtys_show(struct device *dev, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%X\n", hvcsd->p_unit_address);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(partner_vtys, S_IRUGO, hvcs_partner_vtys_show, NULL);
+
+static ssize_t hvcs_partner_clcs_show(struct device *dev, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(partner_clcs, S_IRUGO, hvcs_partner_clcs_show, NULL);
+
+static ssize_t hvcs_current_vty_store(struct device *dev, const char * buf,
+		size_t count)
+{
+	/*
+	 * Don't need this feature at the present time because firmware doesn't
+	 * yet support multiple partners.
+	 */
+	printk(KERN_INFO "HVCS: Denied current_vty change: -EPERM.\n");
+	return -EPERM;
+}
+
+static ssize_t hvcs_current_vty_show(struct device *dev, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static DEVICE_ATTR(current_vty,
+	S_IRUGO | S_IWUSR, hvcs_current_vty_show, hvcs_current_vty_store);
+
+static ssize_t hvcs_vterm_state_store(struct device *dev, const char *buf,
+		size_t count)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+
+	/* writing a '0' to this sysfs entry will result in the disconnect. */
+	if (simple_strtol(buf, NULL, 0) != 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	if (hvcsd->open_count > 0) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		printk(KERN_INFO "HVCS: vterm state unchanged.  "
+				"The hvcs device node is still in use.\n");
+		return -EPERM;
+	}
+
+	if (hvcsd->connected == 0) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		printk(KERN_INFO "HVCS: vterm state unchanged. The"
+				" vty-server is not connected to a vty.\n");
+		return -EPERM;
+	}
+
+	hvcs_partner_free(hvcsd);
+	printk(KERN_INFO "HVCS: Closed vty-server@%X and"
+			" partner vty@%X:%d connection.\n",
+			hvcsd->vdev->unit_address,
+			hvcsd->p_unit_address,
+			(unsigned int)hvcsd->p_partition_ID);
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return count;
+}
+
+static ssize_t hvcs_vterm_state_show(struct device *dev, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%d\n", hvcsd->connected);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(vterm_state, S_IRUGO | S_IWUSR,
+		hvcs_vterm_state_show, hvcs_vterm_state_store);
+
+static struct attribute *hvcs_attrs[] = {
+	&dev_attr_partner_vtys.attr,
+	&dev_attr_partner_clcs.attr,
+	&dev_attr_current_vty.attr,
+	&dev_attr_vterm_state.attr,
+	NULL,
+};
+
+static struct attribute_group hvcs_attr_group = {
+	.attrs = hvcs_attrs,
+};
+
+static void hvcs_create_device_attrs(struct hvcs_struct *hvcsd)
+{
+	struct vio_dev *vdev = hvcsd->vdev;
+	sysfs_create_group(&vdev->dev.kobj, &hvcs_attr_group);
+}
+
+static void hvcs_remove_device_attrs(struct vio_dev *vdev)
+{
+	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
+}
+
+static ssize_t hvcs_rescan_show(struct device_driver *ddp, char *buf)
+{
+	/* A 1 means it is updating, a 0 means it is done updating */
+	return snprintf(buf, PAGE_SIZE, "%d\n", hvcs_rescan_status);
+}
+
+static ssize_t hvcs_rescan_store(struct device_driver *ddp, const char * buf,
+		size_t count)
+{
+	if ((simple_strtol(buf, NULL, 0) != 1)
+		&& (hvcs_rescan_status != 0))
+		return -EINVAL;
+
+	hvcs_rescan_status = 1;
+	printk(KERN_INFO "HVCS: rescanning partner info for all"
+		" vty-servers.\n");
+	hvcs_rescan_devices_list();
+	hvcs_rescan_status = 0;
+	return count;
+}
+static DRIVER_ATTR(rescan,
+	S_IRUGO | S_IWUSR, hvcs_rescan_show, hvcs_rescan_store);
+
+static void hvcs_create_driver_attrs(void)
+{
+	struct device_driver *driverfs = &(hvcs_vio_driver.driver);
+	driver_create_file(driverfs, &driver_attr_rescan);
+}
+
+static void hvcs_remove_driver_attrs(void)
+{
+	struct device_driver *driverfs = &(hvcs_vio_driver.driver);
+	driver_remove_file(driverfs, &driver_attr_rescan);
+}
diff -uNr linux-2.6.8-rc2/Documentation/powerpc/hvcs.txt hvcs_working-linux-2.6.8-rc2/Documentation/powerpc/hvcs.txt
--- linux-2.6.8-rc2/Documentation/powerpc/hvcs.txt	Wed Dec 31 18:00:00 1969
+++ hvcs_working-linux-2.6.8-rc2/Documentation/powerpc/hvcs.txt	Wed Jul 28 12:37:45 2004
@@ -0,0 +1,534 @@
+===========================================================================
+				   HVCS
+	IBM "Hypervisor Virtual Console Server" Installation Guide
+			  for Linux Kernel 2.6.4+
+		    Copyright (C) 2004 IBM Corporation
+
+===========================================================================
+NOTE:Eight space tabs are the optimum editor setting for reading this file.
+===========================================================================
+
+	       Author(s) :  Ryan S. Arnold <rsa@us.ibm.com>
+		       Date Created: March, 02, 2004
+		       Last Changed: July, 07, 2004
+
+---------------------------------------------------------------------------
+Table of contents:
+
+	1.  Driver Introduction:
+	2.  System Requirements
+	3.  Build Options:
+		3.1  Built-in:
+		3.2  Module:
+	4.  Installation:
+	5.  Connection:
+	6.  Disconnection:
+	7.  Configuration:
+	8.  Questions & Answers:
+	9.  Reporting Bugs:
+
+---------------------------------------------------------------------------
+1. Driver Introduction:
+
+This is the device driver for the IBM Hypervisor Virtual Console Server,
+"hvcs".  The IBM hvcs provides a tty driver interface to allow Linux user
+space applications access to the system consoles of logically partitioned
+operating systems (Linux and AIX) running on the same partitioned Power5
+ppc64 system.  Physical hardware consoles per partition are not practical
+on this hardware so system consoles are accessed by this driver using
+firmware interfaces to virtual terminal devices.
+
+---------------------------------------------------------------------------
+2. System Requirements:
+
+This device driver was written using 2.6.4 Linux kernel APIs and will only
+build and run on kernels of this version or later.
+
+This driver was written to operate solely on IBM Power5 ppc64 hardware
+though some care was taken to abstract the architecture dependent firmware
+calls from the driver code.
+
+Sysfs must be mounted on the system so that the user can determine which
+major and minor numbers are associated with each vty-server.  Directions
+for sysfs mounting are outside the scope of this document.
+
+---------------------------------------------------------------------------
+3. Build Options:
+
+The hvcs driver registers itself as a tty driver.  The tty layer
+dynamically allocates a block of major and minor numbers in a quantity
+requested by the registering driver.  The hvcs driver asks the tty layer
+for 64 of these major/minor numbers by default to use for hvcs device node
+entries.
+
+If the default number of device entries is adequate then this driver can be
+built into the kernel.  If not, the default can be over-ridden by inserting
+the driver as a module with insmod parameters.
+
+---------------------------------------------------------------------------
+3.1 Built-in:
+
+The following menuconfig example demonstrates selecting to build this
+driver into the kernel.
+
+	Device Drivers  --->
+		Character devices  --->
+			<*> IBM Hypervisor Virtual Console Server Support
+
+Begin the kernel make process.
+
+---------------------------------------------------------------------------
+3.2 Module:
+
+The following menuconfig example demonstrates selecting to build this
+driver as a kernel module.
+
+	Device Drivers  --->
+		Character devices  --->
+			<M> IBM Hypervisor Virtual Console Server Support
+
+The make process will build the following kernel modules:
+
+	hvcs.ko
+	hvcserver.ko
+
+To insert the module with the default allocation execute the following
+commands in the order they appear:
+
+	insmod hvcserver.ko
+	insmod hvcs.ko
+
+The hvcserver module contains architecture specific firmware calls and must
+be inserted first, otherwise the hvcs module will not find some of the
+symbols it expects.
+
+To override the default use an insmod parameter as follows (requesting 4
+tty devices as an example):
+
+	insmod hvcs.ko hvcs_parm_num_devs=4
+
+There is a maximum number of dev entries that can be specified on insmod.
+We think that 1024 is currently a decent maximum number of server adapters
+to allow.  This can always be changed by modifying the constant in the
+source file before building.
+
+NOTE: The length of time it takes to insmod the driver seems to be related
+to the number of tty interfaces the registering driver requests.
+
+In order to remove the driver module execute the following command:
+
+	rmmod hvcs.ko
+
+The recommended method for installing hvcs as a module is to use depmod to
+build a current modules.dep file in /lib/modules/`uname -r` and then
+execute:
+
+modprobe hvcs hvcs_parm_num_devs=4
+
+The modules.dep file indicates that hvcserver.ko needs to be inserted
+before hvcs.ko and modprobe uses this file to smartly insert the modules in
+the proper order.
+
+The following modprobe command is used to remove hvcs and hvcserver in the
+proper order:
+
+modprobe -r hvcs
+
+---------------------------------------------------------------------------
+4. Installation:
+
+The tty layer creates sysfs entries which contain the major and minor
+numbers allocated for the hvcs driver.  The following snippet of "tree"
+output of the sysfs directory shows where these numbers are presented:
+
+	sys/
+	|-- *other sysfs base dirs*
+	|
+	|-- class
+	|   |-- *other classes of devices*
+	|   |
+	|   `-- tty
+	|       |-- *other tty devices*
+	|       |
+	|       |-- hvcs0
+	|       |   `-- dev
+	|       |-- hvcs1
+	|       |   `-- dev
+	|       |-- hvcs2
+	|       |   `-- dev
+	|       |-- hvcs3
+	|       |   `-- dev
+	|       |
+	|       |-- *other tty devices*
+	|
+	|-- *other sysfs base dirs*
+
+For the above examples the following output is a result of cat'ing the
+"dev" entry in the hvcs directory:
+
+	Pow5:/sys/class/tty/hvcs0/ # cat dev
+	254:0
+
+	Pow5:/sys/class/tty/hvcs1/ # cat dev
+	254:1
+
+	Pow5:/sys/class/tty/hvcs2/ # cat dev
+	254:2
+
+	Pow5:/sys/class/tty/hvcs3/ # cat dev
+	254:3
+
+The output from reading the "dev" attribute is the char device major and
+minor numbers that the tty layer has allocated for this driver's use.  Most
+systems running hvcs will already have the device entries created or udev
+will do it automatically.
+
+Given the example output above, to manually create a /dev/hvcs* node entry
+mknod can be used as follows:
+
+	mknod /dev/hvcs0 c 254 0
+	mknod /dev/hvcs1 c 254 1
+	mknod /dev/hvcs2 c 254 2
+	mknod /dev/hvcs3 c 254 3
+
+Using mknod to manually create the device entries makes these device nodes
+persistent.  Once created they will exist prior to the driver insmod.
+
+Attempting to connect an application to /dev/hvcs* prior to insertion of
+the hvcs module will result in an error message similar to the following:
+
+	"/dev/hvcs*: No such device".
+
+NOTE: Just because there is a device node present doesn't mean that there
+is a vty-server device configured for that node.
+
+---------------------------------------------------------------------------
+5. Connection
+
+Since this driver controls devices that provide a tty interface a user can
+interact with the device node entries using any standard tty-interactive
+method (e.g. "cat", "dd", "echo").  The intent of this driver however, is
+to provide real time console interaction with a Linux partition's console,
+which requires the use of applications that provide bi-directional,
+interactive I/O with a tty device.
+
+Applications (e.g. "minicom" and "screen") that act as terminal emulators
+or perform terminal type control sequence conversion on the data being
+passed through them are NOT acceptable for providing interactive console
+I/O.  These programs often emulate antiquated terminal types (vt100 and
+ANSI) and expect inbound data to take the form of one of these supported
+terminal types but they either do not convert, or do not _adequately_
+convert, outbound data into the terminal type of the terminal which invoked
+them (though screen makes an attempt and can apparently be configured with
+much termcap wrestling.)
+
+For this reason kermit and cu are two of the recommended applications for
+interacting with a Linux console via an hvcs device.  These programs simply
+act as a conduit for data transfer to and from the tty device.  They do not
+require inbound data to take the form of a particular terminal type, nor do
+they cook outbound data to a particular terminal type.
+
+In order to ensure proper functioning of console applications one must make
+sure that once connected to a /dev/hvcs console that the console's $TERM
+env variable is set to the exact terminal type of the terminal emulator
+used to launch the interactive I/O application.  If one is using xterm and
+kermit to connect to /dev/hvcs0 when the console prompt becomes available
+one should "export TERM=xterm" on the console.  This tells ncurses
+applications that are invoked from the console that they should output
+control sequences that xterm can understand.
+
+As a precautionary measure an hvcs user should always "exit" from their
+session before disconnecting an application such as kermit from the device
+node.  If this is not done, the next user to connect to the console will
+continue using the previous user's logged in session which includes
+using the $TERM variable that the previous user supplied.
+
+---------------------------------------------------------------------------
+6. Disconnection
+
+As a security feature to prevent the delivery of stale data to an
+unintended target the Power5 system firmware disables the fetching of data
+and discards that data when a connection between a vty-server and a vty has
+been severed.  As an example, when a vty-server is immediately disconnected
+from a vty following output of data to the vty the vty adapter may not have
+enough time between when it received the data interrupt and when the
+connection was severed to fetch the data from firmware before the fetch is
+disabled by firmware.
+
+When hvcs is being used to serve consoles this behavior is not a huge issue
+because the adapter stays connected for large amounts of time following
+almost all data writes.  When hvcs is being used as a tty conduit to tunnel
+data between two partitions [see Q & A below] this is a huge problem
+because the standard Linux behavior when cat'ing or dd'ing data to a device
+is to open the tty, send the data, and then close the tty.  If this driver
+manually terminated vty-server connections on tty close this would close
+the vty-server and vty connection before the target vty has had a chance to
+fetch the data.
+
+Additionally, disconnecting a vty-server and vty only on module removal or
+adapter removal is impractical because other vty-servers in other
+partitions may require the usage of the target vty at any time.
+
+Due to this behavioral restriction disconnection of vty-servers from the
+connected vty is a manual procedure using a write to a sysfs attribute
+outlined below, on the other hand the initial vty-server connection to a
+vty is established automatically by this driver.  Manual vty-server
+connection is never required.
+
+In order to terminate the connection between a vty-server and vty the
+"vterm_state" sysfs attribute within each vty-server's sysfs entry is used.
+Reading this attribute reveals the current connection state of the
+vty-server adapter.  A zero means that the vty-server is not connected to a
+vty.  A one indicates that a connection is active.
+
+Writing a '0' (zero) to the vterm_state attribute will disconnect the VTERM
+connection between the vty-server and target vty ONLY if the vterm_state
+previously read '1'.  The write directive is ignored if the vterm_state
+read '0' or if any value other than '0' was written to the vterm_state
+attribute.  The following example will show the method used for verifying
+the vty-server connection status and disconnecting a vty-server connection.
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # cat vterm_state
+	1
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # echo 0 > vterm_state
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # cat vterm_state
+	0
+
+All vty-server connections are automatically terminated when the device is
+hotplug removed and when the module is removed.
+
+---------------------------------------------------------------------------
+7. Configuration
+
+Each vty-server has a sysfs entry in the /sys/devices/vio directory, which
+is symlinked in several other sysfs tree directories, notably under the
+hvcs driver entry, which looks like the following example:
+
+	Pow5:/sys/bus/vio/drivers/hvcs # ls
+	.  ..  30000003  30000004  rescan
+
+By design, firmware notifies the hvcs driver of vty-server lifetimes and
+partner vty removals but not the addition of partner vtys.  Since an HMC
+Super Admin can add partner info dynamically we have provided the hvcs
+driver sysfs directory with the "rescan" update attribute which will query
+firmware and update the partner info for all the vty-servers that this
+driver manages.  Writing a '1' to the attribute triggers the update.  An
+explicit example follows:
+
+	Pow5:/sys/bus/vio/drivers/hvcs # echo 1 > rescan
+
+Reading the attribute will indicate a state of '1' or '0'.  A one indicates
+that an update is in process.  A zero indicates that an update has
+completed or was never executed.
+
+Vty-server entries in this directory are a 32 bit partition unique unit
+address that is created by firmware.  An example vty-server sysfs entry
+looks like the following:
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # ls
+	.   current_vty   devspec  partner_clcs  vterm_state
+	..  detach_state  name     partner_vtys
+
+Each entry is provided, by default with a "name" attribute.  Reading the
+"name" attribute will reveal the device type as shown in the following
+example:
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000003 # cat name
+	vty-server
+
+Each entry is also provided, by default, with a "devspec" attribute which
+reveals the full device specification when read, as shown in the following
+example:
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # cat devspec
+	/vdevice/vty-server@30000004
+
+Each vty-server sysfs dir is provided with two read-only attributes that
+provide lists of easily parsed partner vty data: "partner_vtys" and
+"partner_clcs".
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # cat partner_vtys
+	30000000
+	30000001
+	30000002
+	30000000
+	30000000
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # cat partner_clcs
+	U5112.428.103048A-V3-C0
+	U5112.428.103048A-V3-C2
+	U5112.428.103048A-V3-C3
+	U5112.428.103048A-V4-C0
+	U5112.428.103048A-V5-C0
+
+Reading partner_vtys returns a list of partner vtys.  Vty unit address
+numbering is only per-partition-unique so entries will frequently repeat.
+
+Reading partner_clcs returns a list of "converged location codes" which are
+composed of a system serial number followed by "-V*", where the '*' is the
+target partition number, and "-C*", where the '*' is the slot of the
+adapter.  The first vty partner corresponds to the first clc item, the
+second vty partner to the second clc item, etc.
+
+A vty-server can only be connected to a single vty at a time.  The entry,
+"current_vty" prints the clc of the currently selected partner vty when
+read.
+
+The current_vty can be changed by writing a valid partner clc to the entry
+as in the following example:
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # echo U5112.428.10304
+	8A-V4-C0 > current_vty
+
+Changing the current_vty when a vty-server is already connected to a vty
+does not affect the current connection.  The change takes effect when the
+currently open connection is freed.
+
+Information on the "vterm_state" attribute was covered earlier on the
+chapter entitled "disconnection".
+
+---------------------------------------------------------------------------
+8. Questions & Answers:
+===========================================================================
+Q: What are the security concerns involving hvcs?
+
+A: There are three main security concerns:
+
+	1. The creator of the /dev/hvcs* nodes has the ability to restrict
+	the access of the device entries to certain users or groups.  It
+	may be best to create a special hvcs group privilege for providing
+	access to system consoles.
+
+	2. To provide network security when grabbing the console it is
+	suggested that the user connect to the console hosting partition
+	using a secure method, such as SSH or sit at a hardware console.
+
+	3. Make sure to exit the user session when done with a console or
+	the next vty-server connection (which may be from another
+	partition) will experience the previously logged in session.
+
+---------------------------------------------------------------------------
+Q: How do I multiplex a console that I grab through hvcs so that other
+people can see it:
+
+A: You can use "screen" to directly connect to the /dev/hvcs* device and
+setup a session on your machine with the console group privileges.  As
+pointed out earlier by default screen doesn't provide the termcap settings
+for most terminal emulators to provide adequate character conversion from
+term type "screen" to others.  This means that curses based programs may
+not display properly in screen sessions.
+
+---------------------------------------------------------------------------
+Q: Why are the colors all messed up?
+Q: Why are the control characters acting strange or not working?
+Q: Why is the console output all strange and unintelligible?
+
+A: Please see the preceding section on "Connection" for a discussion of how
+applications can affect the display of character control sequences.
+Additionally, just because you logged into the console using and xterm
+doesn't mean someone else didn't log into the console with the HMC console
+(vt320) before you and leave the session logged in.  The best thing to do
+is to export TERM to the terminal type of your terminal emulator when you
+get the console.  Additionally make sure to "exit" the console before you
+disconnect from the console.  This will ensure that the next user gets
+their own TERM type set when they login.
+
+---------------------------------------------------------------------------
+Q: When I try to CONNECT kermit to an hvcs device I get:
+"Sorry, can't open connection: /dev/hvcs*"What is happening?
+
+A: Some other Power5 console mechanism has a connection to the vty and
+isn't giving it up.  You can try to force disconnect the consoles from the
+HMC by right clicking on the partition and then selecting "close terminal".
+Otherwise you have to hunt down the people who have console authority.  It
+is possible that you already have the console open using another kermit
+session and just forgot about it.  Please review the console options for
+Power5 systems to determine the many ways a system console can be held.
+
+OR
+
+A: Another user may not have a connectivity method currently attached to a
+/dev/hvcs device but the vterm_state may reveal that they still have the
+vty-server connection established.  They need to free this using the method
+outlined in the section on "Disconnection" in order for others to connect
+to the target vty.
+
+OR
+
+A: The user profile you are using to execute kermit probably doesn't have
+permissions to use the /dev/hvcs* device.
+
+OR
+
+A: You probably haven't inserted the hvcs.ko module yet but the /dev/hvcs*
+entry still exists (on systems without udev).
+
+OR
+
+A: There is not a corresponding vty-server device that maps to an existing
+/dev/hvcs* entry.
+
+---------------------------------------------------------------------------
+Q: When I try to CONNECT kermit to an hvcs device I get:
+"Sorry, write access to UUCP lockfile directory denied."
+
+A: The /dev/hvcs* entry you have specified doesn't exist where you said it
+does?  Maybe you haven't inserted the module (on systems with udev).
+
+---------------------------------------------------------------------------
+Q: If I already have one Linux partition installed can I use hvcs on said
+partition to provide the console for the install of a second Linux
+partition?
+
+A: Yes granted that your are connected to the /dev/hvcs* device using
+kermit or cu or some other program that doesn't provide terminal emulation.
+
+---------------------------------------------------------------------------
+Q: Can I connect to more than one partition's console at a time using this
+driver?
+
+A: Yes.  Of course this means that there must be more than one vty-server
+configured for this partition and each must point to a disconnected vty.
+
+---------------------------------------------------------------------------
+Q: Does the hvcs driver support dynamic (hotplug) addition of devices?
+
+A: Yes, if you have dlpar and hotplug enabled for your system and it has
+been built into the kernel the hvcs drivers is configured to dynamically
+handle additions of new devices and removals of unused devices.
+
+---------------------------------------------------------------------------
+Q: Can I use /dev/hvcs* as a conduit to another partition and use a tty
+device on that partition as the other end of the pipe?
+
+A: Yes, on Power5 platforms the hvc_console driver provides a tty interface
+for extra /dev/hvc* devices (where /dev/hvc0 is most likely the console).
+In order to get a tty conduit working between the two partitions the HMC
+Super Admin must create an additional "serial server" for the target
+partition with the HMC gui which will show up as /dev/hvc* when the target
+partition is rebooted.
+
+The HMC Super Admin then creates an additional "serial client" for the
+current partition and points this at the target partition's newly created
+"serial server" adapter (remember the slot).  This shows up as an
+additional /dev/hvcs* device.
+
+Now a program on the target system can be configured to read or write to
+/dev/hvc* and another program on the current partition can be configured to
+read or write to /dev/hvcs*.  Now you have a tty conduit between two
+partitions.
+
+---------------------------------------------------------------------------
+9. Reporting Bugs:
+
+The proper channel for reporting bugs is either through the Linux OS
+distribution company that provided your OS or by posting issues to the
+ppc64 development mailing list at:
+
+linuxppc64-dev@lists.linuxppc.org
+
+This request is to provide a documented and searchable public exchange
+of the problems and solutions surrounding this driver for the benefit of
+all users.

--=-iVKXtnpHlaL1Hde2pIuv--

