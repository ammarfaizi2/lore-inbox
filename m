Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263944AbUFPOy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUFPOy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUFPOy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:54:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44216 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263944AbUFPOyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:54:53 -0400
Date: Wed, 16 Jun 2004 07:54:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
cc: mingo@elte.hu, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, akpm@osdl.org, wli@holomorphy.com,
       markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
Message-ID: <3040000.1087397675@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0406152004540.4142@ppc970.osdl.org>
References: <E1BaPwX-0007k0-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0406152004540.4142@ppc970.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > How the hell can that have any effect on non-threaded workloads? Perhaps
>> > some part of kernel compile *is* multi-threaded. It does seem to get 
>> 
>> make(1) with vfork(2) perhaps?
> 
> Very likely. And in the vfork() case it is definitely WRONG to try to
> reschedule (either threads _or_ processes), since the parent is going to
> go to sleep real soon now.
> 
> I think this code:
> 
>                         if (clone_flags & CLONE_VM)
>                                 wake_up_forked_thread(p);
>                         else
>                                 wake_up_forked_process(p);
> 
> is just wrong, and it should be replaced with
> 
> 			wake_up_new_process(p, clone_flags);
> 
> and then "wake_up_new_process()" can do the right thing, which is 
> basically:
> 
> 	if (clone_flags & CLONE_VFORK)
> 		synchronous wakeup, same as pipe-will-block case
> 	else if (clone_flags & CLONE_VM)
> 		thread-wakeup-case
> 	else
> 		process-wakeup-case
> 
> No?

Looks much better ... but I'd still dispute whether we need to throw 
non-vfork threads cross node by default. I'd suggest that's disabled
by default, and is either enabled by a global userspace option, or a
per-process one (or the option of both). Most thing (except benchmarks)
simply don't want this in real life ...

M.

