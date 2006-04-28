Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWD1BiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWD1BiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWD1Bh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:37:58 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:61918 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030252AbWD1Bfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:35:53 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: Chandra Seetharaman <sekharan@us.ibm.com>
Date: Thu, 27 Apr 2006 18:35:52 -0700
Message-Id: <20060428013552.27212.84332.sendpatchset@localhost.localdomain>
In-Reply-To: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
References: <20060428013518.27212.954.sendpatchset@localhost.localdomain>
Subject: [PATCH 6/6] numtasks - Documentation for Numtasks controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

6/6: numtasks_docs

Documents what the numtasks controller does and how to use it.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 numtasks |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 133 insertions(+)

Index: linux-2617-rc3/Documentation/res_groups/numtasks
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2617-rc3/Documentation/res_groups/numtasks	2006-04-27 10:14:30.000000000 -0700
@@ -0,0 +1,133 @@
+Introduction
+-------------
+
+Numtasks is a resource controller under the Resource Groups framework that
+allows the user/sysadmin to
+	- manage the number of tasks a resource group can create.
+       - limit the fork rate across the system.
+
+As with any other resource under the Resource Groups framework, numtasks also
+assigns all the resources to the default resource group(/config/res_groups).
+Since, the number of tasks in a system is not limited, this resource controller
+provides a way to set the total number of tasks available in the system through
+the config file. The config variable that affect this is total_numtasks.
+
+This resource controller also allows the sysadmin to limit the number of forks
+that are allowed in the system within the specified number of seconds. This
+can be acheived by changing the attributes forkrate and forkrate_interval in
+the config file. Using this feature one can protect the system from being
+attacked by fork bomb type applications.
+
+Configuration parameters of numtasks controller (forkrate, total_numtasks
+and forkrate_interval) can be read/changed through the modparam interface
+/sys/module/numtasks/parameters/
+
+Installation
+-------------
+
+1. Configure "Number of Tasks Resource Manager" under Resource Groups (see
+      Documentation/res_groups/installation).
+
+2. Reboot the system with the new kernel.
+
+3. Verify the controller's presence by reading the file
+   /config/res_groups/shares (should show a line with res=numtasks)
+
+Usage
+-----
+
+For brevity, unless otherwise specified all the following commands are
+executed in the default resource group(/config/res_groups).
+
+As explained above, files in /sys/module/numtasks/parameters/
+shows total_numtasks and forkrate info.
+
+   # cd /sys/module/numtasks/parameters/
+   # ls
+   .  ..  forkrate  forkrate_interval  total_numtasks
+   # cat total_numtasks
+   2147483647
+   		# value is INT_MAX which means unlimited
+   # cat forkrate
+   2147483647
+   		# value is INT_MAX which means unlimited
+   # cat forkrate_interval
+   1
+   		# forkrate forks are allowed per 1 sec
+
+By default, the total_numtasks is set to "unlimited", forkrate is set
+to "unlimited" and forkrate_interval is set to 1 second. Which means the
+total number of tasks in a system is unlimited and the forks per second is
+also unlimited.
+
+sysadmin can change these values by just writing the attribute/value pair
+to the config file.
+
+   # echo 10000 > forkrate
+   # cat forkrate
+   10000
+   # echo 100001 > total_numtasks
+   # cat total_numtasks
+   100001
+
+By making child_shares_divisor to be same as total_numtasks, sysadmin can
+make the numbers in shares file be same as the number of tasks for a
+resource group.
+In other words, the numbers in shares file will be the absolute number of
+tasks a resource group is allowed.
+
+   # cd /config/res_groups
+   # cat shares
+   res=numtasks,min_shares=-3,max_shares=-3,child_shares_divisor=100
+   # echo res=numtasks,child_shares_divisor=1000 > shares
+   # cat shares
+   res=numtasks,min_shares=-3,max_shares=-3,child_shares_divisor=1000
+
+Class creation
+--------------
+
+   # mkdir c1
+
+Its initial share is don't care. The parent's share values will be unchanged.
+
+Setting a new resource group share
+-------------------------
+
+'min_shares' specifies the number of tasks this resource group is entitled
+to get
+'max_shares' is the maximum number of tasks this resource group can get.
+
+Following command will set the min_shares of resource group c1 to be 250
+and max_shares to be 500
+
+   # echo 'res=numtasks,min_shares=250,max_shares=500' > c1/shares
+   # cat c1/shares
+   res=numtasks,min_shares=250,max_shares=500,child_shares_divisor=100
+
+Note that the min_shares of 250 and max_shares of 500 is w.r.t the
+paren't's 1000 above, and not the absolute numbers.
+
+Limiting forks in a time period
+-------------------------------
+By default, this resource controller allows unlimited forks per second.
+
+Following commands would change it to allow only 100 forks per 10 seconds
+
+   # cd /sys/module/numtasks/parameters
+   # cat 100 > forkrate
+   # cat 10 > forkrate_interval
+
+Note that the same set of values is used across the system. In other words,
+each individual resource group will be allowed 'forkrate' forks in
+'forkrate_interval' seconds.
+
+Monitoring
+----------
+
+stats file shows statistics of the number of tasks usage of a resource
+group
+   # cd /config/res_groups
+   # cat stats
+   numtasks: Number of successes 12554
+   numtasks: Number of failures 0
+   numtasks: Number of forkrate failures 0

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
