Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbSKFQL0>; Wed, 6 Nov 2002 11:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbSKFQLZ>; Wed, 6 Nov 2002 11:11:25 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:29458
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265797AbSKFQLW>; Wed, 6 Nov 2002 11:11:22 -0500
Subject: Re: yet another update to the post-halloween doc.
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021106140844.GA5463@suse.de>
References: <20021106140844.GA5463@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 11:18:01 -0500
Message-Id: <1036599481.3405.1080.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 09:08, Dave Jones wrote:

Hey Dave, good job!

One idea: how about covering new system calls?  We have the thread calls
Ingo did, the sched_[set|get]affinity calls, AIO, etc.

Couple points...

> Kernel preemption.
> ~~~~~~~~~~~~~~~~~~
> - The much talked about preemption patches made it into 2.5.
>   With this included you should notice much lower latencies especially
>   in demanding multimedia applications. 
> - Note, there are still cases where preemption must be temporarily disabled
>   where we do not.  If you get "xxx exited with preempt count=n" messages
>   in syslog, don't panic, these are non fatal, but are somewhat unclean.
> - Report such cases (and any other preemption related problems) to
>   rml@tech9.net

I just want to clarify that, in the second point, the "xxx exited with
preempt_count=n" message and not disabling preemption are two different
issues.

The "xxx exited" message is a general debugging notice that a lock was
not dropped.  Relevant to the whole system (regardless of preemption,
possibly) but a real problem for preemption because the lock count is
off.

Not disabling preemption where needed is like an SMP race condition. 
There may be a some per-CPU data left that needs explicit protection but
hopefully not much.

Finally, if you DO notice high latency with kernel preemption enabled in
a specific code path, please report that to Andrew Morton
<akpm@digeo.com> and myself <rml@tech9.net>.  We consider those bugs. 
The report should be something like "the latency in my xyz application
hits xxx ms when I do foo but is normally yyy" where foo is an action
like "unlink a huge directory tree".

> procps
> ~~~~~~
> - The 2.5 /proc filesystems changed some statistics, which confuse
>   older versions of procps. Rik van Riel and Robert Love have
>   been maintaining a version of procps during the 2.5 cycle which
>   tracks changes to /proc which you can find at http://tech9.net/rml/procps/
> - Alternatively, the original procps by Albert Cahalan now supports
>   the altered formats since v3.0.5, but lags behind the bleeding edge
>   version maintained by Rik and Robert. -- http://procps.sf.net/
> - The /proc/meminfo format changed slightly which also broke
>   gtop in strange ways.

Just a note that the tree Rik and I are hacking on is the original and
not a fork.  It is the same tree mkj created and is in the official Red
Hat CVS repository.  It just has not had much activity lately and now it
has new blood :)

Albert's tree is a fork.

If you are using the official procps package, I think you need at least
2.0.8 or so - but the latest version is ideal, which is 2.0.10.

> Debugging options.
> ~~~~~~~~~~~~~~~~~~
> During the stabilising period, it's likely that the debugging options
> in the kernel hacking menu will trigger quite a few problems.
> Please report any of these problems to linux-kernel@vger.kernel.org
> rather than just disabling the relevant CONFIG_ options.
> 
> Merging of kksymoops means that the kernel will now spit out
> automatically decoded oopses (no more feeding them to ksymoops).
> For this reason, you should always enable the option in the
> kernel hacking menu labelled "Load all symbols for debugging/kksymoops".

Please please please test with CONFIG_PREEMPT, CONFIG_DEBUG, and
CONFIG_KKALLSYMS enabled.  Kernel preemption gives us the ability to do
a whole slew of debugging checks like sleeping with locks held,
scheduling while atomic, exiting with locks held, etc. etc.

> Need checking.
> ~~~~~~~~~~~~~~
> - Someone reported evolution locks up when calender/tasks/contacts is selected.
>   http://lists.ximian.com/archives/public/evolution-hackers/2002-March/004292.html
>   reports this as an evolution/ORBit problem.  Did it get fixed ?

Not yet.  I have talked to the Evolution/ORBit guys about this -
especially Elliot Lee.

It is an ORBit problem and is currently not fixed as of the latest
release.  The problem is 2.4, actually, which has bad behavior with
getpeername() - it does not fill in the sun_path member.  ORBit works
around this behavior, which breaks 2.5 which does fill in the value.

A quick fix is to just have ORBit set sun_path to null after calling
getpeername().

	Robert Love

