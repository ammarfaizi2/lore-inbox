Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUK2TdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUK2TdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUK2TdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:33:17 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16042 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261576AbUK2SzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:55:16 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM: 10/10 CKRM:  Documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19888.1101754307.1@us.ibm.com>
Date: Mon, 29 Nov 2004 10:51:47 -0800
Message-Id: <E1CYqcl-0005Ap-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds all current documentation on CKRM.

Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@us.ibm.com>
Signed-Off-By: Vivek Kashyap <vivk@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Index: linux-2.6.10-rc2/Documentation/ckrm/ckrm_basics
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/Documentation/ckrm/ckrm_basics	2004-11-19 20:50:04.013932163 -0800
@@ -0,0 +1,66 @@
+CKRM Basics
+-------------
+A brief review of CKRM concepts and terminology will help make installation
+and testing easier. For more details, please visit http://ckrm.sf.net. 
+
+Currently there are two class types, taskclass and socketclass for grouping,
+regulating and monitoring tasks and sockets respectively.
+
+To avoid repeating instructions for each classtype, this document assumes a
+task to be the kernel object being grouped. By and large, one can replace task
+with socket and taskclass with socketclass.
+
+RCFS depicts a CKRM class as a directory. Hierarchy of classes can be
+created in which children of a class share resources allotted to
+the parent. Tasks can be classified to any class which is at any level.
+There is no correlation between parent-child relationship of tasks and
+the parent-child relationship of classes they belong to.
+
+Without a Classification Engine, class is inherited by a task. A privileged
+user can reassigned a task to a class as described below, after which all
+the child tasks under that task will be assigned to that class, unless the
+user reassigns any of them.
+
+A Classification Engine, if one exists, will be used by CKRM to
+classify a task to a class. The Rule based classification engine uses some
+of the attributes of the task to classify a task. When a CE is present
+class is not inherited by a task.
+
+Characteristics of a class can be accessed/changed through the following magic
+files under the directory representing the class:
+
+shares:  allows to change the shares of different resources managed by the
+         class
+stats:   allows to see the statistics associated with each resources managed
+         by the class
+target:  allows to assign a task to a class. If a CE is present, assigning
+         a task to a class through this interface will prevent CE from
+		 reassigning the task to any class during reclassification.
+members: allows to see which tasks has been assigned to a class
+config:  allow to view and modify configuration information of different
+         resources in a class.
+
+Resource allocations for a class is controlled by the parameters:
+
+guarantee: specifies how much of a resource is guranteed to a class. A
+           special value DONT_CARE(-2) mean that there is no specific
+	   guarantee of a resource is specified, this class may not get
+	   any resource if the system is runing short of resources
+limit:     specifies the maximum amount of resource that is allowed to be
+           allocated by a class. A special value DONT_CARE(-2) mean that
+	   there is no specific limit is specified, this class can get all
+	   the resources available.
+total_guarantee: total guarantee that is allowed among the children of this
+           class. In other words, the sum of "guarantee"s of all children
+	   of this class cannot exit this number.
+max_limit: Maximum "limit" allowed for any of this class's children. In
+	   other words, "limit" of any children of this class cannot exceed
+	   this value.
+
+None of this parameters are absolute or have any units associated with
+them. These are just numbers(that are relative to its parents') that are
+used to calculate the absolute number of resource available for a specific
+class.
+
+Note: The root class has an absolute number of resource units associated with it.
+
Index: linux-2.6.10-rc2/Documentation/ckrm/core_usage
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/Documentation/ckrm/core_usage	2004-11-19 20:50:04.017931529 -0800
@@ -0,0 +1,72 @@
+Usage of CKRM without a classification engine
+-----------------------------------------------
+
+1. Create a class
+
+   # mkdir /rcfs/taskclass/c1
+   creates a taskclass named c1 , while
+   # mkdir /rcfs/socket_class/s1
+   creates a socketclass named s1 
+
+The newly created class directory is automatically populated by magic files
+shares, stats, members, target and config.
+
+2. View default shares 
+
+   # cat /rcfs/taskclass/c1/shares
+
+   "guarantee=-2,limit=-2,total_guarantee=100,max_limit=100" is the default
+   value set for resources that have controllers registered with CKRM.
+
+3. change shares of a <class>
+
+   One or more of the following fields can/must be specified
+       res=<res_name> #mandatory
+       guarantee=<number>
+       limit=<number>
+       total_guarantee=<number>
+       max_limit=<number>
+   e.g.
+	# echo "res=numtasks,limit=20" > /rcfs/taskclass/c1
+
+   If any of these parameters are not specified, the current value will be
+   retained. 
+
+4. Reclassify a task (listening socket)
+
+   write the pid of the process to the destination class' target file
+   # echo 1004 > /rcfs/taskclass/c1/target	
+
+   write the "<ipaddress>\<port>" string to the destination class' target file 
+   # echo "0.0.0.0\32770"  > /rcfs/taskclass/c1/target
+
+5. Get a list of tasks (sockets) assigned to a taskclass (socketclass)
+
+   # cat /rcfs/taskclass/c1/members
+   lists pids of tasks belonging to c1
+
+   # cat /rcfs/socket_class/s1/members
+   lists the ipaddress\port of all listening sockets in s1 
+
+6. Get the statictics of different resources of a class
+
+   # cat /rcfs/tasksclass/c1/stats
+   shows c1's statistics for each resource with a registered resource
+   controller.
+
+   # cat /rcfs/socket_class/s1/stats
+   show's s1's stats for the listenaq controller.	
+
+7. View the configuration values of the resources associated with a class
+
+   # cat /rcfs/taskclass/c1/config
+   shows per-controller config values for c1.
+
+8. Change the configuration values of resources associated with a class
+   Configuration values are different for different resources. the comman
+   field "res=<resname>" must always be specified.
+
+   # echo "res=numtasks,parameter=value" > /rcfs/taskclass/c1/config
+   to change (without any effect), the value associated with <parameter>.
+
+
Index: linux-2.6.10-rc2/Documentation/ckrm/crbce
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/Documentation/ckrm/crbce	2004-11-19 20:50:04.020931054 -0800
@@ -0,0 +1,33 @@
+CRBCE
+----------
+
+crbce is a superset of rbce. In addition to providing automatic
+classification, the crbce module
+- monitors per-process delay data that is collected by the delay 
+accounting patch
+- collects data on significant kernel events where reclassification
+could occur e.g. fork/exec/setuid/setgid etc., and
+- uses relayfs to supply both these datapoints to userspace
+
+To illustrate the utility of the data gathered by crbce, we provide a
+userspace daemon called crbcedmn that prints the header info received
+from the records sent by the crbce module.
+
+0. Ensure that a CKRM-enabled kernel with following options configured
+   has been compiled. At a minimum, core, rcfs, atleast one classtype,
+   delay-accounting patch and relayfs. For testing, it is recommended
+   all classtypes and resource controllers be compiled as modules.
+
+1. Ensure that the Makefile's BUILD_CRBCE=1 and KDIR points to the
+   kernel of step 1 and call make.
+   This also builds the userspace daemon, crbcedmn.
+
+2..9 Same as rbce installation and testing instructions, 
+     except replacing rbce.ko with crbce.ko
+
+10. Read the pseudo daemon help file
+    # ./crbcedmn -h
+
+11. Run the crbcedmn to display all records being processed
+    # ./crbcedmn 
+
Index: linux-2.6.10-rc2/Documentation/ckrm/installation
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/Documentation/ckrm/installation	2004-11-19 20:50:04.023930579 -0800
@@ -0,0 +1,70 @@
+Kernel installation
+------------------------------
+
+<kernver> = version of mainline Linux kernel
+<ckrmver> = version of CKRM
+
+Note: It is expected that CKRM versions will change fairly rapidly. Hence once
+a CKRM version has been released for some <kernver>, it will only be made
+available for future <kernver>'s until the next CKRM version is released. 
+
+1. Patch 
+
+    Apply ckrm/kernel/<kernver>/ckrm-<ckrmversion>.patch to a mainline kernel
+    tree with version <kernver>. 
+
+    If CRBCE will be used, additionally apply the following patches, in order: 
+       delayacctg-<ckrmversion>.patch 
+       relayfs-<ckrmversion>.patch
+    
+ 
+2. Configure
+
+Select appropriate configuration options:
+
+a. for taskclasses 
+
+   General Setup-->Class Based Kernel Resource Management
+
+   [*] Class Based Kernel Resource Management
+   <M> Resource Class File System (User API)
+   [*]   Class Manager for Task Groups  
+   <M>     Number of Tasks Resource Manager
+
+b. To test socket_classes and multiple accept queue controller 
+
+   General Setup-->Class Based Kernel Resource Management
+   [*] Class Based Kernel Resource Management
+   <M> Resource Class File System (User API)
+   [*]   Class Manager for socket groups
+   <M>     Multiple Accept Queues Resource Manager    
+   
+   Device Drivers-->Networking Support-->Networking options-->
+   [*] Network packet filtering (replaces ipchains)  
+   [*] IP: TCP Multiple accept queues support
+
+c. To test CRBCE later (requires 2a.)
+
+   File Systems-->Pseudo filesystems-->
+   <M> Relayfs filesystem support 
+   (enable all sub fields)
+   
+   General Setup-->
+   [*] Enable delay accounting
+   
+
+3. Build, boot into kernel
+
+4. Enable rcfs
+
+    # insmod <patchedtree>/fs/rcfs/rcfs.ko
+    # mount -t rcfs rcfs /rcfs
+ 
+    This will create the directories /rcfs/taskclass and
+    /rcfs/socketclass which are the "roots" of subtrees for creating
+    taskclasses and socketclasses respectively.
+  	
+5. Load numtasks and listenaq controllers
+
+    # insmod <patchedtree>/kernel/ckrm/ckrm_tasks.ko
+    # insmod <patchedtree>/kernel/ckrm/ckrm_listenaq.ko
Index: linux-2.6.10-rc2/Documentation/ckrm/rbce_basics
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/Documentation/ckrm/rbce_basics	2004-11-19 20:50:04.026930104 -0800
@@ -0,0 +1,67 @@
+Rule-based Classification Engine (RBCE)
+-------------------------------------------
+
+The ckrm/rbce directory contains the sources for two classification engines
+called rbce and crbce. Both are optional, built as kernel modules and share much
+of their codebase. Only one classification engine (CE) can be loaded at a time
+in CKRM.
+
+
+With RBCE, user can specify rules for how tasks are classified to a
+class.  Rules are specified by one or more attribute-value pairs and
+an associated class. The tasks that match all the attr-value pairs
+will get classified to the class attached with the rule.
+
+The file rbce_info under /rcfs/ce directory details the functionality
+of different files available under the directory and also details
+about attributes that can are used to define rules.
+
+order: When multiple rules are defined the rules are executed
+	   according to the order of a rule. Order can be specified
+	   while defining a rule.  If order is not specified, the
+	   highest order will be assigned to the rule(i.e, the new
+	   rule will be executed after all the previously defined
+	   evaluate false). So, order of rules is important as that
+	   will decide, which class a task will get assigned to. For
+	   example, if we have the two following rules: r1:
+	   uid=1004,order=10,class=/rcfs/taskclass/c1 r2:
+	   uid=1004,cmd=grep,order=20,class=/rcfs/taskclass/c2 then,
+	   the task "grep" executed by user 1004 will always be
+	   assigned to class /rcfs/taskclass/c1, as rule r1 will be
+	   executed before r2 and the task successfully matched the
+	   rule's attr-value pairs. Rule r2 will never be consulted
+	   for the command.  Note: The order in which the rules are
+	   displayed(by ls) has no correlation with the order of the
+	   rule.
+
+dependency: Rules can be defined to be depend on another rule. i.e a
+	   rule can be dependent on one rule and has its own
+	   additional attr-value pairs. the dependent rule will
+	   evaluate true only if all the attr-value pairs of both
+	   rules are satisfied.  ex: r1: gid=502,class=/rcfs/taskclass
+	   r2: depend=r1,cmd=grep,class=rcfstaskclass/c1 r2 is a
+	   dependent rule that depends on r1, a task will be assigned
+	   to /rcfs/taskclass/c1 if its gid is 502 and the executable
+	   command name is "grep". If a task's gid is 502 but the
+	   command name is _not_ "grep" then it will be assigned to
+	   /rcfs/taskclass
+
+	   Note: The order of dependent rule must be _lesser_ than the
+	   rule it depends on, so that it is evaluated _before the
+	   base rule is evaluated. Otherwise the base rule will
+	   evaluate true and the task will be assigned to the class of
+	   that rule without the dependent rule ever getting
+	   evaluated. In the example above, order of r2 must be lesser
+	   than order of r1.
+
+app_tag: a task can be attached with a tag(ascii string), that becomes
+	   an attribute of that task and rules can be defined with the
+	   tag value.
+
+state: states are at two levels in RBCE. The entire RBCE can be
+	   enabled or disabled which writing 1 or 0 to the file
+	   rbce_state under /rcfs/ce.  Disabling RBCE, would mean that
+	   the rules defined in RBCE will not be utilized for
+	   classifying a task to a class.  A specific rule can be
+	   enabled/disabled by changing the state of that rule. Once
+	   it is disabled, the rule will not be evaluated.
Index: linux-2.6.10-rc2/Documentation/ckrm/rbce_usage
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2/Documentation/ckrm/rbce_usage	2004-11-19 20:50:04.030929470 -0800
@@ -0,0 +1,98 @@
+Usage of CKRM with RBCE
+--------------------------
+
+0. Ensure that a CKRM-enabled kernel with following options configured
+   has been compiled. At a minimum, core, rcfs and atleast one
+   classtype. For testing, it is recommended all classtypes and
+   resource controllers be compiled as modules.
+
+1. Change ckrm/rbce/Makefile's KDIR to point to this compiled kernel's source
+   tree and call make
+
+2. Load rbce module.
+   # insmod ckrm/rbce/rbce.ko 
+   Note that /rcfs has to be mounted before this.
+   Note: this command should populate the directory /rcfs/ce with files
+   rbce_reclassify, rbce_tag, rbce_info, rbce_state and a directory
+   rules.
+
+   Note2: If these are not created automatically, just create them by
+   using the commands touch and mkdir.(bug that needs to be fixed)
+
+3. Defining a rule
+   Rules are defined by creating(by writing) to a file under the
+   /rcfs/ce/rules directory by concatinating multiple attribute value
+   pairs.
+
+   Note that the classes must be defined before defining rules that
+   uses the classes.  eg: the command # echo
+   "uid=1004,class=/rcfs/taskclass/c1" > /rcfs/ce/rules/r1 will define
+   a rule r1 that classifies all tasks belong to user id 1004 to class
+   /rcfs/taskclass/c1
+
+4. Viewing a rule
+   read the corresponding file.
+   to read rule r1, issue the command:
+      # cat /rcfs/ce/rules/r1
+
+5. Changing a rule
+
+   Changing a rule is done the same way as defining a rule, the new
+   rule will include the old set of attr-value pairs slapped with new
+   attr-value pairs.  eg: if the current r2 is
+   uid=1004,depend=r1,class=/rcfs/taskclass/c1
+   (r1 as defined in step 3)
+
+   the command:
+     # echo gid=502 > /rcfs/ce/rules/r1
+   will change the rule to
+     r1: uid=1004,gid=502,depend=r1,class=/rcfs/taskclass/c1
+
+   the command:
+     # echo uid=1005 > /rcfs/ce/rules/r1
+   will change the rule to
+     r1: uid=1005,class=/rcfs/taskclass/c1
+
+   the command:
+     # echo class=/rcfs/taskclass/c2 > /rcfs/ce/rules/r1
+   will change the rule to
+     r1: uid=1004,depend=r1,class=/rcfs/taskclass/c2
+   
+   the command:
+     # echo depend=r4 > /rcfs/ce/rules/r1
+   will change the rule to
+     r1: uid=1004,depend=r4,class=/rcfs/taskclass/c2
+   
+   the command:
+     # echo +depend=r4 > /rcfs/ce/rules/r1
+   will change the rule to
+     r1: uid=1004,depend=r1,depend=r4,class=/rcfs/taskclass/c2
+   
+   the command:
+     # echo -depend=r1 > /rcfs/ce/rules/r1
+   will change the rule to
+     r1: uid=1004,class=/rcfs/taskclass/c2
+
+6. Checking the state of RBCE
+   State(enabled/disabled) of RBCE can be checked by reading the file
+   /rcfs/ce/rbce_state, it will show 1(enabled) or 0(disabled).
+   By default, RBCE is enabled(1).
+   ex: # cat /rcfs/ce/rbce_state
+
+7. Changing the state of RBCE
+   State of RBCE can be changed by writing 1(enable) or 0(disable).
+   ex: # echo 1 > cat /rcfs/ce/rbce_state
+
+8. Checking the state of a rule
+   State of a rule is displayed in the rule. Rule can be viewed by
+   reading the rule file.  ex: # cat /rcfs/ce/rules/r1
+
+9. Changing the state of a rule
+
+   State of a rule can be changed by writing "state=1"(enable) or
+   "state=0"(disable) to the corresponding rule file. By defeault, the
+   rule is enabled when defined.  ex: to disable an existing rule r1,
+   issue the command 
+   # echo "state=0" > /rcfs/ce/rules/r1
+
+
Index: linux-2.6.10-rc2/kernel/ckrm/Makefile
===================================================================
--- linux-2.6.10-rc2.orig/kernel/ckrm/Makefile	2004-11-19 20:49:58.362827447 -0800
+++ linux-2.6.10-rc2/kernel/ckrm/Makefile	2004-11-19 20:50:04.033928995 -0800
@@ -3,9 +3,9 @@
 #
 
 ifeq ($(CONFIG_CKRM),y)
-    obj-y = ckrm_events.o ckrm.o ckrmutils.o rbce/
+    obj-y = ckrm_events.o ckrm.o ckrmutils.o ckrm_numtasks_stub.o rbce/
 endif	
-obj-$(CONFIG_CKRM_TYPE_TASKCLASS)  += ckrm_tc.o ckrm_numtasks_stub.o
+obj-$(CONFIG_CKRM_TYPE_TASKCLASS)  += ckrm_tc.o
 obj-$(CONFIG_CKRM_TYPE_SOCKETCLASS)  += ckrm_sockc.o
 obj-$(CONFIG_CKRM_RES_NUMTASKS)     += ckrm_numtasks.o
 obj-$(CONFIG_CKRM_RES_LISTENAQ)     += ckrm_listenaq.o
