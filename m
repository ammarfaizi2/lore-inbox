Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSHOVoa>; Thu, 15 Aug 2002 17:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSHOVoa>; Thu, 15 Aug 2002 17:44:30 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:55283 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317506AbSHOVo3>; Thu, 15 Aug 2002 17:44:29 -0400
Date: Thu, 15 Aug 2002 17:48:25 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] reduce stack usage of sanitize_e820_map
Message-ID: <20020815174825.F29874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Currently, sanitize_e820_map uses 0x738 bytes of stack.  The patch below 
moves the arrays into __initdata, reducing stack usage to 0x34 bytes.

		-ben

:r ~/patches/v2.5/v2.5.31-stack-e820.diff
diff -urN foo-v2.5.31/arch/i386/kernel/setup.c bar-v2.5.31/arch/i386/kernel/setup.c
--- foo-v2.5.31/arch/i386/kernel/setup.c	Mon Jun 17 15:41:13 2002
+++ bar-v2.5.31/arch/i386/kernel/setup.c	Thu Aug 15 17:47:41 2002
@@ -275,16 +275,17 @@
  * replaces the original e820 map with a new one, removing overlaps.
  *
  */
+struct change_member {
+	struct e820entry *pbios; /* pointer to original bios entry */
+	unsigned long long addr; /* address for this change point */
+};
+struct change_member change_point_list[2*E820MAX] __initdata;
+struct change_member *change_point[2*E820MAX] __initdata;
+struct e820entry *overlap_list[E820MAX] __initdata;
+struct e820entry new_bios[E820MAX] __initdata;
+
 static int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
 {
-	struct change_member {
-		struct e820entry *pbios; /* pointer to original bios entry */
-		unsigned long long addr; /* address for this change point */
-	};
-	struct change_member change_point_list[2*E820MAX];
-	struct change_member *change_point[2*E820MAX];
-	struct e820entry *overlap_list[E820MAX];
-	struct e820entry new_bios[E820MAX];
 	struct change_member *change_tmp;
 	unsigned long current_type, last_type;
 	unsigned long long last_addr;
