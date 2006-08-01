Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbWHALNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWHALNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWHALGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59356 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932633AbWHALFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:31 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 14/33] x86_64: Properly report in /proc/iomem the kernel address
Date: Tue,  1 Aug 2006 05:03:29 -0600
Message-Id: <1154430237912-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code assumed that the kernel was always loaded
at 1M in memory.  This fixes that assumption.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/setup.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 8a099ff..11d31ea 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -521,7 +521,7 @@ static void discover_ebda(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	unsigned long kernel_end;
+	unsigned long kernel_start, kernel_end;
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	screen_info = SCREEN_INFO;
@@ -596,8 +596,9 @@ #endif
 				(table_end - table_start) << PAGE_SHIFT);
 
 	/* reserve kernel */
+	kernel_start = __pa_symbol(&_text);
 	kernel_end = round_up(__pa_symbol(&_end),PAGE_SIZE);
-	reserve_bootmem_generic(HIGH_MEMORY, kernel_end - HIGH_MEMORY);
+	reserve_bootmem_generic(kernel_start, kernel_end - kernel_start);
 
 	/*
 	 * reserve physical page 0 - it's a special BIOS page on many boxes,
-- 
1.4.2.rc2.g5209e

