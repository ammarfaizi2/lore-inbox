Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWJDAIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWJDAIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWJDAIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:08:41 -0400
Received: from mga06.intel.com ([134.134.136.21]:20385 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030417AbWJDAIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:08:40 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,252,1157353200"; 
   d="scan'208"; a="140052959:sNHT18676581"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: herbert@gondor.apana.org.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
In-Reply-To: <1159916644.8035.35.camel@localhost.localdomain>
References: <1159916644.8035.35.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel
Date: Tue, 03 Oct 2006 16:19:41 -0700
Message-Id: <1159917581.8035.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry my mailer screwed up the line-wrap.  Here's a resent of the patch.

Tim

The patch "Let WARN_ON/WARN_ON_ONCE return the condition"
http://kernel.org/git/?
p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=684f978347deb42d180373ac4c427f82ef963171

introduced 40% more 2nd level cache miss to tbench workload
being run in a loop back mode on a Core 2 machine.  I think the
introduction of the local variables to WARN_ON and WARN_ON_ONCE

typeof(x) __ret_warn_on = (x);
typeof(condition) __ret_warn_once = (condition);

results in the extra cache misses.  In our test workload profile, we see
heavily used functions like do_softirq and local_bh_enable 
takes a lot longer to execute.  

The modification below helps fix the problem.  I made a slight
modification to sched.c to get around a gcc bug.

Signed-off-by: Tim Chen <tim.c.chen@intel.com>
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index a525089..05ed388 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -17,13 +17,12 @@ #endif
 
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) ({						\
-	typeof(condition) __ret_warn_on = (condition);			\
-	if (unlikely(__ret_warn_on)) {					\
+	if (unlikely(condition)) {					\
 		printk("BUG: warning at %s:%d/%s()\n", __FILE__,	\
 			__LINE__, __FUNCTION__);			\
 		dump_stack();						\
 	}								\
-	unlikely(__ret_warn_on);					\
+	unlikely(condition);						\
 })
 #endif
 
@@ -43,12 +42,16 @@ #endif
 
 #define WARN_ON_ONCE(condition)	({			\
 	static int __warn_once = 1;			\
-	typeof(condition) __ret_warn_once = (condition);\
 							\
-	if (likely(__warn_once))			\
-		if (WARN_ON(__ret_warn_once)) 		\
-			__warn_once = 0;		\
-	unlikely(__ret_warn_once);			\
+	if (unlikely(condition)){ 			\
+		if (likely(__warn_once)){		\
+			__warn_once=0;			\
+			printk("BUG: warning at %s:%d/%s()\n", __FILE__, \
+				__LINE__, __FUNCTION__);\
+			dump_stack(); 			\
+		}					\
+	}						\
+	unlikely(condition);				\
 })
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched.c b/kernel/sched.c
index 5c848fd..8ae972c 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5629,7 +5629,8 @@ static unsigned long domain_distance(int
 	struct sched_domain *sd;
 
 	for_each_domain(cpu1, sd) {
-		WARN_ON(!cpu_isset(cpu1, sd->span));
+		if (unlikely(!cpu_isset(cpu1, sd->span)))
+			WARN_ON(1);
 		if (cpu_isset(cpu2, sd->span))
 			return distance;
 		distance++;
