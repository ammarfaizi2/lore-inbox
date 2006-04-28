Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWD1Bj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWD1Bj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWD1BjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:39:18 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:8867 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030266AbWD1Bi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:38:58 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:38:17 +0900
Message-Id: <20060428013817.9582.60748.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 9/9] CPU controller - Documentation how to use the controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

9/9: cpu_docs

Documentation how to use the CPU controller

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 Documentation/res_groups/cpurc |   72 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+)

Index: linux-2.6.17-rc3/Documentation/res_groups/cpurc
===================================================================
--- /dev/null
+++ linux-2.6.17-rc3/Documentation/res_groups/cpurc
@@ -0,0 +1,73 @@
+Introduction
+------------
+
+CPU resource controller enables user/sysadmin to control CPU time
+percentage of tasks in a resouce group. It controls time_slice of tasks based on
+the feedback of difference between the target value and the current usage
+in order to control the percentage of the CPU usage to the target value.
+
+Installation
+------------
+
+1. Configure "CPU Resource Controller" under RES_GROUPS. Currently, this cannot
+be configured as a module.
+
+2. Reboot the system with the new kernel.
+
+3. Verify that the CPU resource controller is present by reading
+the file /config/res_groups/shares (should show a line with res=cpu).
+
+Assigning shares
+----------------
+
+Follows the general approach of setting shares for a resource group in Resource
+Groups.
+
+# echo "res=cpu,min_shares=val" > shares
+
+sets the min_shares of a resource group.
+
+The CPU resource controller calculates an effective min_shares in percent
+for each resoruce group. Following is an example of resource groups/min_shares
+settings and each effective min_shares.
+
+			/
+			  effective_min_shares
+			  = 100% - 50% - 30%
+			  = 20%
+	+---------------+---------------+
+	/A min_shares=50%		/B min_shares=30%
+	   effective_min_shares		   effective_min_shares
+	   = 50% - 10% - 25%	    	   = 30% - 0%
+	   = 15%			   = 30%
++---------------+---------------+
+/C min_shares=20%		/D min_shares=50%
+effective_min_shares		   effective_min_shares
+= 20% of 50% - 0% = 10%	   = 50% of 50% - 0 %
+= 10%			   = 25%
+
+If the min_shares in the resource group /A is changed 50% to 40% in the above
+example, the effective_min_shares of the resource group /A, /C and /D are
+automatically changed to 12%, 8% and 20% respectively.
+
+Although the child_shares_divisor can be changed, the effective_min_shares is
+always calculated in percent.
+
+Note that the CPU resource controller doesn't support the limit, so assigning
+the limit for "res=cpu" will have no effect.
+
+Monitoring
+----------
+
+stats file shows the effective min_shares and the current cpu usage of a resouce
+group in percentage.
+
+# cat stats
+cpu:effective_min_shares=50, load=40
+
+That means the effective min_shares of the resource group is 50% and the current
+load average of the resource group is 40%.
+
+Since the tasks in the resource group do not always try to consume CPU,
+the load could be less or greater than the effective_min_shares. Both cases
+are normal.
