Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270769AbUJURti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270769AbUJURti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbUJURnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:43:43 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:48803
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270781AbUJUPtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:49:55 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9 HOTFIX
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041021132717.GA29153@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098373313.27089.15.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 17:41:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 15:27, Ingo Molnar wrote:
> i have released the -U9 Real-Time Preemption patch, which can be
> downloaded from:

tglx

diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U9/kernel/sched.c
2.6.9-rc4-mm1-U9-E0/kernel/sched.c
--- 2.6.9-rc4-mm1-RT-U9/kernel/sched.c	2004-10-21 15:47:21.000000000
+0200
+++ 2.6.9-rc4-mm1-U9-E0/kernel/sched.c	2004-10-21 17:17:44.000000000
+0200
@@ -3185,9 +3185,9 @@
 			__set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock_irq(&x->wait.lock);
 			timeout = schedule_timeout(timeout);
+			spin_lock_irq(&x->wait.lock);
 			if (!timeout)
 				goto out;
-			spin_lock_irq(&x->wait.lock);
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}
@@ -3250,8 +3250,10 @@
 			}
 			__set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irq(&x->wait.lock);
-			schedule();
-			spin_lock_irq(&x->wait.lock);
+			timeout = schedule_timeout(timeout);
+ 			spin_lock_irq(&x->wait.lock);
+			if (!timeout)
+				goto out;
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}


