Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUFPVGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUFPVGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUFPVFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:05:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264791AbUFPVEC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:04:02 -0400
Date: Wed, 16 Jun 2004 17:03:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: eliot@cincom.com
cc: Linux kernel <linux-kernel@vger.kernel.org>, tgriggs@key.net
Subject: Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across
 context switches
In-Reply-To: <200406162032.NAA29397@central.parcplace.com>
Message-ID: <Pine.LNX.4.53.0406161652120.541@chaos>
References: <200406162032.NAA29397@central.parcplace.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 eliot@cincom.com wrote:

> Hi,
>
> 	I am the team lead and chief VM developer for a Smaltalk implementation based on a JIT execution engine.  Our customers have been seeing rare incorrect floating-point results in intensive fp applications on 2.6 kernels using various x86 compatible processors.  These problems do not occur on previous kernel versons.  We recently had occasion to reimplement our fp primitives to avoid severe performance problems on Xeon processors that were traced to Xeon's relatively slow implementation of fnclex and fstsw.  The older implementaton would produce a result and test for a valid (non NaN, non Inf) result by examining the FPU status flags via fstsw.  The newer implementation produces a result and tests its exponent for the NaN/Inf exponent.  The new implementation does not show the rare incorrect floating-point results in intensive fp applications on 2.6 kernels.  My conclusion is that context switches between the production of the result and the execution of the fstsw are the culprit, and that the context switch machinery fails to preserve the FPU status flags.
>
> I don't know whether any action on your part is appropriate.  The use of the FPU status flags is presumably rare on linux (I believe that neither gcc nor glibc make use of them).  But "exotic" execution machinery such as runtimes for dynamic or functional languages (language implementations that may not use IEEE arithmetic and instead flag Infs and NaNs as an error) may fall foul of this issue.  Since previous versions of the kernel on x86 apparently do preserve the FPU status flags perhaps its simple to preserve the old behaviour.  At the very least let me suggest you document the limitation.
>
> Sincerely,
> ---
> Eliot Miranda                 ,,,^..^,,,                mailto:eliot@cincom.com
> VisualWorks Engineering, Cincom  Smalltalk: scene not herd  Tel +1 408 216 4581
> 3350 Scott Blvd, Bldg 36 Suite B, Santa Clara, CA 95054 USA Fax +1 408 216 4500
>

All versions of the kernels preserve FPU state, including its flags
across context-switches. They use the FNSAVE/FRSTOR pair which saves
and restores the entire FPU environment including its flags. This
is very expensive, taking roughly 130 clocks for each operation.

What they don't do is save/restore FPU state during system calls
because it is extremely wasteful of preformance. So, if there is
any module loaded that (improperly) uses the FPU, the user's FPU
state can get trashed.

Also, I don't imagine you know what the [Enter] key does, do you?
If you hit this occasionally, somebody might be able to read your
text on a conventional terminal, rather than a Windows auto-warp
contraption.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


