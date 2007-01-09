Return-Path: <linux-kernel-owner+w=401wt.eu-S1751124AbXAII6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXAII6A (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 03:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXAII6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 03:58:00 -0500
Received: from cantor2.suse.de ([195.135.220.15]:60541 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbXAII57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 03:57:59 -0500
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org
Date: Tue, 9 Jan 2007 19:57:50 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17827.22798.625018.673326@notabene.brown>
Subject: [PATCH - RFC] allow setting vm_dirty below 1% for large memory machines
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Imagine a machine with lots of memory - say 100Gig.

Suppose there is one (largish) filesystem that is ext3 (or maybe
reiser) with the default data=ordered.

Suppose this filesystem is being written to steadily so that the
maximum amount of memory is always dirty.  With the default
vm.dirty_ratio of 40%, this could be 40Gig.

When the journal triggers a commit, all the dirty data needs to be
flushed out in order to adhere to the "data=ordered" semantics.
This can take a while.

While this is happening, some small updates such as 'atime' update can
block waiting for the journal to be unlocked again after the flush.

Waiting for 40gig to flush for an atime update to complete is clearly
unsatisfactory. 

We can reduce the amount of dirty memory by setting vm.dirty_ratio
down to 1 still allows 1Gig of dirty data which can cause unpleasant
pauses (and this was on a kernel where '1' still meant something.  In
current kernels, '5' is the effective minimum).

So this patch removes the minimum of '5' and introduces a new tunable
'vm.dirty_kb' which sets an upper limit in Kibibytes.

This allows the amount of dirty memory to be limited to - say - 50M
which should flush fast enough.

So: is this patch acceptable?  And should a lower default value for
vm_dirty_kb be used?


Some of the details in the above description might not be 100%
accurate (I'm not sure of the exact connection between atime updates
and journal commits).  The symptoms are:
  While generating constant write traffic on a machine with > 20Gig
  of RAM, performing assorted read-only operations can sometimes
  produces a pause of 10s of seconds.
  The pause can be removed by:
    - mounting noatime
    - mounting data=writeback
    - setting vm.dirty_kb to 1000 with this patch.

Maybe the problem is really just in atime updates, but I feel that it
is broader than that.

Thanks for any comments.

NeilBrown

-----------------
Allow fixed limit on amount of dirty memory.


On large memory machines, a interger percentage (dirty_ratio) does not
allow sufficiently fine control on the limit to the amount of dirty memory,
especially when that percentage is forced to be >=5.

So remove the >=5 restriction and introduce 'vm_dirty_kb' which sets
an upper limit in kibibytes to the amount of dirty memory.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/writeback.h |    1 +
 ./kernel/sysctl.c           |   11 +++++++++++
 ./mm/page-writeback.c       |   19 +++++++++++++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff .prev/include/linux/writeback.h ./include/linux/writeback.h
--- .prev/include/linux/writeback.h	2007-01-09 17:16:00.000000000 +1100
+++ ./include/linux/writeback.h	2007-01-09 17:16:31.000000000 +1100
@@ -95,6 +95,7 @@ static inline int laptop_spinned_down(vo
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int vm_dirty_ratio;
+extern int vm_dirty_kb;
 extern int dirty_writeback_interval;
 extern int dirty_expire_interval;
 extern int block_dump;

diff .prev/kernel/sysctl.c ./kernel/sysctl.c
--- .prev/kernel/sysctl.c	2007-01-09 17:16:00.000000000 +1100
+++ ./kernel/sysctl.c	2007-01-09 17:17:57.000000000 +1100
@@ -860,6 +860,17 @@ static ctl_table vm_table[] = {
 		.extra2		= &one_hundred,
 	},
 	{
+		.ctl_name	= -2,
+		.procname	= "dirty_kb",
+		.data		= &vm_dirty_kb,
+		.maxlen		= sizeof(vm_dirty_kb),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= NULL,
+	},
+	{
 		.ctl_name	= VM_DIRTY_WB_CS,
 		.procname	= "dirty_writeback_centisecs",
 		.data		= &dirty_writeback_interval,

diff .prev/mm/page-writeback.c ./mm/page-writeback.c
--- .prev/mm/page-writeback.c	2007-01-09 17:16:00.000000000 +1100
+++ ./mm/page-writeback.c	2007-01-09 17:52:55.000000000 +1100
@@ -75,6 +75,11 @@ int dirty_background_ratio = 10;
 int vm_dirty_ratio = 40;
 
 /*
+ * If that percentage exceeds this limit, use this instead
+ */
+int vm_dirty_kb = 10000000; /* 10 gigabytes, way too much really */
+
+/*
  * The interval between `kupdate'-style writebacks, in jiffies
  */
 int dirty_writeback_interval = 5 * HZ;
@@ -149,15 +154,21 @@ get_dirty_limits(long *pbackground, long
 	if (dirty_ratio > unmapped_ratio / 2)
 		dirty_ratio = unmapped_ratio / 2;
 
-	if (dirty_ratio < 5)
-		dirty_ratio = 5;
-
 	background_ratio = dirty_background_ratio;
 	if (background_ratio >= dirty_ratio)
 		background_ratio = dirty_ratio / 2;
+	if (dirty_background_ratio && !background_ratio)
+		background_ratio = 1;
 
-	background = (background_ratio * available_memory) / 100;
 	dirty = (dirty_ratio * available_memory) / 100;
+	if (dirty > vm_dirty_kb / (PAGE_SIZE/1024))
+		dirty = vm_dirty_kb / (PAGE_SIZE/1024);
+	if (dirty_ratio == 0)
+		background = 0;
+	else if (background_ratio >= dirty_ratio)
+		background = dirty / 2;
+	else
+		background = dirty * background_ratio / dirty_ratio;
 	tsk = current;
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
 		background += background / 4;
