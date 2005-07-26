Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVGZRqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVGZRqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGZRqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:46:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30855 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261903AbVGZRqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:46:09 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/23] x86_64: Implemenent machine_emergency_restart
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:45:31 -0600
In-Reply-To: <m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:44:21 -0600")
Message-ID: <m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is not safe to call set_cpus_allowed() in interrupt
context and disabling the apics is complicated code.
So unconditionally skip machine_shutdown in machine_emergency_reboot
on x86_64.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/reboot.c            |   18 +++++++++++-------
 include/asm-x86_64/emergency-restart.h |    2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

c274d84d274bd40c63be01cd6a4ba26ae2be135a
diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c
+++ b/arch/x86_64/kernel/reboot.c
@@ -109,16 +109,10 @@ void machine_shutdown(void)
 	local_irq_enable();
 }
 
-void machine_restart(char * __unused)
+void machine_emergency_restart(void)
 {
 	int i;
 
-	printk("machine restart\n");
-
-	if (!reboot_force) {
-		machine_shutdown();
-	}
-	
 	/* Tell the BIOS if we want cold or warm reboot */
 	*((unsigned short *)__va(0x472)) = reboot_mode;
        
@@ -143,6 +137,16 @@ void machine_restart(char * __unused)
 	}      
 }
 
+void machine_restart(char * __unused)
+{
+	printk("machine restart\n");
+
+	if (!reboot_force) {
+		machine_shutdown();
+	}
+	machine_emergency_restart();
+}
+
 void machine_halt(void)
 {
 }
diff --git a/include/asm-x86_64/emergency-restart.h b/include/asm-x86_64/emergency-restart.h
--- a/include/asm-x86_64/emergency-restart.h
+++ b/include/asm-x86_64/emergency-restart.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_EMERGENCY_RESTART_H
 #define _ASM_EMERGENCY_RESTART_H
 
-#include <asm-generic/emergency-restart.h>
+extern void machine_emergency_restart(void);
 
 #endif /* _ASM_EMERGENCY_RESTART_H */
