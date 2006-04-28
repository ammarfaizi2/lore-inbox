Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWD1Bmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWD1Bmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWD1Bfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:35:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:7067 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030243AbWD1BfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:18 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:17 -0700
Message-Id: <20060428013517.27212.32432.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
References: <20060428013410.27212.45968.sendpatchset@localhost.localdomain>
Subject: [PATCH 12/12] Documentation for Resource Groups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12/12 - res_groups_docs

Documentation describing important Resource Groups components such as
resource group, shares, controllers, and the configfs based user interface.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Hubertus Franke <frankeh@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>
Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 res_groups_basics  |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 res_groups_install |   29 +++++++++++++++++++++
 res_groups_usage   |   53 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)

Index: linux-2617-rc3/Documentation/res_groups/res_groups_basics
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/Documentation/res_groups/res_groups_basics	2006-04-27 10:18:48.000000000 -0700
@@ -0,0 +1,71 @@
+Resource Groups Basics
+-------------
+A brief review of Resoruce Groups concepts and terminology will help make
+installation and testing easier. For more details, please visit
+http://ckrm.sf.net.
+
+Concept:
+User defines a resource group, attaches some amount of resources to
+the resource group, and associates tasks with that resource group. Tasks
+belonging to that resource group will be bound by the amount of resource
+that is assigned to that group.
+
+User interface for the Resource Groups is through configfs. Resource group
+is depicted as as a directory. Hierarchy of resource groups can be
+created in which children of a resource group share resources allotted to
+the parent. Tasks can be attached to any resource group which is at any level.
+There is no correlation between parent-child relationship of tasks and
+the parent-child relationship of the resource groups they belong to.
+
+During fork(), resource group is inherited by a task. A privileged user can
+reassign a task to any resource group.
+
+Characteristics of a resource group can be accessed/changed through the
+following files under the directory representing the resource group:
+
+shares:  allows changing shares of different resources managed by the
+         resource group
+stats:   shows statistics associated with each resources managed by the
+         resource group
+members: allows assignment of tasks to a resource group and shows tasks
+         that are assigned to a resource group.
+
+Resource allocations of a resource group is resource group to the amount
+of resources available to the resource group's parent.
+Resource allocations for a resource group is controlled by the parameters:
+
+min_shares: Minimum amount shares that can be allocated by a resource group. A
+            special value of DONT_CARE(-3) means that there is no minimum
+	    shares of a resource is specified. This resource group may not get
+	    any resource if the system is running short on resources.
+max_shares: Specifies the maximum amount of resource that is allowed to be
+           allocated by a resource group. A special value DONT_CARE(-3) mean
+	   that there is no specific limit is specified, this resource group
+	   can get all the resources available.
+child_shares_divisor: total guarantee that is allowed among the children of
+           this resource group. In other words, the sum of "guarantee"s of all
+	   children of this resource group cannot exit this number.
+
+Any of these parameter can have a special value, UNSUPPORTED(-2) meaning
+that the specific controller does not support this parameter. User's
+request to change the value will be ignored.
+
+None of this parameters neither absolute nor have any units associated with
+them. These are just numbers that are used to calculate the absolute number
+of resource available for a specific resource group.
+
+Absolute amount of minimum shares available for a resource group is
+calculuated as:
+
+	absolute minimum shares = (parent's absolute amount of resource) *
+		(resource group's min_shares / parent's child_shares_divisor)
+
+Maximum shares is also calculated in the same way.
+
+Root resource group is allocated all the resources available in the system.
+In other words absolute amount of resource available for the root resource
+group is same as that of what is available in the system.
+
+min_shares and max_shares are related to the parent, these values on
+the root resource group have no effect. Similarly, child_shares_divisor
+is related to children, and hence it has no effect on leaf resource groups.
Index: linux-2617-rc3/Documentation/res_groups/res_groups_install
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/Documentation/res_groups/res_groups_install	2006-04-27 10:18:48.000000000 -0700
@@ -0,0 +1,29 @@
+1. Configure
+
+Select appropriate configuration options:
+
+   Enable configfs filesystem:
+   File systems --->
+     Pseudo filesystems --->
+       <M> Userspace-driven configuration filesystem (EXPERIMENTAL)
+
+   Enable Resource Group components:
+   General Setup --->
+     Resource Groups --->
+        [*] Resource Groups
+        <M> Resource Groups Configfs Subsystem (User API)
+        [*]     Number of Tasks Resource Manager
+
+
+2. Build, boot the kernel
+
+3. Enable rgcs
+
+    # insmod <patchestree>/fs/configfs/configfs.ko # if compiled as module
+    # insmod <patchedtree>/kernel/res_config/rgcs.ko # if compiled in as module
+    # mount -t configfs none /config
+
+    This will create the directory /config/res_groups which is the root of
+    classes.
+
+4. Work with class hierarchy as explained in the file res_groups_usage
Index: linux-2617-rc3/Documentation/res_groups/res_groups_usage
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/Documentation/res_groups/res_groups_usage	2006-04-27 10:18:48.000000000 -0700
@@ -0,0 +1,53 @@
+Usage of Resoruce Groups
+------------------------
+
+1. Create a resource group
+
+   # mkdir /config/res_groups/c1
+   creates a resource group named c1, while
+
+The newly created directory is automatically populated by magic files
+shares, stats, members, and attrib.
+
+2. View default shares of a resource group
+
+   # cat /config/res_groups/c1/shares
+   res=numtasks,min_shares=-3,max_shares=-3,child_total_divisor=100
+
+   Above is the default value set for resources that have controllers
+   registered with Resource Groups framework.
+
+3. change shares of a specific resource in a resource group
+
+   One or more of the following fields can/must be specified
+       res=<res_name> #mandatory
+       min_shares=<number>
+       max_shares=<number>
+       child_total_divisor=<number>
+   e.g.
+	# echo "res=numtasks,max_shares=20" > /config/res_groups/c1/shares
+
+   If any of these parameters are not specified, the current value will be
+   retained.
+
+4. Move a task to a different resource group
+
+   write the pid of the process to the destination resource group's members
+   file
+   # echo 1004 > /config/res_groups/c1/members
+
+5. Get a list of tasks assigned to a resource group
+
+   # cat /config/res_groups/c1/members
+   lists pids of tasks belonging to c1
+
+6. Get statictics of different resources of a resource group
+
+   # cat /config/res_groups/c1/stats
+   shows c1's statistics for each registered resource controller.
+
+7. Configuration settings for controllers
+   Configuration values for controller are available through module
+   parameter interfaces. Consult the controller specific documents for
+   details. For example, numtasks has it available through
+   /sys/module/numtasks/parameters.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
