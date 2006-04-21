Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWDUCcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWDUCcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWDUCb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:31:57 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:16831 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWDUCZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:19 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:18 -0700
Message-Id: <20060421022518.6145.32158.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 12/12] Documentation for CKRM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12/12 - ckrm_docs

Documentation describing important CKRM elements such as classes, shares,
controllers, and the interface provided to userspace via RCFS
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 Documentation/ckrm/ckrm_basics  |   65 ++++++++++++++++++++++++++++++++++++++++
 Documentation/ckrm/ckrm_install |   54 +++++++++++++++++++++++++++++++++
 Documentation/ckrm/ckrm_usage   |   52 ++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)

Index: linux-2.6.16/Documentation/ckrm/ckrm_basics
===================================================================
--- /dev/null
+++ linux-2.6.16/Documentation/ckrm/ckrm_basics
@@ -0,0 +1,65 @@
+CKRM Basics
+-------------
+A brief review of CKRM concepts and terminology will help make installation
+and testing easier. For more details, please visit http://ckrm.sf.net.
+
+Concept:
+User defines a class, associate some amount of resources to the class, and
+associates tasks with the class. Tasks belonging to that class will be
+bound by the amount of resources that are assigned to that class.
+
+RCFS depicts a CKRM class as a directory. Hierarchy of classes can be
+created in which children of a class share resources allotted to
+the parent. Tasks can be classified to any class which is at any level.
+There is no correlation between parent-child relationship of tasks and
+the parent-child relationship of classes they belong to.
+
+During fork(), class is inherited by a task. A privileged user can
+reassign a task to any class.
+
+Characteristics of a class can be accessed/changed through the following
+files under the directory representing the class:
+
+shares:  allows changing shares of different resource managed by the class
+stats:   shows statistics associated with each resource managed by the class
+members: allows assignment of tasks to a class and shows tasks that are
+         assigned to a class.
+
+Resource allocation of a class is proportional to the amount of resources
+available to the class's parent.
+Resource allocation for a class is controlled by the parameters:
+
+min_shares: Minimum amount shares that can be allocated by a class. A
+            special value of DONT_CARE(-3) means that there is no minimum
+	    shares of a resource specified. This class may not get
+	    any resource if the system is running short on resources.
+max_shares: Specifies the maximum amount of resource that is allowed to be
+           allocated by a class. A special value DONT_CARE(-3) means
+	   there is no specific limit is specified, this class can get all
+	   the resources available.
+child_shares_divisor: total guarantee that is allowed among the children of
+           this class. In other words, the sum of "guarantee"s of all
+	   children of this class cannot exceed this number.
+
+Any of these parameters can have a special value, UNSUPPORTED(-2) meaning
+that the specific controller does not support this parameter. User
+request to change the value will be ignored.
+
+None of these parameters neither absolute nor have any units associated with
+them. These are just numbers that are used to calculate the absolute number
+of resource available for a specific class.
+
+In order to make them independent of the type of resource and handle
+complexities like hotplug none of these parameters have units associated
+with them. Furthermore they are not percentages. They are called shares
+because an appropriate analogy would be shares in a stock market.
+
+The absolute amount (for example no. of tasks) of minimum shares available
+for a class is calculuated as:
+
+	absolute minimum shares = (parent's absolute amount of resource) *
+			(class's min_shares / parent's child_shares_divisor)
+
+Maximum shares is also calculated in the same way.
+
+Root class is allocated all the resources available in the system. In other
Index: linux-2.6.16/Documentation/ckrm/ckrm_install
===================================================================
--- /dev/null
+++ linux-2.6.16/Documentation/ckrm/ckrm_install
@@ -0,0 +1,54 @@
+Kernel installation
+------------------------------
+
+<kernver> = version of mainline Linux kernel
+<ckrmver> = version of CKRM
+
+Note: It is expected that CKRM versions will change often. Hence once
+a CKRM version has been released for some <kernver>, it will only be made
+available for future <kernver>'s until the next CKRM version is released.
+
+Patches released will specify which version of kernel source that patchset
+is released against.
+
+Core patches will be released in two formats
+	1. set of patches with a series file (to be used with quilt)
+	2. a single patch that is inclusive of all the core patches.
+
+Controler patches will be released as a set. An excpetion would be the
+numtasks controller which would be released as part of the core patchset.
+
+1. Patch
+
+    Apply ckrm-single-<ckrmversion>.patch to a mainline kernel
+    tree with version <kernver>.
+
+2. Configure
+
+Select appropriate configuration options:
+
+   Enable configfs filesystem:
+   File systems --->
+     Pseudo filesystems --->
+       <M> Userspace-driven configuration filesystem (EXPERIMENTAL)
+
+   Enable CKRM components:
+   General Setup --->
+     Class Based Kernel Resource Management --->
+        [*] Class Based Kernel Resource Management Core
+        <M> Resource Class File System (User API)
+        [*]     Number of Tasks Resource Manager
+
+
+3. Build, boot the kernel
+
+4. Enable rcfs
+
+    # insmod <patchestree>/fs/configfs/configfs.ko # if compiled as module
+    # insmod <patchedtree>/kernel/ckrm/ckrm_rcfs.ko # if compiled in as module
+    # mount -t configfs none /config
+
+    This will create the directory /config/ckrm which is the root of classes.
+
+5. Work with class hierarchy as explained in the file ckrm_usage
+
Index: linux-2.6.16/Documentation/ckrm/ckrm_usage
===================================================================
--- /dev/null
+++ linux-2.6.16/Documentation/ckrm/ckrm_usage
@@ -0,0 +1,52 @@
+Usage of CKRM
+-------------
+
+1. Create a class
+
+   # mkdir /config/ckrm/c1
+   creates a class named c1 , while
+
+The newly created class directory is automatically populated by magic files
+shares, stats, members, and attrib.
+
+2. View default shares of a class
+
+   # cat /config/ckrm/c1/shares
+   min_shares=-3,max_shares=-3,child_total_divisor=100
+
+   Above is the default value set for resources that have controllers
+   registered with CKRM.
+
+3. change shares of a specific resource in a class
+
+   One or more of the following fields can/must be specified
+       res=<res_name> #mandatory
+       min_shares=<number>
+       max_shares=<number>
+       child_total_divisor=<number>
+   e.g.
+	# echo "res=numtasks,max_shares=20" > /config/ckrm/c1/shares
+
+   If any of these parameters are not specified, the current value will be
+   retained.
+
+4. Reclassify a task
+
+   write the pid of the process to the destination class' members file
+   # echo 1004 > /config/ckrm/c1/members
+
+5. Get a list of tasks assigned to a class
+
+   # cat /config/ckrm/c1/members
+   lists pids of tasks belonging to c1
+
+6. Get statictics of different resources of a class
+
+   # cat /config/ckrm/c1/stats
+   shows c1's statistics for each registered resource controller.
+
+7. Configuration settings for controllers
+   Configuration values for controller are available through module
+   parameter interfaces. Consult the controller specific documents for
+   details. For example, numtasks has it available through
+   /sys/module/ckrm_numtasks/parameters.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
