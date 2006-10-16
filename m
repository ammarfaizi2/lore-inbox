Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWJPW7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWJPW7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWJPW7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:59:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:27586 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161151AbWJPW7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:59:10 -0400
From: Neil Brown <neilb@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Date: Tue, 17 Oct 2006 08:58:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17716.3749.114642.108540@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: 2.6.19-rc2 cpu hotplug lockdep  warning: possible circular locking dependency
In-Reply-To: message from Ravikiran G Thirumalai on Monday October 16
References: <20061016085439.GA6651@localhost.localdomain>
	<20061016111511.3901be27.akpm@osdl.org>
	<20061016192615.GA3746@localhost.localdomain>
	<20061016124808.20123a01.akpm@osdl.org>
	<20061016224330.GB3746@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 16, kiran@scalex86.org wrote:
> (Was: [patch] slab: Fix a cpu hotplug race condition while tuning slab cpu
> caches)
> 
> On Mon, Oct 16, 2006 at 12:48:08PM -0700, Andrew Morton wrote:
> > > 
> > > Not when I tested it.  I just retested with lockdep on and things seemed 
> > > fine on a SMP.
> > 
> > Great, thanks.  Please ensure that lockdep is used when testing the kernel.
> >  Also preempt, DEBUG_SLAB, DEBUG_SPINLOCK_SLEEP and various other things. 
> > I guess the list in Documentation/SubmitChecklist is the definitive one.
> 
> Seems like cpu offline spits out lockdep warnings when actually offlining a 
> CPU with CPU_HOTPLUG + CONFIG_PREEMPT + CONFIG_SLAB_DEBUG etc.  Here is the 
> trace I get.  Note that this is plain 2.6.19-rc2 (_without_ the slab cpu 
> hotplug fix).

That one is fixed by the following patch which will be in the next
-mm.

Thanks,
NeilBrown

Convert cpu hotplug notifiers to use raw_notifier instead of blocking_notifier

The use of blocking notifier by _cpu_up and _cpu_down in cpu.c
has two problem.

1/ An interaction with the workqueue notifier causes lockdep to
   spit a warning.
2/ A notifier could conceivable be added or removed while _cpu_up or
   _cpu_down are in process.  As each notifier is called twice 
   (prepare then commit/abort) this could be unhealthy.

To fix to we simply take cpu_add_remove_lock while adding
or removing notifiers to/from the list.

This makes the 'blocking' usage unnecessary as all accesses to
cpu_chain are now protected by cpu_add_remove_lock.  So
change "blocking" to "raw" in all relevant places.
This fixes 1.

Credit: Andrew Morton
Cc:  rusty@rustcorp.com.au


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./kernel/cpu.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff .prev/kernel/cpu.c ./kernel/cpu.c
--- .prev/kernel/cpu.c	2006-10-16 15:41:11.000000000 +1000
+++ ./kernel/cpu.c	2006-10-13 14:33:49.000000000 +1000
@@ -19,7 +19,7 @@
 static DEFINE_MUTEX(cpu_add_remove_lock);
 static DEFINE_MUTEX(cpu_bitmask_lock);
 
-static __cpuinitdata BLOCKING_NOTIFIER_HEAD(cpu_chain);
+static __cpuinitdata RAW_NOTIFIER_HEAD(cpu_chain);
 
 /* If set, cpu_up and cpu_down will return -EBUSY and do nothing.
  * Should always be manipulated under cpu_add_remove_lock
@@ -68,7 +68,11 @@ EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 /* Need to know about CPUs going up/down? */
 int __cpuinit register_cpu_notifier(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&cpu_chain, nb);
+	int ret;
+	mutex_lock(&cpu_add_remove_lock);
+	ret = raw_notifier_chain_register(&cpu_chain, nb);
+	mutex_unlock(&cpu_add_remove_lock);
+	return ret;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -77,7 +81,9 @@ EXPORT_SYMBOL(register_cpu_notifier);
 
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&cpu_chain, nb);
+	mutex_lock(&cpu_add_remove_lock);
+	raw_notifier_chain_unregister(&cpu_chain, nb);
+	mutex_unlock(&cpu_add_remove_lock);
 }
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
@@ -126,7 +132,7 @@ static int _cpu_down(unsigned int cpu)
 	if (!cpu_online(cpu))
 		return -EINVAL;
 
-	err = blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
+	err = raw_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
 						(void *)(long)cpu);
 	if (err == NOTIFY_BAD) {
 		printk("%s: attempt to take down CPU %u failed\n",
@@ -146,7 +152,7 @@ static int _cpu_down(unsigned int cpu)
 
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
-		if (blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
+		if (raw_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
 				(void *)(long)cpu) == NOTIFY_BAD)
 			BUG();
 
@@ -169,7 +175,7 @@ static int _cpu_down(unsigned int cpu)
 	put_cpu();
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
-	if (blocking_notifier_call_chain(&cpu_chain, CPU_DEAD,
+	if (raw_notifier_call_chain(&cpu_chain, CPU_DEAD,
 			(void *)(long)cpu) == NOTIFY_BAD)
 		BUG();
 
@@ -206,7 +212,7 @@ static int __devinit _cpu_up(unsigned in
 	if (cpu_online(cpu) || !cpu_present(cpu))
 		return -EINVAL;
 
-	ret = blocking_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
+	ret = raw_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
 		printk("%s: attempt to bring up CPU %u failed\n",
 				__FUNCTION__, cpu);
@@ -223,11 +229,11 @@ static int __devinit _cpu_up(unsigned in
 	BUG_ON(!cpu_online(cpu));
 
 	/* Now call notifier in preparation. */
-	blocking_notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
+	raw_notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
 	if (ret != 0)
-		blocking_notifier_call_chain(&cpu_chain,
+		raw_notifier_call_chain(&cpu_chain,
 				CPU_UP_CANCELED, hcpu);
 
 	return ret;
