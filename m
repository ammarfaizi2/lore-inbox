Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbTCJTRW>; Mon, 10 Mar 2003 14:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbTCJTRW>; Mon, 10 Mar 2003 14:17:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261415AbTCJTRV>; Mon, 10 Mar 2003 14:17:21 -0500
Date: Mon, 10 Mar 2003 11:25:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status
 field.
In-Reply-To: <20030310.105659.57012503.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0303101119220.2240-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Mar 2003, David S. Miller wrote:
>    
> At least on sparc{32,64}, we consider FPU state to be clobbered coming
> into system calls, this eliminates a lot of hair wrt. FPU state
> restoring in cases such as fork().

We could _probably_ do it on x86 too. The standard C calling convention on 
x86 says FPU register state is clobbered, if I remember correctly. 
However, some of the state is "long-term", like rounding modes, exception 
masking etc, and even if we didn't save the register state we would have 
to save that part.

And once you save that part, you're better off saving the registers too, 
since it's all loaded and saved with the same fxsave/fxrestor instruction 
(ie we'd actually have to do _more_ work to save only part of the FP 
state).

> Are you preserving FPU state across fork() on x86?  If so, what do you
> think might rely on this?

Probably nothing per se. HOWEVER, we'd still need to save the state for 
rounding etc, so we might as well save it all.

As it was, the x86 state was pretty much random after fork(), and that can 
definitely lead to problems for real programs if they depend on things 
like silent underflow etc. 

(Now, in _practice_ all processes on the machine tends to use the same
rounding and exception control, so the "random" state wasn't actually very
random, and would not lead to problems. It's a security issue, though).

		Linus

