Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWJBNkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWJBNkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWJBNkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:40:06 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:62434 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932314AbWJBNkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:40:05 -0400
Date: Mon, 2 Oct 2006 08:42:07 -0500
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] IPMI: allow user to override the kernel IPMI daemon enable
Message-ID: <20061002134207.GA10202@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After the previous patch to disable the kernel IPMI daemon if interrupts
were available, the issue of broken hardware was raised, and a reasonable
request to add an override was mode.  So here it is.

Allow the user to force the kernel ipmi daemon on or off.  This way,
hardware with broken interrupts or users that are not concerned with
performance can turn it on or off to their liking.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.18/Documentation/IPMI.txt
===================================================================
--- linux-2.6.18.orig/Documentation/IPMI.txt
+++ linux-2.6.18/Documentation/IPMI.txt
@@ -364,6 +364,7 @@ You can change this at module load time 
        regspacings=<sp1>,<sp2>,... regsizes=<size1>,<size2>,...
        regshifts=<shift1>,<shift2>,...
        slave_addrs=<addr1>,<addr2>,...
+       force_kipmid=<enable1>,<enable2>,...
 
 Each of these except si_trydefaults is a list, the first item for the
 first interface, second item for the second interface, etc.
@@ -409,7 +410,13 @@ The slave_addrs specifies the IPMI addre
 usually 0x20 and the driver defaults to that, but in case it's not, it
 can be specified when the driver starts up.
 
-When compiled into the kernel, the addresses can be specified on the
+The force_ipmid parameter forcefully enables (if set to 1) or disables
+(if set to 0) the kernel IPMI daemon.  Normally this is auto-detected
+by the driver, but systems with broken interrupts might need an enable,
+or users that don't want the daemon (don't need the performance, don't
+want the CPU hit) can disable it.
+
+When compiled into the kernel, the parameters can be specified on the
 kernel command line as:
 
   ipmi_si.type=<type1>,<type2>...
@@ -419,6 +426,7 @@ kernel command line as:
        ipmi_si.regsizes=<size1>,<size2>,...
        ipmi_si.regshifts=<shift1>,<shift2>,...
        ipmi_si.slave_addrs=<addr1>,<addr2>,...
+       ipmi_si.force_kipmid=<enable1>,<enable2>,...
 
 It works the same as the module parameters of the same names.
 
Index: linux-2.6.18/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.18.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.18/drivers/char/ipmi/ipmi_si_intf.c
@@ -217,6 +217,11 @@ struct smi_info
 	struct list_head link;
 };
 
+#define SI_MAX_PARMS 4
+
+static int force_kipmid[SI_MAX_PARMS];
+static int num_force_kipmid = 0;
+
 static int try_smi_init(struct smi_info *smi);
 
 static ATOMIC_NOTIFIER_HEAD(xaction_notifier_list);
@@ -908,6 +913,7 @@ static int smi_start_processing(void    
 				ipmi_smi_t intf)
 {
 	struct smi_info *new_smi = send_info;
+	int             enable = 0;
 
 	new_smi->intf = intf;
 
@@ -917,10 +923,18 @@ static int smi_start_processing(void    
 	mod_timer(&new_smi->si_timer, jiffies + SI_TIMEOUT_JIFFIES);
 
 	/*
+	 * Check if the user forcefully enabled the daemon.
+	 */
+	if (new_smi->intf_num < num_force_kipmid)
+		enable = force_kipmid[new_smi->intf_num];
+	/*
 	 * The BT interface is efficient enough to not need a thread,
 	 * and there is no need for a thread if we have interrupts.
 	 */
- 	if ((new_smi->si_type != SI_BT) && (!new_smi->irq)) {
+ 	else if ((new_smi->si_type != SI_BT) && (!new_smi->irq))
+		enable = 1;
+
+	if (enable) {
 		new_smi->thread = kthread_run(ipmi_thread, new_smi,
 					      "kipmi%d", new_smi->intf_num);
 		if (IS_ERR(new_smi->thread)) {
@@ -948,7 +962,6 @@ static struct ipmi_smi_handlers handlers
 /* There can be 4 IO ports passed in (with or without IRQs), 4 addresses,
    a default IO port, and 1 ACPI/SPMI address.  That sets SI_MAX_DRIVERS */
 
-#define SI_MAX_PARMS 4
 static LIST_HEAD(smi_infos);
 static DEFINE_MUTEX(smi_infos_lock);
 static int smi_num; /* Used to sequence the SMIs */
@@ -1021,6 +1034,10 @@ MODULE_PARM_DESC(slave_addrs, "Set the d
 		 " the controller.  Normally this is 0x20, but can be"
 		 " overridden by this parm.  This is an array indexed"
 		 " by interface number.");
+module_param_array(force_kipmid, int, &num_force_kipmid, 0);
+MODULE_PARM_DESC(force_kipmid, "Force the kipmi daemon to be enabled (1) or"
+		 " disabled(0).  Normally the IPMI driver auto-detects"
+		 " this, but the value may be overridden by this parm.");
 
 
 #define IPMI_IO_ADDR_SPACE  0
