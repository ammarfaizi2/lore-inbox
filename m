Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVJOXvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVJOXvP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 19:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVJOXvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 19:51:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28909 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751256AbVJOXvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 19:51:15 -0400
Date: Sun, 16 Oct 2005 00:51:12 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: davem@davemloft.net
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] highest_possible_processor_id() has to be a macro
Message-ID: <20051015235112.GA7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	... otherwise, things like alpha and sparc64 break and break
badly.  They define cpu_possible_map to something else in smp.h
*AFTER* having included cpumask.h.

	If that puppy is a macro, expansion will happen at the actual
caller, when we'd already seen #define cpu_possible_map ... and we will
get the right thing used.

	As an inline helper it will be tokenized before we get to that
define and that's it; no matter what we define later, it won't affect
anything.  We get modules with dependency on cpu_possible_map instead
of the right symbol (phys_cpu_present_map in case of sparc64), or outright
link errors if they are built-in.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc4-git4-base/include/linux/cpumask.h current/include/linux/cpumask.h
--- RC14-rc4-git4-base/include/linux/cpumask.h	2005-10-15 16:21:34.000000000 -0400
+++ current/include/linux/cpumask.h	2005-10-15 19:46:34.000000000 -0400
@@ -393,15 +393,13 @@
 #define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 
 /* Find the highest possible smp_processor_id() */
-static inline unsigned int highest_possible_processor_id(void)
-{
-	unsigned int cpu, highest = 0;
-
-	for_each_cpu_mask(cpu, cpu_possible_map)
-		highest = cpu;
-
-	return highest;
-}
+#define highest_possible_processor_id() \
+({ \
+	unsigned int cpu, highest = 0; \
+	for_each_cpu_mask(cpu, cpu_possible_map) \
+		highest = cpu; \
+	highest; \
+})
 
 
 #endif /* __LINUX_CPUMASK_H */
