Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVGVFXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVGVFXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 01:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVGVFXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 01:23:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262039AbVGVFW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 01:22:56 -0400
Date: Thu, 21 Jul 2005 22:22:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
In-Reply-To: <20050722132756.578acca7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0507212211400.6074@g5.osdl.org>
References: <200507212309_MC3-1-A534-95EF@compuserve.com>
 <20050722132756.578acca7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jul 2005, Andrew Morton wrote:
> 
> Is the benchmark actually doing floating point stuff?

It must be. We still do lazy FP saves.

> We do have the `used_math' optimisation in there which attempts to avoid
> doing the FP save/restore if the app isn't actually using math.

No, it's more than that. There's a per-processor "used_math" flag to
determine if we need to _initialize_ the FPU, but on context switches we 
always assume the program we're switching to will _not_ use FP, and we 
just set the "fault on FP" flag and do not normally restore FP state.

It seems volanomark will always use FP, if this is the hot path. 

We'll only save the FP context if the thread has used the FP in _that_ 
particular time-slice (TS_USEDFPU).

As to why volanomark also uses FP, I don't know. I wouldn't be surprised 
if the benchmark was designed by somebody to not benefit from the x87 
state save optimization.

On the other hand, I also wouldn't be surprised if glibc (or similar
system libraries) is over-eagerly using things like SSE instructions for
memcopies etc, not realizing that they can have serious downsides. I don't
see why volanomark would use FP, but hey, it's billed as a java VM and
thread torture test for "chatrooms". Whatever.

		Linus
