Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWD2KDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWD2KDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 06:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWD2KDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 06:03:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:45517 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751863AbWD2KDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 06:03:05 -0400
Date: Sat, 29 Apr 2006 12:03:00 +0200 (MEST)
Message-Id: <200604291003.k3TA30oP025481@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: 76306.1226@compuserve.com
Subject: Re: [BUG] 2.6.17-rc3 broke FP exceptions on x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2006 04:00:49 -0400, Chuck Ebbert <76306.1226@compuserve.com> wrote:
>On Fri, 28 Apr 2006 14:54:40 +0200, Mikael Pettersson wrote:
>
>> Running an FP exception using user-space application
>> (the runtime system for the Erlang programming language
>> in my case) on an Athlon64 with a 32-bit 2.6.17-rc3 kernel
>> quickly results in a complete system hang: mouse is dead,
>> keyboard is dead, the network doesn't reply to pings.
>> Had to reboot via the power switch to get the machine back.
>> 
>> This happended twice in a row. With 2.6.17-rc2 things
>> work fine like they always have before.
>
>This should fix it... please test.
>
>Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
>
>--- 2.6.17-rc3-d4.orig/include/asm-i386/i387.h
>+++ 2.6.17-rc3-d4/include/asm-i386/i387.h
>@@ -58,13 +58,13 @@ static inline void __save_init_fpu( stru
> 	alternative_input(
> 		"fnsave %[fx] ;fwait;" GENERIC_NOP8 GENERIC_NOP4,
> 		"fxsave %[fx]\n"
>-		"bt $7,%[fsw] ; jc 1f ; fnclex\n1:",
>+		"bt $7,%[fsw] ; jnc 1f ; fnclex\n1:",
> 		X86_FEATURE_FXSR,
> 		[fx] "m" (tsk->thread.i387.fxsave),
> 		[fsw] "m" (tsk->thread.i387.fxsave.swd) : "memory");
> 	/* AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception
> 	   is pending.  Clear the x87 state here by setting it to fixed
>-   	   values. __per_cpu_offset[0] is a random variable that should be in L1 */
>+   	   values. safe_address is a random variable that should be in L1 */
> 	alternative_input(
> 		GENERIC_NOP8 GENERIC_NOP2,
> 		"emms\n\t"	  	/* clear stack tags */

This fixed the problem. Thanks.

Acked-by: Mikael Pettersson <mikpe@it.uu.se>
