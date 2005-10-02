Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVJBEUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVJBEUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 00:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbVJBEUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 00:20:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50594 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750961AbVJBEUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 00:20:42 -0400
Date: Sat, 1 Oct 2005 21:20:26 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] CPUMETER (Re: [PATCH 0/5] SUBCPUSETS: a resource
 control functionality using CPUSETS)
Message-Id: <20051001212026.1d39222a.pj@sgi.com>
In-Reply-To: <20050926093432.626D07003D@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.626D07003D@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro-san,

I spent a little more reading the cpuset side of your cpumeter patches.

I am hopeful that some substantial restructuring of the code would
integrate it better with the existing cpuset structure, reducing the
size of new code substantially.

I noticed not one, but two, nested CONFIG options added for CPUMETER:
CONFIG_CPUMETER and CONFIG_CPU_RC.  If this CPUMETER patch only
affected the cpuset code, I'd be tempted to have no additional CONFIG_*
options, however since the affect on the scheduler might be more
interesting (I am not a scheduler guru), it might make sense to have
one new such option - say the CONFIG_CPUMETER one, that covers it all.
Two seems at least one too many.

I am surprised to see fixed length arrays of size CPUMETER_CTRLS_MAX,
rather than having the cpumeter struct be dynamically allocated,
reference counted and locked.   I hope we do not have to have a small
fixed upper limit on the number of distinct cpu controllers.

I suspect that we should have a single additional pointer to cpu
resource controller (rc) domain structure, referenced from both
cpusets and tasks, where that structure is reference counted and
has its own lock.  All tasks and all cpuses in a given cpu rc domain
would point to the same structure.  This would remove any need in the
critical scheduler code to reference a tasks cpuset or the parent
of that cpuset, and it would allow the cpusets in such a domain to
have child cpusets, which would inherit another reference to the same
cpumeter rc domain, as I have been hoping would be possible.

So the code now added to struct cpuset:

	#ifdef CONFIG_CPUMETER
		/*
		 * rcdomains: used for the recource control domains
		 *            to keep track of total ammount of resources.
		 * meters:    used for metering resources assigned for
		 *            the cpuset.
		 */
		void *rcdomains[CPUMETER_CTLRS_MAX];
		struct cpumeter meters[CPUMETER_CTLRS_MAX];
	#endif /* CONFIG_CPUMETER */

might collapse to simply:

	struct cpumeter *cpumeter;

The use of the last CPUMETER_CTLRS_MAX (16) bits, starting at offset
CS_METER_OFFSET, of the typedef enum cpuset_flagbigs_t for one bit per
controller instance is creative, but hopefully unnecessary.  Rather,
if the struct cpumeters are dynamically allocated, then whether the
cpuset->cpumeter pointer is non-NULL will determine if that cpuset
is metered, and the pointer will reference the information about that
metered domain, shared by all cpusets in that domain, and hence by all
tasks in those cpusets.  Be sure to update which cpumeter rc domain a
task is in, if that task is moved to another cpuset, by attach_task().

The cpumeter_destroy_meters() routine should not be called from
cpuset_diput().  Rather the reference count on the meter structure
should be incremented and decremented each time a cpuset or task
attaches to or detached from it, and it should be free'd when the
count goes to zero.

There are 736 lines of code added to the end of kernel/cpuset.c,
with many snippets closely resembling existing code from the rest
of kernel/cpuset.c.   This is too much duplicated, parallel code,
and too much duplicate, parallel data structures.  I am hoping
that this can be collapsed into the existing cpuset.c code, adding
perhaps 100 or 200 lines instead of 736 lines.  But I have not
thought about it too hard - this hope might be wishful thinking.
Seeing routines such as "cpumeter_file_read_common()", along side
the existing "cpuset_common_file_read()", worries me.  Way too much
duplication of code.  And I hope we don't need a whole different
set of file_operations for the guar and lim files.

This code provides a basis for other forms of metering besides just
cpu metering.  I wonder if perhaps it would be better to just do
cpu metering here, and remove a bit of the generality that supports
other types of controllers.  If the addition of this cpuset based
controller were sufficiently integrated with the existing cpuset
code, and kept simple enough, then adding another controller type,
such as for memory, could just do the same sort of thing easy enough.
It would be easier to read the code if lines such as the following:

		sprintf(name, "%s%s%s", cpumeter_meter_prefix, c->name,
			cpumeter_guar_suffix);

were instead:

		name = "meter_cpu_guar";

You have been most gracious in your consideration of my suggestions
so far.  I hope the above thoughts will benefit your work.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
