Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbTFNIcb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbTFNIcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:32:31 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:20424 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S265648AbTFNIc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:32:29 -0400
Date: Sat, 14 Jun 2003 04:46:11 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.5. PATCH] cpufreq: correct initialization on Intel Coppermines
Message-ID: <20030614084611.GA10182@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
	cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
References: <20021108092241.A1636@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108092241.A1636@brodo.de>
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-7.2, required 5,
	BAYES_20, EMAIL_ATTRIBUTION, IN_REP_TO, PATCH_UNIFIED_DIFF,
	QUOTED_EMAIL_TEXT, REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On fri 08 nov 2002 09:30:08 GMT, Dominik Brodowski wrote:
> The detection process for speedstep-enabled Pentium III Coppermines is
> considered proprietary by Intel.

They seem to have changed their mind:

http://www.intel.com/support/processors/sb/cs-003779-prd24.htm

Which looks a bit like what was implemented at first. Here is a patch.
I kept the setup parameter, but it might be removed now?

--- linux-2.5.70-bk12/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-05-26 21:00:20.000000000 -0400
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-06-14 04:33:04.000000000 -0400
@@ -503,6 +503,15 @@
 			if (speedstep_coppermine)
 				return SPEEDSTEP_PROCESSOR_PIII_C;
 
+			/* if the processor is a mobile version,
+			 * platform ID has bit 50 set
+			 * it has SpeedStep technology if either
+			 * bit 56 or 57 is set */
+			rdmsr(MSR_IA32_PLATFORM_ID, msr_lo, msr_hi);
+			dprintk(KERN_DEBUG "cpufreq: Coppermine: MSR_IA32_PLATFORM ID is 0x%x, 0x%x\n", msr_lo, msr_hi);
+			if ((msr_hi & (1<<18)) && (msr_hi & (3<<24)))
+				return SPEEDSTEP_PROCESSOR_PIII_C;
+
 			printk(KERN_INFO "cpufreq: in case this is a SpeedStep-capable Intel Pentium III Coppermine\n");
 			printk(KERN_INFO "cpufreq: processor, please pass the boot option or module parameter\n");
 			printk(KERN_INFO "cpufreq: `speedstep_coppermine=1` to the kernel. Thanks!\n");
