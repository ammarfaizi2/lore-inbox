Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTCJUBF>; Mon, 10 Mar 2003 15:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbTCJUBF>; Mon, 10 Mar 2003 15:01:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17924 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261463AbTCJUBE>; Mon, 10 Mar 2003 15:01:04 -0500
Date: Mon, 10 Mar 2003 12:09:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status
 field.
In-Reply-To: <3E6CEEB9.1050304@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0303101203330.2722-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Mar 2003, Chris Friesen wrote:
> > 
> > And once you save that part, you're better off saving the registers too, 
> > since it's all loaded and saved with the same fxsave/fxrestor instruction 
> > (ie we'd actually have to do _more_ work to save only part of the FP 
> > state).
> 
> Does this open the door for using FP in the kernel?

Not any wider than it already is.

For a while now, x86-specific optimizations (and all such stuff is by 
nature very much architecture-specific) have been able to do

	kernel_fpu_begin();
	...
	kernel_fpu_end();

and use the FP state in between. It generally sucks if the user-mode 
process had touched FP state (we'll force it saved), but most of the time 
that isn't true, and the only thing it does is to temporarily clear the 
TS bit so that the FPU works again (and then sets it again in fpu_end, 
although if this was a common thing we _could_ make that be a "work" 
thing that is only done at return-to-user-mode).

Of course, clearing TS isn't exactly fast, so this really only works if 
you have tons of stuff that you _really_ want to use the FPU for. And 
since the FP cache is per-CPU, the whole region in question is 
non-preemptible, so this can only be used for non-blocking stuff.

In other words: it's still very much a special case, and if the question 
was "can I just use FP in the kernel" then the answer is still a 
resounding NO, since other architectures may not support it AT ALL.

		Linus

