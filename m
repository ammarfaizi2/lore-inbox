Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbUKVR3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUKVR3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUKVR2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:28:42 -0500
Received: from klutz.cs.utk.edu ([160.36.56.50]:62367 "EHLO klutz.cs.utk.edu")
	by vger.kernel.org with ESMTP id S262240AbUKVRYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:24:03 -0500
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads
From: "Philip J. Mucci" <mucci@cs.utk.edu>
Reply-To: mucci@cs.utk.edu
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
In-Reply-To: <20041122162214.GE21861@wotan.suse.de>
References: <41A20AF3.9030408@sgi.com>
	 <20041122162214.GE21861@wotan.suse.de>
Content-Type: text/plain
Organization: Lawrence Berkeley National Laboratory / Innovative Computing
	Laboratory
Message-Id: <1101144227.4166.25.camel@stork.pdc.kth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 22 Nov 2004 18:23:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Allow me to say that this particular case is very special, because
ITIMER_PROF is used in many performance tools. Inside of PAPI for
example, we use ITIMER_PROF for both counter multiplexing and for
statistical profiling. Tools such as HPCToolkit, PerfSuite and others
often enable ITIMER_PROF at the highest available resolution. So while
there may be hundreds or thousands of ways to do this, this particular
avenue has many useful tools out there that make can easily trigger this
case. 

However, I think your suggestion is an excellent one regarding a fast
path for ITIMER_PROF. 

FWIW, Solaris has ITIMER_REALPROF, which when enabled, sends
ITIMER_PROFs to all LWP's in the process for each tick. In this way,
each thread doesn't have to call setitimer()
by itself to get a signal...yeah yeah, I know what POSIX says about
signal delivery to any LWP, but on every Linux I've tested, you only get
itimer(PROF) to the thread that registered the timer. Granted, 
I haven't run the test on an Altix.

Regards,

Philip Mucci

> I suspect there are hundreds or thousands of ways on such a big system to 
> exploit some lock to make the system unresponsive.  If you wanted
> to fix them all your would be in a large scale redesign effort. 
> It's not clear why this particular case is special.

> > Since signals are sent much more often than sigaction() is called, it would
> > seem to make more sense to make sigaction() take a heavier weight lock of
> 
> At least in traditional signal semantics you have to call sigaction
> or signal in each signal handler to reset the signal. So that 
> assumption is not necessarily true.
> 
> > It seems to me that scalability would be improved if we moved the siglock 
> > from
> > the sighand structure to the task_struct.  (keep reading, please...)  Code 
> > that manipulates the current task signal data only would just obtain that 
> > lock.  Code that needs to change the sighand structure (e. g. sigaction())
> > would obtain all of the siglock's of all tasks using the same sighand 
> > structure.  A list of those task_struct's would be added to the sighand
> > structure to enable finding these structurs without having to take the
> > task_list_lock and search for them.
> 
> Taking all these locks without risking deadlock would be tricky.
> You could just use a ring, but would need to point to a common
> anchor and always start from there to make sure all lock grabbers
> aquire the locks in the same order.
> 
> > Anyway, we would be interested in the community's ideas about dealing with
> > this signal delivery scalability issue, and, comments on the solution above
> > or suggestions for alternative solutions are welcome.
> 
> How about you figure out a fast path of some signals that can work
> without locking: e.g. no load balancing needed, no queued signal, etc. 
> and then just do the delivery of SIGPROF lockless? Or just ignore it
> since the original premise doesn't seem to useful.
> 
> -Andi
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

