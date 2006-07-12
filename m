Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWGLIwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWGLIwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWGLIwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:52:13 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:43141 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750969AbWGLIwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:52:12 -0400
Date: Wed, 12 Jul 2006 10:52:11 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, oleg@tv-sign.ru, ioe-lkml@rameria.de
Subject: Re: [PATCH] de_thread: Use tsk not current.
Message-ID: <20060712085211.GA15665@rhlx01.fht-esslingen.de>
References: <m1bqrwkb0u.fsf@ebiederm.dsl.xmission.com> <20060711031635.a6a1f759.akpm@osdl.org> <44B3A2D1.2010108@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B3A2D1.2010108@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 11, 2006 at 11:08:33PM +1000, Nick Piggin wrote:
> Andrew Morton wrote:
> >On Mon, 10 Jul 2006 22:42:25 -0600
> >ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >
> >>Ingo Oeser pointed out that because current expands to an inline 
> >>function it
> >>is more space efficient and somewhat faster to simply keep a cached copy 
> >>of
> >>current in another variable.  This patch implements that for the 
> >>de_thread
> >>function.
> >>
> >>-	if (thread_group_empty(current))
> >>+	if (thread_group_empty(tsk))
> >>-	if (unlikely(current->group_leader == child_reaper))
> >>-		child_reaper = current;
> >>+	if (unlikely(tsk->group_leader == child_reaper))
> >>+		child_reaper = tsk;
> >>-	zap_other_threads(current);
> >>+	zap_other_threads(tsk);
> >>	read_unlock(&tasklist_lock);
> >>...
> >
> >
> >This saves nearly 100 bytes of text on gcc-4.1.0/i686.
> 
> Why can't current be a pure function, I wonder?

Most likely due to compiler issues:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=17972
(which turns out to deal with current_thread_info() specifically!)
http://www.cs.helsinki.fi/linux/linux-kernel/2003-22/0265.html

However as I've been interested in this issue since I noticed
AGI stalls (pipeline stalls) in oprofile output on x86 recently
due to very non-parallel "mov    %esp,%eax; and    $0xffffe000,%eax"
sequence (but couldn't think of a way to get rid of this),
I'm going to verify what adding pure does with my >= 4.0.0 gcc on my x86 box.

I'm expecting quite some *general* performance improvement in the
low percentage range here...
(since this would be much more than simply merging multiple "current"
into a local stack variable, since *every* current_thread_info() call
would benefit from this and current_tread_info() is used all over the
place in high-profile call sites)

If this works for >= 4.0.0, then I'll try to add conditional support
for pure etc. in our compiler version dependent infrastructure headers.

Plus, we also access current_thread_info() related things within loops
in some cases; would be much better then to store it in a stack variable
outside, methinks. Or could this conflict with aggressive preemption???

Andreas Mohr
