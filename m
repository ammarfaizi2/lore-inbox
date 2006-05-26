Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWEZRrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWEZRrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWEZRrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:47:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52156 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751214AbWEZRrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:47:09 -0400
Date: Fri, 26 May 2006 19:47:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Message-ID: <20060526174723.GD30208@elte.hu>
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <20060513160541.8848.2113.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de> <20060526085916.GA14388@elte.hu> <b0943d9e0605260937j5a86d4dr4adcae6fc35c73fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0605260937j5a86d4dr4adcae6fc35c73fa@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> A problem I'm facing (also because I'm not familiar with the other 
> architectures) is detecting the effective stack boundaries of the 
> threads running or waiting in kernel mode. Scanning the whole stack 
> (8K) hides some possible leaks (because of no longer used local 
> variables) and not scanning the list at all can lead to false 
> positives. I would need to investigate this a bit more.

i was thinking about this too, and i wanted to suggest a different 
solution here: you could build a list of "temporary" objects that only 
get registered with the memleak proper once a thread exits a system call 
(or once a kernel thread goes back to its main loop). This means a 
(lightweight) callback in the syscall exit (or irq exit) path. This way 
you'd not have to scan kernel stacks at all, only .data and the objects 
themselves.

the stack boundary rules can be quite complex: for example on x86_64 you 
can have a pretty complex nesting of exception, interrupt and process 
stacks. In fact on SMP we dont even know the precise stack boundary for 
tasks that are running on some other CPU. [because we have no snapshot 
of their register state]

avoiding the scanning of the kernel stacks gets rid of some of the 
biggest source of natural entropy. (they contain strings and all sorts 
of other binary data that could accidentally match up with a kernel 
pointer)

	Ingo
