Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264177AbTEaGrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTEaGrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:47:36 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:59011
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264177AbTEaGrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:47:35 -0400
Date: Sat, 31 May 2003 02:50:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <pan.2003.05.31.04.41.25.903565@interlinx.bc.ca>
Message-ID: <Pine.LNX.4.50.0305310246250.31414-100000@montezuma.mastecende.com>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz> <20030528173432.GA21379@linux.interlinx.bc.ca>
 <Pine.LNX.4.50.0305281341160.1982-100000@montezuma.mastecende.com>
 <pan.2003.05.30.22.14.35.511205@interlinx.bc.ca>
 <Pine.LNX.4.50.0305301907230.29718-100000@montezuma.mastecende.com>
 <pan.2003.05.31.03.38.16.701826@interlinx.bc.ca> <pan.2003.05.31.04.41.25.903565@interlinx.bc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Brian J. Murrell wrote:

> Just to confirm now, I have modified Zwane's patch add another kernel arg,
> [no]locapictimer, which deals with dont_use_local_apic_timer in the same
> way his patch deals with the dont_enable_local_apic flag, and indeed, a
> kernel booted with "nolapic" does hang in the APIC timer calibration
> however a kernel booted with "nolocapictimer" does not.
> 
> Is it really valid to go and try to calibrate the APIC timer if it was
> disabled by the user, or even DMI?

bah, the early boot hacks are just ugly, we do detect_init_APIC early in 
traps code and then just blindly go frobbing the APIC anyway.

The following patch will honour the dont_enable_local_apic flag in the 
necessary places. If it works for you i'll forward it.

Index: linux-2.5/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
retrieving revision 1.50
diff -u -p -B -r1.50 apic.c
--- linux-2.5/arch/i386/kernel/apic.c	30 May 2003 20:14:41 -0000	1.50
+++ linux-2.5/arch/i386/kernel/apic.c	31 May 2003 05:53:34 -0000
@@ -665,6 +665,7 @@ static int __init detect_init_APIC (void
 	return 0;
 
 no_apic:
+	dont_enable_local_apic = 1;
 	printk("No local APIC present or hardware disabled\n");
 	return -1;
 }
@@ -1127,6 +1128,9 @@ asmlinkage void smp_error_interrupt(void
  */
 int __init APIC_init_uniprocessor (void)
 {
+	if (dont_enable_local_apic)
+		return -1;
+
 	if (!smp_found_config && !cpu_has_apic)
 		return -1;
 
-- 
function.linuxpower.ca
