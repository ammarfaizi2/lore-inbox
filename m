Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755650AbWKTNVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbWKTNVB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 08:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459AbWKTNVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 08:21:00 -0500
Received: from static.88-198-202-190.clients.your-server.de ([88.198.202.190]:4766
	"EHLO kleinhenz.com") by vger.kernel.org with ESMTP
	id S1755649AbWKTNU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 08:20:59 -0500
Message-ID: <4561ABB4.6090700@hogyros.de>
Date: Mon, 20 Nov 2006 14:20:52 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC: implement daemon() in the kernel
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please CC me on replies]

Hi,

I'm working with Linux on MMUless systems, and one of the biggest issues
in porting software is the lack of working fork().

Except some special cases (like openssh's priviledge separation), fork()
is called in mainly three cases:

 - spawn off a new process, which calls exec() immediately

This can be easily replaced by a call to vfork(), which invokes the
clone() syscall with the CLONE_VFORK flag.

 - split off some work into a separate thread and provide address space
separation

Since we don't have a MMU, there is no address space separation anyway,
so we can replace this with a pthread_create(), which in turn calls clone().

 - daemonize a process

There is a function called daemon() that does this; its behaviour is
roughly defined by (modulo error handling)

int daemon(int nochdir, int noclose)
{
	if(!nochdir)
		chdir("/");

	if(!noclose)
	{
		int fd = open("/dev/null", O_RDWR);
		dup2(fd, 0);
		dup2(fd, 1);
		dup2(fd, 2);
		close(fd);
	}

	if(fork() > 0)
		_exit(0);
}

Since it calls _exit() right after fork() returns (so daemon() never
returns to the calling process except in case of an error) it would be
possible to implement this on MMUless machines if the last two lines
could happen in the kernel.

I can see three possible implementations:

 - "cheap" implementation

The process is assigned a new PID and the parent is pretended to have
exited. There are a lot of pitfalls here, so it is probably not a good idea.

 - a reverse vfork()

The child process is created and suspended, the parent continues to run
until it calls exec() or _exit(). The good thing here is that it should
be easy to implement as the infrastructure for suspending a process
until another exits already exists.

 - "normal" implementation

The child is created, the parent immediately zombiefied with a return
code of zero. This might be more difficult to implement as the current
implementation of fork() does not need to terminate a process in any
way, so there might be funny locking and other issues.

Questions? Comments?

   Simon
