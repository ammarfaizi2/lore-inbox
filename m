Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270036AbRHMJbe>; Mon, 13 Aug 2001 05:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270042AbRHMJbZ>; Mon, 13 Aug 2001 05:31:25 -0400
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:48084 "helo
	staff.cs.usyd.edu.au") by vger.kernel.org with SMTP
	id <S270036AbRHMJbF>; Mon, 13 Aug 2001 05:31:05 -0400
Date: Mon, 13 Aug 2001 19:29:32 +1100
From: bruce@cs.usyd.edu.au (Bruce Janson)
Subject: ptrace(), fork(), sleep(), exit(), SIGCHLD
To: linux-kernel@vger.kernel.org
Message-Id: <20010813093116Z270036-761+611@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    The following program behaves incorrectly when traced:

  $ uname -a
  Linux dependo 2.4.2-2 #1 Sun Apr 8 19:37:14 EDT 2001 i686 unknown
  $ cc -v
  Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
  gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
  $ strace -V
  strace -- version 4.2
  $ cat t.c
  main()
  {
  	switch (fork())
  	{
  	case -1:
  		write(2, "fork\n", 5);
  		break;
  
  	case 0:
  		usleep(1000000);
  		break;
  
  	default:
  		if (usleep(5000000) == -1)
  			write(2, "wrong\n", 6);
  		break;
  	}
  
  	exit(0);
  }
  $ cc t.c
  $ time ./a.out
  
  real    0m5.011s
  user    0m0.000s
  sys     0m0.000s
  $ time strace -o /dev/null ./a.out
  wrong
  
  real    0m1.025s
  user    0m0.010s
  sys     0m0.010s
  $ 

The problem appears to be that, when traced, the child process' exit()
interrupts the parent's usleep() with a SIGCHLD, the latter returning EINTR.
It also fails in the same way under Linux 2.2.16 and 2.2.19.

What am I missing?
