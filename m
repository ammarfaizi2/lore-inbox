Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUGAHHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUGAHHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUGAHHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:07:13 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:32490 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S264160AbUGAHG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:06:56 -0400
Date: Thu, 1 Jul 2004 00:06:51 -0700
Message-Id: <200407010706.i6176pTa019793@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrea Arcangeli <andrea@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: Linus Torvalds's message of  Wednesday, 30 June 2004 22:56:18 -0700 <Pine.LNX.4.58.0406302250120.11212@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Zippy-Says: I'm young..  I'm HEALTHY..  I can HIKE THRU CAPT GROGAN'S LUMBAR REGIONS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 30 Jun 2004, Roland McGrath wrote:
> > 
> > No, I am preserving the feature that the child doesn't go away in this case.
> > ptraced threads always become zombies and let the ptracer see their exit
> > notification and status value.  That is the way we want it to stay.
> 
> Umm.. This is not the "ptrace_list". This is the _regular_ child list.

The ptrace_list/ptrace_children list is the list of your natural children
that someone else has stolen by tracing them.  The "regular" child list is
all your natural children that noone has stolen, plus the ones you are
tracing.  We are talking here about an element on your "regular" child list
that is one you have stolen by tracing it, not a natural child.  If it is a
natural child, whether or not you are tracing it, this is not the case we
have been addressing so far.

> Which means that a bad person can try to:
>  - have "normal" children that are self-reaping.
>  - _also_ have a self-reaping ptraced child.
> 
> Now those _normal_ children may go away, no?

I think you are talking about this case:

	#include <signal.h>
	#include <unistd.h>
	#include <sys/ptrace.h>

	int main (void)
	{
	  signal(SIGCHLD,SIG_IGN);
	  switch (fork()) {
	  case -1:perror("fork");return 2;
	  case 0: ptrace(PTRACE_TRACEME, 0, (char *) 1, 0); _exit(2);
	  default:
	    sleep(2);
	    return 0;
	  }
	}

This program leaves a leaked zombie around.  That is fixed by handling the
case in reparent_thread where it possibly calls do_notify_parent in the
same way as the forget_original_parent case.  Not surprising, as both
places have the same existing code to handle the same issue--and both
overlook the same case.  I've just tested a version of my prior patch that
covers this case as well, and it works.  I can give you either the
lock-reacquiring version of that or the version based on the
list-collection patch I just posted.

> .. since this information should be available anyway (we'll have woken up 
> the tracer, and the tracer will see that the child is gone by simply 
> seeing the ESRCH errorcode from ptrace).

When did you wake up the tracer?  I don't see how that happened.  If the
tracer is blocked in a wait4 call and still has other live children, it
stays blocked.  Next time it wakes up for some other reason, it can poll
via a wait4 or ptrace call for each specific thread it knows it was
attached to and ascertain through ESRCH errors when one died.  
Having to do that sucks ass.


Thanks,
Roland
