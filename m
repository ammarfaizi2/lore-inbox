Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTEVDPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 23:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTEVDPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 23:15:09 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:64474 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262464AbTEVDPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 23:15:06 -0400
Subject: [PATCH][2.4][CPUFREQ] Allow user to force speedstep speed
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: davej@codemonkey.org.uk
Content-Type: multipart/mixed; boundary="=-hQH4re+6GYsc/aJRDcvA"
Organization: 
Message-Id: <1053574090.1448.19.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 May 2003 23:28:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hQH4re+6GYsc/aJRDcvA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As the comment says, IANAKG so this may be way wrong.  "It works for
me"..

Basically it adds "speedstep_default" as a module param (untested!) and
as a boot-time option to allow forcing of cpufreq default policy. (It is
only implemented for speedstep, but should be easily ported to others;
if it doesn't have any other glaring flaws I may do so unless someone
beats me to it.)

My laptop (Dell Inspiron) gives no bios option to force cpufreq speed -
it is either completely disabled or based on the AC status at boot.  (It
also has ACPI instead of APM, so swsusp is my friend..)  The problem is
that if you suspend in performance mode and then boot without AC, the
bios forces it to powersave mode and things get weird - /proc/cpufreq
indicates powersave, but /proc/cpuinfo shows the performance speed (and
bogomips).  At one point while testing that I found that my 2g p4m was
reporting at around 3.8g (wow!), I suspect due to suspending in
powersave (1.2g) and restoring in performance.

This patch (plus a small addition to the pre/post suspend scripts in
swsusp) allows you to set the cpu to a known value on suspend and then
restore that on resume, before the swsusp handler kicks in.  (For module
users it won't help, but they may want to force policy at modprobe and
the change was minimal to allow that.)  I've run through a few
boot/suspend/resume cycles here without managing to confuse it, and the
(AFAICT) worst side-effect is either jumping to performance mode on
batteries or booting/resuming in powersave mode while on AC, depending
on your choice of 'known state'.

These patches are against 2.4.21-rc2 and "speedstep.c,v 1.68 2003/01/20
17:31:47" (the cpufreq patch is actually from -ck5, cleaned up for
mostly-bare 2.4.21-rc2, as I can't find a valid repository for cpufreq
other than the cvs snapshots.)

Params.diff is to Documentation/kernel-parameters (adds 'CPUFREQ' as a
depends-on [] flag and information about speedstep_default) and
speedstep.diff is for arch/i386/kernel/speedstep.c

Comments encouraged, I'm on the list.

-- 
Disconnect <lkml@sigkill.net>

--=-hQH4re+6GYsc/aJRDcvA
Content-Disposition: attachment; filename=params.diff
Content-Type: text/plain; name=params.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- Documentation/kernel-parameters.txt.orig	2003-05-21 23:01:55.000000000 -0400
+++ Documentation/kernel-parameters.txt	2003-05-21 23:05:29.000000000 -0400
@@ -15,6 +15,7 @@
 	APM 	Advanced Power Management support is enabled.
 	AX25	Appropriate AX.25 support is enabled.
 	CD	Appropriate CD support is enabled.
+	CPUFREQ	Appropriate cpufreq driver is enabled
 	DEVFS   devfs support is enabled. 
 	DRM	Direct Rendering Management support is enabled. 
 	EFI	EFI Partitioning (GPT) is enabled
@@ -580,6 +581,11 @@
 
 	specialix=	[HW,SERIAL] Specialix multi-serial port adapter.
 
+	speedstep_default=	[CPUFREQ,SPEEDSTEP] Force cpufreq to specific 
+				speed, integer from include/linux/cpufreq.h 
+				CPUFREQ_POLICY_* (CPUFREQ_POLICY_GOVERNOR not 
+				supported)
+
 	sscape=		[HW,SOUND]
  
 	st=		[HW,SCSI] SCSI tape parameters (buffers, etc.).

--=-hQH4re+6GYsc/aJRDcvA
Content-Disposition: attachment; filename=speedstep.diff
Content-Type: text/plain; name=speedstep.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- arch/i386/kernel/speedstep.c.orig	2003-05-21 22:59:41.000000000 -0400
+++ arch/i386/kernel/speedstep.c	2003-05-21 23:08:17.000000000 -0400
@@ -49,6 +49,7 @@
  */
 static unsigned int                     speedstep_processor = 0;
 static int                              speedstep_coppermine = 0;
+static int                              speedstep_default_speed = 0;
 
 #define SPEEDSTEP_PROCESSOR_PIII_C      0x00000001  /* Coppermine core */
 #define SPEEDSTEP_PROCESSOR_PIII_T      0x00000002  /* Tualatin core */
@@ -638,11 +639,15 @@
 		(speed / 1000));
 
 	/* cpuinfo and default policy values */
-	policy->policy = (speed == speedstep_low_freq) ? 
-		CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
+	if(speedstep_default_speed==0)
+		policy->policy = (speed == speedstep_low_freq) ? 
+			CPUFREQ_POLICY_POWERSAVE : CPUFREQ_POLICY_PERFORMANCE;
+	else
+		policy->policy = speedstep_default_speed;
+
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->cur = speed;
-
+	
 	return cpufreq_frequency_table_cpuinfo(policy, &speedstep_freqs[0]);
 }
 
@@ -663,7 +668,32 @@
 	speedstep_coppermine = simple_strtoul(str, &str, 0);
 	return 1;
 }
+
+/**
+ * speedstep_set_default
+ * 
+ * Ripped blatantly from the coppermine handling, this is for
+ * forcing cpufreq to set a specific policy/speed on init.
+ *
+ * Coded up for use with swsusp (it gets weird if you suspend at
+ * one speed and resume at another) but it might be generally useful.
+ *
+ * IANAKG so this may be very wrong.
+ */
+static int __init speedstep_set_default(char *str)
+{
+	speedstep_default_speed=simple_strtoul(str,&str,0);
+	if (speedstep_default_speed != CPUFREQ_POLICY_POWERSAVE &&
+			speedstep_default_speed != CPUFREQ_POLICY_PERFORMANCE) {
+		printk(KERN_INFO "cpufreq: Unknown default: %s\n",str);
+		speedstep_default_speed=0;
+	} else 
+		printk(KERN_INFO "cpufreq: Default forced: %s\n", (speedstep_default_speed == CPUFREQ_POLICY_PERFORMANCE) ? "performance" : "powersave");
+	return 1;
+}
+
 __setup("speedstep_coppermine=", speedstep_setup);
+__setup("speedstep_default=", speedstep_set_default);
 #endif
 
 
@@ -672,7 +702,7 @@
 	.target 	= speedstep_target,
 	.init		= speedstep_cpu_init,
 	.exit		= NULL,
-	.policy		= NULL,
+	.policy		= (speedstep_set_default? speedstep_set_default : NULL),
 	.name		= "speedstep",
 };
 
@@ -719,7 +749,7 @@
 
 
 MODULE_PARM (speedstep_coppermine, "i");
-
+MODULE_PARM (speedstep_default_speed, "i");
 MODULE_AUTHOR ("Dave Jones <davej@suse.de>, Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION ("Speedstep driver for Intel mobile processors.");
 MODULE_LICENSE ("GPL");

--=-hQH4re+6GYsc/aJRDcvA--

