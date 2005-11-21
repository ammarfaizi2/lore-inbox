Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVKUSEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVKUSEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVKUSEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:04:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34314 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932434AbVKUSEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:04:10 -0500
Date: Mon, 21 Nov 2005 17:38:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Shut up warnings in net/core/flow.c
Message-ID: <20051121173825.GF21032@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not really a network problem, more a !SMP issue.

net/core/flow.c:295: warning: statement with no effect

flow.c:295:        smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);

Fix this by converting the macro to an inline function, which
also increases the typechecking for !SMP builds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/include/linux/smp.h b/include/linux/smp.h
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -94,7 +94,13 @@ void smp_prepare_boot_cpu(void);
  */
 #define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
-#define smp_call_function(func,info,retry,wait)	({ 0; })
+
+static inline int smp_call_function(void (*func) (void *info), void *info,
+				    int retry, int wait)
+{
+	return 0;
+}
+
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1

-- 
Russell King
