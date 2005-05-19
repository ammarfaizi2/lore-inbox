Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVESXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVESXng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVESXm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:42:26 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:20406 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261303AbVESXbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:31:51 -0400
Message-ID: <428D21E5.1090604@acm.org>
Date: Thu, 19 May 2005 18:31:49 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add IPMI power cycle capability
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010003070406010500090409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003070406010500090409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010003070406010500090409
Content-Type: text/x-patch;
 name="ipmi_power_cycle_handling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_power_cycle_handling.diff"


This patch to adds "power cycle" functionality to the IPMI power off module
ipmi_poweroff. It also contains changes to support procfs control of the
feature.

The power cycle action is considered an optional chassis control in the
IPMI specification.  However, it is definitely useful when the hardware
supports it.  A power cycle is usually required in order to reset a
firmware in a bad state.  This action is critical to allow remote
management of servers.

The implementation adds power cycle as optional to the ipmi_poweroff
module. It can be modified dynamically through the proc entry mentioned
above. During a power down and enabled, the power cycle command is sent
to the BMC firmware. If it fails either due to non-support or some
error, it will retry to send the command as power off.

Signed-off-by: Christopher A. Poblete <Chris_Poblete@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc4/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.12-rc4/drivers/char/ipmi/ipmi_poweroff.c
@@ -34,6 +34,8 @@
 #include <asm/semaphore.h>
 #include <linux/kdev_t.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
@@ -44,6 +46,18 @@
 /* Where to we insert our poweroff function? */
 extern void (*pm_power_off)(void);
 
+/* Definitions for controlling power off (if the system supports it).  It
+ * conveniently matches the IPMI chassis control values. */
+#define IPMI_CHASSIS_POWER_DOWN		0	/* power down, the default. */
+#define IPMI_CHASSIS_POWER_CYCLE	0x02	/* power cycle */
+
+/* the IPMI data command */
+static int poweroff_control = IPMI_CHASSIS_POWER_DOWN;
+
+/* parameter definition to allow user to flag power cycle */
+module_param(poweroff_control, int, IPMI_CHASSIS_POWER_DOWN);
+MODULE_PARM_DESC(poweroff_control, " Set to 2 to enable power cycle instead of power down. Power cycle is contingent on hardware support, otherwise it defaults back to power down.");
+
 /* Stuff from the get device id command. */
 static unsigned int mfg_id;
 static unsigned int prod_id;
@@ -349,26 +363,38 @@
         smi_addr.channel = IPMI_BMC_CHANNEL;
         smi_addr.lun = 0;
 
-	printk(KERN_INFO PFX "Powering down via IPMI chassis control command\n");
+ powercyclefailed:
+	printk(KERN_INFO PFX "Powering %s via IPMI chassis control command\n",
+		((poweroff_control != IPMI_CHASSIS_POWER_CYCLE) ? "down" : "cycle"));
 
 	/*
 	 * Power down
 	 */
 	send_msg.netfn = IPMI_NETFN_CHASSIS_REQUEST;
 	send_msg.cmd = IPMI_CHASSIS_CONTROL_CMD;
-	data[0] = 0; /* Power down */
+	data[0] = poweroff_control;
 	send_msg.data = data;
 	send_msg.data_len = sizeof(data);
 	rv = ipmi_request_in_rc_mode(user,
 				     (struct ipmi_addr *) &smi_addr,
 				     &send_msg);
 	if (rv) {
-		printk(KERN_ERR PFX "Unable to send chassis powerdown message,"
-		       " IPMI error 0x%x\n", rv);
-		goto out;
+		switch (poweroff_control) {
+			case IPMI_CHASSIS_POWER_CYCLE:
+				/* power cycle failed, default to power down */
+				printk(KERN_ERR PFX "Unable to send chassis power " \
+					"cycle message, IPMI error 0x%x\n", rv);
+				poweroff_control = IPMI_CHASSIS_POWER_DOWN;
+				goto powercyclefailed;
+
+			case IPMI_CHASSIS_POWER_DOWN:
+			default:
+				printk(KERN_ERR PFX "Unable to send chassis power " \
+					"down message, IPMI error 0x%x\n", rv);
+				break;
+		}
 	}
 
- out:
 	return;
 }
 
@@ -430,7 +456,8 @@
 	if (ready)
 		return;
 
-	rv = ipmi_create_user(if_num, &ipmi_poweroff_handler, NULL, &ipmi_user);
+	rv = ipmi_create_user(if_num, &ipmi_poweroff_handler, NULL,
+			      &ipmi_user);
 	if (rv) {
 		printk(KERN_ERR PFX "could not create IPMI user, error %d\n",
 		       rv);
@@ -509,21 +536,84 @@
 };
 
 
