Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbTFLBGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTFLBGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:06:37 -0400
Received: from mail.aurema.com ([203.31.96.1]:21381 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S264652AbTFLBGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:06:32 -0400
Date: Thu, 12 Jun 2003 11:20:11 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
Message-ID: <20030612112011.C29095@aurema.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <205830000.1054566142@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <205830000.1054566142@[10.10.2.4]>; from mbligh@aracnet.com on Mon, Jun 02, 2003 at 08:02:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 02, 2003 at 08:02:22AM -0700, Martin J. Bligh wrote:
>            Summary: btime in /proc/stat wobbles (even over 30 seconds)
>     Kernel Version: 2.5.70 but also in 2.2.20
>             Status: NEW
>           Severity: normal
>              Owner: johnstul@us.ibm.com
>          Submitter: h.lambermont@aramiska.net
> 
> 
> Distribution: Debian and Red Hat
> Hardware Environment: i386
> Software Environment: /proc
> Problem Description:
> 
> btime in /proc/stat changes over time. We even see it wobble over 30 seconds.
> See also
> http://www.google.nl/search?q=cache:ISSy3HrMcvQJ:bugzilla.redhat.com/bugzilla/long_list.cgi%3Fbuglist%3D75107+btime+/proc/stat&hl=nl&ie=UTF-8
> 
> Steps to reproduce:
> 
> Comparing /proc/stat's btime every minute shows the differences.
> We see this behaviour on all of our 1500 Linux machines.

I see that there has been a fix made for this since 2.5.70-bk13 or
2.5.70-bk14 that solves this problem by using the seqlock to ensure
that the jiffies and time of day are atomically read.

However, wouldn't it be better to have the boottime calculated only
once so that it is independent of changes in the system time that may
occur later?  Even with the fix with seqlock, the boottime can still
change back or forwards whenever the system time is set back or
forwards.  IMHO an unchanging boottime that is independent of the time
of day is the best approach.  Maybe something like the patch against
2.5.70-bk14 that I've attached.

What do people think?

-- 
		Kingsley

--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc_misc-2.5.70-bk14.patch"

--- linux/fs/proc/proc_misc.c.orig	Tue Jun 10 11:03:31 2003
+++ linux/fs/proc/proc_misc.c	Tue Jun 10 11:13:08 2003
@@ -51,6 +51,9 @@
 #include <asm/tlb.h>
 #include <asm/div64.h>
 
+/* System boot time in seconds since the UNIX epoch.  */
+static time_t boottime;
+
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 /*
@@ -378,23 +381,7 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	u64 jif;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
-	struct timeval now; 
-	unsigned long seq;
-
-	/* Atomically read jiffies and time of day */ 
-	do {
-		seq = read_seqbegin(&xtime_lock);
-
-		jif = get_jiffies_64();
-		do_gettimeofday(&now);
-	} while (read_seqretry(&xtime_lock, seq));
-
-	/* calc # of seconds since boot time */
-	jif -= INITIAL_JIFFIES;
-	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
-	do_div(jif, HZ);
 
 	for (i = 0 ; i < NR_CPUS; i++) {
 		int j;
@@ -436,12 +423,12 @@
 
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
-		"btime %lu\n"
+		"btime %ld\n"
 		"processes %lu\n"
 		"procs_running %lu\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
-		(unsigned long)jif,
+		boottime,
 		total_forks,
 		nr_running(),
 		nr_iowait());
@@ -626,6 +613,9 @@
 
 void __init proc_misc_init(void)
 {
+	u64 jif;
+	unsigned long seq;
+	struct timeval now; 
 	struct proc_dir_entry *entry;
 	static struct {
 		char *name;
@@ -652,6 +642,24 @@
 		{"execdomains",	execdomains_read_proc},
 		{NULL,}
 	};
+
+	/* 
+	 * Intialise system boot time before creating /proc/stat
+	 * entry.  This way we avoid it changing whenever the system
+	 * time is changed.  Atomically read jiffies and time of day.
+	 */ 
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		jif = get_jiffies_64();
+		do_gettimeofday(&now);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	/* calc # of seconds since boot time */
+	jif -= INITIAL_JIFFIES;
+	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
+	do_div(jif, HZ);
+	boottime = (time_t)jif;
+
 	for (p = simple_ones; p->name; p++)
 		create_proc_read_entry(p->name, 0, NULL, p->read_proc, NULL);
 

--NDin8bjvE/0mNLFQ--
