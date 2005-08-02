Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVHBFSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVHBFSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVHBFSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:18:08 -0400
Received: from fmr19.intel.com ([134.134.136.18]:42406 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261368AbVHBFSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:18:06 -0400
Subject: Re: [ACPI] S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP
	600X))
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20050801070926.GI27580@elf.ucw.cz>
References: <20050730103034.GC1942@elf.ucw.cz>
	 <1122879094.3285.2.camel@linux-hp.sh.intel.com>
	 <20050801070926.GI27580@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 13:16:17 +0800
Message-Id: <1122959777.6864.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 09:09 +0200, Pavel Machek wrote:
> Hi!
> 
> > > If you think it is a linux bug, can you produce small test case doing 
> > > just the sigwait, and post it on l-k with big title "sigwait() breaks 
> > > when straced, and on suspend"?
> > > 
> > > That way it is going to get some attetion, and you'll get either 
> > > documentation or kernel fixed. 
> > Looks like a linux bug to me. The refrigerator fake signal waked the
> > task up and without restart for the sigwait case. How about below
> > patch:
> 
> Is there chance to fix strace case, too? sigwait() is broken in more
> than one way it seems...
This patch should fix two cases. Can anybody familiar with signal
handling look at it?
The posix standard said for sigtimedwait:
"If no signal in set is pending at the time of the call, the calling
thread shall be suspended until one or more signals in set become
pending or until it is interrupted by an unblocked, caught signal."
Systemcall might be restarted if it's not interrupted by a caught
signal.

Thanks,
Shaohua



---

 linux-2.6.13-rc4-root/kernel/signal.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN kernel/signal.c~sigwait-suspend-resume kernel/signal.c
--- linux-2.6.13-rc4/kernel/signal.c~sigwait-suspend-resume	2005-08-02 10:33:16.798179984 +0800
+++ linux-2.6.13-rc4-root/kernel/signal.c	2005-08-02 12:49:06.688208376 +0800
@@ -2231,7 +2231,8 @@ sys_rt_sigtimedwait(const sigset_t __use
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
-			try_to_freeze();
+			if (freezing(current))
+				return -ERESTARTNOINTR;
 			spin_lock_irq(&current->sighand->siglock);
 			sig = dequeue_signal(current, &these, &info);
 			current->blocked = current->real_blocked;
@@ -2250,7 +2251,7 @@ sys_rt_sigtimedwait(const sigset_t __use
 	} else {
 		ret = -EAGAIN;
 		if (timeout)
-			ret = -EINTR;
+			ret = -ERESTARTNOHAND;
 	}
 
 	return ret;
_



