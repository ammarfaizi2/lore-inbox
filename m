Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUDEPKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 11:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDEPKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 11:10:34 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:63380 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262766AbUDEPK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 11:10:28 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 5 Apr 2004 08:09:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Mihai RUSU <dizzy@roedu.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5 & AMD64 epoll weirdness
In-Reply-To: <Pine.LNX.4.58L0.0404051326360.1773@ahriman.bucharest.roedu.net>
Message-ID: <Pine.LNX.4.44.0404050802580.2051-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2004, Mihai RUSU wrote:

> Hi
> 
> I have this little test program:
> #include <sys/epoll.h>
> 
> int main(void)
> {
>     int efd;
>     struct epoll_event event;
>     struct epoll_event events[10];
> 
>     efd = epoll_create(100);
>     event.data.fd = 0;
>     epoll_ctl(efd, EPOLLIN, 0, &event);
>     epoll_wait(efd, events, 10, -1);
> }
> 
> This program runs fine on x86/32bit with 2.6.5 kernel. But on AMD64 it 
> does this (strace qoute):
> 
> epoll_create(0x64)                      = 3
> epoll_ctl(0x3, 0x1, 0, 0x7fbffff860)    = -1 ENOSYS (Function not implemented)
> epoll_wait(0x3, 0x7fbffff7e0, 0xa, 0xffffffff) = -1 ENOSYS (Function not implemented)
> 
> This is rather weird because I would expect to have epoll_create() fail 
> too (in fact I use this check at runtime, I try epoll_create and if it 
> works I presume epoll is functional; I needed this check because glibc 
> might have dummy epoll functions which always fail although the program 
> compiles fine with it). So do I really need to check all epoll syscalls 
> before presuming that epoll works on the current system ? (I would like to 
> have epoll_create failing in the case it doesnt supports AMD64).

I belive you have a glibc compiled with an old unistd.h. The epoll_ctl and 
epoll_wait functions seem that have been moved:

#define __NR_epoll_ctl_old      214  __SYSCALL(__NR_epoll_ctl_old, sys_ni_syscall)
#define __NR_epoll_wait_old     215  __SYSCALL(__NR_epoll_wait_old, sys_ni_syscall)
...
#define __NR_epoll_wait         232  __SYSCALL(__NR_epoll_wait, sys_epoll_wait)
#define __NR_epoll_ctl          233  __SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)

while epoll_create have not. A asm trace into epoll_ctl or epoll_wait 
might confirm this.



- Davide


