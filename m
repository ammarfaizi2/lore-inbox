Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUJaCUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUJaCUj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUJaCUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:20:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52444 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261473AbUJaCU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:20:26 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041030231358.6f1eeeac@mango.fruits.de>
References: <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
	 <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu>
	 <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu>
	 <20041030214738.1918ea1d@mango.fruits.de>
	 <1099165925.1972.22.camel@krustophenia.net>
	 <20041030221548.5e82fad5@mango.fruits.de>
	 <1099167996.1434.4.camel@krustophenia.net>
	 <20041030231358.6f1eeeac@mango.fruits.de>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 22:20:24 -0400
Message-Id: <1099189225.1754.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 23:13 +0200, Florian Schmidt wrote: 
> On Sat, 30 Oct 2004 16:26:35 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Take a look at the patch I posted to jackit-devel the other day to
> > calculate the CPU speed (previously we grabbed it from /proc/cpuinfo).
> > I just copied the code from realfeel2.
> > 
> 
> ah, ok.. tarball updated. The third argument is now a percentage. If the
> cycle count difference between two different wakeups differs more than the
> specified percentage from the "perfect" period, then a line is printed to
> the terminal showing by how much percent it differs. 
> 
> flo
> 

Here is a patch that causes the number of consecutive missed interrupts
to be printed, as well as setting RT priority itself instead of relying
on the rt_wakeup wrapper.

I have found that moving the mouse quickly will reliably cause many
interrupts to be missed.

Lee

--- wakeup/wakeup.cc	2004-10-30 17:11:08.000000000 -0400
+++ wakeup2/wakeup.cc	2004-10-30 21:03:21.000000000 -0400
@@ -90,6 +90,22 @@
 }
 // realfeel
 
+int set_realtime_priority(void)
+{
+	struct sched_param schp;
+	/*
+	 * set the process to realtime privs
+	 */
+	memset(&schp, 0, sizeof(schp));
+	schp.sched_priority = sched_get_priority_max(SCHED_FIFO);
+	
+	if (sched_setscheduler(0, SCHED_FIFO, &schp) != 0) {
+		perror("sched_setscheduler");
+		exit(1);
+	}
+
+	return 0;
+}
 
 
 
@@ -181,6 +197,8 @@
     perror("ioctl");
     exit(errno);
   }
+ 
+  set_realtime_priority();
   
   unsigned int irqs = 0;
   unsigned int missed_irqs = 0;
@@ -220,7 +238,7 @@
     irqs += data;
     // std::cout << data << std::endl;
     if (data > 1) {
-      std::cout << "ouch! we missed one ore more irq[s]" << std::endl;
+      std::cout << "ouch! we missed " << data << " or more irq[s]" << std::endl;
       missed_irqs++;
     }
   }

Lee


