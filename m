Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVHAGvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVHAGvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVHAGvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:51:14 -0400
Received: from fmr20.intel.com ([134.134.136.19]:39055 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262358AbVHAGvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:51:11 -0400
Subject: Re: [ACPI] S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP
	600X))
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20050730103034.GC1942@elf.ucw.cz>
References: <20050730103034.GC1942@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 14:51:34 +0800
Message-Id: <1122879094.3285.2.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 18:30 +0800, Pavel Machek wrote:
> Hi!
> 
> > >> One other glitch is that pdnsd (a nameserver caching daemon) has
> crashed 
> > >> when the system wakes up from swsusp.  It also happens when
> waking up 
> > >> from S3, which was working with 2.6.11.4 although not with
> 2.6.13-rc3. 
> > >> Many people have said mysql also does not suspend well.  Is their
> use of 
> > >> a named pipe or socket causing the problem? 
> >  
> > > No idea, strace? 
> >  
> > The upshot of stracing is in tthe Debian BTS <bugs.debian.org> 
> > #319572.  Paul Rombouts, an author of pdnsd, reproduced the strace 
> > crash and found the problem: 
> >  
> > > Apparently strace causes sigwait to return EINTR, which is 
> > > inconsistent with the documentation I could find on sigwait. 
> >  
> > Which is true.  The sigwait man entry (Debian 'etch') says: 
> >        The !sigwait! function never returns an error. 
> >  
> > His patch (available in the BTS and included below) fixed the
> problem 
> > of strace or S3 sleep crashing pdnsd.
> 
> If you think it is a linux bug, can you produce small test case doing 
> just the sigwait, and post it on l-k with big title "sigwait() breaks 
> when straced, and on suspend"?
> 
> That way it is going to get some attetion, and you'll get either 
> documentation or kernel fixed. 
Looks like a linux bug to me. The refrigerator fake signal waked the
task up and without restart for the sigwait case. How about below patch:


Thanks,
Shaohua
---

 linux-2.6.13-rc4-root/kernel/signal.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -puN kernel/signal.c~sigwait-suspend-resume kernel/signal.c
--- linux-2.6.13-rc4/kernel/signal.c~sigwait-suspend-resume	2005-08-01 14:00:39.089460688 +0800
+++ linux-2.6.13-rc4-root/kernel/signal.c	2005-08-01 14:30:13.821660384 +0800
@@ -2188,6 +2188,7 @@ sys_rt_sigtimedwait(const sigset_t __use
 	struct timespec ts;
 	siginfo_t info;
 	long timeout = 0;
+	int recover = 0;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset_t))
@@ -2225,15 +2226,23 @@ sys_rt_sigtimedwait(const sigset_t __use
 			 * be awakened when they arrive.  */
 			current->real_blocked = current->blocked;
 			sigandsets(&current->blocked, &current->blocked, &these);
+do_recover:
 			recalc_sigpending();
 			spin_unlock_irq(&current->sighand->siglock);
 
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
-			try_to_freeze();
+			if (try_to_freeze())
+				recover = 1;
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
+			if (!sig && recover) {
+				if (timeout == 0)
+					timeout = MAX_SCHEDULE_TIMEOUT;
+				recover = 0;
+				goto do_recover;
+			}
 			current->blocked = current->real_blocked;
 			siginitset(&current->real_blocked, 0);
 			recalc_sigpending();
_


