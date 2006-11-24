Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934994AbWKXR6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934994AbWKXR6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935000AbWKXR6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:58:34 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:12694
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S934994AbWKXR6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:58:33 -0500
Date: Fri, 24 Nov 2006 17:58:01 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 vsyscall fails to compile when CONFIG_HOTPLUG_CPU is disabled
Message-ID: <e605df1da2b2e35ab69e8167c2b71b7f@pinky>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 vsyscall fails to compile when CONFIG_HOTPLUG_CPU is disabled

The following change attempted to fix up the notifier structure
when CONFIG_HOTPLUG_CPU is disabled:

    [PATCH] x86-64: Fix vgetcpu when CONFIG_HOTPLUG_CPU is disabled

It seems to leave a reference to the cpu_vsyscall_notifier which is
not declared unles CONFIG_HOTPLUG_CPU is defined, leading to the following
compile time error:

  arch/x86_64/kernel/vsyscall.c:310: error: `cpu_vsyscall_notifier'
				  undeclared (first use in this function)

Make the hotcpu_notifier dependant on CONFIG_HOTPLUG_CPU.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index 3416462..e93ffcf 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -307,7 +307,9 @@ static int __init vsyscall_init(void)
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
 	on_each_cpu(cpu_vsyscall_init, NULL, 0, 1);
+#ifdef CONFIG_HOTPLUG_CPU
 	hotcpu_notifier(cpu_vsyscall_notifier, 0);
+#endif
 	return 0;
 }
 
