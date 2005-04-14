Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVDNRSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVDNRSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVDNRSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:18:18 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:40088 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261562AbVDNROg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:14:36 -0400
X-IronPort-AV: i="3.92,102,1112590800"; 
   d="scan'208"; a="248376656:sNHT1511950416"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.11.7] Add power cycle to ipmi_poweroff module
Date: Thu, 14 Apr 2005 11:50:38 -0500
Message-ID: <D69989B48C25DB489BBB0207D0BF51F70262F43C@ausx2kmpc104.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.11.7] Add power cycle to ipmi_poweroff module
Thread-Index: AcU8StJ9shkcAEmmRLmwpiQ1YjzLbgEwjsCQ
From: <Chris_Poblete@Dell.com>
To: <linux-kernel@vger.kernel.org>
Cc: <cminyard@mvista.com>, <sdake@mvista.com>
X-OriginalArrivalTime: 14 Apr 2005 16:50:40.0135 (UTC) FILETIME=[17050970:01C54112]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supersedes the one submitted earlier with title 
"[PATCH 2.6.11.6] Add power cycle to ipmi_poweroff module".

Below is a patch to add "power cycle" functionality to the IPMI power
off module ipmi_poweroff. It also contains changes to support absence of
procfs feature.

Files affected by this patch:
drivers/char/ipmi/ipmi_poweroff.c
drivers/char/ipmi/ipmi_msghandler.c

A new module param is added to support this:
parmtype:       chassis_ctrl_cmd_param:int
parm:           chassis_ctrl_cmd: Set to 2 to enable power cycle instead
of power down. Power cycle is contingent on hardware support, otherwise
it defaults back to power down.

This parameter can also be dynamically modified through the proc
filesystem:
/proc/ipmi/<interface_num>/chassctrl

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

--
Chris Poblete
Software Engineer
Dell OpenManage Instrumentation


===== drivers/char/ipmi/ipmi_poweroff.c linux-2.6.11.7 vi edited =====
--- linux-2.6.11.7/drivers/char/ipmi/ipmi_poweroff.c.orig
2005-04-14 11:45:09.000000000 -0500
+++ linux-2.6.11.7/drivers/char/ipmi/ipmi_poweroff.c	2005-04-14
11:43:08.000000000 -0500
@@ -34,6 +34,8 @@
 #include <asm/semaphore.h>
 #include <linux/kdev_t.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
