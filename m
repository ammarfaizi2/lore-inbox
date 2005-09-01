Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030512AbVIAXEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbVIAXEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbVIAXD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:03:59 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:40839 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030512AbVIAXD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:03:58 -0400
Message-ID: <431788DA.3010801@acm.org>
Date: Thu, 01 Sep 2005 18:03:54 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: viro@ZenIV.linux.org.uk, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
References: <20050901064313.GB26264@ZenIV.linux.org.uk>	<1125592902.27283.5.camel@i2.minyard.local> <20050901124114.7af633b1.akpm@osdl.org>
In-Reply-To: <20050901124114.7af633b1.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040502010509030304010201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040502010509030304010201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>Indeed, this function is badly written.  In rewriting, I couldn't find a
>> nice function for reading integers from userspace, and the proc_dointvec
>> stuff didn't seem terribly suitable.
>>    
>>
>
>We write numbers into profs files all the time.  Is there something
>different about the IPMI requirement which makes the approach used by, say,
>dirty_writeback_centisecs_handler() inappropriate?
>  
>
Ok, that's probably better, and this probably belongs in 
/proc/sys/dev/ipmi.  This is new enough that it doesn't matter, I don't 
think any one is using it yet.

Patch is attached.

-Corey

--------------040502010509030304010201
Content-Type: unknown/unknown;
 name="ipmi-poweroff-fix-chassis-ctrl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-poweroff-fix-chassis-ctrl.patch"

The IPMI power control function proc_write_chassctrl was badly
written, it directly used userspace pointers, it assumed that
strings were NULL terminated, and it used the evil sscanf function.
This converts over to using the sysctl interface for this data and
changes the semantics to be a little more logical.

Signed-off-by: Corey Minyard <minyard@acm.org>

 Documentation/IPMI.txt            |   13 +--
 drivers/char/ipmi/ipmi_poweroff.c |  136 ++++++++++++++++----------------------
 include/linux/sysctl.h            |    6 +
 3 files changed, 73 insertions(+), 82 deletions(-)

Index: linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
@@ -52,11 +52,11 @@ extern void (*pm_power_off)(void);
 #define IPMI_CHASSIS_POWER_CYCLE	0x02	/* power cycle */
 
 /* the IPMI data command */
-static int poweroff_control = IPMI_CHASSIS_POWER_DOWN;
+static int poweroff_powercycle = 0;
 
 /* parameter definition to allow user to flag power cycle */
-module_param(poweroff_control, int, IPMI_CHASSIS_POWER_DOWN);
-MODULE_PARM_DESC(poweroff_control, " Set to 2 to enable power cycle instead of power down. Power cycle is contingent on hardware support, otherwise it defaults back to power down.");
+module_param(poweroff_powercycle, int, 0);
+MODULE_PARM_DESC(poweroff_powercycles, " Set to non-zero to enable power cycle instead of power down. Power cycle is contingent on hardware support, otherwise it defaults back to power down.");
 
 /* Stuff from the get device id command. */
 static unsigned int mfg_id;
@@ -365,37 +365,34 @@ static void ipmi_poweroff_chassis (ipmi_
 
  powercyclefailed:
 	printk(KERN_INFO PFX "Powering %s via IPMI chassis control command\n",
-		((poweroff_control != IPMI_CHASSIS_POWER_CYCLE) ? "down" : "cycle"));
+		(poweroff_powercycle ? "cycle" : "down"));
 
 	/*
 	 * Power down
 	 */
 	send_msg.netfn = IPMI_NETFN_CHASSIS_REQUEST;
 	send_msg.cmd = IPMI_CHASSIS_CONTROL_CMD;
