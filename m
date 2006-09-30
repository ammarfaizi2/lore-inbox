Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWI3V4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWI3V4s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWI3V4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:56:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751354AbWI3V4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:56:47 -0400
Date: Sat, 30 Sep 2006 14:56:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <200609302230.24070.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609301449130.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org> <200609302230.24070.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Andi Kleen wrote:
> 
> Anyways, I guess we need even more validation in the fallback code,
> but just terminating the kernel thread stacks should fix that particular case.

Why not just add the simple validation?

A kernel stack is one page in size. If you move to another page, you 
terminate. It's that simple.

What if the kernel stack is corrupt? Buffer overruns do that.

This patch seems to just paper over the _real_ problem, namely the fact 
that the stack tracer code doesn't actually validate any of its arguments.

> When show_trace faults it is actually not the unwinder itself
> (which would be unwind()/processCFI() etc.), but fallback code
> which is actually just the old unwinder. So most of your accusations 
> are hitting the wrong piece of code, Linus.

Ehh, that's not even _true_, Andi.

The old unwinder (well, at least for x86, and I assume x86-64 used that as 
the beginning point) didn't have this problem at all, exactly because it 
couldn't get on the wrong stack-page in the first place.

The old code literally had:

	static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
	{
	        return  p > (void *)tinfo &&
	                p < (void *)tinfo + THREAD_SIZE - 3;
	}

and would refuse to touch anything that wasn't in the stack page. It was 
simple, AND WE NEVER _EVER_ HAD A BUG RELATED TO IT, AFAIK.

In contrast, the new code doesn't do any sanity checking at all, and this 
is not the first or even the second time it causes problems.

So be honest here, don't try to shift the blame.

		Linus
