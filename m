Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292293AbSBTUj0>; Wed, 20 Feb 2002 15:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSBTUjQ>; Wed, 20 Feb 2002 15:39:16 -0500
Received: from zok.sgi.com ([204.94.215.101]:51387 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292293AbSBTUjK>;
	Wed, 20 Feb 2002 15:39:10 -0500
Date: Wed, 20 Feb 2002 12:38:56 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Robert Love <rml@tech9.net>
cc: Erich Focht <efocht@ess.nec.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for
 non-current tasks
In-Reply-To: <1014234254.18361.43.camel@phantasy>
Message-ID: <Pine.SGI.4.21.0202201220180.557863-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2002, Robert Love, responding to Erich Focht, wrote:
> 
> I was working on the same thing myself.

good news.

> ...
> 
> I am a little surprised by how much code it took, though.

Not have looked at Ingo's patch yet, I can't tell how much
of Erich's patch is just Ingo's, and how much is the additional
change needed for non-current set_cpus_allowed().

I do see things like minor spacing changes in this patch
which might be bulking it up, but don't know the history
of such changes (comment prefix changed from 3 chars " * "
to 2 chars "* ", for example).

I also notice that the BUG() call in set_cpus_allowed() is
commented out:

-       if (p != current)
-               BUG();
+       //if (p != current)
+       //      BUG();

Would it not be cleaner to remove the lines, not leave old
cruft laying around?  There are a half dozen other such
commented out lines that this same notice might also apply to.


> Do we need the function to act asynchronously?  In other words,
> is it a requirement that the task reschedule immediately, or
> only that when it next reschedules it obeys its affinity?

Excellent question, in my view.

I see three levels of synchonization possible here:

1) As Erich did, use IPI to get immediate application

2) Wakeup the target task, so that it will "soon" see the
   cpus_allowed change, but don't bother with the IPI, or

3) Make no effort to expedite notifcation, and let the
   target notice its changed cpus_allowed when (and if)
   it ever happens to be scheduled active again.

Personally, I don't care, past hoping that the code is as simple
as possible (but no simpler ;).  But I'm just implementing
an intermediate mechanism (CpuMemSets) that is intended to
provide a generic hook for a wide variety of load balancing
mechanisms.  The implementors of those various load balancers
(NUMA extensions) likely have some minimum requirements.

I'd suspect that (2) would be sufficient, and much easier
and more portable to implement.


> Also, what is the reason for allowing multiple calls to
> set_cpus_allowed?  How often would that even occur?

I haven't looked at this enough to understand your question.
Could you (Robert or Erich) explain more?  I trust no one is
saying that it's ok to have code that is unsafe because it
will only crash rarely.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

