Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSGJNIk>; Wed, 10 Jul 2002 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSGJNIj>; Wed, 10 Jul 2002 09:08:39 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:36063 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S315754AbSGJNIh>; Wed, 10 Jul 2002 09:08:37 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Jul 2002 09:10:07 -0400 (EDT)
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: Karim Yaghmour <karim@opersys.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@conectiva.com.br>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Richard Moore <richardj_moore@uk.ibm.com>,
       bob <bob@watson.ibm.com>, okrieg@watson.ibm.com
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
In-Reply-To: <20020710043844.GA69117@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com>
	<3D29DCBC.5ADB7BE8@opersys.com>
	<20020710022208.GA56823@compsoc.man.ac.uk>
	<3D2BB505.889304A8@opersys.com>
	<20020710043844.GA69117@compsoc.man.ac.uk>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15660.9997.207798.658026@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,
     I have been cc'ed on this email as I was an active participant at the
RAS performance monitoring/tracing session at OLS.  Let me preface by
saying that my view may be a bit biased as I have worked on the the core
tracing infrastructure that went into IRIX in the mid 90s as well as the
tracing infrastructure for K42, our research OS (see
http://www.research.ibm.com/K42/index.html), and in both cases helped solve
performance issues that would not have been otherwise solved.  From the
below it doesn't appear that anyone is arguing that tracing is not useful.
The debate (except for some of the details) appears over whether it should
be included in the kernel in a first-class manner or individual mechanisms
put in on an ad-hoc basis.  While this is indeed philosophical, let me
share some experiences and benefits from other systems I've worked on:
 1) The mechanism proposed is very non-invasive, a single line of
code (some TRACE_XXX macro or like) is added to the area of interest.
Further, at OLS, the proposal was to add only a few trace points.
Programming-wise this does not clutter the code - in fact having a single
well-known unified mechanism is cleaner coding than a set of one-off
ways, as when anyone sees a trace macro it will be clear what it is.
 2) In the end, there will be less intrusion with a single unified
approach.  With a series of different mechanisms over time multiple events
will get added in the same place creating performance issues and more
importantly causing confusion.
 3) A unified approach will uncover performance issues not explicitly being 
searched for and allow ones of known interest to be tracked down without
adding a patch (that may be cumbersome to maintain) and re-compilation.
 4) In both my experiences, I have had resistance to adding this
tracing infrastructure, and in both experiences other kernel developers
have come back after the fact and thanked me for my persistence :-), as it
helped them solve timing sensitive or other such issues they were having
great difficulty with.

If there is interest, I would happy to set up a conference number so people 
who are interested could all speak.

-bob

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

----

John Levon writes:
 > On Wed, Jul 10, 2002 at 12:16:05AM -0400, Karim Yaghmour wrote:
 >  
 > [snip]
 >  
 > > And the list goes on.
 >  
 > Sure, there are all sorts of things where some tracing can come in
 > useful. The question is whether it's really something the mainline
 > kernel should be doing, and if the gung-ho approach is nice or not.
 > 
 > > The fact that so many kernel subsystems already have their own tracing
 > > built-in (see other posting)
 >  
 > Your list was almost entirely composed of per-driver debug routines.
 > This is not the same thing as logging trap entry/exits, syscalls etc
 > etc, on any level, and I'm a bit perplexed that you're making such an
 > assocation.
 >  
 > > expect user-space developers to efficiently use the kernel if they
 > > have
 > > absolutely no idea about the dynamic interaction their processes have
 > > with the kernel and how this interaction is influenced by and
 > > influences
 > > the interaction with other processes?
 >  
 > This is clearly an exaggeration. And seeing as something like LTT
 > doesn't (and cannot) tell the "whole story" either, I could throw the
 > same argument directly back at you. The point is, there comes a point of
 > no return where usefulness gets outweighed by ugliness. For the very few
 > cases that such detailed information is really useful, the user can
 > usually install the needed special-case tools.
 >  
 > In contrast a profiling mechanism that improves on the poor lot that
 > currently exists (gprof, readprofile) has a truly general utility, and
 > can hopefully be done without too much ugliness.
 >  
 > The primary reason I want to see something like this is to kill the ugly
 > code I have to maintain.
 > 
 > > > The entry.S examine-the-registers approach is simple enough, but
 > > > it's
 > > > not much more tasteful than sys_call_table hackery IMHO
 > >
 > > I guess we won't agree on this. From my point of view it is much
 > > better
 > > to have the code directly within entry.S for all to see instead of
 > > having some external software play around with the syscall table in a
 > > way kernel users can't trace back to the kernel's own code.
 > 
 > Eh ? I didn't say sys_call_table hackery was better. I said the entry.S
 > thing wasn't much better ...
 > 
 > regards
 > john
 > 