-	data[0] = poweroff_control;
+	if (poweroff_powercycle)
+		data[0] = IPMI_CHASSIS_POWER_CYCLE;
+	else
+		data[0] = IPMI_CHASSIS_POWER_DOWN;
 	send_msg.data = data;
 	send_msg.data_len = sizeof(data);
 	rv = ipmi_request_in_rc_mode(user,
 				     (struct ipmi_addr *) &smi_addr,
 				     &send_msg);
 	if (rv) {
-		switch (poweroff_control) {
-			case IPMI_CHASSIS_POWER_CYCLE:
-				/* power cycle failed, default to power down */
-				printk(KERN_ERR PFX "Unable to send chassis power " \
-					"cycle message, IPMI error 0x%x\n", rv);
-				poweroff_control = IPMI_CHASSIS_POWER_DOWN;
-				goto powercyclefailed;
-
-			case IPMI_CHASSIS_POWER_DOWN:
-			default:
-				printk(KERN_ERR PFX "Unable to send chassis power " \
-					"down message, IPMI error 0x%x\n", rv);
-				break;
+		if (poweroff_powercycle) {
+			/* power cycle failed, default to power down */
+			printk(KERN_ERR PFX "Unable to send chassis power " \
+			       "cycle message, IPMI error 0x%x\n", rv);
+			poweroff_powercycle = 0;
+			goto powercyclefailed;
 		}
-	}
 
-	return;
+		printk(KERN_ERR PFX "Unable to send chassis power " \
+		       "down message, IPMI error 0x%x\n", rv);
+	}
 }
 
 
@@ -537,39 +534,35 @@ static struct ipmi_smi_watcher smi_watch
 
 
 #ifdef CONFIG_PROC_FS
