Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTFFVjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTFFVja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:39:30 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:59800 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S262298AbTFFVic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:38:32 -0400
Date: Fri, 6 Jun 2003 23:51:59 +0200
To: linux-kernel@vger.kernel.org
Subject: [RFC] machine_reboot and friends
Message-ID: <20030606215159.GB10721@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19OP7v-00030z-00*dcLXji2/jZg*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a thought:

What if machine_restart/machine_halt/machine_power_off were made
functionpointers instead? And let the architectures assign to them
instead of defining the functions? Some architectures are already
doing this. (There should be no problems with races or so, they are
assigned early in the boot, and used at shutdowntime. And letting modules
assign them wouldn't work in the ideal world where modules are
deinitialized at shutdown)

A bit orthogonal: Different architechtures do different things if the action
fails (or is unimplemented), some panic, some return, some do "for(;;);",
isn't it about time someone defined the semantics for these functions?

I mean something like the following, modulo changes to architechtures...

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/


--- 1.3/include/linux/reboot.h	Thu Dec  5 02:05:34 2002
+++ edited/include/linux/reboot.h	Fri Jun  6 21:07:01 2003
@@ -44,9 +44,9 @@
  * Architecture-specific implementations of sys_reboot commands.
  */
 
-extern void machine_restart(char *cmd);
-extern void machine_halt(void);
-extern void machine_power_off(void);
+extern void (*machine_restart)(char *cmd);
+extern void (*machine_halt)(void);
+extern void (*machine_power_off)(void);
 
 #endif
 
--- 1.45/kernel/sys.c	Sun May 25 23:08:02 2003
+++ edited/kernel/sys.c	Fri Jun  6 21:32:14 2003
@@ -63,6 +63,14 @@
 int fs_overflowgid = DEFAULT_FS_OVERFLOWUID;
 
 /*
+ * These callbacks define archspecific behaviour.
+ */
+void (*machine_restart)(char *cmd);
+void (*machine_halt)(void);
+void (*machine_power_off)(void);
+void (*pm_power_off)(void);
+
+/*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
  */
 
@@ -403,7 +411,8 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
-		machine_restart(NULL);
+		if(machine_restart)
+			machine_restart(NULL);
 		break;
 
 	case LINUX_REBOOT_CMD_CAD_ON:
@@ -419,7 +428,8 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
-		machine_halt();
+		if(machine_halt)
+			machine_halt();
 		unlock_kernel();
 		do_exit(0);
 		break;
@@ -429,7 +439,10 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
-		machine_power_off();
+		if(machine_power_off)
+			machine_power_off();
+		if(pm_power_off)
+			pm_power_off();
 		unlock_kernel();
 		do_exit(0);
 		break;
@@ -445,7 +458,9 @@
 		system_running = 0;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
-		machine_restart(buffer);
+		
+		if(machine_restart)
+			machine_restart(buffer);
 		break;
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
@@ -470,7 +485,8 @@
 static void deferred_cad(void *dummy)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-	machine_restart(NULL);
+	if(machine_restart)
+		machine_restart(NULL);
 }
 
 /*
@@ -1414,3 +1430,4 @@
 EXPORT_SYMBOL(unregister_reboot_notifier);
 EXPORT_SYMBOL(in_group_p);
 EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL(pm_power_off);


