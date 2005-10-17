Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVJQCUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVJQCUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 22:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVJQCUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 22:20:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbVJQCUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 22:20:21 -0400
Date: Sun, 16 Oct 2005 19:19:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org,
       khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <20051016185632.GE8303@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
References: <87fyr2ape5.fsf@foo.vault.bofh.ru> <87slv23bw5.fsf@foo.vault.bofh.ru>
 <20051016162306.GA10410@in.ibm.com> <873bn1thwf.fsf@foo.vault.bofh.ru>
 <20051016185632.GE8303@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Dipankar Sarma wrote:
> 
> Secondly, on subsequent repeated tests, I saw a very large number
> of allocated objects (600000+) in filp cache. That does point to either RCU
> grace period not happening or my sycall measurements completely
> wrong. I did run with the following patch that adds syscall
> exit as a queiescent state, but it didn't help. I am going
> to have to instrument RCU to see what is really happening.

I would _really_ prefer to not do this in the system call hot-path by 
default. That is unquestionably the hottest path in the kernel by far. 

It would be _much_ better to set one of the TIF_WORK flags when there's a 
lot of RCU stuff, and do this all in the not-quit-so-hot path of 
do_notify_resume() (on x86, I think others call it other things) instead.

If you use the same kind of "set the TIF flag every 1000 rcu events" 
approach that my failed patch had, you'd be much better off.

In fact, in that path you could even do a full "rcu_process_callbacks()". 
After all, this is not that different from signal handling.

Gaah. I had really hoped to release 2.6.14 tomorrow. It's been a week 
since -rc4.

Maybe this isn't that serious in practice right now? Serge, how did you 
notice it?

			Linus
