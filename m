Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTDKTJr (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTDKTJr (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:09:47 -0400
Received: from galileo.bork.org ([66.11.174.148]:18451 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261530AbTDKTJf (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:09:35 -0400
Date: Fri, 11 Apr 2003 15:21:16 -0400
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030411192116.GO3413@bork.org>
References: <20030407201337.GE28468@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407201337.GE28468@bork.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here is the next iteration of this patch.  This time it includes some
documentation as well as a sysctl interface and a kernel command line
option.

The patch is against 2.5-bk.

Any comments?
mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1184  -> 1.1186 
#	include/linux/kernel.h	1.35    -> 1.36   
#	     kernel/sysctl.c	1.41    -> 1.42   
#	include/linux/sysctl.h	1.42    -> 1.43   
#	     kernel/printk.c	1.24    -> 1.25   
#	               (new)	        -> 1.2     Documentation/printksubsystems.txt
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/11	mort@socrates.bork.org	1.1185
# Add printk subsystems.
# --------------------------------------------
# 03/04/11	mort@socrates.bork.org	1.1186
# Documentation updates.
# --------------------------------------------
#
diff -Nru a/Documentation/printksubsystems.txt b/Documentation/printksubsystems.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/printksubsystems.txt	Fri Apr 11 15:14:14 2003
@@ -0,0 +1,131 @@
+
+Printk Subsystems
+=================
+
+What and Why
+------------
+
+Printk subsystems were introduced to provide a mechanism to control
+which messages are actually logged into the fixed length printk buffer.
+As the Linux Kernel has been made to work on larger and larger 
+machines, the number of messages that are displayed on the console
+during bootup have increased also.  Certain subsystems are extremely
+verbose and are easily able to overflow the fixed length printk buffer.
+
+Although simply making the printk buffer larger is possible, this is 
+just a stop gap solution.  It was decided that there should be a 
+method to partition printk calls into different categories based
+on which subsystem they originate from so they can be filtered at 
+run time.  Please note that this depends on people using the KERN_*
+printk priority system.
+
+Printk subsystems are a benefit to anyone but are particularly useful 
+for those who maintain or have customers who maintain (for example)  
+large SMP machines, large NUMA machines, or machines with many SCSI 
+controllers and disks. They allow you to control how verbose each 
+subsystem is during normal operation.  If you run into a problem more 
+messages can be logged by increasing the loglevel for that particular 
+subsystem.  The main point is that all of the printk strings are still
+in the kernel, they just aren't placed into the printk log if they
+aren't high enough priority.
+
+
+
+How to use it
+-------------
+
+The way everyone currently calls printk is something like this:
+
+printk(KERN_NOTIFY "My message.  Value = %d\n", foo);
+
+Another set of flags have been added that assign the message to a
+particular printk subsystem.  Currently these are:
+
+PRINTK_UNASS     -- The default if no identifier is provided.
+PRINTK_CORE      -- For core messages (e.g., cpu messages, memory, etc.)
+PRINTK_SCSI      -- Messages related to SCSI.
+PRINTK_NET       -- Messages related to networking.
+PRINTK_USB       -- Messages related to USB.
+
+See include/linux/kernel.h for the latest list (just in case the above 
+isn't kept up-to-date).
+
+If the above printk was originating from somewhere in the network 
+hierarchy then the author should use:
+
+printk(PRINTK_NET KERN_NOTIFY "My message.  Value = %d\n", foo);
+
+
+
+Configuration Parameters
+------------------------
+
+Each of the printk subsystems has a set of parameters associated with it.
+These are the same values that are associated with the console loglevel
+(/proc/sys/kernel/printk).  There are 4 integer parameters:
+
+-Subsystem loglevel
+-Default message loglevel
+-Minimum console loglevel
+-Default console loglevel
+
+The filtering is very simple.  If the message that comes in is not assigned
+to a printk subsystem it is assigned to PRINTK_UNASS.  Then, if there
+is no priority (KERN_*) assigned to the message, it is given a the
+"default message loglevel" priority for the subsystem that the message
+originated from.  Finally, if the message loglevel value is less than the 
+subsystem loglevel value then the message is placed in the printk buffer.  
+It then makes it's way to other locations such as the console or syslog.  
+
+Note that the console_printk's "default message loglevel" is no longer used 
+because if a message has no KERN_* flag prepended to the message then it is 
+assigned the printk subsystem's default message loglevel, not the 
+console_printk's default message loglevel.
+
+These printk subsystem values are configurable through the sysctl interface.  
+The sysctl files associated with this are located in 
+/proc/sys/kernel/printk_subsystem/
+
+The subsystem loglevel is also configurable through a command line option.
+The latter three values are only configurable through sysctl.  If you 
+require a different initial value for any of the latter three values 
+you must recompile the kernel, changing the values of the prink_subsystem 
+array in kernel/printk.c
+
+To change the subsystem loglevel you simply provide a comma separated 
+list of values to the "printk_subsys" kernel command line option.  To
+use a default loglevel for a particular queue, assign the special value
+"-1".
+
+E.g., To set the threshold for unassigned, core and scsi to 6, 5, 4 
+(respectively) add the following to the kernel command line:
+
+printk_subsys=6,5,4
+
+E.g., To set the loglevel of core and net to 5 add the following:
+
+printk_subsys=-1,5,-1,5
+
+
+
+Adding a new printk subsystem
+-----------------------------
+
+1)  In include/linux/printk.h:
+  
+    - Add a new PRINTK_ define
+    - Modify LAST_PRINTK_SUBSYS
+    - Modify NUM_PRINTK_SUBSYSTEMS
+
+2)  In kernel/printk.c modify the printk_subsystem initializer if you
+    would like different defaults for the new printk subsystem.
+
+3)  In include/linux/sysctl.h add a new element to the enum with names
+    like PRINTK_SUBSYS_* that describes your new printk subsystem.
+
+4)  In kernel/sysctl.c add a new entry to the printk_subsys_table.
+
+Recompile and you should have a new printk subsystem available for use.
+
+--
+Martin Hicks <mort@wildopensource.com>  --  April 10, 2003
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Fri Apr 11 15:14:14 2003
+++ b/include/linux/kernel.h	Fri Apr 11 15:14:14 2003
@@ -47,6 +47,17 @@
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
+/* Printk subsystem identifiers */
+#define PRINTK_UNASS    "<A>"   /* unassigned printk subsystem          */
+#define PRINTK_CORE     "<B>"   /* from the core kernel                 */
+#define PRINTK_SCSI     "<C>"   /* from the SCSI subsystem              */
+#define PRINTK_NET      "<D>"   /* from the Net subsystem               */
+#define PRINTK_USB      "<E>"   /* from the USB subsystem               */
+
+#define FIRST_PRINTK_SUBSYS PRINTK_UNASS[1]
+#define LAST_PRINTK_SUBSYS PRINTK_USB[1]
+#define NUM_PRINTK_SUBSYSTEMS 5
+
 struct completion;
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Fri Apr 11 15:14:14 2003
+++ b/include/linux/sysctl.h	Fri Apr 11 15:14:14 2003
@@ -130,6 +130,7 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+        KERN_PRINTK_SUBSYS=58,  /* intvec: controls printk subsystem log levels */
 };
 
 
