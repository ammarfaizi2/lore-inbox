Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbTCJVRw>; Mon, 10 Mar 2003 16:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbTCJVRv>; Mon, 10 Mar 2003 16:17:51 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:10463 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261474AbTCJVRu>; Mon, 10 Mar 2003 16:17:50 -0500
Date: Mon, 10 Mar 2003 22:28:15 +0100
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status field.
Message-ID: <20030310212815.GA30916@averell>
References: <20030310.105659.57012503.davem@redhat.com.suse.lists.linux.kernel> <Pine.LNX.4.44.0303101119220.2240-100000@home.transmeta.com.suse.lists.linux.kernel> <p737kb7542q.fsf@amdsimf.suse.de> <20030310.124502.115944935.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310.124502.115944935.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 12:45:02PM -0800, David S. Miller wrote:
>    Turned out the 32bit ptrace unlazy FPU path shared two lines too many
>    with with the 32bit signal FPU saving path and was resetting the
>    used_fpu flag. Result was that the FPU state of the child could be
>    reinitialized in some circumstances on ptrace accesses.
> 
> So what it depended upon was the FP control register state,
> not the state of the individual FPU registers, across fork()
> right?

Yes. The IA32 ABI says the FPU registers are clobbered in a function
call. And fork is a function call. Same with the SSE registers.

Unfortunately it is much more expensive to save individual registers
(SSE and x87 stack) than to just save everything using FXSAVE. 
FXSAVE uses lazy saving and saves only the x87 registers that are
actually uses.

For SSE registers it may make sense, but then FXSAVE does that already
too and you always have to handle the x87 register stack too.

I doubt it would be a good idea to not use FXSAVE on i386. The microcode
can do a better job here because it has more information. In addition
it also promises to handle future new Intel registers transparently.

x86-64 ABIs have similar semantics.

-Andi 
