Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWJLHxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWJLHxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWJLHxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:53:31 -0400
Received: from ns.suse.de ([195.135.220.2]:20716 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422809AbWJLHx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:53:28 -0400
From: Neil Brown <neilb@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Date: Thu, 12 Oct 2006 17:53:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17709.62567.429791.797941@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rusty@rustcorp.com.au
Subject: Re: SPAM: Re: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
In-Reply-To: message from Arjan van de Ven on Thursday October 12
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	<6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	<17708.33450.608010.113968@cse.unsw.edu.au>
	<6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
	<1160565786.3000.369.camel@laptopd505.fenrus.org>
	<17708.60613.451322.747200@cse.unsw.edu.au>
	<20061011093920.32fc2d07.akpm@osdl.org>
	<17709.33386.884615.679131@cse.unsw.edu.au>
	<1160635872.3000.399.camel@laptopd505.fenrus.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 12, arjan@infradead.org wrote:
> On Thu, 2006-10-12 at 09:46 +1000, Neil Brown wrote:
> > On Wednesday October 11, akpm@osdl.org wrote:
> > > > 
> > > > So A waits on B and C, C waits on B, B waits on A.
> > > > Deadlock.
> > > 
> > > Except the entire operation is serialised by the the two top-level callers
> > > (cpu_up() and cpu_down()) taking mutex_lock(&cpu_add_remove_lock).  Can
> > > lockdep be taught about that?
> > 
> > So you are saying that even though we have locking sequences
> >   A -> B  and B -> A,
> > that cannot - in this case - cause a deadlock as both sequences only
> > ever happen under a third exclusive lock C,
> > So when lockdep records a lock-dependency A -> B, it should also
> > record a list of locks that are *always* held when that dependency
> > occurs.
> 
> in that case... why are A and B there *at all* ?
> 

:-)

Obviously because someone out-side of C might want to interact with
the data protected by A or B.

But wait... what are the implications of that.

The data managed by B (where B == cpu_chain.rwsem) is a list of 
notifiers.  Each notifier is called with CPU_DOWN_PREPARE and then
will be called with either CPU_DOWN_FAILED or CPU_DEAD.

Now because we release and reclaim B it is possible for someone to add
or remove a notifier.  Either of these event means that the relevant
notifier will get called with one of these but not the other.  It
seems likely that a notifier will be written to assume this
bracketing.
In fact workqueue_cpu_callback (which is such a notifier) does
		mutex_lock(&workqueue_mutex);
in CPU_DOWN_PREPARE and 
		mutex_unlock(&workqueue_mutex);
in CPU_DOWN_FAILED and CPU_DEAD.

If it got registered in the middle of _cpu_down, then it would unlock
a mutex that wasn't locked.  Now I suspect it cannot be registered
while _cpu_down is active as it is only registered once, very early.
But it certainly does raise the question of why all this locking
is needed....

I think I'm in favour of the following.  It should clean up the
lockdep warning and seems to make sense.

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./kernel/cpu.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff .prev/kernel/cpu.c ./kernel/cpu.c
--- .prev/kernel/cpu.c	2006-10-12 17:46:37.000000000 +1000
+++ ./kernel/cpu.c	2006-10-12 17:51:50.000000000 +1000
@@ -126,9 +126,11 @@ static int _cpu_down(unsigned int cpu)
 	if (!cpu_online(cpu))
 		return -EINVAL;
 
-	err = blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
+	down_read(&cpu_chain.rwsem);
+	err = raw_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
 						(void *)(long)cpu);
 	if (err == NOTIFY_BAD) {
+		up_read(&cpu_chain.rwsem);
 		printk("%s: attempt to take down CPU %u failed\n",
 				__FUNCTION__, cpu);
 		return -EINVAL;
@@ -146,11 +148,11 @@ static int _cpu_down(unsigned int cpu)
 
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
-		if (blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
+		if (raw_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
 				(void *)(long)cpu) == NOTIFY_BAD)
 			BUG();
 
-		err = PTR_ERR(p);
+			err = PTR_ERR(p);
 		goto out_allowed;
 	}
 
@@ -169,7 +171,7 @@ static int _cpu_down(unsigned int cpu)
 	put_cpu();
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
-	if (blocking_notifier_call_chain(&cpu_chain, CPU_DEAD,
+	if (raw_notifier_call_chain(&cpu_chain, CPU_DEAD,
 			(void *)(long)cpu) == NOTIFY_BAD)
 		BUG();
 
@@ -178,6 +180,7 @@ static int _cpu_down(unsigned int cpu)
 out_thread:
 	err = kthread_stop(p);
 out_allowed:
+	up_read(&cpu_chain.rwsem);
 	set_cpus_allowed(current, old_allowed);
 	return err;
 }
@@ -206,7 +209,8 @@ static int __devinit _cpu_up(unsigned in
 	if (cpu_online(cpu) || !cpu_present(cpu))
 		return -EINVAL;
 
-	ret = blocking_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
+	down_read(&cpu_chain.rwsem);
+	ret = raw_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
 		printk("%s: attempt to bring up CPU %u failed\n",
 				__FUNCTION__, cpu);
@@ -223,13 +227,13 @@ static int __devinit _cpu_up(unsigned in
 	BUG_ON(!cpu_online(cpu));
 
 	/* Now call notifier in preparation. */
-	blocking_notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
+	raw_notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
 	if (ret != 0)
-		blocking_notifier_call_chain(&cpu_chain,
+		raw_notifier_call_chain(&cpu_chain,
 				CPU_UP_CANCELED, hcpu);
-
+	up_read(&cpu_chain.rwsem);
 	return ret;
 }
 
