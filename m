Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWKUAiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWKUAiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966892AbWKUAiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:38:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:22419 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S966893AbWKUAiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:38:54 -0500
Message-ID: <45624A91.3010604@zytor.com>
Date: Mon, 20 Nov 2006 16:38:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Simon Richter <Simon.Richter@hogyros.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: implement daemon() in the kernel
References: <4561ABB4.6090700@hogyros.de>
In-Reply-To: <4561ABB4.6090700@hogyros.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Richter wrote:
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

... that should be if (fork() == 0) ...

> 		_exit(0);

	setsid();
> }
> 


> Since it calls _exit() right after fork() returns (so daemon() never
> returns to the calling process except in case of an error) it would be
> possible to implement this on MMUless machines if the last two lines
> could happen in the kernel.
> 

You could do this quite easily with clone() and a small assembly wrapper.

The assembly wrapper needs to do the last two lines without touching the 
stack in the parent.  That is usually quite trivial, even on 
register-starved architectures; for example, on i386 it would look like 
(ignoring vsyscalls for the moment, which are only an optimization anyway).

__detach_from_parent:
	pushl	%ebx
	movl	$__NR_clone, %eax
	movl	$CLONE_VM|SIGCHLD, %ebx
	xorl	%ecx, %ecx
	int	$0x80
	cmpl	$-4096, %eax
	ja	1f
	andl	%eax, %eax
	je	2f
	# Parent process, must _exit(0)
	xorl	%ebx, %ebx
	movl	$__NR_exit, %eax
	int	$0x80
	# _exit() should never return
	hlt
1:	# Error on fork(), set errno and return -1
	negl	%eax
	movl	%eax, errno		# Or TLS equivalent
	orl	$-1, %eax
2:	# Child process jumps here with %eax == 0 already
	popl	%ebx
	ret

