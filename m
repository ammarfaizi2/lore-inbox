Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933397AbWKTPiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397AbWKTPiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933940AbWKTPiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:38:15 -0500
Received: from smtpout.mac.com ([17.250.248.173]:55525 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S933397AbWKTPiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:38:14 -0500
In-Reply-To: <4561ABB4.6090700@hogyros.de>
References: <4561ABB4.6090700@hogyros.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <33832325-EF32-4C6D-B566-8B7CE179FF1C@mac.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: RFC: implement daemon() in the kernel
Date: Mon, 20 Nov 2006 09:38:06 -0600
To: Linux-Kernel mailing-list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2006, at 7:20 AM, Simon Richter wrote:

> [please CC me on replies]
>
> Hi,
>
> I'm working with Linux on MMUless systems, and one of the biggest  
> issues
> in porting software is the lack of working fork().
>
> Except some special cases (like openssh's priviledge separation),  
> fork()
> is called in mainly three cases:
>
>  - spawn off a new process, which calls exec() immediately
>
> This can be easily replaced by a call to vfork(), which invokes the
> clone() syscall with the CLONE_VFORK flag.
>
>  - split off some work into a separate thread and provide address  
> space
> separation
>
> Since we don't have a MMU, there is no address space separation  
> anyway,
> so we can replace this with a pthread_create(), which in turn calls  
> clone().
>
>  - daemonize a process
>
> There is a function called daemon() that does this; its behaviour is
> roughly defined by (modulo error handling)
>
> int daemon(int nochdir, int noclose)
> {
> 	if(!nochdir)
> 		chdir("/");
>
> 	if(!noclose)
> 	{
> 		int fd = open("/dev/null", O_RDWR);
> 		dup2(fd, 0);
> 		dup2(fd, 1);
> 		dup2(fd, 2);
> 		close(fd);
> 	}
>
> 	if(fork() > 0)
> 		_exit(0);
> }
>
> Since it calls _exit() right after fork() returns (so daemon() never
> returns to the calling process except in case of an error) it would be
> possible to implement this on MMUless machines if the last two lines
> could happen in the kernel.
>
> I can see three possible implementations:
>
>  - "cheap" implementation
>
> The process is assigned a new PID and the parent is pretended to have
> exited. There are a lot of pitfalls here, so it is probably not a  
> good idea.
>
>  - a reverse vfork()
>
> The child process is created and suspended, the parent continues to  
> run
> until it calls exec() or _exit(). The good thing here is that it  
> should
> be easy to implement as the infrastructure for suspending a process
> until another exits already exists.
>
>  - "normal" implementation
>
> The child is created, the parent immediately zombiefied with a return
> code of zero. This might be more difficult to implement as the current
> implementation of fork() does not need to terminate a process in any
> way, so there might be funny locking and other issues.
>
> Questions? Comments?

There is a better way. Simply implement fork(). It can be done even  
without an MMU. People think it is impossible, but that is only  
because they don't consider the possibility of copying memory back  
and forth on task switch. It sounds horrible, but in the vast  
majority of cases, either the parent or child either exits or does an  
exec pretty quickly, so in reality it doesn't cost much. The benefits  
are many: being able to use real shells such as bash and thereby  
being able to use real shell scripts.

When I was at BRECIS we implemented this in a 2.4 uClinux kernel - as  
well as in an OpenBSD port. I can't take any credit for this work - a  
friend of mine did it - but at least I recognized that such a thing  
was possible. Having seen the results of this before, this really is  
the way to go to improve MMU-less systems.

You do have to look out for any applications that fork and do not  
either exit or exec, but that is so much better than having to modify  
so many things just to get them to run.

-- 
Mark Rustad, MRustad@mac.com

