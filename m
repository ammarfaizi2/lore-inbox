Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSFGUO1>; Fri, 7 Jun 2002 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSFGUO0>; Fri, 7 Jun 2002 16:14:26 -0400
Received: from adsl-67-115-15-222.dsl.sndg02.pacbell.net ([67.115.15.222]:50825
	"HELO mx.xpsi.com") by vger.kernel.org with SMTP id <S317340AbSFGUOY>;
	Fri, 7 Jun 2002 16:14:24 -0400
Date: Fri, 7 Jun 2002 13:09:05 -0700
From: Jacob Cohen <cohen@rafb.net>
X-Mailer: The Bat! (v1.53d) Personal
Reply-To: Jake Cohen <cohen@rafb.net>
X-Priority: 3 (Normal)
Message-ID: <12812896964.20020607130905@rafb.net>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.18 - select() returning strange value
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.

Please CC: me on replies

Summary: when calling select() on a set of file descriptors containing
only the descriptor of a non-connected stream socket, select() returns
1 and marks the FD set as if data were waiting on the socket.


Details: I first noticed, when trying to install the perl module
Net::Telnet, that the select test was failing. Running strace on the
test program, I determined that select() was returning an unexpected
value.
I wrote a simple C program to duplicate this behavior, and got the
same results.

sock = socket(AF_INET, SOCK_STREAM, 6);
FD_ZERO(&rfds);
FD_SET(sock, &rfds);
tv.tv_sec = 0; tv.tv_usec = 0;
retval = select(sock+1, &rfds, NULL, NULL, &tv);

Produced these strace lines:

socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
select(4, [3], NULL, NULL, {0, 0}) = 1 (in [3], left {0, 0})

According to what I've read in the man pages for select() and
socket(), a nonconnected socket should be unreadable, and therefore
select() should timeout and return 0. I cannot figure out why it is
returning 1.

I've gotten this result on kernel 2.4.18, and someone confirmed the
same result on 2.4.19-pre7. A user with 2.2.19 ran my test program and
got a return value of 0, which is what I would expect the return value
to be.

Has something changed in the kernel or the way the select() syscall
behaves on a nonconnected socket that I should be aware of? I cannot
find anything relevant in the recent change logs, but I am probably
missing something.

Any insight into this would be much appreciated. Thanks in advance.

-- 
Regards,
Jake                          mailto:cohen@rafb.net

