Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314123AbSDQPLv>; Wed, 17 Apr 2002 11:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314124AbSDQPLv>; Wed, 17 Apr 2002 11:11:51 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:39309
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S314123AbSDQPLt>; Wed, 17 Apr 2002 11:11:49 -0400
Date: Wed, 17 Apr 2002 08:11:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andries.Brouwer@cwi.nl
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] setup_per_cpu_areas in 2.5.8pre3
Message-ID: <20020417151137.GB27144@opus.bloom.county>
In-Reply-To: <UTC200204170824.g3H8OTZ28753.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 10:24:29AM +0200, Andries.Brouwer@cwi.nl wrote:
 
> #ifdef's are evil. You have one, and there are two possible sources.
> Easy and readable. You have two, and there are four. Already a small
> effort to check that indeed all four combinations are OK. That was
> what went wrong in the setup_per_cpu_areas case. You have three and
> it is almost certain that someone forgets to check all possible
> eight cases.

How does the following patch look ?  It's alot longer than the rest but
imho it makes things readable as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== init/main.c 1.40 vs edited =====
--- 1.40/init/main.c	Tue Apr  9 13:35:31 2002
+++ edited/init/main.c	Mon Apr 15 08:56:20 2002
@@ -261,20 +261,7 @@
 extern void setup_arch(char **);
 extern void cpu_idle(void);
 
-#ifndef CONFIG_SMP
-
-#ifdef CONFIG_X86_LOCAL_APIC
-static void __init smp_init(void)
-{
-	APIC_init_uniprocessor();
-}
-#else
-#define smp_init()	do { } while (0)
-#endif
-
-#else
-
-#ifdef __GENERIC_PER_CPU
+#if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 unsigned long __per_cpu_offset[NR_CPUS];
 
 static void __init setup_per_cpu_areas(void)
@@ -300,8 +287,9 @@
 static inline void setup_per_cpu_areas(void)
 {
 }
-#endif /* !__GENERIC_PER_CPU */
+#endif
 
+#ifdef CONFIG_SMP
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
@@ -311,7 +299,15 @@
 	smp_threads_ready=1;
 	smp_commence();
 }
-
+#else
+#ifdef CONFIG_X86_LOCAL_APIC
+static void __init smp_init(void)
+{
+	APIC_init_uniprocessor();
+}
+#else
+#define smp_init()	do { } while (0)
+#endif
 #endif
 
 /*
