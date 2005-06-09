Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVFICU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVFICU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVFICU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:20:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:55494 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262228AbVFICUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:20:39 -0400
Date: Wed, 8 Jun 2005 19:20:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050609022041.GG1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42A714B7.8010105@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A714B7.8010105@lifl.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 05:54:31PM +0200, Eric Piel wrote:
> Paul E. McKenney said:
> >Hello!
> >
> >Midway through the recent "RT patch acceptance" thread, someone mentioned
> >that it might be good to summarize the various approaches.  The following
> >is an attempt to do just this, with an eye to providing a reasonable
> >framework for future discussion.
> >
> >Thoughts?  Errors?  Omissions?
> 
> Hi Paul,
> 
> I haven't yet gone through all your email in detail but it seems very 
> well documented and precise.

Thank you, glad you like it!

> I'd like to add some information about your section "7.  Migration 
> Within OS". I've now been working for more than a year on a project 
> called ARTiS which precisely implements this approach. A announced was 
> recently posted on the LKML :-) . You can find more information in this 
> tread : http://lkml.org/lkml/2005/5/3/50 as well on our webpage 
> www.lifl.fr/west/artis .

Aaack!!!  Don't know how I missed this, will review it and update the
document.  Hmmm...  Checking the date, I plead near-terminal jet lag.

> Concerning the QoS, we have been able to obtain hard realtime, at least 
> very firm real-time. Tests were conducted over 8 hours on IA-64 and x86 
> and gave respectively 105µs and 40µs of maximum latency. Not as good as 
> you have mentioned but mostly of the same order :-)

Quite impressive!  So, does this qualify as "ruby hard", or is it only
"metal hard"?  ;-)

The service measured was process scheduling, right?

> Concerning the "e. fault isolation", on our implementation, holding a 
> lock, mutex or semaphore will automatically migrate the task, therefore 
> it's not a problem. Of course, some parts of the kernel that cannot be 
> migrated might take a lock, namely the scheduler. For the scheduler, we 
> modified most of the data structures requiring a lock so that they can 
> be accessed locklessly (it's the hardest part of the implementation).

Are the non-migrateable portions of the scheduler small enough that
one could do a worst-case timing analysis?  Preferably aided by some
automation...

> Concerning the weaknesses, one point that you didn't mention is the 
> difficulty to fully load the realtime dedicated CPUs. Tasks tends to 
> migrate more away from the RT CPUs than they come back. In ARTiS, a 
> modification of the load-balancer permits to keep most of the power but 
> there is still probably some loss. Concerning the migration overhead, 
> there must be some, but it's not very big and quite difficult to 
> measure. Actually, the migration itself is light in CPU usage, the 
> problem is that it unschedules the task so that it might take some time 
> before the task is scheduled again (but if there is enough load on the 
> computer, we lose mostly nothing).

One approach would be to mark the migrated task so that it returns
to the realtime CPU as soon as it completes the realtime-unsafe
operation.

> Finally, as you pointed out, one major requirement is obiously to have 
> several CPUs. Luckily, SMT and dual core processors are more and more 
> common (ARTiS was succesfully tested on Pentium HT). Still, in the 
> embedded market this is not so usual, so that's a weakeness point if you 
> target very devices. Our implementation is oriented toward big 
> applications that requires both RT properties and high performance 
> (that's why it was developped on IA-64).

Another approach is to insert a virtualization layer (think in terms of
a very cut-down variant of Xen) that tells the OS that there are two CPUs.
This layer then gives realtime service to one, but not to the other.
That way, the OS thinks that it has two CPUs, and can still do the
migration tricks despite having only one real CPU.

Anyway, interesting approach!

						Thanx, Paul

> That's my 2 cents for your summary :-)
> 
> Eric
> 
> PS: please CC me when replying to the lkml.
> 
