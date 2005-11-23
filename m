Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVKWXUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVKWXUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVKWXUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:20:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12960
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932384AbVKWXU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:20:29 -0500
Date: Wed, 23 Nov 2005 15:20:31 -0800 (PST)
Message-Id: <20051123.152031.02282381.davem@davemloft.net>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       ak@muc.de
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0511230849380.13959@g5.osdl.org>
References: <20051123002134.287ff226.akpm@osdl.org>
	<20051123.005530.17893365.davem@davemloft.net>
	<Pine.LNX.4.64.0511230849380.13959@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 23 Nov 2005 08:54:46 -0800 (PST)

> The way to handle it is to do
> 
> 	static inline int maybe_ignored(int arg, ...)
> 	{
> 		return arg;
> 	}
> 
> 	#define smp_call_function(func,info,retry,wait) \
> 		maybe_ignored(0, info, retry, wait)
> 
> which is a very useful way to say: we don't care about "func", but we want 
> to avoid unused warnings for "info", "retry" and "wait", and we want to 
> return 0 regardless and compile it all away.
> 
> If somebody tests this, puts the "maybe_ignored()" function in some nice 
> generic header file, I'll apply it.

I quickly hacked this up and did a UP test build (patch at the end),
but there is another consequence to consider.

With this, we have to either:

1) Mark all IPI functions with ifdef CONFIG_SMP, or
2) Mark them with __attribute__((__unused__))) which is what
   the net/core/flow.c case does

Because if we just leave the static IPI functions there without the
CONFIG_SMP ifdef and without the unused attribute, this new
smp_call_function() will generate an unused static function warning.

What we could do is hide that detail behind some kind of
"DEFINE_IPI_FUNC()" macro, and put the gore into a header file.

I'm sure there are other clean ways of handling it.

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b1e407a..1876d3c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -286,6 +286,11 @@ extern void dump_stack(void);
 	1; \
 })
 
+static inline int maybe_ignored(int arg, ...)
+{
+	return arg;
+}
+
 #endif /* __KERNEL__ */
 
 #define SI_LOAD_SHIFT	16
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9dfa3ee..2a513fe 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -94,7 +94,8 @@ void smp_prepare_boot_cpu(void);
  */
 #define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
-#define smp_call_function(func,info,retry,wait)	({ 0; })
+#define smp_call_function(func,info,retry,wait)	\
+	maybe_ignored(0, info, retry, wait)
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
