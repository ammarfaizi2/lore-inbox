Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317878AbSGZRnc>; Fri, 26 Jul 2002 13:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317881AbSGZRnc>; Fri, 26 Jul 2002 13:43:32 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:59890 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317878AbSGZRna>;
	Fri, 26 Jul 2002 13:43:30 -0400
Date: Fri, 26 Jul 2002 10:46:45 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200207261746.g6QHkjUp005023@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: performance experiment
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch that implements an alternate version of the core-loop
of do_select().  I'm interested in hearing how the two versions
(original and new) compare on various architectures.  The new loop
happens to perform better on ia64 and I suspect the same will be true
for most RISC platforms.  It wouldn't surprise me if the new loop
performed better even on some instances of x86.  I suspect on older
x86s (e.g., 80486), the old loop does better.  If someone is running
Linux on a Transmeta Crusoe chip, I'd be *very* interested in hearing
how the two loops perform there.

Here is what I'm proposing to do: if a couple of people are willing to
try out the patch below, I'll collect the results and post a summary.
To make sure we're comparing apples to apples, I'd like to suggest to
run LMbench 2 with and without the patch below.  Then send me the
select results from the raw results file.  For example, you would run
lmbench like so:

	$ make rerun

Then look at the results file, which is stored in
results/CONFIG/HOSTNAME.N.  For example, on a Pentium III machine
called "adler", the results of the first run would be stored in

	results/i686-pc-linux-gnu/adler.0

I'd prefer if you sent me the complete result files, but if you don't
want to do that, it should be good enough to mail me the first and
second line of the file, all the lines starting with "Select", and a
description of the machine you were testing (CPU type, clock speed,
chipset, memory size, and compiler version would be ideal).  For the
above example, the lines of interest would be:

 [lmbench2.0 results for Linux adler.hpl.hp.com 2.4.8 #1 Wed Aug 15 12:20:46 PDT 2001 i686 unknown]
 [LMBENCH_VER: Beta2.3 20010502085147]
 Select on 10 fd's: 1.8509 microseconds
 Select on 100 fd's: 8.2669 microseconds
 Select on 250 fd's: 18.9724 microseconds
 Select on 500 fd's: 36.6954 microseconds
 Select on 10 tcp fd's: 2.5548 microseconds
 Select on 100 tcp fd's: 15.4286 microseconds
 Select on 250 tcp fd's: 33.2831 microseconds
 Select on 500 tcp fd's: 65.4353 microseconds

IMPORTANT: please collect these results at least for a UP kernel.  If
you can supply the results for an SMP kernel (even if it's run only on
a single-processor machine), that'd be icing on the cake.

Thanks & happy hacking,

	--david

PS: I believe the alternate implementation is semantically identical
    to the old one.  But don't sue me if the kernel crashes and burns
    after applying the patch.

--- linux-2.4.18/fs/select.c	Mon Sep 24 15:08:21 2001
+++ lia64-2.4/fs/select.c	Fri Jul 26 10:28:35 2002
@@ -164,7 +164,7 @@
 int do_select(int n, fd_set_bits *fds, long *timeout)
 {
 	poll_table table, *wait;
-	int retval, i, off;
+	long retval, i, off;
 	long __timeout = *timeout;
 
  	read_lock(&current->files->file_lock);
@@ -182,6 +182,7 @@
 	retval = 0;
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
+#if 0
 		for (i = 0 ; i < n; i++) {
 			unsigned long bit = BIT(i);
 			unsigned long mask;
@@ -214,6 +215,55 @@
 				wait = NULL;
 			}
 		}
+#else
+		unsigned long *rinp, *routp, *rexp, *inp, *outp, *exp;
+
+		inp = fds->in; outp = fds->out; exp = fds->ex;
+		rinp = fds->res_in; routp = fds->res_out; rexp = fds->res_ex;
+
+		for (i = 0; i < n; ++rinp, ++routp, ++rexp) {
+			unsigned long in, out, ex, all_bits, bit = 1, mask, j;
+			unsigned long res_in = 0, res_out = 0, res_ex = 0;
+			struct file_operations *f_op;
+			struct file *file = NULL;
+
+			in = *inp++; out = *outp++; ex = *exp++;
+			all_bits = in | out | ex;
+			if (all_bits == 0)
+				continue;
+
+			for (j = 0; j < __NFDBITS; ++j, ++i, bit <<= 1) {
+				if (i >= n)
+					break;
+				if (!(bit & all_bits))
+					continue;
+				file = fget(i);
+				if (file)
+					f_op = file->f_op;
+				mask = DEFAULT_POLLMASK;
+				if (file) {
+					if (f_op && f_op->poll)
+						mask = (*f_op->poll)(file, retval ? NULL : wait);
+					fput(file);
+					if ((mask & POLLIN_SET) && (in & bit)) {
+						res_in |= bit;
+						retval++;
+					}
+					if ((mask & POLLOUT_SET) && (out & bit)) {
+						res_out |= bit;
+						retval++;
+					}
+					if ((mask & POLLEX_SET) && (ex & bit)) {
+						res_ex |= bit;
+						retval++;
+					}
+				}
+			}
+			if (res_in) *rinp = res_in;
+			if (res_out) *routp = res_out;
+			if (res_ex) *rexp = res_ex;
+		}
+#endif
 		wait = NULL;
 		if (retval || !__timeout || signal_pending(current))
 			break;
