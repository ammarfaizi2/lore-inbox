Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUIDSgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUIDSgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUIDSgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:36:03 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:9163 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265462AbUIDSf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:35:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
Date: Sat, 4 Sep 2004 20:35:59 +0200
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200408272154.i7RLsJk02714@owlet.beaverton.ibm.com>
In-Reply-To: <200408272154.i7RLsJk02714@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PsgOBEfhbuguhQu"
Message-Id: <200409042035.59743.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PsgOBEfhbuguhQu
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 27 of August 2004 23:54, Rick Lindsley wrote:
[- snip -]
> Okay.  A schedstats patch for 2.6.8.1 is available at
> 
>     http://eaglet.rain.com/rick/linux/schedstat/patches/schedstat-2.6.8.1
>     or
>     http://oss.software.ibm.com/linux/patches/?patch_id=730
> 

It seems that after applying it one has to apply the two attached patches to 
the kernel to get it compile on a UP system.

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman

--Boundary-00=_PsgOBEfhbuguhQu
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="schedstat-2.6.8.1-sched.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="schedstat-2.6.8.1-sched.h.patch"

--- orig/linux-2.6.8.1/include/linux/sched.h	2004-09-04 20:13:39.950362408 +0200
+++ linux/include/linux/sched.h	2004-09-04 19:39:10.965895856 +0200
@@ -590,6 +590,14 @@
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 
+enum idle_type
+{
+	IDLE,
+	NOT_IDLE,
+	NEWLY_IDLE,
+	MAX_IDLE_TYPES
+};
+
 #ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
 
@@ -601,14 +609,6 @@
 #define SD_WAKE_BALANCE		32	/* Perform balancing at task wakeup */
 #define SD_SHARE_CPUPOWER	64	/* Domain members share cpu power */
 
-enum idle_type
-{
-	IDLE,
-	NOT_IDLE,
-	NEWLY_IDLE,
-	MAX_IDLE_TYPES
-};
-
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
 	cpumask_t cpumask;

--Boundary-00=_PsgOBEfhbuguhQu
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="schedstat-2.6.8.1-sched.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="schedstat-2.6.8.1-sched.c.patch"

--- orig/linux-2.6.8.1/kernel/sched.c	2004-09-04 20:13:39.958361192 +0200
+++ linux/kernel/sched.c	2004-09-04 19:42:53.097126776 +0200
@@ -342,10 +342,12 @@
 	seq_printf(seq, "timestamp %lu\n", jiffies);
 	for_each_online_cpu (cpu) {
 
+#ifdef CONFIG_SMP
 		int dcnt = 0;
 
-		runqueue_t *rq = cpu_rq(cpu);
 		struct sched_domain *sd;
+#endif
+		runqueue_t *rq = cpu_rq(cpu);
 
 		/* runqueue-specific stats */
 		seq_printf(seq, 
@@ -368,6 +370,7 @@
 
 		seq_printf(seq, "\n");
 
+#ifdef CONFIG_SMP
 		/* domain-specific stats */
 		for_each_domain(cpu, sd) {
 			char mask_str[NR_CPUS];
@@ -386,6 +389,7 @@
 			    sd->sbe_pushed, sd->sbe_attempts,
 			    sd->ttwu_wake_affine, sd->ttwu_wake_balance);
 		}
+#endif
 	}
 	return 0;
 }

--Boundary-00=_PsgOBEfhbuguhQu--
