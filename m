Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUCINug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUCINug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:50:36 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:20471 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261933AbUCINue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:50:34 -0500
Date: Tue, 9 Mar 2004 19:21:43 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, rusty@au1.ibm.com
Subject: [PATCH] call_usermodehelper needs to wait longer
Message-ID: <20040309135143.GB26645@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During my testing of call_usermodehelper, I noticed that 
if it is called from a workqueue function, it does really wait
(when asked to) for the usermodehelper to exit.

Patch below should fix it. It has been tested against 2.6.4-rc2-mm1
on a 4-way x86 SMP box.

--- kmod.c.org  2004-03-09 18:52:19.000000000 +0530
+++ kmod.c      2004-03-09 18:52:38.000000000 +0530
@@ -258,10 +258,13 @@
        if (current_is_keventd()) {
                /* We can't wait on keventd! */
                __call_usermodehelper(&sub_info);
-       } else {
+               if (!wait)
+                       goto out;
+       } else
                schedule_work(&work);
-               wait_for_completion(&done);
-       }
+
+       wait_for_completion(&done);
+
 out:
        return sub_info.retval;
 }



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
