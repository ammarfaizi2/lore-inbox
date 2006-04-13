Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWDMBoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWDMBoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWDMBoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:44:46 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:58325 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932423AbWDMBop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:44:45 -0400
Subject: Re: [RFC] Making percpu module variables have their own memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <p734q0y4k69.fsf@bragg.suse.de>
References: <1144869739.26133.74.camel@localhost.localdomain>
	 <p734q0y4k69.fsf@bragg.suse.de>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 21:44:28 -0400
Message-Id: <1144892668.26133.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

First, thanks a lot for the feedback.

On Wed, 2006-04-12 at 22:23 +0200, Andi Kleen wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> The basic optimization idea looks interesting. But your implementation
> is quite complicated.  

Yes, it's a little complex, but since it only took me a half a day to
figured it out, it can't be too complex.  Nothing some good
documentation and comments can't fix (I would definitely add more
comments to the final patch).

> 
> The basic problem is that extern declarations and definitions
> are the same macro. If they weren't one could just use a different
> macro depending on if MODULE is defined or not and get rid
> of the type comparisons you do.

I don't quite understand what you mean here.

> 
> Since you already need to change a lot of the per CPU definitions how
> about you just define a separate macro for extern per cpu
> declarations? And then change the basic macro to do the right
> thing based on MODULE is set or not.
> 

Well, I haven't really changed a lot of the per_cpu variables.  There
were a few places that were just bad design.  In softirq (at least in
the -rt patch) the uses were referencing the elements in the per_cpu
struct which IMO is broken by design.  For example, we had
__get_cpu_var(ksoftirqd[softirq].tsk) instead of
__get_cpu_var(ksoftirqd[softirq]).tsk.  The ksoftirqd[softirq] was the
per_cpu variable, but the former looked like the ksoftirqd[softirq].tsk
was.  The later shows better what is really meant, and besides, the
former breaks my solution ;)

The other side effect my solution has is that you can't declare a
per_cpu variable static.  But with a quick look, the kernel only has a
few places that actually do that.  But this doesn't increase the size of
the kernel at all. It only adds more to the name space. But per_cpu
variables are in their own name space anyway, so this shouldn't be too
much of an issue.

So, the changes to be made to handle my solution is only a few, but to
change all per_cpu macros to be local or global would be quite an
effort, and much more room to make mistakes.  I would also have to
modify places in the kernel that I can't test, which to me is not a
solution.

My solution was to try to do as much as possible with as little impact
as possible.  And reading this mailing list, I took on the impression
that that's the way to go.  So yes, it adds a little more complexity,
but it actually simplifies module.c and the complexity is located in
only one location, which makes it actually much easier to debug and get
right.

Thanks again for your input,

-- Steve