@@ -190,6 +191,16 @@
 	RANDOM_WRITE_THRESH=4,
 	RANDOM_BOOT_ID=5,
 	RANDOM_UUID=6
+};
+
+/* /proc/sys/kernel/prink_subsystem */
+enum
+{
+        PRINTK_SUBSYS_UNASS=1,
+        PRINTK_SUBSYS_CORE=2,
+        PRINTK_SUBSYS_SCSI=3,
+        PRINTK_SUBSYS_NET=4,
+        PRINTK_SUBSYS_USB=5,
 };
 
 /* /proc/sys/bus/isa */
diff -Nru a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	Fri Apr 11 15:14:14 2003
+++ b/kernel/printk.c	Fri Apr 11 15:14:14 2003
@@ -42,6 +42,9 @@
 #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */
 #define DEFAULT_CONSOLE_LOGLEVEL 7 /* anything MORE serious than KERN_DEBUG */
 
+#define MINIMUM_SUBSYS_LOGLEVEL 1
+#define DEFAULT_SUBSYS_LOGLEVEL 8
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
 int console_printk[4] = {
@@ -51,6 +54,19 @@
 	DEFAULT_CONSOLE_LOGLEVEL,	/* default_console_loglevel */
 };
 
+/*  [][0] == subsystem log level
+ *  [][1] == default message loglevel
+ *  [][2] == minimum subsystem loglevel
+ *  [][3] == default subsystem loglevel */
+int printk_subsystem[NUM_PRINTK_SUBSYSTEMS][4] = {  
+        [0 ... NUM_PRINTK_SUBSYSTEMS-1] = { 
+                DEFAULT_SUBSYS_LOGLEVEL,
+                DEFAULT_MESSAGE_LOGLEVEL,
+                MINIMUM_SUBSYS_LOGLEVEL,
+                DEFAULT_SUBSYS_LOGLEVEL
+        }
+};
+
 int oops_in_progress;
 
 /*
@@ -141,6 +157,27 @@
 
 __setup("console=", console_setup);
 
+
+/*
+ *   Process the command line arguments for the printk subsystems.
+ */
+static int __init printk_subsys_setup(char *str)
+{
+        int i, ret, val;
+
+        for (i = 0; i < NUM_PRINTK_SUBSYSTEMS; i++) {
+                ret = get_option(&str, &val);
+                if (!ret)
+                        break;
+                if (val >= 0 && val <= 8)
+                        printk_subsystem[i][0] = val;
+        }
+
+        return 1;
+}
+
+__setup("printk_subsys=", printk_subsys_setup);
+
 /*
  * Commands to do_syslog:
  *
@@ -390,10 +427,11 @@
 {
 	va_list args;
 	unsigned long flags;
-	int printed_len;
+	int printed_len, msg_log_level, msg_subsystem, i;
 	char *p;
 	static char printk_buf[1024];
-	static int log_level_unknown = 1;
+	static int begin_message = 1;
+        
 
 	if (oops_in_progress) {
 		/* If a crash is occurring, make sure we can't deadlock */
