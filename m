Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSG2Kx1>; Mon, 29 Jul 2002 06:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSG2Kx1>; Mon, 29 Jul 2002 06:53:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27268 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315178AbSG2Kx0>; Mon, 29 Jul 2002 06:53:26 -0400
Date: Mon, 29 Jul 2002 16:27:30 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020729162730.A2393@in.ibm.com>
References: <20020726204033.D18570@in.ibm.com> <3D41990A.EDC1A530@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D41990A.EDC1A530@zip.com.au>; from akpm@zip.com.au on Fri, Jul 26, 2002 at 11:46:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 11:46:34AM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai wrote:
> > 
> > Here is a Scalable statistics counter implementation which works on top
> > of the kmalloc_percpu dynamic allocator published by Dipankar.
> > This patch is against 2.5.27.
> > 
> > ...
> > +static inline int __statctr_init(statctr_t *stctr)
> > +{
> > +       stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), GFP_ATOMIC);
> > +       if(!stctr->ctr)
> > +               return -1;
> > +       return 0;
> > +}
> 
> Minor nit: please force the caller to pass in the gfp_flags when
> designing an API like this.  The fact that you were forced to use
> GFP_ATOMIC here shows why...

Yep, I'll do that with the next release.

<snip>  

> General comment:  we need to clean up the kernel_stat stuff.  We
> cannot just make it per-cpu because it is 32k in size already.  I
> would suggest that we should break out the disk accounting and
> make the rest of kernel_stat per CPU.
> 
> That would be a great application of your interface, and a good
> way to get your interface merged ;)  Is that something which you
> have time to do?

Sure,... anything to get these interfaces merged :)

Are you looking at something on the lines as the diff below? 
What about /proc/stat ? Is it a good idea to have separate /proc files
for disk stats and cpu usage stats? (It'll be good for statctrs that way,
applications monitoring disk_stats only don't cause statctr_reads on
cpu_usage stats then)

--- linux-2.5.29/include/linux/kernel_stat.h	Sat Jul 27 08:28:36 2002
+++ statctr-2.5.29/include/linux/kernel_stat.h	Mon Jul 29 14:21:18 2002
@@ -15,10 +15,13 @@
 #define DK_MAX_MAJOR 16
 #define DK_MAX_DISK 16
 
-struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
+struct cpu_usage_stat {
+	statctr_t	cpu_user;
+	statctr_t	cpu_nice;
+	statctr_t	cpu_system;
+};
+
+struct disk_stat {
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
@@ -26,13 +29,18 @@
 	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
-	unsigned int pgalloc, pgfree;
-	unsigned int pgactivate, pgdeactivate;
-	unsigned int pgfault, pgmajfault;
-	unsigned int pgscan, pgsteal;
-	unsigned int pageoutrun, allocstall;
+        unsigned int pgalloc, pgfree;
+        unsigned int pgactivate, pgdeactivate;
+        unsigned int pgfault, pgmajfault;
+        unsigned int pgscan, pgsteal;
+        unsigned int pageoutrun, allocstall;
+};
+
+struct kernel_stat {
+	struct cpu_usage_stat 	cpu_stat;
+	struct disk_stat	disk_stat;
 #if !defined(CONFIG_ARCH_S390)
-	unsigned int irqs[NR_CPUS][NR_IRQS];
+	statctr_t irqs[NR_IRQS];
 #endif
 };
 
@@ -44,8 +52,8 @@
  * Maybe we need to smp-ify kernel_stat some day. It would be nice to do
  * that without having to modify all the code that increments the stats.
  */
-#define KERNEL_STAT_INC(x) kstat.x++
-#define KERNEL_STAT_ADD(x, y) kstat.x += y
+#define DISK_STAT_INC(x) kstat.disk_stat.x++
+#define DISK_STAT_ADD(x, y) kstat.disk_sat.x += y
 
 #if !defined(CONFIG_ARCH_S390)
 /*
@@ -53,12 +61,7 @@
  */
 static inline int kstat_irqs (int irq)
 {
-	int i, sum=0;
-
-	for (i = 0 ; i < NR_CPUS ; i++)
-		sum += kstat.irqs[i][irq];
-
-	return sum;
+	return statctr_read(&kstat.irqs[irq]);
 }
 #endif

