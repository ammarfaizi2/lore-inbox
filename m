Return-Path: <linux-kernel-owner+w=401wt.eu-S932435AbXAGI6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbXAGI6f (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbXAGI6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:58:35 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:38568 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435AbXAGI6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:58:34 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 03:58:34 EST
Date: Sun, 7 Jan 2007 02:49:55 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>,
       Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2.6.20] tasks cannot run on cpus onlined after boot
Message-ID: <20070107084955.GD7654@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5c1e176781f43bc902a51e5832f789756bff911b ("sched: force
/sbin/init off isolated cpus") sets init's cpus_allowed to a subset of
cpu_online_map at boot time, which means that tasks won't be scheduled
on cpus that are added to the system later.

Make init's cpus_allowed a subset of cpu_possible_map instead.  This
should still preserve the behavior that Nick's change intended.

Thanks to Giuliano Pochini for reporting this and testing the fix:

http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029397.html


Signed-off-by: Nathan Lynch <ntl@pobox.com>

---

This is a regression from 2.6.18.  Assuming this change is okay, this
should go to -stable for 2.6.19.x.

diff --git a/kernel/sched.c b/kernel/sched.c
index b515e3c..3c8b1c5 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -6875,7 +6875,7 @@ void __init sched_init_smp(void)
 
 	lock_cpu_hotplug();
 	arch_init_sched_domains(&cpu_online_map);
-	cpus_andnot(non_isolated_cpus, cpu_online_map, cpu_isolated_map);
+	cpus_andnot(non_isolated_cpus, cpu_possible_map, cpu_isolated_map);
 	if (cpus_empty(non_isolated_cpus))
 		cpu_set(smp_processor_id(), non_isolated_cpus);
 	unlock_cpu_hotplug();
