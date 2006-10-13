Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWJMEt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWJMEt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 00:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJMEt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 00:49:58 -0400
Received: from mail.suse.de ([195.135.220.2]:40913 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750780AbWJMEt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 00:49:57 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 13 Oct 2006 14:49:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17711.6883.764895.822786@cse.unsw.edu.au>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rusty@rustcorp.com.au
Subject: Re: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
In-Reply-To: message from Andrew Morton on Thursday October 12
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
	<17709.62567.429791.797941@cse.unsw.edu.au>
	<20061012010406.e799e036.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 12, akpm@osdl.org wrote:
> On Thu, 12 Oct 2006 17:53:11 +1000
> Neil Brown <neilb@suse.de> wrote:
> 
> > I think I'm in favour of the following. 
> 
> Would be simpler to take cpu_add_remove_lock in
> [un]register_cpu_notifier().  I actually thought I'd done that to fix this
> bug but must have forgotten or lost the patch :(
> 
> We can then convert all the notifier chains in there to raw_*.

The two philosophers gaped at him.

"Bloody hell," said Majikthise, "now that is what I call
thinking. Here Vroomfondel, why do we never think of things like
that?" 

"Dunno," said Vroomfondel in an awed whisper, "think our brains must
be too highly trained Majikthise." 

[ http://flag.blackened.net/dinsdale/dna/book1.html ]

I guess you'll be wanting this then, unless you have done it already.

NeilBrown

-----------
Subject: Convert cpu hotplug notifiers to use raw_notifier instead of blocking_notifier

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
Cc:  rusty@rustcorp.com.au (maintainer)
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com> (reporter)
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./kernel/cpu.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff .prev/kernel/cpu.c ./kernel/cpu.c
--- .prev/kernel/cpu.c	2006-10-13 14:30:56.000000000 +1000
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
