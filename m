Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSGJOck>; Wed, 10 Jul 2002 10:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSGJOcj>; Wed, 10 Jul 2002 10:32:39 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:33672 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S317385AbSGJOch>; Wed, 10 Jul 2002 10:32:37 -0400
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
       bob <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
       mjbligh@linux.ibm.com, John Levon <moz@compsoc.man.ac.uk>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFF41DACAC.FEED90BA-ON80256BF2.004DC147@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Wed, 10 Jul 2002 15:28:04 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 10/07/2002 15:33:35
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Sure, there are all sorts of things where some tracing can come in
>useful. The question is whether it's really something the mainline
>kernel should be doing, and if the gung-ho approach is nice or not.
>
>> The fact that so many kernel subsystems already have their own tracing
>> built-in (see other posting)
>
>Your list was almost entirely composed of per-driver debug routines.
>This is not the same thing as logging trap entry/exits, syscalls etc
>etc, on any level, and I'm a bit perplexed that you're making such an
>assocation.

There's a balance to be struck with tracing. First we should point out that
the recording mechanism doesn't have to intrude within the kernel unlss you
want init time tracing. The bigger point of contention seems to be that of
instrumentation. Yes, it is very ugly to have thousands of trace points
littering the source. On the otherhand, for basic serviceability a minimal
set should be present in a production system - these would typically allow
the external interface of any component to be traced.  For low-level
tracing - i.e. internal routines etc - the dynamic trace can be used. This
requires no modification to source. The tracepoint is implemanted
dynamically in execting code. DProbes+LTT provides this capability.

Some level of tracing (along with other complementary PD tools e.g. crash
dump) needs to be readiliy available to deal with those types of problem we
see with mature systems employed in the production environment. Typically
such problems are not readily recreatable nor even prictable. I've often
had to solve problems which impact a business environment severely, where
one server out of 2000 gets hit each day, but its a different one each day.
Its under those circumstances that trace along without other automated data
capturing problem determination tools become invaluable. And its a fact of
life that only those types of difficult problem remain once we've beaten a
system to death in developments and test. Being able to use a common set of
tools whatever the componets under investigation greatly eases problem
determination. This is especially so where you have the ability to use
dprobes with LTT to provide ad hoc tracepoints that were not originally
included by the developers.



Richard J Moore CEng, MIEE, Consulting IT Specialist, TSM
RAS Project Lead - Linux Technology Centre (ATS-PIC).
http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK
The IBM Academy will hold a Conference on Performance Engineering in
Toronto July 8-10. A High Availability Conference follows July 10-12.
Details on http://w3.ibm.com/academy/


                                                                                                                                           
                      John Levon                                                                                                           
                      <movement@marcelothewonderp        To:       Karim Yaghmour <karim@opersys.com>                                      
                      enguin.com>                        cc:       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton                  
                      Sent by: John Levon                 <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>, Rik van Riel               
                      <moz@compsoc.man.ac.uk>             <riel@conectiva.com.br>, "linux-mm@kvack.org" <linux-mm@kvack.org>,              
                                                          mjbligh@linux.ibm.com, linux-kernel@vger.kernel.org, Richard J                   
                                                          Moore/UK/IBM@IBMGB, bob <bob@watson.ibm.com>                                     
                      10/07/2002 00:38                   Subject:  Re: Enhanced profiling support (was Re: vm lock contention reduction)   
                      Please respond to John                                                                                               
                      Levon                                                                                                                
                                                                                                                                           
                                                                                                                                           



On Wed, Jul 10, 2002 at 12:16:05AM -0400, Karim Yaghmour wrote:

[snip]

> And the list goes on.

Sure, there are all sorts of things where some tracing can come in
useful. The question is whether it's really something the mainline
kernel should be doing, and if the gung-ho approach is nice or not.

> The fact that so many kernel subsystems already have their own tracing
> built-in (see other posting)

Your list was almost entirely composed of per-driver debug routines.
This is not the same thing as logging trap entry/exits, syscalls etc
etc, on any level, and I'm a bit perplexed that you're making such an
assocation.

> expect user-space developers to efficiently use the kernel if they
> have
> absolutely no idea about the dynamic interaction their processes have
> with the kernel and how this interaction is influenced by and
> influences
> the interaction with other processes?

This is clearly an exaggeration. And seeing as something like LTT
doesn't (and cannot) tell the "whole story" either, I could throw the
same argument directly back at you. The point is, there comes a point of
no return where usefulness gets outweighed by ugliness. For the very few
cases that such detailed information is really useful, the user can
usually install the needed special-case tools.

In contrast a profiling mechanism that improves on the poor lot that
currently exists (gprof, readprofile) has a truly general utility, and
can hopefully be done without too much ugliness.

The primary reason I want to see something like this is to kill the ugly
code I have to maintain.

> > The entry.S examine-the-registers approach is simple enough, but
> > it's
> > not much more tasteful than sys_call_table hackery IMHO
>
> I guess we won't agree on this. From my point of view it is much
> better
> to have the code directly within entry.S for all to see instead of
> having some external software play around with the syscall table in a
> way kernel users can't trace back to the kernel's own code.

Eh ? I didn't say sys_call_table hackery was better. I said the entry.S
thing wasn't much better ...

regards
john





