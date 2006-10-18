Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWJREk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWJREk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWJREk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:40:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39394 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932081AbWJREk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:40:56 -0400
Date: Wed, 18 Oct 2006 05:40:54 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: dealing with excessive includes
Message-ID: <20061018044054.GH29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 08:24:55AM -0700, Linus Torvalds wrote:
> > FWIW, that reminds me - I ought to resurrect the patchset killing bogus 
> > dependencies; I modified sparse to collect stats on how many times each 
> > #include actually pulls a header during build, added those to data on 
> > dependencies (from .cmd.*) and got interesting results.
> 
> Yeah, we tend to include a _ton_ of stuff that we probably don't need to.

See ftp://ftp.linux.org.uk/pub/people/viro/counts for some fun current stats;
there I've put the number of files depending on given header (all stats for
amd64 allmodconfig).  It's too long to post, but here are some observations:
	* look at the distribution of headers by the number of
depenendencies; it's very suggestive.  We have

10 in range 4360--4369
 4 in range 4350--4359
25 in range 4340--4349
31 in range 4330--4339
30 in range 4320--4329
 5 in range 4310--4319
55 in range 4300--4309
 2 in range 4280--4289
 1 in range 3910--3919
 2 in range 3900--3909
 7 in range 3890--3899
 2 in range 3790--3799
 1 in range 3780--3789
 5 in range 3740--3749
11 in range 3730--3739
 2 in range 3300--3309
 5 in range 3290--3299
 1 in range 3180--3189

	Note the huge gaps *and* very high local concentrations.  It actually
gets even more impressive if we look in finer details: in range 4300--4309
the distribution is
4305:	37
4306:	 2
4307:	 6
4308:	13
	Now, every widely included header is going to pull a tail in that
distribution; that is expected.  However, the large number hitting exact
same spot is not.  That's where the things get really interesting; let's
take a look at the pile at 4305:
   4305   include/asm/signal.h
   4305   include/asm/siginfo.h
   4305   include/asm/sembuf.h
   4305   include/asm/seccomp.h
   4305   include/asm/resource.h
   4305   include/asm/ipcbuf.h
   4305   include/asm/cputime.h
   4305   include/asm/auxvec.h
   4305   include/linux/unistd.h
   4305   include/linux/uio.h
   4305   include/linux/signal.h
   4305   include/linux/sem.h
   4305   include/linux/securebits.h
   4305   include/linux/seccomp.h
   4305   include/linux/sched.h
   4305   include/linux/rtmutex.h
   4305   include/linux/resource.h
   4305   include/linux/rbtree.h
   4305   include/linux/pid.h
   4305   include/linux/param.h
   4305   include/linux/ktime.h
   4305   include/linux/ipc.h
   4305   include/linux/hrtimer.h
   4305   include/linux/futex.h
   4305   include/linux/fs_struct.h
   4305   include/linux/completion.h
   4305   include/linux/capability.h
   4305   include/linux/auxvec.h
   4305   include/linux/aio_abi.h
   4305   include/linux/aio.h
   4305   include/asm-generic/signal.h
   4305   include/asm-generic/siginfo.h
   4305   include/asm-generic/resource.h
   4305   include/asm-generic/cputime.h

There is an obvious candidate in creators of that pile: linux/sched.h.  It's
(a) very high in distribution and (b) pulls quite a few headers itself.

Now, the next question is how much of that pile is pulled by linux/sched.h.
The answer is "all of them".  It certainly means that something's badly
wrong.  In particular, there is not a single C file that would pull signal.h
but not sched.h; *all* information about the real use of that signal.h is
drowned.  And 4305 is very high; the top of list is
   4369   include/asm/types.h
   4368   include/linux/compiler.h
   4366   include/linux/compiler-gcc4.h
   4366   include/linux/compiler-gcc.h
   4365   include/asm/linkage.h
   4365   include/linux/linkage.h
   4361   include/asm/posix_types.h
   4361   include/linux/types.h
   4361   include/linux/stddef.h
   4361   include/linux/posix_types.h
and those are pulled practically by everything.

So which #include is responsible for that mess?  Apriori we might just
have it directly pulled all over the place.  However, the situation turns
out to be very different.  Top pullers are:
   4305 include/linux/futex.h
   3918 include/asm/compat.h
   3892 include/linux/module.h
   3739 include/linux/radix-tree.h
   3738 include/linux/fs.h
   3295 include/linux/mm.h
   3173 include/asm/uaccess.h
   2644 include/linux/smp_lock.h
   2300 include/linux/interrupt.h

Now, futex.h is simply mutual pull with sched.h.  Odd idea, of course, but
it doesn't affect the picture unless we have tons of independent pulls of
futex.h.  Unlikely.

asm/compat.h is curious one.  Main puller of that bugger is asm/elf.h.
AFAICS, it has no reason whatsoever to pull compat.h, let alone sched.h.

asm/elf.h is a member of a cluster similar to sched.h one.  Here it is:
   3918   include/asm/compat.h
   3906   include/asm/user.h
   3902   include/linux/elf-em.h
   3895   include/asm/elf.h
   3894   include/linux/elf.h
   3893   include/linux/moduleparam.h
   3892   include/asm/module.h
   3892   include/asm/local.h
   3892   include/linux/module.h
   3892   include/linux/kmod.h
and module.h is the obvious leader (the next above is
   4282   include/linux/stat.h
and below we have
   3791   include/asm/ioctl.h
).  BTW, radix-tree.h is also in a cluster - fs.h one...

