Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSHFRgT>; Tue, 6 Aug 2002 13:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHFRgT>; Tue, 6 Aug 2002 13:36:19 -0400
Received: from jdike.solana.com ([198.99.130.100]:1665 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S314514AbSHFRgS>;
	Tue, 6 Aug 2002 13:36:18 -0400
Message-Id: <200208061742.g76HgIg31452@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Tue, 06 Aug 2002 18:02:02 +0200."
             <20020806180202.66f1865a.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Aug 2002 13:42:18 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
> I'm glad we agree on that one :) 

Yup, sorry.  That test is wrong, and is slated to be fixed at some point.

> When the task is registered as socket owner and is just about to enter
> the kernel due to a syscall, it will stop with a SIGTRAP and the
> tracing kernel process will run sometime and see a SIGCHLD. But after
> the task stopped and before the kernel process can change SIGIO
> ownership back, a new interrupt could come in and the SIGIO would
> remain pending in the task's process until the task was scheduled to
> run next time.
>
> How do you solve this?

A couple of ways.  The system call path can call sigio_handler to clear
out any pending IO.  The SIGIO that was trapped in the process will cause
another call to sigio_handler which won't turn up any IO, but I don't 
consider that to be a problem.

The kernel process can examine the signal pending mask of the process after
it has transferred SIGIO to itself.  This can be done either through 
/proc/<pid>/status or a ptrace extension, since we're happily postulating 
new things for it to do anyway.  If there is a SIGIO pending, it calls
sigio_handler.

Any other possibilities that you see?

				Jeff

