Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSHAUcP>; Thu, 1 Aug 2002 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSHAUcP>; Thu, 1 Aug 2002 16:32:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:8719 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S317005AbSHAUcO>;
	Thu, 1 Aug 2002 16:32:14 -0400
Date: Thu, 1 Aug 2002 22:35:20 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] solved APM bug with -rc5
Message-ID: <20020801203520.GA244@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local> <1028213732.14865.50.camel@irongate.swansea.linux.org.uk> <20020801135623.GA19879@alpha.home.local> <20020801152459.GA19989@alpha.home.local> <1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 05:53:46PM +0100, Alan Cox wrote:
> Very curious indeed because someone else reported that rc3-ac5 works
> (which has the same vm86 code). In addition the vm86 handler in the
> kernel isnt actually used for APM. We make 32bit APM calls and the one
> 16bit case we do is a true return to real mode.

I finally got rid of it ! I now understand why it hanged randomly, and
why I spent lots of time adding/removing unrelated patches. It's because
in apm=power-off mode (SMP), a kernel thread is started for the apm()
function, which does bios calls. And sometimes, the bios is called from
CPU >0, which my bios doesn't like at all, thus explaining why the oopses
were corrupted.

By copying a piece of code somewhere else in the same file, I could force
apm() to be used only by CPU0. I could verify that it doesn't crash anymore,
and that I can also crash it on demand if I force CPU1.

The bonus is that I could re-enable the debug code in this function even
in SMP mode since we're sure that it runs on CPU0.

Here is the patch against 2.4.19-rc5. Marcelo, Alan, please review and apply.

Cheers,
Willy


diff -urN linux-2.4.19-rc5/arch/i386/kernel/apm.c linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c
--- linux-2.4.19-rc5/arch/i386/kernel/apm.c	Thu Aug  1 22:07:39 2002
+++ linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c	Thu Aug  1 22:26:56 2002
@@ -1661,6 +1661,17 @@
 	strcpy(current->comm, "kapmd");
 	sigfillset(&current->blocked);
 
+#ifdef CONFIG_SMP
+	/* 2002/08/01 - WT
+	 * This is to avoid random crashes at boot time during initialization
+	 * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
+	 * Some bioses don't like being called from CPU != 0.
+	 */
+	while (cpu_number_map(smp_processor_id()) != 0) {
+		schedule();
+	}
+#endif
+	
 	if (apm_info.connection_version == 0) {
 		apm_info.connection_version = apm_info.bios.version;
 		if (apm_info.connection_version > 0x100) {
@@ -1707,7 +1718,7 @@
 		}
 	}
 
-	if (debug && (smp_num_cpus == 1)) {
+	if (debug) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
