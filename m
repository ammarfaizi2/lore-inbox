Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756050AbWKRAH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050AbWKRAH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756072AbWKRAHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:07:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:22957 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756079AbWKRAGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:06:39 -0500
Date: Fri, 17 Nov 2006 17:41:58 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [PATCH 6/20] x86_64: Modify copy bootdata to use virtual addresses
Message-ID: <20061117224158.GG15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use virtual addresses instead of physical addresses
in copy bootdata.  In addition fix the implementation
of the old bootloader convention.  Everything is
at real_mode_data always.  It is just that sometimes
real_mode_data was relocated by setup.S to not sit at
0x90000.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/head64.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff -puN arch/x86_64/kernel/head64.c~x86_64-modify-copy_bootdata-to-use-virtual-addresses arch/x86_64/kernel/head64.c
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/head64.c~x86_64-modify-copy_bootdata-to-use-virtual-addresses	2006-11-17 00:07:30.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/head64.c	2006-11-17 00:07:30.000000000 -0500
@@ -29,27 +29,26 @@ static void __init clear_bss(void)
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
 			return;
 		}
-		new_data = OLD_CL_BASE_ADDR + * (u16 *) OLD_CL_OFFSET;
+		new_data = __pa(real_mode_data) + *(u16 *)(real_mode_data + OLD_CL_OFFSET);
 	}
-	command_line = (char *) ((u64)(new_data));
+	command_line = __va(new_data);
 	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 }
 
@@ -74,7 +73,7 @@ void __init x86_64_start_kernel(char * r
  		cpu_pda(i) = &boot_cpu_pda[i];
 
 	pda_init(0);
-	copy_bootdata(real_mode_data);
+	copy_bootdata(__va(real_mode_data));
 #ifdef CONFIG_SMP
 	cpu_set(0, cpu_online_map);
 #endif
_
