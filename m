Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbUAMVJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUAMVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:09:39 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.14]:16922 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S265620AbUAMVJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:09:25 -0500
Date: Tue, 13 Jan 2004 22:09:23 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040113210923.GA955@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I first upgraded to Linux 2.6.0, I noticed that my mail
program (mutt) would occasionally stall when I send mails, even
when I send to a local account.

I investigated this further using the following strace command
(must be done as root) on qmail-inject:

  env - /usr/bin/strace -s1024 -tt -T -fF -o /tmp/st.out \
   /var/qmail/bin/qmail-inject </tmp/mail.test

/tmp/mail.test is this file:

  -----BEGIN-----
  From: hakonrk
  To: hakonrk
  Subject: hello

  world
  -----END-----

The entire output from strace is available for download from
<http://home.chello.no/~hakonrk/2.6.1.strace.out>, but I think
only this line is interesting:

  5083  16:00:30.714309 write(5, "\0", 1) = 1 <1.637019>

This the only write() to file descriptor 5 issued by qmail-queue,
right before it exists, and this is what causes the delay.
Notice that writing this single NUL-byte takes almost 1.64 seconds
(the number in the angle brackets at the end of the line is the
time spent in the system call, given by the -T flag to strace).
Furthermore, the kernel appears to be busy-waiting in this system
call, because the CPU usage quickly jumps to 100%.

Compare this to the result on Linux 2.4.24:
<http://home.chello.no/~hakonrk/2.4.24.strace.out>
Here's the same line that causes the delay on 2.6:

  5172  17:55:23.979799 write(5, "\0", 1) = 1 <0.000441>

Three orders of magnitude faster on 2.4!

I should also mention that the write-delay varies greatly.  I got
the above result (1.64 seconds) on a 2.6-system that had been
up for around four hours.  After rebooting, the delay dropped to
0.3 seconds, but it increases steadily while the system is up.

Finally, some info on my system:

  OS:      Slackware 9.1
  Kernels: 2.6.0, 2.6.1, 2.4.24
  Qmail:   1.03
  libc:    2.3.2
  gcc:     3.2.3
  CPU:     Athlon XP2500+

Kernel 2.6.1 was configured with
<http://home.chello.no/~hakonrk/config-2.6.1> 
and 2.4.24 with <http://home.chello.no/~hakonrk/config-2.4.24>.
If you need to know more, just ask.

If anyone on this list uses Qmail on Linux 2.6.x, I'd appreciate
it if you could do the strace test and see if you can reproduce
this bug.  Thanks in advance!

-- 
 Haakon
