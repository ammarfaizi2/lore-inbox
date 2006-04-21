Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWDUC1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWDUC1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWDUC0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:26:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:4018 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751018AbWDUCZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:25:54 -0400
From: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: sekharan@us.ibm.com
Date: Thu, 20 Apr 2006 19:25:53 -0700
Message-Id: <20060421022553.6145.92952.sendpatchset@localhost.localdomain>
In-Reply-To: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
References: <20060421022519.6145.78248.sendpatchset@localhost.localdomain>
Subject: [RFC] [PATCH 6/6] numtasks - Documentation for Numtasks controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

6/6: ckrm_numtasks_docs

Documents what the numtasks controller does and how to use it.
--

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>

 Documentation/ckrm/numtasks |  130 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+)

Index: linux2617-rc2/Documentation/ckrm/numtasks
===================================================================
--- /dev/null
+++ linux2617-rc2/Documentation/ckrm/numtasks
@@ -0,0 +1,130 @@
+Introduction
+-------------
+
+Numtasks is a resource controller under the CKRM framework that allows the
+user/sysadmin to
+	- manage the number of tasks a class can create.
+        - limit the fork rate across the system.
+
+As with any other resource under the CKRM framework, numtasks also assigns
+all the resources to the default class(/config/ckrm). Since, the number
+of tasks in a system is not limited, this resource controller provides a
+way to set the total number of tasks available in the system through the config
+file. The config variable that affect this is total_numtasks.
+
+This resource controller also allows the sysadmin to limit the number of forks
+that are allowed in the system within the specified number of seconds. This
+can be acheived by changing the attributes forkrate and forkrate_interval in
+the config file. Using this feature one can protect the system from being
+attacked by fork bomb type applications.
+
+Configuration parameters of numtasks controller (forkrate, total_numtasks
+and forkrate_interval) can be read/changed through the modparam interface
+/sys/module/ckrm_numtasks/parameters/
+
+Installation
+-------------
+
+1. Configure "Number of Tasks Resource Manager" under CKRM (see
+      Documentation/ckrm/installation).
+
+2. Reboot the system with the new kernel.
+
+3. Verify the controller's presence by reading the file
+   /config/ckrm/shares (should show a line with res=numtasks)
+
+Usage
+-----
+
+For brevity, unless otherwise specified all the following commands are
+executed in the default class (/config/ckrm).
+
+As explained above, files in /sys/module/ckrm_numtasks/parameters/
+shows total_numtasks and forkrate info.
+
+   # cd /sys/module/ckrm_numtasks/parameters/
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
+make the numbers in shares file be same as the number of tasks for a class.
+In other words, the numbers in shares file will be the absolute number of
+tasks a class is allowed.
+
+   # cd /config/ckrm
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
+Setting a new class share
+-------------------------
+
+'min_shares' specifies the number of tasks this class is entitled to get
+'limit' is the maximum number of tasks this class can get.
+
+Following command will set the min_shares of class c1 to be 250 and the limit
+to be 500
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
+   # cd /sys/module/ckrm_numtasks/parameters
+   # cat 100 > forkrate
+   # cat 10 > forkrate_interval
+
+Note that the same set of values is used across the system. In other words,
+each individual class will be allowed 'forkrate' forks in 'forkrate_interval'
+seconds.
+
+Monitoring
+----------
+
+stats file shows statistics of the number of tasks usage of a class
+   # cd /config/ckrm
+   # cat stats
+   numtasks: Number of successes 12554
+   numtasks: Number of failures 0
+   numtasks: Number of forkrate failures 0

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