@@ -329,6 +331,17 @@ static void ipmi_poweroff_cpi1 (ipmi_use
 #define IPMI_NETFN_CHASSIS_REQUEST	0
 #define IPMI_CHASSIS_CONTROL_CMD	0x02
 
+#define IPMI_CHASSIS_POWER_DOWN		0
+#define IPMI_CHASSIS_POWER_CYCLE	0x02
+
+/* the IPMI data command */
+static unsigned char chassis_ctrl_cmd = IPMI_CHASSIS_POWER_DOWN;
+static int chassis_ctrl_cmd_param = IPMI_CHASSIS_POWER_DOWN;
+
+/* parameter definition to allow user to flag power cycle */
+module_param(chassis_ctrl_cmd_param, int, IPMI_CHASSIS_POWER_DOWN);
+MODULE_PARM_DESC(chassis_ctrl_cmd, " Set to 2 to enable power cycle
instead of power down. Power cycle is contingent on hardware support,
otherwise it defaults back to power down.");
+
 static int ipmi_chassis_detect (ipmi_user_t user)
 {
 	/* Chassis support, use it. */
@@ -349,26 +362,38 @@ static void ipmi_poweroff_chassis (ipmi_
         smi_addr.channel = IPMI_BMC_CHANNEL;
         smi_addr.lun = 0;
 
-	printk(KERN_INFO PFX "Powering down via IPMI chassis control
command\n");
+ powercyclefailed:
+	printk(KERN_INFO PFX "Powering %s via IPMI chassis control
command\n",
+		((chassis_ctrl_cmd != IPMI_CHASSIS_POWER_CYCLE) ? "down"
: "cycle"));
 
 	/*
 	 * Power down
 	 */
 	send_msg.netfn = IPMI_NETFN_CHASSIS_REQUEST;
 	send_msg.cmd = IPMI_CHASSIS_CONTROL_CMD;
-	data[0] = 0; /* Power down */
+	data[0] = chassis_ctrl_cmd;
 	send_msg.data = data;
 	send_msg.data_len = sizeof(data);
 	rv = ipmi_request_in_rc_mode(user,
 				     (struct ipmi_addr *) &smi_addr,
 				     &send_msg);
 	if (rv) {
-		printk(KERN_ERR PFX "Unable to send chassis powerdown
message,"
-		       " IPMI error 0x%x\n", rv);
-		goto out;
+		switch (chassis_ctrl_cmd) {
+			case IPMI_CHASSIS_POWER_CYCLE:
+				/* power cycle failed, default to power
down */
+				printk(KERN_ERR PFX "Unable to send
chassis power " \
+					"cycle message, IPMI error
0x%x\n", rv);
+				chassis_ctrl_cmd =
IPMI_CHASSIS_POWER_DOWN;
+				goto powercyclefailed;
+
+			case IPMI_CHASSIS_POWER_DOWN:
+			default:
+				printk(KERN_ERR PFX "Unable to send
chassis power " \
+					"down message, IPMI error
0x%x\n", rv);
+				break;
+		}
 	}
 
- out:
 	return;
 }
 
@@ -418,6 +443,53 @@ static void ipmi_poweroff_function (void
 	ipmi_user_set_run_to_completion(ipmi_user, 0);
 }
 
+/* displays properties to proc */
+static int proc_read_chassctrl(char *page, char **start,
+			off_t off, int count,
+			int *eof, void *data)
+{
+	int chassis_ctrl_cmd_loc;
+
+	/* sanity check */
+	if (data != NULL) {
+		chassis_ctrl_cmd_loc = *((int *)data);
+		return sprintf(page, "%u\t[ 0=powerdown 2=powercycle
]\n",
+			chassis_ctrl_cmd_loc);
+	}
+
+	return -EINVAL;
+}
+
+/* process property writes from proc */
+static int proc_write_chassctrl(struct file *file,
+			const char *buffer,
+			unsigned long count,
+			void *data)
+{
+	int *chassis_ctrl_cmd_loc;
+	int rv = count;
+	int newval = 0;
+
+	/* sanity check */
+	if ((buffer != NULL) && (data != NULL)) {
+		chassis_ctrl_cmd_loc = (int *)data;
+		sscanf(buffer, "%u", &newval);
+		switch (newval) {
+			case IPMI_CHASSIS_POWER_CYCLE:
+				printk(KERN_INFO PFX "power cycle is now
enabled\n");
+				*chassis_ctrl_cmd_loc = newval;
+				break;
+
+			case IPMI_CHASSIS_POWER_DOWN:
+			default:
+				*chassis_ctrl_cmd_loc =
IPMI_CHASSIS_POWER_DOWN;
+				break;
+		}
+	}
+
+	return rv;
+}
+
 /* Wait for an IPMI interface to be installed, the first one installed
    will be grabbed by this code and used to perform the powerdown. */
 static void ipmi_po_new_smi(int if_num)
@@ -430,6 +502,15 @@ static void ipmi_po_new_smi(int if_num)
 	if (ready)
 		return;
 
+	/* add poweroff proc entries */
+	rv = ipmi_if_num_add_proc_entry(if_num, "chassctrl",
+		proc_read_chassctrl, proc_write_chassctrl,
+		&chassis_ctrl_cmd, THIS_MODULE);
+	if (rv) {
+		printk(KERN_ERR PFX "failed to create proc entry\n");
+		return;
+	}
+
 	rv = ipmi_create_user(if_num, &ipmi_poweroff_handler, NULL,
&ipmi_user);
 	if (rv) {
 		printk(KERN_ERR PFX "could not create IPMI user, error
%d\n",
@@ -520,6 +601,18 @@ static int ipmi_poweroff_init (void)
 		" IPMI Powerdown via sys_reboot version "
 		IPMI_POWEROFF_VERSION ".\n");
 
+	chassis_ctrl_cmd = chassis_ctrl_cmd_param;
+	switch (chassis_ctrl_cmd) {
+		case IPMI_CHASSIS_POWER_CYCLE:
+			printk(KERN_INFO PFX "Power cycle is
enabled.\n");
+			break;
+
+		case IPMI_CHASSIS_POWER_DOWN:
+		default:
+			chassis_ctrl_cmd = IPMI_CHASSIS_POWER_DOWN;
+			break;
+	}
+
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv)
 		printk(KERN_ERR PFX "Unable to register SMI watcher:
%d\n", rv);


===== drivers/char/ipmi/ipmi_msghandler.c linux-2.6.11.7 vi edited =====
--- linux-2.6.11.7/drivers/char/ipmi/ipmi_msghandler.c.orig
2005-04-14 11:45:22.000000000 -0500
+++ linux-2.6.11.7/drivers/char/ipmi/ipmi_msghandler.c	2005-04-14
11:42:39.000000000 -0500
@@ -54,7 +54,9 @@ static int ipmi_init_msghandler(void);
 
 static int initialized = 0;
 
+#ifdef CONFIG_PROC_FS
 static struct proc_dir_entry *proc_ipmi_root = NULL;
+#endif /* CONFIG_PROC_FS */
 
 #define MAX_EVENTS_IN_QUEUE	25
 
@@ -1460,6 +1462,7 @@ int ipmi_smi_add_proc_entry(ipmi_smi_t s
 	int                    rv = 0;
 	struct ipmi_proc_entry *entry;
 
+#ifdef CONFIG_PROC_FS
 	/* Create a list element. */
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
@@ -1487,14 +1490,33 @@ int ipmi_smi_add_proc_entry(ipmi_smi_t s
 		entry->next = smi->proc_entries;
 		smi->proc_entries = entry;
 	}
+#endif /* CONFIG_PROC_FS */
 
 	return rv;
 }
 
+int ipmi_if_num_add_proc_entry(int if_num, char *name,
+			    read_proc_t *read_proc, write_proc_t
*write_proc,
+			    void *data, struct module *owner)
+{
+
+	/* make sure if_num is not bogus */
+	if (if_num < MAX_IPMI_INTERFACES) {
+		/* check if interface at index if_num exist */
+		if (ipmi_interfaces[if_num] != NULL) {
+			return
ipmi_smi_add_proc_entry(ipmi_interfaces[if_num], 
+				name, read_proc, write_proc, data,
owner);
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int add_proc_entries(ipmi_smi_t smi, int num)
 {
 	int rv = 0;
 
+#ifdef CONFIG_PROC_FS
 	sprintf(smi->proc_dir_name, "%d", num);
 	smi->proc_dir = proc_mkdir(smi->proc_dir_name, proc_ipmi_root);
 	if (!smi->proc_dir)
@@ -1517,12 +1539,14 @@ static int add_proc_entries(ipmi_smi_t s
 		rv = ipmi_smi_add_proc_entry(smi, "version",
 					     version_file_read_proc,
NULL,
 					     smi, THIS_MODULE);
+#endif /* CONFIG_PROC_FS */
 
 	return rv;
 }
 
 static void remove_proc_entries(ipmi_smi_t smi)
 {
+#ifdef CONFIG_PROC_FS
 	struct ipmi_proc_entry *entry;
 
 	while (smi->proc_entries) {
@@ -1534,6 +1558,7 @@ static void remove_proc_entries(ipmi_smi
 		kfree(entry);
 	}
 	remove_proc_entry(smi->proc_dir_name, proc_ipmi_root);
+#endif /* CONFIG_PROC_FS */
 }
 
 static int
@@ -3065,6 +3090,7 @@ static int ipmi_init_msghandler(void)
 		ipmi_interfaces[i] = NULL;
 	}
 
+#ifdef CONFIG_PROC_FS
 	proc_ipmi_root = proc_mkdir("ipmi", NULL);
 	if (!proc_ipmi_root) {
 	    printk(KERN_ERR PFX "Unable to create IPMI proc dir");
@@ -3072,6 +3098,7 @@ static int ipmi_init_msghandler(void)
 	}
 
 	proc_ipmi_root->owner = THIS_MODULE;
+#endif /* CONFIG_PROC_FS */
 
 	init_timer(&ipmi_timer);
 	ipmi_timer.data = 0;
@@ -3112,7 +3139,9 @@ static __exit void cleanup_ipmi(void)
 		schedule_timeout(1);
 	}
 
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry(proc_ipmi_root->name, &proc_root);
+#endif /* CONFIG_PROC_FS */
 
 	initialized = 0;
 
@@ -3153,4 +3182,6 @@ EXPORT_SYMBOL(ipmi_get_my_address);
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 EXPORT_SYMBOL(ipmi_get_my_LUN);
 EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
+EXPORT_SYMBOL(ipmi_if_num_add_proc_entry);
 EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