@@ -409,23 +447,45 @@
 	va_start(args, fmt);
 	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
 	va_end(args);
-
+        
 	/*
-	 * Copy the output into log_buf.  If the caller didn't provide
-	 * appropriate log level tags, we insert them here
+	 * Copy the output into log_buf.
 	 */
-	for (p = printk_buf; *p; p++) {
-		if (log_level_unknown) {
-			if (p[0] != '<' || p[1] < '0' || p[1] > '7' || p[2] != '>') {
+        p = printk_buf;
+	while (*p) {
+		if (begin_message) {
+                        /* Figure out if there is zero, one or two flags */
+                        msg_log_level = -1;
+                        msg_subsystem = 0;  /* A - Unassigned */
+                        for (i = 0; i < 2; i++) {
+				if (p[0] == '<' && p[2] == '>') {
+                                	if (p[1] >= '0' && p[1] <= '7')
+                                        	msg_log_level = p[1] - '0';
+                                	if (p[1] >= FIRST_PRINTK_SUBSYS && 
+                                            p[1] <= LAST_PRINTK_SUBSYS)
+                                        	msg_subsystem = p[1] - FIRST_PRINTK_SUBSYS;
+				} else 
+					break;
+				p+=3;
+			}
+
+                        /* Decide if we print this message at all */
+                        if (msg_log_level == -1)
+                                msg_log_level = printk_subsystem[msg_subsystem][1];
+                                
+                        if (msg_log_level < printk_subsystem[msg_subsystem][0]) {
+                                begin_message = 0;
 				emit_log_char('<');
-				emit_log_char(default_message_loglevel + '0');
+                                emit_log_char(msg_log_level + '0');
 				emit_log_char('>');
+                        } else { // Get out of this loop.  Don't log anything.
+                                break;
 			}
-			log_level_unknown = 0;
 		}
 		emit_log_char(*p);
 		if (*p == '\n')
-			log_level_unknown = 1;
+			begin_message = 1;
+                p++;
 	}
 
 	if (!cpu_online(smp_processor_id())) {
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Fri Apr 11 15:14:14 2003
+++ b/kernel/sysctl.c	Fri Apr 11 15:14:14 2003
@@ -57,6 +57,7 @@
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int printk_subsystem[][4];
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -122,6 +123,7 @@
 static ctl_table debug_table[];
 static ctl_table dev_table[];
 extern ctl_table random_table[];
+static ctl_table printk_subsys_table[];
 
 /* /proc declarations: */
 
@@ -265,6 +267,7 @@
 	 0600, NULL, &proc_dointvec},
 	{KERN_PANIC_ON_OOPS,"panic_on_oops",
 	 &panic_on_oops,sizeof(int),0644,NULL,&proc_dointvec},
+        {KERN_PRINTK_SUBSYS, "printk_subsystem", NULL, 0, 0555, printk_subsys_table},
 	{0}
 };
 
@@ -363,6 +366,20 @@
 static ctl_table dev_table[] = {
 	{0}
 };  
+
+static ctl_table printk_subsys_table[] = {
+        {PRINTK_SUBSYS_UNASS, "unassigned", printk_subsystem[0], 4*sizeof(int), 
+         0644, NULL, &proc_dointvec},
+        {PRINTK_SUBSYS_CORE, "core", printk_subsystem[1], 4*sizeof(int),
+         0644, NULL, &proc_dointvec},
+        {PRINTK_SUBSYS_SCSI, "scsi", printk_subsystem[2], 4*sizeof(int),
+         0644, NULL, &proc_dointvec},
+        {PRINTK_SUBSYS_NET, "net", printk_subsystem[3], 4*sizeof(int),
+         0644, NULL, &proc_dointvec},
+        {PRINTK_SUBSYS_USB, "usb", printk_subsystem[4], 4*sizeof(int),
+         0644, NULL, &proc_dointvec},
+        {0}
+};
 
 extern void init_irq_proc (void);
 