+#ifdef CONFIG_PROC_FS
+/* displays properties to proc */
+static int proc_read_chassctrl(char *page, char **start, off_t off, int count,
+			       int *eof, void *data)
+{
+	return sprintf(page, "%d\t[ 0=powerdown 2=powercycle ]\n",
+			poweroff_control);
+}
+
+/* process property writes from proc */
+static int proc_write_chassctrl(struct file *file, const char *buffer,
+			        unsigned long count, void *data)
+{
+	int          rv = count;
+	unsigned int newval = 0;
+
+	sscanf(buffer, "%d", &newval);
+	switch (newval) {
+		case IPMI_CHASSIS_POWER_CYCLE:
+			printk(KERN_INFO PFX "power cycle is now enabled\n");
+			poweroff_control = newval;
+			break;
+
+		case IPMI_CHASSIS_POWER_DOWN:
+			poweroff_control = IPMI_CHASSIS_POWER_DOWN;
+			break;
+
+		default:
+			rv = -EINVAL;
+			break;
+	}
+
+	return rv;
+}
+#endif /* CONFIG_PROC_FS */
+
 /*
  * Startup and shutdown functions.
  */
 static int ipmi_poweroff_init (void)
 {
-	int rv;
+	int                   rv;
+	struct proc_dir_entry *file;
 
 	printk ("Copyright (C) 2004 MontaVista Software -"
 		" IPMI Powerdown via sys_reboot version "
 		IPMI_POWEROFF_VERSION ".\n");
 
+	switch (poweroff_control) {
+		case IPMI_CHASSIS_POWER_CYCLE:
+			printk(KERN_INFO PFX "Power cycle is enabled.\n");
+			break;
+
+		case IPMI_CHASSIS_POWER_DOWN:
+		default:
+			poweroff_control = IPMI_CHASSIS_POWER_DOWN;
+			break;
+	}
+
 	rv = ipmi_smi_watcher_register(&smi_watcher);
-	if (rv)
+	if (rv) {
 		printk(KERN_ERR PFX "Unable to register SMI watcher: %d\n", rv);
+		goto out_err;
+	}
 
+#ifdef CONFIG_PROC_FS
+	file = create_proc_entry("poweroff_control", 0, proc_ipmi_root);
+	if (!file) {
+		printk(KERN_ERR PFX "Unable to create proc power control\n");
+	} else {
+		file->nlink = 1;
+		file->read_proc = proc_read_chassctrl;
+		file->write_proc = proc_write_chassctrl;
+		file->owner = THIS_MODULE;
+	}
+#endif
+
+ out_err:
 	return rv;
 }
 
@@ -532,6 +622,10 @@
 {
 	int rv;
 
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("poweroff_control", proc_ipmi_root);
+#endif
+
 	ipmi_smi_watcher_unregister(&smi_watcher);
 
 	if (ready) {
Index: linux-2.6.12-rc4/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.12-rc4/drivers/char/ipmi/ipmi_msghandler.c
@@ -54,7 +54,9 @@
 
 static int initialized = 0;
 
-static struct proc_dir_entry *proc_ipmi_root = NULL;
+#ifdef CONFIG_PROC_FS
+struct proc_dir_entry *proc_ipmi_root = NULL;
+#endif /* CONFIG_PROC_FS */
 
 #define MAX_EVENTS_IN_QUEUE	25
 
@@ -124,11 +126,13 @@
 	unsigned char protocol;
 };
 
+#ifdef CONFIG_PROC_FS
 struct ipmi_proc_entry
 {
 	char                   *name;
 	struct ipmi_proc_entry *next;
 };
+#endif
 
 #define IPMI_IPMB_NUM_SEQ	64
 #define IPMI_MAX_CHANNELS       8
@@ -156,10 +160,13 @@
 	struct ipmi_smi_handlers *handlers;
 	void                     *send_info;
 
+#ifdef CONFIG_PROC_FS
 	/* A list of proc entries for this interface.  This does not
 	   need a lock, only one thread creates it and only one thread
 	   destroys it. */
+	spinlock_t             proc_entry_lock;
 	struct ipmi_proc_entry *proc_entries;
+#endif
 
 	/* A table of sequence numbers for this interface.  We use the
            sequence numbers for IPMB messages that go out of the
@@ -1529,8 +1536,9 @@
 			    read_proc_t *read_proc, write_proc_t *write_proc,
 			    void *data, struct module *owner)
 {
-	struct proc_dir_entry  *file;
 	int                    rv = 0;
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry  *file;
 	struct ipmi_proc_entry *entry;
 
 	/* Create a list element. */
@@ -1556,10 +1564,13 @@
 		file->write_proc = write_proc;
 		file->owner = owner;
 
+		spin_lock(&smi->proc_entry_lock);
 		/* Stick it on the list. */
 		entry->next = smi->proc_entries;
 		smi->proc_entries = entry;
+		spin_unlock(&smi->proc_entry_lock);
 	}
