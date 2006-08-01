Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWHALJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWHALJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbWHALHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:07:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18653 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932659AbWHALGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:43 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 21/33] x86_64: modify copy_bootdata to use virtual addresses
Date: Tue,  1 Aug 2006 05:03:36 -0600
Message-Id: <1154430241739-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use virtual addresses instead of physical addresses
in copy bootdata.  In addition fix the implementation
of the old bootloader convention.  Everything is
at real_mode_data always.  It is just that sometimes
real_mode_data was relocated by setup.S to not sit at
0x90000.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/head64.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86_64/kernel/head64.c b/arch/x86_64/kernel/head64.c
index 454498c..defef4e 100644
--- a/arch/x86_64/kernel/head64.c
+++ b/arch/x86_64/kernel/head64.c
@@ -29,29 +29,28 @@ static void __init clear_bss(void)
 }
 
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
-#define OLD_CL_MAGIC_ADDR	0x90020
+#define OLD_CL_MAGIC_ADDR	0x20
 #define OLD_CL_MAGIC            0xA33F
-#define OLD_CL_BASE_ADDR        0x90000
-#define OLD_CL_OFFSET           0x90022
+#define OLD_CL_OFFSET           0x22
 
 extern char saved_command_line[];
 
 static void __init copy_bootdata(char *real_mode_data)
 {
-	int new_data;
+	unsigned long new_data;
 	char * command_line;
 
 	memcpy(x86_boot_params, real_mode_data, BOOT_PARAM_SIZE);
-	new_data = *(int *) (x86_boot_params + NEW_CL_POINTER);
+	new_data = *(u32 *) (x86_boot_params + NEW_CL_POINTER);
 	if (!new_data) {
-		if (OLD_CL_MAGIC != * (u16 *) OLD_CL_MAGIC_ADDR) {
+		if (OLD_CL_MAGIC != *(u16 *)(real_mode_data + OLD_CL_MAGIC_ADDR)) {
 			printk("so old bootloader that it does not support commandline?!\n");
 			return;
 		}
-		new_data = OLD_CL_BASE_ADDR + * (u16 *) OLD_CL_OFFSET;
+		new_data = __pa(real_mode_data) + *(u16 *)(real_mode_data + OLD_CL_OFFSET);
 		printk("old bootloader convention, maybe loadlin?\n");
 	}
-	command_line = (char *) ((u64)(new_data));
+	command_line = __va(new_data);
 	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 	printk("Bootdata ok (command line is %s)\n", saved_command_line);	
 }
@@ -99,7 +98,7 @@ void __init x86_64_start_kernel(char * r
  		cpu_pda(i) = &boot_cpu_pda[i];
 
 	pda_init(0);
-	copy_bootdata(real_mode_data);
+	copy_bootdata(__va(real_mode_data));
 #ifdef CONFIG_SMP
 	cpu_set(0, cpu_online_map);
 #endif
-- 
1.4.2.rc2.g5209e

