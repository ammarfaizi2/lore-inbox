Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSHBAKg>; Thu, 1 Aug 2002 20:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSHBAKg>; Thu, 1 Aug 2002 20:10:36 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:48143 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S317351AbSHBAJy>;
	Thu, 1 Aug 2002 20:09:54 -0400
Date: Fri, 2 Aug 2002 02:12:58 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] solved APM bug with -rc5 (take 2)
Message-ID: <20020802001258.GA178@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local> <1028213732.14865.50.camel@irongate.swansea.linux.org.uk> <20020801135623.GA19879@alpha.home.local> <20020801152459.GA19989@alpha.home.local> <1028220826.14865.69.camel@irongate.swansea.linux.org.uk> <20020801203520.GA244@pcw.home.local> <1028240183.15022.99.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028240183.15022.99.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 11:16:23PM +0100, Alan Cox wrote:
> On Thu, 2002-08-01 at 21:35, Willy TARREAU wrote:
> > +#ifdef CONFIG_SMP
> > +	/* 2002/08/01 - WT
> > +	 * This is to avoid random crashes at boot time during initialization
> > +	 * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
> > +	 * Some bioses don't like being called from CPU != 0.
> > +	 */
> > +	while (cpu_number_map(smp_processor_id()) != 0) {
> > +		schedule();
> > +	}
> > +#endif
> 
> What guarantees that loop will ever exit ?

I asked Ingo for some advice, and he gently sent me a piece of code as an
example of how to reliably bind a task to a CPU. I tried it, and it's OK here.
I could reliably switch several times from cpu0 to cpu1, then back to cpu0.
Since it was cleaner than the previous method, I also did the same for
apm_power_off(), thus getting rid of apm_magic() and its dedicated thread.
Then again, I tested with multiple cpu switches, and every time, my system
correctly handles the case. I'm writing this mail under 2.4.19-rc5.

So here is the patch against 2.4.19-rc5, hoping it will get in this time.
I think it should apply without a glitch to 2.4.19-rc5-ac1, but don't
know about 2.5, nor even if it is needed.

Feedback welcome, of course ;-)

Cheers,
Willy


--- linux-2.4.19-rc5/arch/i386/kernel/apm.c	Thu Aug  1 22:07:39 2002
+++ linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c	Fri Aug  2 01:52:55 2002
@@ -862,14 +862,6 @@
 		apm_do_busy();
 }
 
-#ifdef CONFIG_SMP
-static int apm_magic(void * unused)
-{
-	while (1)
-		schedule();
-}
-#endif
-
 /**
  *	apm_power_off	-	ask the BIOS to power off
  *
@@ -897,10 +889,11 @@
 	 */
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
-	while (cpu_number_map(smp_processor_id()) != 0) {
-		kernel_thread(apm_magic, NULL,
-			CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
+	if (cpu_number_map(smp_processor_id()) != 0) {
+		current->cpus_allowed = 1;
 		schedule();
+		if (unlikely(cpu_number_map(smp_processor_id()) != 0))
+			BUG();
 	}
 #endif
 	if (apm_info.realmode_power_off)
@@ -1661,6 +1654,21 @@
 	strcpy(current->comm, "kapmd");
 	sigfillset(&current->blocked);
 
+#ifdef CONFIG_SMP
+	/* 2002/08/01 - WT
+	 * This is to avoid random crashes at boot time during initialization
+	 * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
+	 * Some bioses don't like being called from CPU != 0.
+	 * Method suggested by Ingo Molnar.
+	 */
+	if (cpu_number_map(smp_processor_id()) != 0) {
+		current->cpus_allowed = 1;
+		schedule();
+		if (unlikely(cpu_number_map(smp_processor_id()) != 0))
+			BUG();
+	}
+#endif
+	
 	if (apm_info.connection_version == 0) {
 		apm_info.connection_version = apm_info.bios.version;
 		if (apm_info.connection_version > 0x100) {
@@ -1707,7 +1715,7 @@
 		}
 	}
 
-	if (debug && (smp_num_cpus == 1)) {
+	if (debug) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");

