Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbTCJSZx>; Mon, 10 Mar 2003 13:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbTCJSZx>; Mon, 10 Mar 2003 13:25:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14602 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261393AbTCJSZw>; Mon, 10 Mar 2003 13:25:52 -0500
Date: Mon, 10 Mar 2003 10:33:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: Jamie Lokier <jamie@shareable.org>, <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
In-Reply-To: <20030310110635.GA2148@averell>
Message-ID: <Pine.LNX.4.44.0303101027490.2059-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Mar 2003, Andi Kleen wrote:
> 
> Unfortunately the patch still has the problem pointed out by Manfred
> Spraul: if you're unlucky it could destroy the _TIF_SIGPENDING set by
> another CPU with the non atomic access. Really thread_info should have
> two flag words: one that is truly local and can be accessed without LOCK
> and one that can be changed at will by external users too.

Yup, you're right.

I fixed that by splitting the "flags" field into two: "flags" is the old
flags, and "status" is thread-synchronous stuff (ie things that don't need
to worry about atomicity). Right now the FP lazy bit is the only thing 
that is marked as thread-synchronous.

While going through the users I also noticed that fork() did the FPU 
unlazy() thing totally wrong - it the the parent unlazy() _after_ it had 
already copied the process flags to the child, so even though it copied 
the x87 state to the child, the process flags could still say that the 
child was using lazy state, and thus the FP state in the child was 
basically totally corrupt. I wrote a test program to verify.

So I fixed that part too, by having a "prepare_to_copy()" function that
properly "calms down" the parent before we copy the task and thread
states. That fixes the bug, and also avoids an extra unnecessary x87 state
copy on x86.

(Not that the extra copy is noticeable - fork() is expensive enough 
anyway. It might just _barely_ be noticeable on thread creation when we 
don't have to worry about copying the VM state. But the bug was real, 
and the simplification is an added bonus).

			Linus

