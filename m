Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVFMOkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFMOkk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFMOkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:40:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57306 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261584AbVFMOkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:40:22 -0400
Date: Mon, 13 Jun 2005 07:40:22 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613144022.GA1305@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ACE2D3.9080106@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 09:35:15PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > This could potentially address the need for version-synchronization
> > between RTAI-Fusion and the Linux kernel.  Would you really want two
> > separate builds, or is there some reasonable way of producing a single
> > kernel binary that has both?  And if there is some reasonable way of
> > doing this, is it the right thing to do?
> 
> No, single build is what I'm looking for. Nothing precludes the
> fusion parts from being built during the same kernel build ...
> as modules. If you don't load 'em, you don't need to worry about
> 'em.

OK...  Then the idea is to dynamically redirect the symbolic link
to include/linux-srt or include/linux-srt that you mentioned in your
previous email, or is the symlink serving some other purpose?

> > The single-binary approach could potentially reduce the
> > dual-OS-administration load associated with RTAI-Fusion.  However,
> > handling all the interactions between the deterministic and
> > non-deterministic system calls could get hairy.  No big deal for
> > scheduling primitives, but things could get interesting for I/O and
> > networking protocols.
> 
> Again, if you don't load 'em, you don't get 'em. If you use it
> and it's broken, then you're doing rt and you need to sync up
> with the maintainer. Nothing different here from the standard
> run of the mill "I'm using subsystem X and it doesn't work"
> posting to LKML.

So your focus is on system calls that can have totally separate
realtime and non-realtime implementations?  Or am I missing some
trick here?

> > So, one can use the following types of combination:
> > 
> > o	single source tree, multiple kernels (which is what I now
> > 	think that you are getting at above).
> > 
> > o	straight merge, as between PREEMPT and PREEMPT_RT.
> > 
> > o	single kernel, multiple syscall implementations for
> > 	some syscalls (deterministic vs. non-deterministic).
> > 
> > o	side-by-side combination, as with dual-OS/dual-core and
> > 	pretty much any other approach.
> 
> I'm not sure how you'd fit what I'm trying to suggest above, but
> let me rephrase it with the above in mind:
> 
> What I'm suggesting is that all rt components be included, but
> in separate directories within mainline. That may or may not
> mean additional schedulers/services. In the case where the
> new layout would include both PREEMPT_RT and fusion, what
> we'd get is that the user would have access to these configs:
> - Plain Linux, no PREEMPT_RT, no ipipe, no fusion.
> - Linux with PREEMPT_RT, no fusion: ints are threaded and locks
>   are mutexes like now (however without the code intrusiveness
>   given the use of separate directories.) May or may not include
>   ipipe.
> - Linux with fusion, no PREEMPT_RT: the fusion modules are built
>   and installed with the rest of the modules. ipipe must be
>   enabled.
> - Linux with fusion and PREEMPT_RT: combination of the previous
>   two.
> - Linux with ipipe, no fusion or PREEMPT_RT: the soft-cli stuff
>   is built into the kernel and loaded drivers can get
>   deterministic response times, but there are no fancy rt
>   services offered to anyone.

Single kernel, multiple implementations for some syscalls, more
or less, anyway.

> Practically, linux/hard-rt/ would contain both the code for
> PREEMPT_RT and the code for fusion. The actual layout in that
> directory would still need to be detailed, but the desired
> effect is that both PREEMPT_RT and fusion share as much code
> as possible.
> 
> Hope this clarifies what I'm suggesting a little bit more. Of
> course, all this would need to be rehashed a number of times,
> and most importantly, the PREEMPT_RT folks and the fusion
> effort would need to agree to join forces. From the fusion
> POV, it's clear that the door is open for collaboration. As
> proof, Philippe has been publishing combo patches with Adeos
> and PREEMPT_RT for some time. I can't speak for the PREEMPT_RT
> POV, though. I might be mistaken, but it seems that the feedback
> I've seen from some PREEMPT_RT backers does seem to indicate
> some openess. We'll see how things go.

My guess is that there are enough people in the PREEMPT_RT camp that
it might not make sense to ascribe a single point of view to them  ;-)

How are you and Kristian looking to benchmark/compare the various
combinations you call out above?  Seems like one would have to look
at more than straight scheduling/interrupt latency to make a reasonable
comparison.

						Thanx, Paul
