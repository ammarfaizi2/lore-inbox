Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314026AbSDQCV0>; Tue, 16 Apr 2002 22:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314027AbSDQCV0>; Tue, 16 Apr 2002 22:21:26 -0400
Received: from [202.135.142.194] ([202.135.142.194]:6405 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314026AbSDQCVZ>; Tue, 16 Apr 2002 22:21:25 -0400
Date: Tue, 16 Apr 2002 22:48:56 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] setup_per_cpu_areas in 2.5.8pre3
Message-Id: <20020416224856.538d3e65.rusty@rustcorp.com.au>
In-Reply-To: <UTC200204142115.VAA627059.aeb@cwi.nl>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2002 21:15:29 GMT
Andries.Brouwer@cwi.nl wrote:

> 
> Now that I am writing anyway, one of the changes I needed
> to compile 2.5.8pre3 is the following.

Yeah, better patch below (__GENERIC_PER_CPU implies SMP anyway).

> Of course the real fix is to remove the #ifdef's,
> maybe using a weak symbol instead, or some other construction
> that defines an empty default that can be replaced by an actual
> routine.

Not unless you make it as readable as the current code.  Having magic
appearing functions sounds cool, but beware that the cure might be
worse than the disease.

Yes, I know this patch looks like I'm moving smp_init(), but really
it's moving the #ifdef __GENERIC_PER_CPU bit past the SMP #endif.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8/init/main.c working-2.5.8-percpu/init/main.c
--- linux-2.5.8/init/main.c	Mon Apr 15 11:47:50 2002
+++ working-2.5.8-percpu/init/main.c	Tue Apr 16 21:11:50 2002
@@ -274,6 +274,18 @@
 
 #else
 
+/* Called by boot processor to activate the rest. */
+static void __init smp_init(void)
+{
+	/* Get other processors into their bootup holding patterns. */
+	smp_boot_cpus();
+
+	smp_threads_ready=1;
+	smp_commence();
+}
+
+#endif
+
 #ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS];
 
@@ -301,18 +313,6 @@
 {
 }
 #endif /* !__GENERIC_PER_CPU */
-
-/* Called by boot processor to activate the rest. */
-static void __init smp_init(void)
-{
-	/* Get other processors into their bootup holding patterns. */
-	smp_boot_cpus();
-
-	smp_threads_ready=1;
-	smp_commence();
-}
-
-#endif
 
 /*
  * We need to finalize in a non-__init function or else race conditions

