Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUI2O1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUI2O1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUI2OYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:24:51 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:14806 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268447AbUI2OX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:23:29 -0400
Date: Wed, 29 Sep 2004 16:23:25 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Hui Huang <Hui.Huang@Sun.COM>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040929142325.GK4084@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <415903E4.1030808@sun.com> <20040928141914.GE2412@dualathlon.random> <415A7564.2090909@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415A7564.2090909@sun.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 01:42:12AM -0700, Hui Huang wrote:
> Sorry, I actually meant read _or_ write; that is, disable gap if
> prev_vma is PROT_NONE. The heap-stack-gap is essentially a floating
> PROT_NONE page. So if you see a PROT_NONE page below a growsdown stack,
> you could ignore the gap and allow stack to grow without losing any
> protection.

PROT_NONE would be ever safer than read-only indeed.

> You mean if there's heap memory right below the previously read-only
> vma, now it becomes read-write the stack can keep growing down and
> it can overwrite heap without a trap? That's a good point. We don't
> see that problem because the way we handle stack and heap. But it's
> certainly a possibility.

yes, even with PROT_NONE I'd still need to trap mprotect calls, and see
if the gap is still enforced after the mprotect. Then I would need to
return some sort of failure in mprotect if the gap is not enforced...

>                                                  So for simplicity of the
> >implementation I would prefer not to track readonly pages.  If you've a
> >strong reason for tracking readonly pages let me know of course. I think
> >java already does fine by checking the heap-stack-gap.
> 
> Indeed having a special case for PROT_NONE would complicate the
> situation, and it's not that simple as you pointed out.
> 
> However, my concern is that a hidden gap floating in memory makes it
> very hard to manage stacks, while on the other hand applications
> need heap-stack-gap protection could simply call mprotect to
> explicitly set up a range of memory as PROT_NONE. I can't imagine
> java being the only app out there that needs to handle stack
> overflows. Other people could see similar problems too (i.e. SEGV
> while cr2 is in the gap, not in the guard page).

I'm afraid most other apps don't do that (or if they do, they set it low
enough that it doesn't bother the further heap-stack-gap protection),
and on 64bit archs that's ok (only 32bit is a problem). java is safer
than the others of course.

> Now another wish - instead of a system-wide property, a per-process
> mechanism to change heap-stack-gap. Applications that need the gap
> can set up the appropriate size, while others like Java that manage
> heap and stack can simply disable the gap. Is it possible?

This is a very reasonable request, and yes, this is definitely possible,
I feel this is a much better feature than the mprotect trapping, which
is possible too, but it sounds not worth it.

As for the api, should that be a prctl, /proc/<pid>/heap-stack-gap, or a
brand new syscall? I personally enjoy the /proc/<pid>/heap-stack-gap
approach, but that's just me, the prctl and syscall would be more
efficient at runtime (but the point is that this doesn't need to be more
efficient and echo xx > /proc/<pid>/heap-stack-gap is so much easier to
play with for experiments)

If we can choose the API together I'll take care of implementing the
rest. I'd like to still leave a global sysctl for global system safety
(since most apps needs it and they won't all be required to tune it by
hand), so that the final number will be choose with:

	if (likely(per_process_setting < 0))
		return global_sysctl;
	else
		return per_process_setting;
