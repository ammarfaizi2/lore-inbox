Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVAGFxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVAGFxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 00:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVAGFxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 00:53:35 -0500
Received: from mail.joq.us ([67.65.12.105]:64447 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261256AbVAGFxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 00:53:21 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andreas Steinmetz <ast@domdv.de>,
       Lee Revell <rlrevell@joe-job.com>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>
	<20050103140359.GA19976@infradead.org>
	<1104862614.8255.1.camel@krustophenia.net>
	<20050104182010.GA15254@infradead.org>
	<1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
	<1104898693.24187.162.camel@localhost.localdomain>
	<20050107011820.GC2995@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 06 Jan 2005 23:54:05 -0600
In-Reply-To: <20050107011820.GC2995@waste.org> (Matt Mackall's message of
 "Thu, 6 Jan 2005 17:18:20 -0800")
Message-ID: <87brc17pj6.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Adding linux-audio-dev to the CC list]

Matt Mackall <mpm@selenic.com> writes:

> On Wed, Jan 05, 2005 at 04:18:15AM +0000, Alan Cox wrote:
>> gid hacks are not a good long term plan.
>> 
>> Can we use capabilities, if not - why not and how do we fix it so
>> we can do the job right. Do we need some more capability bits that
>> are implicitly inherited and not touched by setuidness ?
>
> Why can't this be done with a simple SUID helper to promote given
> tasks to RT with sched_setschedule, doing essentially all the checks
> this LSM is doing?

The answer to your simple question is a long, sad story.  :-(

There is clearly no practical way to write large audio applications
(many with elaborate graphical interfaces) securly enough to run them
as root.  So, we have used capabilities with linux-2.4 systems for
several years.  It was never a satisfactory solution, but was all we
could do at the time.  

There is a small setuid program called `jackstart' that exec()s the
JACK server (`jackd') with appropriate privileges so it can pass
realtime privileges to its applications.  Each client needs to create
a realtime thread and mlock() its storage to do its part of the
realtime audio cycle.  Note that sched_setschedule() provides no way
to handle the mlock() requirement, which cannot be done from another
process.  Clients may come and go at any time, so dropping the
privilege after initialization is not an option.

Unfortunately, all this heavyweight mechanism only helps with JACK and
its many clients.  Lots of other audio or video oriented applications
also have realtime needs.

The biggest problem was CAP_SETPCAP, which for good reasons[1] is
disabled in distributed kernels.  This forced every user to patch and
build a custom kernel.  Worse, it opened all our systems up to the
problems reported by this sendmail security advisory.

 [1] http://www.securiteam.com/unixfocus/5KQ040A1RI.html

While stumbling along with this very unsatisfactory state of affairs,
many on the Linux Audio Developers mailing list were shocked[2] to
hear about an LKML discussion[3] suggesting a significant lack of
developer committment to addressing these issues...

> Quoting Albert Cahalan[3]: "The authors of our code seem to have
> given up and moved on. Nobody cleaned up the mess. Is it any wonder
> the POSIX draft didn't ever make it beyond the draft state?"

 [2] http://www.music.columbia.edu/pipermail/linux-audio-dev/2003-November/005332.html
 [3] http://www.kerneltraffic.org/kernel-traffic/kt20031101_239.html#3

So, all our work, frustration and user confusion while trying to "do
the right thing" seemed doomed to failure.  Since the Linux kernel
developers continued to show little interest in our needs, we started
a discussion about how to meet them ourselves[4].

 [4] http://www.music.columbia.edu/pipermail/linux-audio-dev/2003-November/005345.html

Looking at our security requirements in a practical manner, we quickly
concluded that CAP_SETPCAP is the work of the devil.  A true
filesystem-based privilege vector solution might be adequate, but is
clearly beyond the scope of what we audio programmers could hope to
accomplish.  Even then, it would be difficult to administer.

A simple group ID test is far more secure than CAP_SETPCAP, and
perfectly adequate for us.  When configuring a Digital Audio
Workstation, one is not terribly concerned about local Denial of
Service attacks or runaway realtime threads.  That would be
unacceptable for many other systems, but not ours.  Yet, we want to
avoid system integrity holes in network daemons like sendmail[1].  In
other words: we can tolerate the bad guys crashing the system, but we
don't want them turning it into an open spam relay or corrupting the
filesystem.

So, we needed to provide a simple way for an unskilled system admin
(aka "musician") to configure a personal workstation to run realtime
applications without opening egregious security holes.  Equally
important, it must be easy for other system admins to ensure that
these privileges are *not* available on their server systems.  It soon
became apparent that the then-new LSM framework provided a good
solution.  Because LSM's can be built outside the kernel source tree,
we were no longer forced to wait for some kernel developer to take an
interest.

The realtime-lsm is the solution we evolved.  It has been actively
used by thousands of Linux audio users for over a year now[5].  The
first supported SourceForge release was in April of 2004[6].  It is
now used by many popular audio-oriented distributions, including
Planet CCRMA[7] from Stanford University and the Debian Music
Distribution[8] from the AGNULA project.

 [5] http://www.music.columbia.edu/pipermail/linux-audio-dev/2003-December/005745.html
 [6] http://eca.cx/laa/2004/04/0028.html
 [7] http://ccrma.stanford.edu/planetccrma/software/
 [8] http://www.agnula.org/

I understand that kernel developers are busy and have other problems
they consider more important than ours.  But, you ought to at least
understand that this is really important to us.  We needed a clean
solution two or three years ago.  Now we finally have one.

Distributing it with the kernel sources would be a great convenience
for our users and would significantly simplify maintenance.  It would
also (IMHO) close a significant security and usability deficiency in
the standard kernel.  Any of the NSA and DoD experts will tell you: a
security solution that is difficult to administer is not secure.

It is no surprise that kernel developers should consider our solution
technically inferior to their own ideas on the subject.  I would have
been delighted to have some kernel developer step in and provide a
clean, well-thought out solution several years ago.  This is a kernel
deficiency, not an audio problem.  I don't want to work on kernels.

But, I am feeling quite discouraged that so many kernel developers
still seem to consider this problem unimportant.  I sense a distinct
unwillingness to move forward on this issue.  I really hope I am wrong
about that.
-- 
  joq
