Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTJLCOO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 22:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTJLCOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 22:14:14 -0400
Received: from dp.samba.org ([66.70.73.150]:27593 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263375AbTJLCN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 22:13:57 -0400
Date: Sat, 11 Oct 2003 09:40:07 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-Id: <20031011094007.1cfd6d74.rusty@rustcorp.com.au>
In-Reply-To: <20031010185609.GA4875@hockin.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
	<20031009115809.GE8370@vega.digitel2002.hu>
	<20031009165723.43ae9cb5.skraw@ithnet.com>
	<3F864F82.4050509@longlandclan.hopto.org>
	<20031010125137.4080a13b.skraw@ithnet.com>
	<3F86BD0E.4060607@longlandclan.hopto.org>
	<20031010143529.GT5112@vega.digitel2002.hu>
	<20031010144723.GC727@holomorphy.com>
	<20031010180320.GA1995@hockin.org>
	<20031010182909.GG727@holomorphy.com>
	<20031010185609.GA4875@hockin.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 11:56:09 -0700
Tim Hockin <thockin@hockin.org> wrote:

> On Fri, Oct 10, 2003 at 11:29:09AM -0700, William Lee Irwin III wrote:
> > I think there is some generalized cpu hotplug stuff that's gone in that
> > direction already, though I don't know any details. The bits about non-
> > cooperative offlining were very interesting to hear, though.
> 
> I spoke with Rusty about it at OLS.  I haven't tracked the hotplug CPU
> projects.  I think that TASK_UNRUNNABLE is the sane way to handle said edge
> case, but at the time Rusty was leaning towards SIGPOWER.

Yeah, if a task has become unrunnable, I do a SIGPOWER (with a new cpu siginfo
field).  If hotplug CPUs had been introduced at the same time as affinity,
this would IMHO have been a valid approach, but may not be so now.

See my kernel.org page, and the sourceforge mailing list for details.

I haven't done anything fancy with cpu offlining, but the most painful bit
is all the callbacks for workqueue threads, migration threads etc.  Once
that's in place, doing the atomic-style switch should be quite possible.
There's a theoretical case where code would do:

	spin_lock
	foo[smp_processor_id()]++;
	...
	foo[smp_processor_id()]--;
	spin_unlock

So you might want to fake up the answer to smp_processor_id() for that
task/interrupt.  Other real per-cpu things might have problems (if you
were halfway through fiddling with the interrupt state on that CPU,
maybe MTRR), but that's what makes it fun.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