-/* displays properties to proc */
-static int proc_read_chassctrl(char *page, char **start, off_t off, int count,
-			       int *eof, void *data)
-{
-	return sprintf(page, "%d\t[ 0=powerdown 2=powercycle ]\n",
-			poweroff_control);
-}
-
-/* process property writes from proc */
-static int proc_write_chassctrl(struct file *file, const char *buffer,
-			        unsigned long count, void *data)
-{
-	int          rv = count;
-	unsigned int newval = 0;
-
-	sscanf(buffer, "%d", &newval);
-	switch (newval) {
-		case IPMI_CHASSIS_POWER_CYCLE:
-			printk(KERN_INFO PFX "power cycle is now enabled\n");
-			poweroff_control = newval;
-			break;
-
-		case IPMI_CHASSIS_POWER_DOWN:
-			poweroff_control = IPMI_CHASSIS_POWER_DOWN;
-			break;
-
-		default:
-			rv = -EINVAL;
-			break;
-	}
+#include <linux/sysctl.h>
 
-	return rv;
-}
+static ctl_table ipmi_table[] = {
+	{ .ctl_name	= DEV_IPMI_POWEROFF_POWERCYCLE,
+	  .procname	= "poweroff_powercycle",
+	  .data		= &poweroff_powercycle,
+	  .maxlen	= sizeof(poweroff_powercycle),
+	  .mode		= 0644,
+	  .proc_handler	= &proc_dointvec },
+	{ }
+};
+
+static ctl_table ipmi_dir_table[] = {
+	{ .ctl_name	= DEV_IPMI,
+	  .procname	= "ipmi",
+	  .mode		= 0555,
+	  .child	= ipmi_table },
+	{ }
+};
+
+static ctl_table ipmi_root_table[] = {
+	{ .ctl_name	= CTL_DEV,
+	  .procname	= "dev",
+	  .mode		= 0555,
+	  .child	= ipmi_dir_table },
+	{ }
+};
+
+static struct ctl_table_header *ipmi_table_header;
 #endif /* CONFIG_PROC_FS */
 
 /*
@@ -577,41 +570,32 @@ static int proc_write_chassctrl(struct f
  */
 static int ipmi_poweroff_init (void)
 {
-	int                   rv;
-	struct proc_dir_entry *file;
+	int rv;
 
 	printk ("Copyright (C) 2004 MontaVista Software -"
 		" IPMI Powerdown via sys_reboot.\n");
 
-	switch (poweroff_control) {
-		case IPMI_CHASSIS_POWER_CYCLE:
-			printk(KERN_INFO PFX "Power cycle is enabled.\n");
-			break;
-
-		case IPMI_CHASSIS_POWER_DOWN:
-		default:
-			poweroff_control = IPMI_CHASSIS_POWER_DOWN;
-			break;
+	if (poweroff_powercycle)
+		printk(KERN_INFO PFX "Power cycle is enabled.\n");
+
+#ifdef CONFIG_PROC_FS
+	ipmi_table_header = register_sysctl_table(ipmi_root_table, 1);
+	if (!ipmi_table_header) {
+		printk(KERN_ERR PFX "Unable to register powercycle sysctl\n");
+		rv = -ENOMEM;
+		goto out_err;
 	}
+#endif
 
+#ifdef CONFIG_PROC_FS
 	rv = ipmi_smi_watcher_register(&smi_watcher);
+#endif
 	if (rv) {
+		unregister_sysctl_table(ipmi_table_header);
 		printk(KERN_ERR PFX "Unable to register SMI watcher: %d\n", rv);
 		goto out_err;
 	}
 
-#ifdef CONFIG_PROC_FS
-	file = create_proc_entry("poweroff_control", 0, proc_ipmi_root);
-	if (!file) {
-		printk(KERN_ERR PFX "Unable to create proc power control\n");
-	} else {
-		file->nlink = 1;
-		file->read_proc = proc_read_chassctrl;
-		file->write_proc = proc_write_chassctrl;
-		file->owner = THIS_MODULE;
-	}
-#endif
-
  out_err:
 	return rv;
 }
@@ -622,7 +606,7 @@ static __exit void ipmi_poweroff_cleanup
 	int rv;
 
 #ifdef CONFIG_PROC_FS
-	remove_proc_entry("poweroff_control", proc_ipmi_root);
+	unregister_sysctl_table(ipmi_table_header);
 #endif
 
 	ipmi_smi_watcher_unregister(&smi_watcher);
Index: linux-2.6.13/Documentation/IPMI.txt
===================================================================
--- linux-2.6.13.orig/Documentation/IPMI.txt
+++ linux-2.6.13/Documentation/IPMI.txt
@@ -605,12 +605,13 @@ is in the ipmi_poweroff module.  When th
 it will send the proper IPMI commands to do this.  This is supported on
 several platforms.
 
-There is a module parameter named "poweroff_control" that may either be zero
-(do a power down) or 2 (do a power cycle, power the system off, then power
-it on in a few seconds).  Setting ipmi_poweroff.poweroff_control=x will do
-the same thing on the kernel command line.  The parameter is also available
-via the proc filesystem in /proc/ipmi/poweroff_control.  Note that if the
-system does not support power cycling, it will always to the power off.
+There is a module parameter named "poweroff_powercycle" that may
+either be zero (do a power down) or non-zero (do a power cycle, power
+the system off, then power it on in a few seconds).  Setting
+ipmi_poweroff.poweroff_control=x will do the same thing on the kernel
+command line.  The parameter is also available via the proc filesystem
+in /proc/sys/dev/ipmi/poweroff_powercycle.  Note that if the system
+does not support power cycling, it will always do the power off.
 
 Note that if you have ACPI enabled, the system will prefer using ACPI to
 power off.
Index: linux-2.6.13/include/linux/sysctl.h
===================================================================
--- linux-2.6.13.orig/include/linux/sysctl.h
+++ linux-2.6.13/include/linux/sysctl.h
@@ -711,6 +711,7 @@ enum {
 	DEV_RAID=4,
 	DEV_MAC_HID=5,
 	DEV_SCSI=6,
+	DEV_IPMI=7,
 };
 
 /* /proc/sys/dev/cdrom */
@@ -776,6 +777,11 @@ enum {
 	DEV_SCSI_LOGGING_LEVEL=1,
 };
 
+/* /proc/sys/dev/ipmi */
+enum {
+	DEV_IPMI_POWEROFF_POWERCYCLE=1,
+};
+
 /* /proc/sys/abi */
 enum
 {

--------------040502010509030304010201--
