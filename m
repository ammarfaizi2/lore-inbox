Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWITCmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWITCmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWITCmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:42:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45083 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750781AbWITCmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:42:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references;
	b=kWKj2Yv3LIB20nArYyOApSgYHqW2xp2ZO/XxMG8O9Nmvua5ea2hC5Jq7sJVrh4ClU
	7aEr2SpC8QHNQTzCcpcHw==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 3/4] therm_throt: Make the jiffies compares use the 64bit safe macros.
Date: Tue, 19 Sep 2006 19:42:41 -0700
Message-Id: <1158720162574-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11587201621900-git-send-email-dmitriyz@google.com>
References: <11587201623432-git-send-email-dmitriyz@google.com> <11587201623187-git-send-email-dmitriyz@google.com> <11587201621900-git-send-email-dmitriyz@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>
---
 arch/i386/kernel/cpu/mcheck/therm_throt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
index 342750e..3d6f217 100644
--- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -22,7 +22,7 @@ #endif /* CONFIG_X86_64 */
 /* How long to wait between reporting thermal events */
 #define CHECK_INTERVAL              (300 * HZ)
 
-static DEFINE_PER_CPU(unsigned long, next_check);
+static DEFINE_PER_CPU(__u64, next_check) = INITIAL_JIFFIES;
 
 #ifdef CONFIG_X86_64
 static void therm_throt_log_mce(unsigned int cpu, __u64 status)
@@ -58,10 +58,10 @@ void therm_throt_process(int curr, __u64
 {
 	unsigned int cpu = smp_processor_id();
 
-	if (time_before(jiffies, __get_cpu_var(next_check)))
+	if (time_before64(get_jiffies_64(), __get_cpu_var(next_check)))
 		return;
 
-	__get_cpu_var(next_check) = jiffies + CHECK_INTERVAL;
+	__get_cpu_var(next_check) = get_jiffies_64() + CHECK_INTERVAL;
 
 	/* if we just entered the thermal event */
 	if (curr) {
-- 
1.4.2

