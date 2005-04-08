Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVDHOyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVDHOyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVDHOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:54:40 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:32624 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262837AbVDHOyM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:54:12 -0400
X-IronPort-AV: i="3.92,88,1112590800"; 
   d="scan'208"; a="245874289:sNHT425851014"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2.6.11.6] Add power cycle to ipmi_poweroff module
Date: Fri, 8 Apr 2005 09:54:10 -0500
Message-ID: <D69989B48C25DB489BBB0207D0BF51F701F4ECD4@ausx2kmpc104.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.11.6] Add power cycle to ipmi_poweroff module
Thread-Index: AcU8StJ9shkcAEmmRLmwpiQ1YjzLbg==
From: <Chris_Poblete@Dell.com>
To: <linux-kernel@vger.kernel.org>
Cc: <cminyard@mvista.com>, <sdake@mvista.com>
X-OriginalArrivalTime: 08 Apr 2005 14:54:11.0273 (UTC) FILETIME=[D2DAD390:01C53C4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch to add "power cycle" functionality to the IPMI power
off module ipmi_poweroff.

A new module param is added to support this:
parmtype:       do_power_cycle:int
parm:           do_power_cycle: Set to 1 to enable power cycle instead
of power down. Power cycle is contingent on hardware support, otherwise
it defaults back to power down.

This parameter can also be dynamically modified through the proc
filesystem:
/proc/ipmi/<interface_num>/poweroff

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


===== drivers/char/ipmi/ipmi_poweroff.c linux-2.6.11.6 vi edited =====
--- linux-2.6.11.6/drivers/char/ipmi/ipmi_poweroff.c.orig
2005-03-25 21:28:22.000000000 -0600
+++ linux-2.6.11.6/drivers/char/ipmi/ipmi_poweroff.c	2005-04-07
18:36:10.656537656 -0500
@@ -34,6 +34,8 @@
 #include <asm/semaphore.h>
 #include <linux/kdev_t.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
@@ -41,6 +43,13 @@
 #define PFX "IPMI poweroff: "
 #define IPMI_POWEROFF_VERSION	"v33"
 
+/* container to flag power cycle instead of power down */
+static int do_power_cycle = 0;
+
+/* parameter definition to allow user to flag power cycle */
+module_param(do_power_cycle, int, 0);
+MODULE_PARM_DESC(do_power_cycle, " Set to 1 to enable power cycle
instead of power down. Power cycle is contingent on hardware support,
otherwise it defaults back to power down.");
+
 /* Where to we insert our poweroff function? */
 extern void (*pm_power_off)(void);
 
@@ -349,23 +358,37 @@ static void ipmi_poweroff_chassis (ipmi_
         smi_addr.channel = IPMI_BMC_CHANNEL;
         smi_addr.lun = 0;
 
-	printk(KERN_INFO PFX "Powering down via IPMI chassis control
command\n");
+ powercyclefailed:
+	printk(KERN_INFO PFX "Powering %s via IPMI chassis control
command\n",
+		((do_power_cycle != 1) ? "down" : "cycle"));
 
 	/*
 	 * Power down
 	 */
 	send_msg.netfn = IPMI_NETFN_CHASSIS_REQUEST;
 	send_msg.cmd = IPMI_CHASSIS_CONTROL_CMD;
-	data[0] = 0; /* Power down */
+	if (do_power_cycle != 1) {
+		data[0] = 0; /* Power down */
+	} else {
+		data[0] = 2; /* Power cycle */
+	}
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
+		if (do_power_cycle != 1) {
+			printk(KERN_ERR PFX "Unable to send chassis
power " \
+				"down message, IPMI error 0x%x\n", rv);
+			goto out;
+                } else {
+			/* power cycle failed, default to power down */
+			printk(KERN_ERR PFX "Unable to send chassis
power " \
+				"cycle message, IPMI error 0x%x\n", rv);
+			do_power_cycle = 0;
+			goto powercyclefailed;
+                }
 	}
 
  out:
@@ -418,6 +441,110 @@ static void ipmi_poweroff_function (void
 	ipmi_user_set_run_to_completion(ipmi_user, 0);
 }
 
+/* procfs global memory */
+static struct proc_dir_entry *proc_ipo_root = NULL;
+static struct proc_dir_entry *proc_ipo_dir = NULL;
+static char ipo_dirname[4];
+
+/* displays properties to proc */
+static int proc_read_do_power_cycle(char *page, char **start,
+			off_t off, int count,
+			int *eof, void *data)
+{
+	/* sanity check */
+	if (data != NULL) {
+		return sprintf(page, "do_power_cycle = '%s'\n",
+			(*((int *)data) != 0 ? "enabled" : "disabled"));
+	}
+
+	return -EINVAL;
+}
+
+/* process property writes from proc */
+static int proc_write_do_power_cycle(struct file *file,
+			const char *buffer,
+			unsigned long count,
+			void *data)
+{
+	int rv = count;
+	int newval = 0;
+
+	/* sanity check */
+	if ((buffer != NULL) && (data != NULL)) {
+		sscanf(buffer, "%d", &newval);
+		if (newval != 0) {
+			*((int *)data) = 1;
+			printk(KERN_INFO PFX "power cycle is now
enabled\n");
+		} else {
+			*((int *)data) = 0;
+			printk(KERN_INFO PFX "power cycle is now
disabled\n");
+		}
+	}
+
+	return rv;
+}
+
+/* removes proc entries */
+static void ipmi_po_remove_proc_entries(void)
+{
+	remove_proc_entry("poweroff", proc_ipo_dir);
+	if (ipo_dirname[0] != '\0') {
+		remove_proc_entry(ipo_dirname, proc_ipo_root);
+		ipo_dirname[0] = '\0';
+	}
+	remove_proc_entry("ipmi", NULL);
+}
+
+/* creates proc entries */
+static int ipmi_po_add_proc_entries(int if_num)
+{
+	struct proc_dir_entry *proc_ipo_pc = NULL;
+	int rv = -ENOMEM;
+
+	/* check for unreasonable value, besides buffer has room for
only 3 */
+	if ((if_num < 0) || (if_num > 255)) {
+		printk(KERN_ERR PFX "invalid interface num: %d\n",
if_num);
+		goto error1;
+	}
+	proc_ipo_root = proc_mkdir("ipmi", NULL);
+	if (!proc_ipo_root) {
+		printk(KERN_ERR PFX "failed to create ipmi proc dir\n");
+		goto error1;
+	}
+	proc_ipo_root->owner = THIS_MODULE;
+	ipo_dirname[0] = '\0';
+	sprintf(ipo_dirname, "%d", if_num);
+	if (ipo_dirname[0] == '\0') {
+		goto error2;
+	}
+	proc_ipo_dir = proc_mkdir(ipo_dirname, proc_ipo_root);
+	if (!proc_ipo_dir) {
+		printk(KERN_ERR PFX "failed to create ipmi/%d proc
dir\n", if_num);
+		goto error2;
+	}
+	proc_ipo_dir->owner = THIS_MODULE;
+	proc_ipo_pc = create_proc_entry("poweroff", 0, proc_ipo_dir);
+	if (!proc_ipo_pc) {
+		printk(KERN_ERR PFX "failed to create poweroff proc
entry\n");
+		goto error3;
+	}
+	proc_ipo_pc->owner = THIS_MODULE;
+	proc_ipo_pc->data = &do_power_cycle;
+	proc_ipo_pc->read_proc = proc_read_do_power_cycle;
+	proc_ipo_pc->write_proc = proc_write_do_power_cycle;
+
+	/* success only at this point */
+	return 0;
+
+ error3:
+	remove_proc_entry(ipo_dirname, proc_ipo_root);
+ error2:
+	ipo_dirname[0] = '\0';
+	remove_proc_entry("ipmi", NULL);
+ error1:
+	return rv;
+}
+
 /* Wait for an IPMI interface to be installed, the first one installed
    will be grabbed by this code and used to perform the powerdown. */
 static void ipmi_po_new_smi(int if_num)
@@ -430,6 +557,13 @@ static void ipmi_po_new_smi(int if_num)
 	if (ready)
 		return;
 
+	/* add procfs entries for setting properties */
+	rv = ipmi_po_add_proc_entries(if_num);
+	if (rv) {
+		printk(KERN_ERR PFX "failed to create procfs
entries\n");
+		return;
+	}
+
 	rv = ipmi_create_user(if_num, &ipmi_poweroff_handler, NULL,
&ipmi_user);
 	if (rv) {
 		printk(KERN_ERR PFX "could not create IPMI user, error
%d\n",
@@ -520,6 +654,10 @@ static int ipmi_poweroff_init (void)
 		" IPMI Powerdown via sys_reboot version "
 		IPMI_POWEROFF_VERSION ".\n");
 
+	if (do_power_cycle == 1) {
+		printk (KERN_INFO PFX "Power cycle is enabled.\n");
+	}
+
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv)
 		printk(KERN_ERR PFX "Unable to register SMI watcher:
%d\n", rv);
@@ -532,6 +670,7 @@ static __exit void ipmi_poweroff_cleanup
 {
 	int rv;
 
+	ipmi_po_remove_proc_entries();
 	ipmi_smi_watcher_unregister(&smi_watcher);
 
 	if (ready) {
