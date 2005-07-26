Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVGZRqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVGZRqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGZRn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:43:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26759 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261973AbVGZRmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:42:04 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/23] i386: Implement machine_emergency_reboot
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
        <m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:41:26 -0600
Message-ID: <m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


set_cpus_allowed is not safe in interrupt context
and disabling apics is complicated code so don't
call machine_shutdown on i386 from emergency_restart().

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/i386/kernel/reboot.c            |   10 +++++++---
 include/asm-i386/emergency-restart.h |    2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

fcfe4ee919b83e5002dd696a94834fd3ccb31be8
diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -311,10 +311,8 @@ void machine_shutdown(void)
 #endif
 }
 
-void machine_restart(char * __unused)
+void machine_emergency_restart(void)
 {
-	machine_shutdown();
-
 	if (!reboot_thru_bios) {
 		if (efi_enabled) {
 			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
@@ -337,6 +335,12 @@ void machine_restart(char * __unused)
 	machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
 }
 
+void machine_restart(char * __unused)
+{
+	machine_shutdown();
+	machine_emergency_restart();
+}
+
 void machine_halt(void)
 {
 }
diff --git a/include/asm-i386/emergency-restart.h b/include/asm-i386/emergency-restart.h
--- a/include/asm-i386/emergency-restart.h
+++ b/include/asm-i386/emergency-restart.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_EMERGENCY_RESTART_H
 #define _ASM_EMERGENCY_RESTART_H
 
-#include <asm-generic/emergency-restart.h>
+extern void machine_emergency_restart(void);
 
 #endif /* _ASM_EMERGENCY_RESTART_H */