So the natural plan of attack would be
	* try to kill asm-x86_64/elf.h -> asm-x86_64/compat.h
	* try to kill linux/module.h -> linux/sched.h
	* see what falls out.
The first one is simply killable.  No problems arise from its removal.
That drives the count of asm/compat.h from 3918 to 266 (which is already
something), but doesn't affect anything else.

module.h is trickier.  First of all, we want extern for wake_up_process().
And unlike the first severed include, we *do* have files that need something
from sched.h and rely on pulling it implicitly via module.h.  Fortunately,
there are few of those.  For amd64 allmodconfig we only need to touch includes
in
 arch/i386/kernel/cpu/mcheck/therm_throt.c
 drivers/hwmon/abituguru.c
 drivers/leds/ledtrig-ide-disk.c
 drivers/leds/ledtrig-timer.c
 drivers/scsi/scsi_transport_sas.c
 drivers/w1/slaves/w1_therm.c
 include/linux/phy.h
 kernel/latency.c
and in almost all cases we are actually missing jiffies.h, not sched.h.
However, at that point we really need to look at other targets; they
do add several extra places, but again not much.  Below is what I've got
from my usual mix of cross-builds; for resulting dependeny counts (again,
amd64 allmodconfig) see ftp://ftp.linux.org.uk/pub/people/viro/counts-after.
Not too bad for a trivial patch, IMO.

The next obvious targets for sched.h are fs.h and mm.h, but that's going
to be trickier.

diff --git a/arch/i386/kernel/alternative.c b/arch/i386/kernel/alternative.c
index 28ab806..e7f7322 100644
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -1,4 +1,5 @@
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <asm/alternative.h>
diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
index 2d8703b..bad8b44 100644
--- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
@@ -20,6 +20,7 @@ #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <linux/notifier.h>
+#include <linux/jiffies.h>
 #include <asm/therm_throt.h>
 
 /* How long to wait between reporting thermal events */
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4bef76a..1f745f1 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -5,6 +5,7 @@
 #include <linux/sysdev.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/device.h>
diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index e5cb0fd..b1dc63e 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -21,6 +21,7 @@
     etc voltage & frequency control is not supported!
 */
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
diff --git a/drivers/leds/ledtrig-ide-disk.c b/drivers/leds/ledtrig-ide-disk.c
index fa65188..54b155c 100644
--- a/drivers/leds/ledtrig-ide-disk.c
+++ b/drivers/leds/ledtrig-ide-disk.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/timer.h>
diff --git a/drivers/leds/ledtrig-timer.c b/drivers/leds/ledtrig-timer.c
index 179c287..2f9e3ba 100644
--- a/drivers/leds/ledtrig-timer.c
+++ b/drivers/leds/ledtrig-timer.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/list.h>
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index b5b0c2c..5c0b75b 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -25,6 +25,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 5372cfc..b022fff 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -24,6 +24,7 @@ #include <asm/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/delay.h>
diff --git a/include/asm-x86_64/elf.h b/include/asm-x86_64/elf.h
index a406fcb..6d24ea7 100644
--- a/include/asm-x86_64/elf.h
+++ b/include/asm-x86_64/elf.h
@@ -45,7 +45,6 @@ #define ELF_ARCH	EM_X86_64
 
 #ifdef __KERNEL__
 #include <asm/processor.h>
-#include <asm/compat.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/include/linux/acct.h b/include/linux/acct.h
index 0496d1f..302eb72 100644
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -119,6 +119,7 @@ #ifdef __KERNEL__
 #ifdef CONFIG_BSD_PROCESS_ACCT
 struct vfsmount;
 struct super_block;
+struct pacct_struct;
 extern void acct_auto_close_mnt(struct vfsmount *m);
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_init_pacct(struct pacct_struct *pacct);
diff --git a/include/linux/module.h b/include/linux/module.h
index d1d00ce..007a865 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -6,7 +6,6 @@ #define _LINUX_MODULE_H
  * Rewritten by Richard Henderson <rth@tamu.edu> Dec 1996
  * Rewritten again by Rusty Russell, 2002
  */
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/stat.h>
@@ -410,6 +409,8 @@ static inline int try_module_get(struct 
 	return ret;
 }
 
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+
 static inline void module_put(struct module *module)
 {
 	if (module) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 9447a57..f7c2dca 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -20,6 +20,8 @@ #define __PHY_H
 
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/timer.h>
 
 #define PHY_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
 				 SUPPORTED_10baseT_Full | \
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 401192e..efa7385 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -25,6 +25,8 @@ #define LIBISCSI_H
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <scsi/iscsi_proto.h>
 #include <scsi/iscsi_if.h>
 
diff --git a/kernel/latency.c b/kernel/latency.c
index 258f255..e63fcac 100644
--- a/kernel/latency.c
+++ b/kernel/latency.c
@@ -36,6 +36,7 @@ #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/jiffies.h>
 #include <asm/atomic.h>
 
 struct latency_info {
diff --git a/kernel/module.c b/kernel/module.c
index 67009bd..c7945b7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -34,10 +34,10 @@ #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/vermagic.h>
 #include <linux/notifier.h>
+#include <linux/sched.h>
 #include <linux/stop_machine.h>
 #include <linux/device.h>
 #include <linux/string.h>
-#include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/unwind.h>
 #include <asm/uaccess.h>
