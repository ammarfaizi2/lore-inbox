Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWDUC3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWDUC3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWDUC3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:29:23 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15590 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932126AbWDUC2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:52 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:28:14 +0900
Message-Id: <20060421022814.13598.238.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 9/9] CPU controller - Documents how to use the controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

9/9: ckrm_cpu_docs

Documents how to use the CPU controller

Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>

 Documentation/ckrm/cpurc |   70 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+)

Index: linux-2.6.17-rc2/Documentation/ckrm/cpurc
===================================================================
--- /dev/null
+++ linux-2.6.17-rc2/Documentation/ckrm/cpurc
@@ -0,0 +1,71 @@
+Introduction
+------------
+
+CPU resource controller enables user/sysadmin to control CPU time
+percentage of tasks in a class. It controls time_slice of tasks based on
+the feedback of difference between the target value and the current usage
+in order to control the percentage of the CPU usage to the target value.
+
+Installation
+------------
+
+1. Configure "CPU Resource Controller" under CKRM. Currently, this cannot be
+configured as a module.
+
+2. Reboot the system with the new kernel.
+
+3. Verify that the CPU resource controller is present by reading
+the file /config/ckrm/shares (should show a line with res=cpu).
+
+Assigning shares
+----------------
+
+Follows the general approach of setting shares for a class in CKRM.
+
+# echo "res=cpu,min_shares=val" > shares
+
+sets the min_shares of a class.
+
+The CPU resource controller calculates an effective min_shares in percent
+for each class. Following is an example of class/min_shares settings
+and each effective min_shares.
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
+If the min_shares in the class /A is changed 50% to 40% in the above
+example, the effective_min_shares of the class /A, /C and /D are automatically
+changed to 12%, 8% and 20% respectively.
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
+stats file shows the effective min_shares and the current cpu usage of a class
+in percentage.
+
+# cat stats
+cpu:effective_min_shares=50, load=40
+
+That means the effective min_shares of the class is 50% and the current load
+average of the class is 40%.
+
+Since the tasks in the class do not always try to consume CPU, the load could be
+less or greater than the effective_min_shares. Both cases are normal.