+#endif /* CONFIG_PROC_FS */
 
 	return rv;
 }
@@ -1568,6 +1579,7 @@
 {
 	int rv = 0;
 
+#ifdef CONFIG_PROC_FS
 	sprintf(smi->proc_dir_name, "%d", num);
 	smi->proc_dir = proc_mkdir(smi->proc_dir_name, proc_ipmi_root);
 	if (!smi->proc_dir)
@@ -1590,14 +1602,17 @@
 		rv = ipmi_smi_add_proc_entry(smi, "version",
 					     version_file_read_proc, NULL,
 					     smi, THIS_MODULE);
+#endif /* CONFIG_PROC_FS */
 
 	return rv;
 }
 
 static void remove_proc_entries(ipmi_smi_t smi)
 {
+#ifdef CONFIG_PROC_FS
 	struct ipmi_proc_entry *entry;
 
+	spin_lock(&smi->proc_entry_lock);
 	while (smi->proc_entries) {
 		entry = smi->proc_entries;
 		smi->proc_entries = entry->next;
@@ -1606,7 +1621,9 @@
 		kfree(entry->name);
 		kfree(entry);
 	}
+	spin_unlock(&smi->proc_entry_lock);
 	remove_proc_entry(smi->proc_dir_name, proc_ipmi_root);
+#endif /* CONFIG_PROC_FS */
 }
 
 static int
@@ -1753,6 +1770,9 @@
 				new_intf->seq_table[j].seqid = 0;
 			}
 			new_intf->curr_seq = 0;
+#ifdef CONFIG_PROC_FS
+			spin_lock_init(&(new_intf->proc_entry_lock));
+#endif
 			spin_lock_init(&(new_intf->waiting_msgs_lock));
 			INIT_LIST_HEAD(&(new_intf->waiting_msgs));
 			spin_lock_init(&(new_intf->events_lock));
@@ -3144,6 +3164,7 @@
 		ipmi_interfaces[i] = NULL;
 	}
 
+#ifdef CONFIG_PROC_FS
 	proc_ipmi_root = proc_mkdir("ipmi", NULL);
 	if (!proc_ipmi_root) {
 	    printk(KERN_ERR PFX "Unable to create IPMI proc dir");
@@ -3151,6 +3172,7 @@
 	}
 
 	proc_ipmi_root->owner = THIS_MODULE;
+#endif /* CONFIG_PROC_FS */
 
 	init_timer(&ipmi_timer);
 	ipmi_timer.data = 0;
@@ -3188,7 +3210,9 @@
 	atomic_inc(&stop_operation);
 	del_timer_sync(&ipmi_timer);
 
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry(proc_ipmi_root->name, &proc_root);
+#endif /* CONFIG_PROC_FS */
 
 	initialized = 0;
 
@@ -3229,6 +3253,7 @@
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 EXPORT_SYMBOL(ipmi_get_my_LUN);
 EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
+EXPORT_SYMBOL(proc_ipmi_root);
 EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
 
 EXPORT_SYMBOL(ipmi_request_with_source);
Index: linux-2.6.12-rc4/include/linux/ipmi.h
===================================================================
--- linux-2.6.12-rc4.orig/include/linux/ipmi.h
+++ linux-2.6.12-rc4/include/linux/ipmi.h
@@ -209,6 +209,11 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+extern struct proc_dir_entry *proc_ipmi_root;
+#endif /* CONFIG_PROC_FS */
+
 /* Opaque type for a IPMI message user.  One of these is needed to
    send and receive messages. */
 typedef struct ipmi_user *ipmi_user_t;
Index: linux-2.6.12-rc4/Documentation/IPMI.txt
===================================================================
--- linux-2.6.12-rc4.orig/Documentation/IPMI.txt
+++ linux-2.6.12-rc4/Documentation/IPMI.txt
@@ -602,3 +602,23 @@
 controller will be queried and the events sent to the SEL on that
 device.  Otherwise, the events go nowhere since there is nowhere to
 send them.
+
+
+Poweroff
+--------
+
+If the poweroff capability is selected, the IPMI driver will install
+a shutdown function into the standard poweroff function pointer.  This
+is in the ipmi_poweroff module.  When the system requests a powerdown,
+it will send the proper IPMI commands to do this.  This is supported on
+several platforms.
+
+There is a module parameter named "poweroff_control" that may either be zero
+(do a power down) or 2 (do a power cycle, power the system off, then power
+it on in a few seconds).  Setting ipmi_poweroff.poweroff_control=x will do
+the same thing on the kernel command line.  The parameter is also available
+via the proc filesystem in /proc/ipmi/poweroff_control.  Note that if the
+system does not support power cycling, it will always to the power off.
+
+Note that if you have ACPI enabled, the system will prefer using ACPI to
+power off.

--------------010003070406010500090409--
