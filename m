Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbUKVMGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbUKVMGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUKVMGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:06:42 -0500
Received: from mx1.elte.hu ([157.181.1.137]:8066 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261923AbUKVMEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:04:33 -0500
Date: Mon, 22 Nov 2004 14:05:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041122130519.GB13574@elte.hu>
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <49222.195.245.190.94.1100789179.squirrel@195.245.190.94> <20041118210517.GA8703@elte.hu> <1100818448.3476.17.camel@localhost> <20041119095451.GC27642@elte.hu> <1101115860.4182.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101115860.4182.7.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Meder <chris@onestepahead.de> wrote:

> * the other important factor is running the jvm in profiling mode,
> running without jvm or with the jvm in non-profiling mode leaves the
> box stable

ah ... CPU profiling i suspect needs SIGPROF, and that is one of the
things that i had to disable in -RT. But it seems this disabling wasnt
fully correct - could you try the patch i attached, does it change the
symptoms?

> So the simplest setup I found til now is the following: 
> 
> chris@blue:~$ java -version
> java version "1.4.1"
> Java(TM) 2 Runtime Environment, Standard Edition (build Blackdown-1.4.1-01)
> Java HotSpot(TM) Client VM (build Blackdown-1.4.1-01, mixed mode)
> chris@blue:~$ JAVA_OPTIONS=-Xrunhprof:cpu=samples,file=crap.log,depth=3 jython 
> Jython 2.1 on java1.4.1 (JIT: null)
> Type "copyright", "credits" or "license" for more information.
> >>>
> 
> Now moving the mouse around in X will make the box lockup in less than
> 10 seconds.
> 
> I'm not sure if JAVA_OPTIONS is a standard jython feature but at least
> it's part of the jython-wrapper script of Debian.

on a FC3 box this gives me:

 saturn:~> JAVA_OPTIONS=-Xrunhprof:cpu=samples,file=crap.log,depth=3 jython
 Exception in thread "main" java.lang.NoClassDefFoundError: error:

(i'm getting the same message when purely running 'jython')

i've got:

 saturn:~> java -version
 java version "1.4.2_03"
 Java(TM) 2 Runtime Environment, Standard Edition (build 1.4.2_03-b02)
 Java HotSpot(TM) Client VM (build 1.4.2_03-b02, mixed mode)

is my java setup botched perhaps?

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2354,12 +2354,12 @@ static inline void account_it_virt(struc
 
 	if (cputime_gt(it_virt, cputime_zero) &&
 	    cputime_gt(cputime, cputime_zero)) {
-#if 0
 		if (cputime_ge(cputime, it_virt)) {
 			it_virt = cputime_add(it_virt, p->it_virt_incr);
+#if 0
 			send_sig(SIGVTALRM, p, 1);
-		}
 #endif
+		}
 		it_virt = cputime_sub(it_virt, cputime);
 		p->it_virt_value = it_virt;
 	}
@@ -2376,12 +2376,12 @@ static void account_it_prof(struct task_
 
 	if (cputime_gt(it_prof, cputime_zero) &&
 	    cputime_gt(cputime, cputime_zero)) {
-#if 0
 		if (cputime_ge(cputime, it_prof)) {
 			it_prof = cputime_add(it_prof, p->it_prof_incr);
+#if 0
 			send_sig(SIGPROF, p, 1);
-		}
 #endif
+		}
 		it_prof = cputime_sub(it_prof, cputime);
 		p->it_prof_value = it_prof;
 	}
@@ -2395,7 +2395,6 @@ static void account_it_prof(struct task_
  */
 static void check_rlimit(struct task_struct *p, cputime_t cputime)
 {
-#if 0
 	cputime_t total, tmp;
 
 	total = cputime_add(p->utime, p->stime);
@@ -2403,14 +2402,19 @@ static void check_rlimit(struct task_str
 	if (unlikely(cputime_gt(total, tmp))) {
 		/* Send SIGXCPU every second. */
 		tmp = cputime_sub(total, cputime);
-		if (cputime_to_secs(tmp) < cputime_to_secs(total))
+		if (cputime_to_secs(tmp) < cputime_to_secs(total)) {
+#if 0
 			send_sig(SIGXCPU, p, 1);
+#endif
+		}
 		/* and SIGKILL when we go over max.. */
 		tmp = jiffies_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_max);
-		if (cputime_gt(total, tmp))
+		if (cputime_gt(total, tmp)) {
+#if 0
 			send_sig(SIGKILL, p, 1);
-	}
 #endif
+		}
+	}
 }
 
 /*
