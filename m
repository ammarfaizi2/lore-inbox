Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVGZRqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVGZRqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVGZRq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:46:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28807 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261782AbVGZRo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:44:59 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/23] x86_64: Fix reboot_force
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:44:21 -0600
In-Reply-To: <m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:41:26 -0600")
Message-ID: <m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We only want to shutdown the apics if reboot_force
is not specified.  Be we are doing this both
in machine_shutdown which is called unconditionally
and if (!reboot_force).  So simply call machine_shutdown
if (!reboot_force).  It looks like something
went weird with merging some of the kexec patches for
x86_64, and caused this.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/reboot.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

a044301f20f8e977206a79ade92c6b385f9e2703
diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c
+++ b/arch/x86_64/kernel/reboot.c
@@ -115,15 +115,8 @@ void machine_restart(char * __unused)
 
 	printk("machine restart\n");
 
-	machine_shutdown();
-
 	if (!reboot_force) {
-		local_irq_disable();
-#ifndef CONFIG_SMP
-		disable_local_APIC();
-#endif
-		disable_IO_APIC();
-		local_irq_enable();
+		machine_shutdown();
 	}
 	
 	/* Tell the BIOS if we want cold or warm reboot */
