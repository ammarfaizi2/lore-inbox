Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWHASi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWHASi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWHASi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:38:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750776AbWHASi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:38:28 -0400
Date: Tue, 1 Aug 2006 14:38:26 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: runtime disable for softlockup
Message-ID: <20060801183826.GM22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The softlockup detector is damned handy, but a real pain if it
prevents your distro installer from running.
As a 'worse case scenario', with the diff below, users can
disable it at boot time, and still manage to get a box installed.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/init/main.c~	2006-03-05 00:45:51.000000000 -0500
+++ linux-2.6/init/main.c	2006-03-05 00:49:41.000000000 -0500
@@ -640,6 +640,15 @@ static void __init do_basic_setup(void)
 	do_initcalls();
 }
 
+static int __initdata nosoftlockup;
+
+static int __init nosoftlockup_setup(char *str)
+{
+	nosoftlockup = 1;
+	return 1;
+}
+__setup("nosoftlockup", nosoftlockup_setup);
+
 static void do_pre_smp_initcalls(void)
 {
 	extern int spawn_ksoftirqd(void);
@@ -649,7 +657,8 @@ static void do_pre_smp_initcalls(void)
 	migration_init();
 #endif
 	spawn_ksoftirqd();
-	spawn_softlockup_task();
+	if (!nosoftlockup)
+		spawn_softlockup_task();
 }
 
 static void run_init_process(char *init_filename)

-- 
http://www.codemonkey.org.uk
