Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWBPVw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWBPVw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWBPVw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:52:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:19343 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932558AbWBPVw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:52:28 -0500
Date: Thu, 16 Feb 2006 22:50:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, akpm@osdl.org
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060216215036.GD25738@elte.hu>
References: <20060216094130.GA29716@elte.hu> <20060216132309.fd4e4723.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216132309.fd4e4723.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> Nice stuff ...
> 
> I wonder if some of the initial questions about whether gcc would be
> forcing something on the kernel, and whether it was unsafe for the
> kernel to be walking a user list, are distracting from a more
> interesting (in my view) question.
>
> One can view this as just another sort of "interesting" system call, 
> where user code puts some data in various register and memory 
> locations, and then ends up by some predictable path in kernel code 
> which is acting on the request encoded in that data.

correct.

> As always with system calls:
>  1) the kernel can't trust the user data any further than the user
>     could have thrown it, and
>  2) the interface needs a robust ABI and one or more language API's,
>     which will stand the test of time, over various architectures
>     and 32-64 emulations.
> 
> >From what I could see glancing at the code and comments, Ingo has (1)
> covered easily enough.
> 
> Would it make sense to have a language independent specification of 
> this interface, providing a detailed ABI, suitably generalized to 
> cover the various big endian, little endian, 32 and 64 and cross 
> environments that Linux normally supports?

little/big endian shouldnt be a problem i think, as this is a 
nonpersistent object. (futexes do not survive reboot)

The 32-bit-on-64-bit support code was indeed interesting, but it's also 
pretty straightforward. See kernel/futex_compat.c where the 64-bit 
kernel walks a 32-bit userspace. The method i took was to have _two_ 
lists:

        struct robust_list_head __user *robust_list;
#ifdef CONFIG_COMPAT
        struct compat_robust_list_head __user *compat_robust_list;
#endif

and at do_exit() time we process _both_ lists, first the 64-bit one, 
then the 32-bit one. This handles execution environments that have both 
32-bit and 64-bit state - they could crash in e.g. 32-bit mode holding 
robust futexes, while holding 64-bit robust futexes too. This method 
correctly handles e.g. x86 binaries on x86_64 [i checked that], and 
native binaries too.

> I have in mind something that a competent assembly language coder 
> could write to, directly, when coding user access to this facility?  
> Or some other language or library implementor, besides C and glibc, 
> could develop to?

in this particular case i dont think it could be described in a more 
generic way. I'm not against your idea per se - but someone would have 
to code it up ;) Nor do i think that in this particular case we'd need 
more flexibility than the patch offers: only a minimal amount of things 
are 'hardcoded' in the robust-list approach, and even those are either 
known futex properties, or are 'obvious' approaches like the fact that 
it's represented as a linked list. (which is what glibc uses anyway) But 
e.g. we dont force the single linked list: userspace can use a 
double-linked list too - the kernel will simply walk the single-linked 
component of that list in a forwards way.

> This is sort of like specifying the over the wire protocols the 
> internet, where each byte is spelled out, avoiding any assumption of 
> what sort of computing device is on the other end.  Well, not quite 
> that bad.  I guess we can assume the user code is running on the same 
> arch as the kernel, give or take possible word size and endian 
> emulations ... though if performance of this even from within machine 
> architecture emulators was a priority, even that assumption is perhaps 
> not desirable.

i think my patch is a good example of how to do it with our existing 
tools: i separated the list walking into a separate function 
(exit_robust_list() and compat_exit_robust_list()), which purely handles 
the data structure details.

In theory you are right, these two functions do essentially the same 
thing, and we could have automatically 'converted' 
compat_exit_robust_list() from the native exit_robust_list() function - 
but in practice it was a pretty straightforward process anyway for these 
~50-line functions. I think it would need a more complex example than 
this to justify some sort of new language.

	Ingo
