Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWAZVIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWAZVIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWAZVIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:08:25 -0500
Received: from DSL022.labridge.com ([206.117.136.22]:4875 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S964886AbWAZVIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:08:24 -0500
Subject: Re: arch/i386/kernel/nmi.c: fix compiler warning
From: Joe Perches <joe@perches.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1138307625.30814.13.camel@mindpipe>
References: <1138307625.30814.13.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 13:08:21 -0800
Message-Id: <1138309701.27471.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3.1.102mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 15:33 -0500, Lee Revell wrote:
> arch/i386/kernel/nmi.c: In function 'check_nmi_watchdog':
> arch/i386/kernel/nmi.c:139: warning: statement with no effect

A more generic solution:

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9dfa3ee..be4e598 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -90,12 +90,25 @@ void smp_prepare_boot_cpu(void);
 #else /* !SMP */
 
 /*
- *	These macros fold the SMP functionality into a single CPU system
+ *	These macros and inlines fold the SMP functionality
+ *	for single CPU systems
  */
 #define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
-#define smp_call_function(func,info,retry,wait)	({ 0; })
-#define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
+
+static inline int smp_call_function(void (*func) (void *info), void *info,
+			      int retry, int wait)
+{
+	return 0;
+}
+
+static inline int on_each_cpu(void (*func) (void *info), void *info,
+			      int retry, int wait)
+{
+	func(info);
+	return 0;
+}
+
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
 #define smp_prepare_boot_cpu()			do {} while (0)


