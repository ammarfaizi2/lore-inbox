Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWBMKsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWBMKsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWBMKsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:48:35 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:54706 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932080AbWBMKse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:48:34 -0500
Date: Mon, 13 Feb 2006 11:46:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060213104645.GA17173@elte.hu>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> The boot sequence on s390 sometimes takes ages and we spend a very 
> long time (up to one or two minutes) in calibrate_migration_costs. The 
> time spent there differs from boot to boot. Also the calculated costs 
> differ a lot. I've seen differences by up to a factor of 15 (yes, 
> factor not percent). Also I doubt that making these measurements make 
> much sense on a completely virtualized architecture where you cannot 
> tell how much cpu time you will get anyway. Is there any workaround or 
> fix available so we can avoid seeing this?

which is the precise kernel version used? We toned down calibration a 
bit recently.

The immediate workaround would be to use the migration_cost=0 boot 
parameter.

Generally, i agree that it makes sense to not calibrate at all on 
virtual platforms. Does the patch below help?  It gives virtual 
platforms a way to provide a default migration cost and thus avoid the 
boot-time calibration altogether. (I have tested it on x86, it does the 
expected thing.) This needs to hit v2.6.16 too.

	Ingo

---------
introduce the CONFIG_DEFAULT_MIGRATION_COST method for an architecture
to set the scheduler migration costs. This turns off automatic detection
of migration costs. Makes sense on virtual platforms, where migration
costs are hard to measure accurately.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 arch/s390/Kconfig |    4 ++++
 kernel/sched.c    |   13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

Index: linux-robust-list.q/arch/s390/Kconfig
===================================================================
--- linux-robust-list.q.orig/arch/s390/Kconfig
+++ linux-robust-list.q/arch/s390/Kconfig
@@ -80,6 +80,10 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
+config DEFAULT_MIGRATION_COST
+	int
+	default "1000000"
+
 config MATHEMU
 	bool "IEEE FPU emulation"
 	depends on MARCH_G5
Index: linux-robust-list.q/kernel/sched.c
===================================================================
--- linux-robust-list.q.orig/kernel/sched.c
+++ linux-robust-list.q/kernel/sched.c
@@ -5159,7 +5159,18 @@ static void init_sched_build_groups(stru
 #define MAX_DOMAIN_DISTANCE 32
 
 static unsigned long long migration_cost[MAX_DOMAIN_DISTANCE] =
-		{ [ 0 ... MAX_DOMAIN_DISTANCE-1 ] = -1LL };
+		{ [ 0 ... MAX_DOMAIN_DISTANCE-1 ] =
+/*
+ * Architectures may override the migration cost and thus avoid
+ * boot-time calibration. Unit is nanoseconds. Mostly useful for
+ * virtualized hardware:
+ */
+#ifdef CONFIG_DEFAULT_MIGRATION_COST
+			CONFIG_DEFAULT_MIGRATION_COST
+#else
+			-1LL
+#endif
+};
 
 /*
  * Allow override of migration cost - in units of microseconds.
