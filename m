Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTEIAm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbTEIAm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:42:28 -0400
Received: from mrt-aod.iram.es ([150.214.224.146]:21255 "EHLO mrt-lx16.iram.es")
	by vger.kernel.org with ESMTP id S262262AbTEIAm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:42:27 -0400
From: paubert <paubert@mrt-lx16.iram.es>
Date: Thu, 8 May 2003 22:54:57 +0000
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: desc v0.61 found a 2.5 kernel bug
Message-ID: <20030508225457.A11862@mrt-lx16.iram.es>
References: <200304301610_MC3-1-36BC-C42@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304301610_MC3-1-36BC-C42@compuserve.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 04:08:05PM -0400, Chuck Ebbert wrote:
[Sorry for the delay I've been extremely busy on other things]
> 
>  Looks like the only clean way is to follow the TSS back link and manually
> validate the segment registers before returning:
> 
>   invalid FS,GS -> 0
>      "    DS,ES -> __USER_DS
>           CS,SS -> panic?

It's still racy on SMP if a thread with the same MM is modifying the LDT
between the time you check whether the selectors are valid and the iret
instruction restoring the previous stack.

> 
>  Bad things can happen if a debug fault happens in certain places... for now
> the solution is to only support int3 breakpoints and avoid those places.

Can you elaborate a bit, in which places?

> 
>  Given the above, I hope to be able to put int3 instructions in either
> kernel or user code and get snapshots of CPU state in the kernel TSS.

And what about the little bit called TS in CR0 which is always set by 
a task switch. That's one bit of state which will be always set when
the debug interrupt returns, and the current code for FPU will be
confused by this AFAICT. Things become even more interesting if you 
want to allow debug traps between in the kernel routines using the
FPU, between kernel_fpu_begin() and kernel_fpu_end().

	Gabriel

