Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWDDWsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWDDWsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWDDWsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:48:40 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:16870 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750904AbWDDWsj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:48:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kRXZtPO+ssb0Kfu0ngcHqtiXKpvVoBQxPQVQEwFlvuNKR13vWJTMvM6Rhc9NcapJqP9WOoYi5nQogy0YBsXCczm/ni88zljWU8l699Ic3jC3sqE/KWUWw1MQxXncpRkhGtgrkjDI1oPPv/mN9O0hy8kANgMLloa7NX7uk7JW1nE=
Message-ID: <bda6d13a0604041548q6c3ac96frf5f760248e2f8dc7@mail.gmail.com>
Date: Tue, 4 Apr 2006 15:48:36 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_FRAME_POINTER and module vermagic
In-Reply-To: <4432EC08.4010104@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <442ACAD6.6@nortel.com>
	 <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com>
	 <4432EC08.4010104@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/06, Christopher Friesen <cfriesen@nortel.com> wrote:
>
> A while back there was a post that CONFIG_FRAME_POINTER doesn't affect
> calling conventions and doesn't need to be in vermagic.
>
> One of my coworkers seems to think otherwise, and I don't know enough
> about the issue to know for sure.  Could someone with i386 knowledge
> comment on his thoughts?
>
> Here's what he's currently thinking:
>
> 1) regs->ebp hold a copy of the stack frame pointer. It's value is
> conserved through any function that are compiled with FRAME_POINTER on.
>
> 2) (unsigned long *)(regs->ebp + 4) is the "pc" of the caller (like the
> link register on PPC which is relative to "fp")
>
> 3) The profile_pc function usually look directly at "pc" to do it's
> profiling magic but sometimes (when the current "pc" is inside a
> lock_function, we're SMP, and CONFIG_FRAME_POINTER is enabled) it uses
> "regs->ebp+4" to be more accurate on the profiling. In other word
> profile_pc doesn't want to create a profiling entry that would show
> redundant information about being stuck into a spin_lock...
>
> So, if the kernel was built with SMP and FRAME_POINTER, a module wasn't,
> the module used ebp as a general register, then blocked in a spinlock
> when profile_pc started...then a regs->ebp value of something
> interesting (like "0", for instance) could cause interesting behaviour.
>
> Seems reasonable to me, but like I said, I'm not an expert on i386.
>
> Chris
1. The calling convention of i386 requires that i386 function calls preserve ebp
(like esi).
2. Therefore, this will only affect code that actually looks at the
stack frame would
have to care.
3. Notice that profile_pc itself is compiled with frame pointers on in
this case and reads the PC [IP] of its own caller.
4. Therefore, the only thing that has to care is the kernel segfault handler.

The kernel segfault handler itself is not properly hardened against
this (it likes to generate recursive die() failure). I know: I've
smashed my own stack working on kernel code.

IMO, the problem here is not linking frame-pointer using code with
non-frame-pointer using code, but failing to harden the segfault
handler against a smashed stack frame
(which is exactly what using ebp as a general register looks like).
