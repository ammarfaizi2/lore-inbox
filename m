Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316381AbSEOMSI>; Wed, 15 May 2002 08:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316382AbSEOMSH>; Wed, 15 May 2002 08:18:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54789 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316381AbSEOMSG>; Wed, 15 May 2002 08:18:06 -0400
Message-Id: <200205151214.g4FCEqY13273@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: William Lee Irwin III <wli@holomorphy.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC][PATCH] iowait statistics
Date: Wed, 15 May 2002 15:17:26 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20020514153956.GI15756@holomorphy.com> <Pine.LNX.4.44L.0205141335080.9490-100000@duckman.distro.conectiva> <20020514165414.GC27957@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2002 14:54, William Lee Irwin III wrote:
> On Tue, 14 May 2002, William Lee Irwin III wrote:
> >> This appears to be global across all cpu's. Maybe nr_iowait_tasks
> >> should be accounted on a per-cpu basis, where
>
> On Tue, May 14, 2002 at 01:36:00PM -0300, Rik van Riel wrote:
> > While your proposal should work, somehow I doubt it's worth
> > the complexity. It's just a statistic to help sysadmins ;)
>
> I reserved judgment on that in order to present a possible mechanism.
> I'm not sure it is either; we'll know it matters if sysadmins scream.

Hi Rik,

Since you are working on this piece of kernel,

I was investigating why sometimes in top I see idle % like
9384729374923.43%. It was caused by idle count in /proc/stat
going backward sometimes.

I found the race responsible for that and have a fix for it
(attached below). It checks for jiffies change and regenerate
stats if jiffies++ hit us.

Unfortunately it is for UP case only, in SMP race still exists,
even on SMP kernel on UP box.

Why: system/user/idle[/iowait] stats are collected at timer int
on UP but _on local APIC int_ on SMP.

It can be fixed for SMP:
* add spinlock
or
* add per_cpu_idle, account it too at timer/APIC int
  and get rid of idle % calculations for /proc/stat

As a user, I vote for glitchless statistics even if they
consume extra i++ cycle every timer int on every CPU.

Now you hear very first scream :-)
--
vda

--- fs/proc/proc_misc.c.orig	Wed Nov 21 03:29:09 2001
+++ fs/proc/proc_misc.c	Thu Apr 25 13:57:55 2002
@@ -239,38 +239,47 @@
 				 int count, int *eof, void *data)
 {
 	int i, len;
-	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	extern unsigned long total_forks; /*FIXME: move into a .h */
+	unsigned long jif, sum, user, nice, system;
 	int major, disk;

-	for (i = 0 ; i < smp_num_cpus; i++) {
-		int cpu = cpu_logical_map(i), j;
-
-		user += kstat.per_cpu_user[cpu];
-		nice += kstat.per_cpu_nice[cpu];
-		system += kstat.per_cpu_system[cpu];
+	do {
+		jif=jiffies;
+		sum = user = nice = system = 0;
+		for (i = 0 ; i < smp_num_cpus; i++) {
+			int cpu = cpu_logical_map(i), j;
+			user += kstat.per_cpu_user[cpu];
+			nice += kstat.per_cpu_nice[cpu];
+			system += kstat.per_cpu_system[cpu];
 #if !defined(CONFIG_ARCH_S390)
-		for (j = 0 ; j < NR_IRQS ; j++)
-			sum += kstat.irqs[cpu][j];
+			for (j = 0 ; j < NR_IRQS ; j++)
+				sum += kstat.irqs[cpu][j];
 #endif
-	}
-
-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
-	for (i = 0 ; i < smp_num_cpus; i++)
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
-			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+		}
+
+		len = sprintf(page, "cpu  %lu %lu %lu %lu\n",
+			    user, nice, system,
+			    jif*smp_num_cpus - (user+nice+system)
+			    );
+		for (i = 0 ; i < smp_num_cpus; i++) {
+			int cpu = cpu_logical_map(i);
+			len += sprintf(page + len, "cpu%d %lu %lu %lu %lu\n",
+				i,
+				(unsigned long)kstat.per_cpu_user[cpu],
+				(unsigned long)kstat.per_cpu_nice[cpu],
+				(unsigned long)kstat.per_cpu_system[cpu],
+				jif - ( kstat.per_cpu_user[cpu]
+					+ kstat.per_cpu_nice[cpu]
+					+ kstat.per_cpu_system[cpu]));
+		}
+	} while(jif!=jiffies); /* regenerate if there was a timer interrupt */
+				/* TODO: check SMP case: SMP uses local APIC ints
+				for kstat updates, not a timer int... */
+
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
-		"intr %u",
+		"intr %lu",
 			kstat.pgpgin >> 1,
 			kstat.pgpgout >> 1,
 			kstat.pswpin,
