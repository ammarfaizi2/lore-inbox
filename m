Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWDUCYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWDUCYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWDUCYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:24:20 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:37849 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750785AbWDUCYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:24:19 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:24:11 -0700
Message-Id: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 00/12] CKRM after a major overhaul
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CKRM has gone through a major overhaul by removing some of the complexity,
cutting down on features and moving portions to userspace.

Diffstat of this patchset (including the numtasks controller that follows)
is:

	23 files changed, 2475 insertions(+), 5 deletions(-)

including Documentaion and comments.

This patchset will be followed with two controllers:
	- a simple controller, numtasks to control number of tasks
	- CPU controller, to control CPU resource.
--

Brief Intro for CKRM:

Class-based Kernel Resource Management (CKRM) enables control of system
resource usage and monitoring of resource usage through user-defined
groups of tasks called classes.

Class is a group of tasks that is grouped by the administrator.

By assigning tasks to classes, administrators can monitor and bound the
resource usage of any system resource with a resource controller.
Resources amenable to such control include CPU ticks, physical pages,
disk I/O bandwidth, number of open file handles, and number of tasks to
name a few.

Userspace interfaces with CKRM through a configfs subsystem: Resource Control
File System (RCFS). Users create and delete classes simply by issuing mkdir
or rmdir commands. Once created the user may set the resource
share of a class and alter the group of tasks bound to those classes by
writing to files in the class directory. Similarly, to monitor the
subsequent resource utilization of the class, users read files in the class
directory.

Users control different resource shares of a class independent of other
resource. In other words, CPU share of class can be very different from
memory share and that of I/O share.

Resource controllers implement a small set of functions that respond to
changes in resource shares, class creation/deletion and class membership.
Given a class and its shares the controller then manages resource usage
of tasks in that class. For instance, a CPU resource controller might
manipulate the timeslice of each task according to its class' remaining
CPU share.

--

Patch Descriptions:

This set of patches implements classes, resource controller registration,
and the RCFS interface. Subsequent sets of patches add specific resource
controllers.

More details are available in the doumentation patch.

Patch descriptions:
01/12: ckrm_core
	- Provides register/unregister functions for a controller

02/12: ckrm_core_class_support
	- Provides functions to alloc and free a user defined class
	- Provides utility functions to walk through the class hierarchy

03/12: ckrm_core_handle_shares
	- Provides functions to set/get shares of a class
	- Defines a teardown function that is intended to be called when
	  user disables CKRM (by umount of configfs or rmmod of rcfs)

04/12: ckrm_tasksupport
	- Adds logic to support adding/removing task to/from a class
	- Provides an interface to set a task's class

05/12: ckrm_tasksupport_fork_exit_init
	- Initializes and clears ckrm specific information at fork() and
	  exit()
	- Inititalizes ckrm (called from start_kernel)

06/12: ckrm_tasksupport_procsupport
	- Adds an interface in /proc to get the class name of a task.

07/12 - ckrm_configfs_rcfs
	Creates configfs interface(RCFS) for managing CKRM.
	Hooks up with configfs. Provides functions for creating and
	deleting classes.

08/12 - ckrm_configfs_rcfs_attr_support
	Adds the basic attribute store and show functions.

09/12 - 04ckrm_configfs_rcfs_stats
	Adds attr_store and attr_show support for stats file.

10/12 - ckrm_configfs_rcfs_shares
	Adds attr_store and attr_show support for shares file.

11/12 - ckrm_configfs_rcfs_members
	Adds attr_store and attr_show support for members file.

12/12 - ckrm_docs
	Documentation describing important CKRM elements such as classes,
	shares, controllers, and the interface provided to userspace via RCFS

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
