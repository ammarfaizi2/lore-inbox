Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUGWRfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUGWRfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 13:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267846AbUGWRfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 13:35:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:26073 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267841AbUGWRfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 13:35:13 -0400
From: zanussi@us.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16641.19483.708016.320557@tut.ibm.com>
Date: Fri, 23 Jul 2004 12:34:19 -0500
To: Roger Luethi <rl@hellgate.ch>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       richardj_moore@uk.ibm.com, bob@watson.ibm.com,
       michel.dagenais@polymtl.ca
Subject: Re: LTT user input
In-Reply-To: <20040723100101.GA22440@k3.hellgate.ch>
References: <16640.10183.983546.626298@tut.ibm.com>
	<20040723100101.GA22440@k3.hellgate.ch>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:
 > On Thu, 22 Jul 2004 15:47:03 -0500, zanussi@us.ibm.com wrote:
 > > One of the things people mentioned wanting to see during Karim's LTT
 > > talk at the Kernel Summit was cases where LTT had been useful to real
 > > users.  Here are some examples culled from the ltt/ltt-dev mailing
 > > lists:
 > [...]
 > > Another thing that came up was the impression that the overhead of
 > > tracing is too high.  I'm not sure where the number mentioned (5%)
 > 
 > The examples you mentioned confirm what Andrew mentioned recently:
 > What little public evidence there is comes from developers trying
 > to understand the kernel or debugging their own applications.
 > 
 > I'd be interested to see examples of how these tools help regular sys
 > admins or technically inclined users (no Aunt Tillie compatibility
 > required) -- IMO that would go a long way to make a case for inclusion [1].
 > 
 > Another concern raised at the summit (and what I am personally most
 > concerned about) is the overlap in all the frameworks that add logging
 > hooks for all kinds of purposes: auditing, performance, user level
 > debugging, etc.
 > 
 > Out of mainline examples that have been around for a while include:
 > 
 > - systrace http://niels.xtdnet.nl/systrace/
 > - syscalltrack http://syscalltrack.sourceforge.net/
 > - LTT http://www.opersys.com/LTT/
 > 
 > I wonder if a basic framework that can serve more than one purpose
 > makes sense.
 > 

I agree that it would make sense for all these tools to at least share
a common set of hooks in the kernel; it would be great if a single
framework could serve them all too.  The question at the summit was
'why not use the auditing framework for tracing?'.  I haven't had a
chance to look much at the code, but the performance numbers published
for tracing syscalls using the auditing framework aren't encouraging
for an application as intensive as tracing the entire system, as LTT
does.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107826445023282&w=2


 > When considering which tracing functionlity should be in mainline,
 > performance measurments for user-space come in pretty much at the
 > bottom of my list: Questions like "which process is overwriting this
 > config file behind my back" seem a lot more common and more likely to
 > be asked by people not willing or capable of compiling a patched kernel
 > for that purpose. And tools that are useful for kernel developers (while
 > unpopular with the powers that be) are nice to have in mainline because
 > as a kernel hacker, you often _have_ to debug the latest kernel for
 > which your favorite debug tool is not working yet. An argument for
 > adding security auditing to mainline is that it helps convince the
 > conservative and cautious security folks that the functionality is
 > accepted and here to stay.
 > 

OK, so peformance isn't that important for your application, but for
LTT it is, the idea being that tracing the system should disrupt it as
little as possible and be able to deal with large numbers of events
efficiently.  That's also why the base LTT tracer doesn't do things in
the kernel that some of these other tools do, such as filtering on
param values for instance.  That type of filtering in the kernel can
however be done using the dynamic tracepoints provided by dprobes,
which can conditionally log data into the LTT data stream.  There's
even a C compiler that allows you to define your probes in C and
access arbitrary kernel data symbolically, including function params
and locals.

 > None of these arguments apply for LTT as it presents itself: If you
 > are debugging or tuning a multi-threaded user space app or trying to
 > understand the kernel, patching some kernel supported by the respective
 > tool should hardly be a problem.
 > 
 > Please note that I just compared the relative merits of merging various
 > kinds of tracing functionality into mainline. I did not argue in favor
 > or against the inclusion of LTT-type functionality.
 > 
 > My point is that the best bet for tools that seem to aim at user-space
 > performance debugging is to demonstrate how they can be useful for a
 > wider audience, or to hitch a ride with a framework that does appeal
 > to a wider audience.
 > 
 > Roger
 > 
 > [1] You could take a page from how DTrace was introduced:
 >     http://www.sun.com/bigadmin/content/dtrace/

Yes, dtrace is interesting.  It has a lot of bells and whistles, but
the basic architecture seems very similar to the pieces we already
have and have had for awhile:

- basic infrastructure (LTT)
- static tracepoints via something like kernel hooks
  (http://www-124.ibm.com/developerworks/oss/linux/projects/kernelhooks/)
- dynamic tracepoints via something like dprobes
  (http://www-124.ibm.com/developerworks/oss/linux/projects/dprobes/)
- low-level probe language something like dprobes' rpn language
- high-level probe language something like the dprobes C compiler

I too would like to have a polished 400 page manual with copious usage
examples but there are only so many hours in the day... ;-)

 >     Or take a look at:
 >     http://syscalltrack.sourceforge.net/when.html
 >     http://syscalltrack.sourceforge.net/examples.html

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

