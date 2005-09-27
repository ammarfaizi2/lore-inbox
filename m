Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVI0Iki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVI0Iki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVI0Iki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:40:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39864 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964867AbVI0Ikh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:40:37 -0400
Date: Tue, 27 Sep 2005 01:37:51 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
Message-Id: <20050927013751.47cbac8b.pj@sgi.com>
In-Reply-To: <20050926093432.9975870043@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[[ Added ckrm-tech@lists.sourceforge.net to the cc list ]]

Welcome Takahiro-san.  I see you have been very busy.

First I will read through your patch set, and comment on little
details that I happen to notice.  Then if I have the energy, I
will step back and try to see a larger view of your fine work.

First minor detail ... I think that the following snippet of code:

+	ssize_t retval;
+	size_t n;
	...
+	/* Do nothing if *ppos is at the eof or beyond the eof. */
+	if (s - page <= *ppos)
+		return 0;
+
+	start = page + *ppos;
+	n = s - start;
	...
+	free_page((unsigned long)page);
+	return retval;


could be slightly clearer, and avoid a leak, as something like:

	ssize_t retval = 0;
	size_t n;			/* how much not yet read */
	...
	start = page + *ppos;
	n = s - start;
	if (n <= 0)
		goto done;
	...
done:
	free_page((unsigned long)page);
	return retval;

I find that inequalities involving expressions (such as 's - page')
cause my brain to stumble momentarily.  And this avoids leaking a
memory page if n <= 0.

The above reminds me of a bug fix that you provided in the previous
patch set, for the case *ppos >= eof.  I wonder if we have duplicated
code here.

I see more duplicated code in cpumeter_file_get_written_data(), where
you are reading what is I guess a single boolean '0' or '1', but
validating that the user provided length is sane by checking it:

+	/* Crude upper limit on largest legitimate cpulist user might write. */
+	if (nbytes > 100 + 6 * NR_CPUS)
+		return -E2BIG;

This is an appropriate check when reading (write system call) an entire
cpu list, not a single number.  For a single number, you could even
consider using a local "char buf[16]" array or some such size,
instead of malloc'ing a whole page.

No doubt this "Crude upper limit" check was taken from the existing
routine cpuset_common_file_write() routine, which has to handle a
greater variety of write calls.

When I see code that is copied from another routine, I ask myself
if there is a clean way to avoid the duplication of code.  Though
I will confess to being too lazy at the moment to see if there is
a good way to do that here.

+#ifdef CONFIG_CPUMETER
+config CPUMETER
+	bool "Cpumeter support"
+	depends on CPUSETS

It might not be worth having CPUMETER as a separate option on top
of CPUSETS.  I guess that depends in part on how much CPUMETER
grows the compiled kernel text size, and what performance impact
it has if any.  You might want to look for a way to measure both
those (text size increase and performance penalty on some appropriate
benchmark.)  If CPUMETER is not too big an extra burden above and
beyond CPUSETS, then I would probably prefer avoiding the extra
ifdefs and config option, and make it one with CPUSETS.

+	s += snprintf(s, PAGE_SIZE, "%lu", val);
+	*s++ = '\n';
+	*s = '\0';

Can the above be collapsed to:

	s += snprintf(s, PAGE_SIZE, "%lu\n", val);

I see that the cpu controller patch, as it must, has hooks in the
critical scheduler paths.  How much does this slow down a system
if CONFIG_CPUMETER is enabled, but the system is running in the
default cpuset and cpumeter configuration, such as it would be
after a reboot, before any intentional administration to setup
particular cpusets or meters is attempted?

... hmmm ... I am ready to retire for the night.  I will have
to continue my review another day.

You will need to encourage someone else, with scheduler expertise,
to review that portion of the patch.  The kernel/sched.c file is
too hard for me; I stick to easier files such as kernel/cpuset.c.

I continue to be quite suspicious that perhaps there should be a
tighter relation between your work and CKRM.  For one thing, I suspect
that CKRM has a cpu controller that serves essentially the same purpose
as yours.  If that is so, I cannot imagine that we would ever put both
cpu controllers in the kernel.  They touch on code that is changing too
rapidly, and too critical for performance.

My wild guess would be that the right answer would be to take the
CKRM cpu controller instead of yours, and connect it to cpusets in the
manner that you have done here.  But I have no expertise in cpu
controllers, so am quite unfit to judge which one or the other, or
perhaps some combination of the two cpu controllers, is the best one.

I hesitate to keep asking about CKRM, as I recall how much I disliked
it when Andrew kept asking me much the same questions, about the
relation between cpusets and CKRM.  Such is life; one must do ones
duty.

Looking back at your nice opening picture, I see you write:
>   cpus/mems/meter_cpu/... and do not have their specific values.
> - The metered CPUSETS can have their children
>   (this is not allowed in SUBCPUSETS).
> - meter_cpu in the children of metered CPUSETS can not be modified
>   (can not create normal CPUSETS under metered CPUSETS).

This seems more restrictive than necessary.  Indeed, it reminds
me of some of the concerns I had with the previous SUBCPUSET
proposal.  I think we should only need the following:

 * Some cpuset C in the hierarchy is marked cpu_exclusive (hence
   its ancestors are also so marked.)
 * None of C's descendents are cpu_exclusive.  This will make
   cpuset C define a sched domain.
 * Each of the -immediate- children of C are marked meter_cpu.
 * But C is not marked meter_cpu, none of the ancestors of C
   are marked meter_cpu, and none of the descendents of C's
   children are marked meter_cpu.  Just C's children as so marked.
 * C's immediate children must have the same CPU's as C.  Children
   of these children can have any CPU's (that are a subset of C's,
   of course.)
 * Each of C's immediate children gets a certain portion of the
   CPU time, as specified in its meter_cpu_* files, to be shared
   amongst all tasks running in that cpuset, or any descendent of
   that cpuset.
 * This should allow for creating normal cpusets under metered
   cpusets.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
