Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282159AbRKWOlX>; Fri, 23 Nov 2001 09:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282158AbRKWOlO>; Fri, 23 Nov 2001 09:41:14 -0500
Received: from [194.65.152.209] ([194.65.152.209]:29606 "EHLO
	criticalsoftware.com") by vger.kernel.org with ESMTP
	id <S282156AbRKWOlG>; Fri, 23 Nov 2001 09:41:06 -0500
Message-Id: <200111231440.fANEeh213167@criticalsoftware.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Lu=EDs=20Henriques?= 
	<lhenriques@criticalsoftware.com>
To: Juan Quintela <quintela@mandrakesoft.com>,
        =?iso-8859-1?q?Lu=EDs=20Henriques?= <umiguel@alunos.deis.isec.pt>
Subject: Re: copy to suer space
Date: Fri, 23 Nov 2001 14:35:13 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Mike Fedyk <mfedyk@matchmail.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <200111211057.fALAvi288566@criticalsoftware.com> <m2ofltljcl.fsf@trasno.mitica>
In-Reply-To: <m2ofltljcl.fsf@trasno.mitica>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is wrong putting a signal handler in your process for a signal,
> and busy wait in that signal all the time that you want?

The point is that I'm implementing a tool that shall test fault tolerance (in 
the user processes, operating system, architecture, ...). The process is not 
supposed to know that he is being delayed!

n0ano suggested me another solution (thanks n0ano!!!): instead of altering 
the CS, I just put some code to the process stack, return to the SS:ESP 
(instead of CS:EIP) and, later, restore the stack and return to the process.

This is not working yet because it's - I'm having some problems with it. 
Could anyone look at this code and tell me where it can fail?

	rdtsc
	movl %eax, %ecx
	addl $0x1, %ecx
   loop:
	rdtsc
	cmp %ecx, %eax
	jb loop

When I read the timestamp («rdtsc»), a value is returned to edx:eax. This 
code works just fine when I put it in the process stack. The problem is when 
I want to compare %edx instead of %eax, that is:

	rdtsc
	movl %edx, %ecx
	addl $0x1, %ecx
   loop:
	rdtsc
	cmp %ecx, %edx
	jb loop

This is supposed to take much more time than the other loop. When I write 
this code to the stack of my process, a segmentation fault occurs after some 
time. Why? I'm not changing the stack at any moment! (By the way, the stack 
pointer is pointing to the end of my code...)

-- 
Luís Henriques
