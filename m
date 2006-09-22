Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWIVAsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWIVAsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWIVAsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:48:23 -0400
Received: from smtp-out.google.com ([216.239.45.12]:10336 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932147AbWIVAsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:48:22 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references;
	b=tb3ri4pj0IxYbMkB2FH4DAlsQMQl4FDtw0NpFyZKf2gH8vmAv8OI6nRYuEvJsteTe
	niH34U3lK8L3lK3PUb3tw==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 3/4] therm_throt: Make the jiffies compares use the 64bit safe macros.
Date: Thu, 21 Sep 2006 17:48:03 -0700
Message-Id: <11588860852885-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11588860853616-git-send-email-dmitriyz@google.com>
References: <11588860842488-git-send-email-dmitriyz@google.com> <11588860854079-git-send-email-dmitriyz@google.com> <11588860853616-git-send-email-dmitriyz@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>

---
 arch/i386/kernel/cpu/mcheck/therm_throt.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
index 85eba00..101f7ac 100644
--- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -18,7 +18,7 @@ #include <asm/therm_throt.h>
 /* How long to wait between reporting thermal events */
 #define CHECK_INTERVAL              (300 * HZ)
 
-static DEFINE_PER_CPU(unsigned long, next_check);
+static DEFINE_PER_CPU(__u64, next_check);
 
 /***
  * therm_throt_process - Process thermal throttling event
@@ -39,11 +39,12 @@ static DEFINE_PER_CPU(unsigned long, nex
 int therm_throt_process(int curr)
 {
 	unsigned int cpu = smp_processor_id();
+	__u64 tmp_jiffs = get_jiffies_64();
 
-	if (time_before(jiffies, __get_cpu_var(next_check)))
+	if (time_before64(tmp_jiffs, __get_cpu_var(next_check)))
 		return 0;
 
-	__get_cpu_var(next_check) = jiffies + CHECK_INTERVAL;
+	__get_cpu_var(next_check) = tmp_jiffs + CHECK_INTERVAL;
 
 	/* if we just entered the thermal event */
 	if (curr) {
-- 
1.4.2

