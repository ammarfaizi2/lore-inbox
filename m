Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVG1Kqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVG1Kqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVG1Kqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:46:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45073 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261353AbVG1Kok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:44:40 -0400
Date: Thu, 28 Jul 2005 12:44:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>,
       rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix MTRR compilation with SMP=n
Message-ID: <20050728104439.GE3572@stusta.de>
References: <20050728025840.0596b9cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 02:58:40AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc3-mm2:
>...
> +alpha-fix-statement-with-no-effect-warnings.patch
> 
>  Alpha warning fixes
>...

This patch broke the compilation on i386 with CONFIG_SMP=n and 
CONFIG_MTRR=y:

<--  snip  -->

...
  CC      arch/i386/kernel/cpu/mtrr/main.o
arch/i386/kernel/cpu/mtrr/main.c: In function 'set_mtrr':
arch/i386/kernel/cpu/mtrr/main.c:225: error: 'ipi_handler' undeclared (first use in this function)
arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is reported only once
arch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)
make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm3/arch/i386/kernel/cpu/mtrr/main.c.old	2005-07-28 12:36:09.000000000 +0200
+++ linux-2.6.13-rc3-mm3/arch/i386/kernel/cpu/mtrr/main.c	2005-07-28 12:39:35.000000000 +0200
@@ -221,9 +221,11 @@
 	atomic_set(&data.count, num_booting_cpus() - 1);
 	atomic_set(&data.gate,0);
 
+#ifdef CONFIG_SMP
 	/*  Start the ball rolling on other CPUs  */
 	if (smp_call_function(ipi_handler, &data, 1, 0) != 0)
 		panic("mtrr: timed out waiting for other CPUs\n");
+#endif  /*  CONFIG_SMP  */
 
 	local_irq_save(flags);
 

