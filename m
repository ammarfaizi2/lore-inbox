Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753130AbWKCGE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbWKCGE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 01:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbWKCGE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 01:04:57 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:48015 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1753130AbWKCGE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 01:04:57 -0500
Date: Fri, 3 Nov 2006 11:34:27 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, martin@lorenz.eu.org, srinivasa@in.ibm.com,
       vatsa@in.ibm.com
Subject: [PATCH] Fix the spurious unlock_cpu_hotplug false warnings.
Message-ID: <20061103060427.GA12399@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cpu-hotplug locking has a minor race case caused because of setting the
variable "recursive" to NULL *after* releasing the cpu_bitmask_lock in the
function unlock_cpu_hotplug,instead of doing so before releasing the
cpu_bitmask_lock. 

This was the cause of most of the recent false spurious lock_cpu_unlock
warnings.

This should fix the problem reported by Martin Lorenz reported in
http://lkml.org/lkml/2006/10/29/127.

Thanks to Srinivasa DS for pointing it out.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

--
 kernel/cpu.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: hotplug/kernel/cpu.c
===================================================================
--- hotplug.orig/kernel/cpu.c
+++ hotplug/kernel/cpu.c
@@ -58,8 +58,8 @@ void unlock_cpu_hotplug(void)
 		recursive_depth--;
 		return;
 	}
-	mutex_unlock(&cpu_bitmask_lock);
 	recursive = NULL;
+	mutex_unlock(&cpu_bitmask_lock);
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
