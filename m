Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSJ1O0v>; Mon, 28 Oct 2002 09:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbSJ1O0v>; Mon, 28 Oct 2002 09:26:51 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:23725 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261258AbSJ1O0o>; Mon, 28 Oct 2002 09:26:44 -0500
Date: Mon, 28 Oct 2002 16:29:33 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Marc Giger <gigerstyle@gmx.ch>, linux-kernel@vger.kernel.org
Cc: ducrot@poupinou.org
Subject: Re: cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available
Message-ID: <20021028162932.B888@brodo.de>
References: <20021026105611.3d6a540c.gigerstyle@gmx.ch> <12722.1035652076@www50.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <12722.1035652076@www50.gmx.net>; from gigerstyle@gmx.ch on Sat, Oct 26, 2002 at 07:07:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marc,

> Why is cpufreq on my laptop not available? I know it works with window$.
> My laptop has an Intel P3 speedstep cpu which supports 600Mhz and 500Mhz
> clock frequency. Will it be supported in the future?
>
> CPU model name      : Pentium III (Coppermine)
>
> 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)

There's a small bug in speedstep.c which causes the initialization process
to fail on all Coppermines. A fix for this had been sent to Linus already;
it's also attached.

Unfortunately, this won't change much on your notebook. Now the line in
dmesg will say "Intel SpeedStep for this chipset not (yet) available." as
Intel continues to withhold information on how to use SpeedStep on 440BX/MX
chipsets (and even removes documentation which had been publicly available on
their servers). However, in an effort mainly lead by Bruno Ducrot,
reverse-engineering is making progress. SpeedStep already works on some
440BX/MX based notebooks, on others -like the one I'm using- it's still a
mystery. 

During the next days, I'll make a patch and further information available.

	Dominik

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq-2.5.44-i386-speedstep-1"

diff -ruN linux-2543original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-2543original/arch/i386/kernel/cpu/cpufreq/speedstep.c	Wed Oct  9 00:44:45 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Thu Oct 17 15:52:49 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: speedstep.c,v 1.53 2002/09/29 23:43:11 db Exp $
+ *  $Id: speedstep.c,v 1.54 2002/10/10 15:52:55 db Exp $
  *
  * (C) 2001  Dave Jones, Arjan van de ven.
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
@@ -72,7 +72,7 @@
 #ifdef SPEEDSTEP_DEBUG
 #define dprintk(msg...) printk(msg)
 #else
-#define dprintk(msg...) do { } while(0);
+#define dprintk(msg...) do { } while(0)
 #endif
 
 
@@ -490,14 +490,14 @@
 			/* platform ID seems to be 0x00140000 */
 			rdmsr(MSR_IA32_PLATFORM_ID, msr_lo, msr_hi);
 			dprintk(KERN_DEBUG "cpufreq: Coppermine: MSR_IA32_PLATFORM ID is 0x%x, 0x%x\n", msr_lo, msr_hi);
-			msr_hi = msr_lo & 0x001c0000;
-			if (msr_hi != 0x00140000)
+			msr_lo = msr_hi & 0x001c0000;
+			if (msr_lo != 0x00140000)
 				return 0;
 
 			/* and these bits seem to be either 00_b, 01_b or
 			 * 10_b but never 11_b */
-			msr_lo &= 0x00030000;
-			if (msr_lo == 0x0030000)
+			msr_hi &= 0x00030000;
+			if (msr_hi == 0x0030000)
 				return 0;
 
 			/* let's hope this is correct... */
@@ -644,11 +644,11 @@
 		speedstep_processor = speedstep_detect_processor();
 
 	if ((!speedstep_chipset) || (!speedstep_processor)) {
-		dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet) available.\n", speedstep_processor ? "chipset" : "processor");
+		printk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet) available.\n", speedstep_processor ? "chipset" : "processor");
 		return -ENODEV;
 	}
 
-	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.53 $\n");
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.54 $\n");
 	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n", 
 	       speedstep_chipset, speedstep_processor);
 

--mP3DRpeJDSE+ciuQ--
