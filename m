Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUK1SLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUK1SLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbUK1SLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:11:04 -0500
Received: from main.gmane.org ([80.91.229.2]:33242 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261545AbUK1SKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:10:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_01@xemaps.com>
Subject: Re: Futex queue_me/get_user ordering
Date: Sun, 28 Nov 2004 12:36:57 -0500
Message-ID: <41AA0CB9.CB30715A@xemaps.com>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041126170649.GA8188@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en-US,en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:
> 
> I've looked at the problem of lost-wakeups problem with NPTL condition
> variables and 2.6 futex, with the help of Jakub's finely presented
> pseudo-code.  Unless I've made a mistake, it is fixable in userspace.
> 
> [ It might be more efficient to fix it in kernel space - on the other
>   hand, doing so might also make kernel futexes slower.  In general, I
>   prefer if the kernel futex semantics can be as "loose" as possible
>   to minimise the locking they are absolutely required to do.  Who
>   knows, we might come up with an algorithm that uses even less
>   cross-CPU traffic in the kernel, if the semantics permit it.
>   However, I appreciate that a more "atomic" kernel semantic is easier
>   to understand, and it is possible to implement that if it is really
>   worth doing.  I would like to see benchmarks proving it doesn't slow
>   down normal futex stress tests though.  It might not be slower at all. ]

[...]
>     5. Like 4, but in the kernel.  We change the kernel to _always_
>        retransmit a wakeup if it's received by the unqueue_me() in the
>        word-didn't-match branch.
> 
>        Effect: In the "Drowsy" state, a waiter may accept a WAKE token
>        but then it will offer it again so they are never lost from
>        "Sleeping" states.
> 
>        NOTE: This is NOT equivalent to changing the kernel to do
>        test-and-queue atomically.  With this change, a FUTEX_WAKE
>        operation can return to userspace _before_ the final
>        destination of the WAKE token decides to begin FUTEX_WAIT.
> 
>        This will result in spurious extra wakeups, erring too far the
>        other way, because of the difference from atomicity described
>        in the preceding paragraph.
> 
>        Therefore, I don't like this.  It would fix the NPTL condition
>        variables, but introduces two new problems:
> 
>            - It violates conservation of WAKE tokens (like energy and
>              momentum), which some other futex-using code may depend
>              on - unless the return value from FUTEX_WAIT is changed
>              to report 1 when it receives a token or 2 when it
>              forwards it successfully.
> 
>            - Some spurious wakeups at times when a wakeup is not
>              required.
> 
>            - No logical benefit over doing it in userspace, but
>              would take away flexibility if kernel always did it.
> 

I think this is similar to a solution that I proposed elsewhere.  You wake up
some other thread, if any, waiting on the futex.  This breaks what you call
WAKE tokens but wait morphing with FUTEX_CMP_REQUEUE does that already as far
as I can tell.   A FUTEX_WAIT that has been requeued onto another futex could
return EINTR instead of zero (one of the reasons you can't loop on EINTR's in
the cond wait code).

I did an alternate lock-free implementation of pthread condition variables with
a work around of sorts for that futex wake preemption problem I mentioned earlier.
I get a 3x to 200x performance improvement depending on what you are doing.  So
naturally I would be interested in a solution that doesn't require a userspace
bottleneck.

Joe Seigh

