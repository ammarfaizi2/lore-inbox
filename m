Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTFFCN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 22:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbTFFCN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 22:13:29 -0400
Received: from smtp.sw.oz.au ([203.31.96.1]:3492 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S264582AbTFFCN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 22:13:26 -0400
Date: Fri, 6 Jun 2003 12:26:53 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
Message-ID: <20030606122653.B29095@aurema.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	trivial@rustcorp.com.au
References: <205830000.1054566142@[10.10.2.4]> <Pine.LNX.4.33.0306021107260.31561-100000@router.windsormachine.com> <20030605171915.A29095@aurema.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030605171915.A29095@aurema.com>; from kingsley@aurema.com on Thu, Jun 05, 2003 at 05:19:15PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2003 at 05:19:15PM +1000, Kingsley Cheung wrote:
 
> I raised this earlier in March this year. See:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104804927502272&w=2
> 
> I sent to Rusty trivial patch for the fix against 2.4.20 back then. 
> 

Attached is a trivial patch to fix the problem against 2.5.70.  I've
also attached the trivial 2.4.20 patch I sent to Rusty back for
completeness.

-- 
		Kingsley

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc_misc-2.5.70.patch"

--- linux/fs/proc/proc_misc.c.orig	Fri Jun  6 12:13:44 2003
+++ linux/fs/proc/proc_misc.c	Fri Jun  6 12:14:46 2003
@@ -51,6 +51,9 @@
 #include <asm/tlb.h>
 #include <asm/div64.h>
 
+/* System boot time in seconds since the UNIX epoch.  */
+static time_t boottime;
+
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 /*
@@ -378,7 +381,6 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	u64 jif = get_jiffies_64() - INITIAL_JIFFIES;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
 
 	for (i = 0 ; i < NR_CPUS; i++) {
@@ -419,15 +421,14 @@
 		len += sprintf(page + len, " %u", kstat_irqs(i));
 #endif
 
-	do_div(jif, HZ);
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
-		"btime %lu\n"
+		"btime %ld\n"
 		"processes %lu\n"
 		"procs_running %lu\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
-		xtime.tv_sec - (unsigned long) jif,
+		boottime,
 		total_forks,
 		nr_running(),
 		nr_iowait());
@@ -612,6 +613,7 @@
 
 void __init proc_misc_init(void)
 {
+	u64 jif = get_jiffies_64() - INITIAL_JIFFIES;
 	struct proc_dir_entry *entry;
 	static struct {
 		char *name;
@@ -638,6 +640,10 @@
 		{"execdomains",	execdomains_read_proc},
 		{NULL,}
 	};
+
+	/* Intialise system boot time before creating /proc/stat entry. */
+	do_div(jif, HZ);
+	boottime = xtime.tv_sec - (time_t)jif;
 	for (p = simple_ones; p->name; p++)
 		create_proc_read_entry(p->name, 0, NULL, p->read_proc, NULL);
 

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc_misc-2.4.20.patch"

--- linux-2.4.20/fs/proc/proc_misc.c	Fri Mar 28 15:53:52 2003
+++ linux-2.4.20_boottime/fs/proc/proc_misc.c	Fri Mar 28 15:34:21 2003
@@ -41,6 +41,9 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+/* System boot time in seconds since the UNIX epoch.  */
+static time_t boottime;
+
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 /*
@@ -372,10 +375,10 @@
 
 	proc_sprintf(page, &off, &len,
 		"\nctxt %u\n"
-		"btime %lu\n"
+		"btime %ld\n"
 		"processes %lu\n",
 		kstat.context_swtch,
-		xtime.tv_sec - jif / HZ,
+		boottime,     
 		total_forks);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
@@ -580,6 +583,9 @@
 		{"execdomains",	execdomains_read_proc},
 		{NULL,}
 	};
+
+	/* Intialise system boot time before creating /proc/stat entry. */
+	boottime = xtime.tv_sec - jiffies / HZ;
 	for (p = simple_ones; p->name; p++)
 		create_proc_read_entry(p->name, 0, NULL, p->read_proc, NULL);
 

--4Ckj6UjgE2iN1+kY--
