Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSC0VC3>; Wed, 27 Mar 2002 16:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292316AbSC0VCJ>; Wed, 27 Mar 2002 16:02:09 -0500
Received: from orinoco.cisco.com ([64.101.176.25]:56203 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S292130AbSC0VCA>;
	Wed, 27 Mar 2002 16:02:00 -0500
Message-ID: <3CA232A1.7040702@cisco.com>
Date: Wed, 27 Mar 2002 14:59:13 -0600
From: Stephen Baker <stbaker@cisco.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel Patch; setpriority
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

This patch will allow a process or thread to changes it's priority 
dynamically based on it's capabilities.  In our case we wanted to use 
threads with Linux.  To have true priorities we need root to use 
SCHED_FIFO or SCHED_RR; in many case root access is not allowed but we 
still wanted priorities.  So we started using setpriority to change a 
threads priority.  Now we used nice values from 19 to 0 which did not 
require root access.  In some cases a thread need to raise it's nice 
level and this would fail.  I also saw a note man renice(8) that said 
this bug exists.
So the following patch address this problem.  It allows any process or 
thread to raise or lower it's nice value for it's current capability. 
For example a CAP_SYS_NICE process can use 19 to -20 for it's value and 
a normal user can use 19 to 0.  By capping normal user to zero then we 
don't have any problems with conflicts with higher priority programs in 
the system since zero is the default value.

SB


--- linux-2.4.9-31/kernel/sys.c    Wed Mar 27 13:11:10 2002
+++ linux/kernel/sys.c    Wed Mar 27 13:09:36 2002
@@ -194,6 +194,12 @@
    return 0;
}

+/*
+ * Allow the process to adjust it's priority higher or lower.
+ * If the process has CAP_SYS_NICE set then we can use
+ * -20 to 19.  Otherwise we use 0 to 19 as our valid priority
+ * range.
+ */
asmlinkage long sys_setpriority(int which, int who, int niceval)
{
    struct task_struct *p;
@@ -220,7 +226,8 @@
        }
        if (error == -ESRCH)
            error = 0;
-        if (niceval < p->nice && !capable(CAP_SYS_NICE))
+        if ((niceval < 0) &&
+            (niceval < p->nice && !capable(CAP_SYS_NICE)))
            error = -EACCES;
        else
            p->nice = niceval;


