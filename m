Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279788AbRKVOgj>; Thu, 22 Nov 2001 09:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279783AbRKVOg3>; Thu, 22 Nov 2001 09:36:29 -0500
Received: from ns0.ipal.net ([206.97.148.120]:13735 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S279778AbRKVOgY>;
	Thu, 22 Nov 2001 09:36:24 -0500
Date: Thu, 22 Nov 2001 08:36:23 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: EINTR vs ERESTARTSYS, ERESTARTSYS not defined
Message-ID: <20011122083623.A18057@vega.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The accept() call does indeed return errno==ERESTARTSYS to user space
when coming back from signal handling, even though other things like
poll() return errno==EINTR.  This would not really be a problem except
for this in include/linux/errno.h starting at line 6:

+=============================================================================
| #ifdef __KERNEL__
| 
| /* Should never be seen by user programs */
| #define ERESTARTSYS     512
| #define ERESTARTNOINTR  513
| #define ERESTARTNOHAND  514     /* restart if no handler.. */
| #define ENOIOCTLCMD     515     /* No ioctl command */
+=============================================================================

So which way is it _supposed_ to be (so someone can patch things up
to make it consistent):

1.  User space should never see ERESTARTSYS from any system call

2.  ERESTARTSYS can be seen from system call and is defined somewhere

In user space I have to define __KERNEL__ to get programs to compile
when coded to know about all possible (valid?) values of errno from
system calls.  As seen from strace:

+=============================================================================
| [pid  6453] accept(5, 0xbffff908, [16]) = ? ERESTARTSYS (To be restarted)
| [pid  6453] --- SIGALRM (Alarm clock) ---
| [pid  6453] getppid()                   = 6452
| [pid  6453] gettimeofday({1006439405, 5879}, NULL) = 0
| [pid  6453] setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={9, 994121}}, NULL) = 0
| [pid  6453] rt_sigreturn(0x5)           = -1 EINTR (Interrupted system call)
| [pid  6453] accept(5, 0xbffff908, [16]) = ? ERESTARTSYS (To be restarted)
| [pid  6453] --- SIGALRM (Alarm clock) ---
| [pid  6453] getppid()                   = 6452
| [pid  6453] gettimeofday({1006439415, 6422}, NULL) = 0
| [pid  6453] setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={9, 993578}}, NULL) = 0
| [pid  6453] rt_sigreturn(0x5)           = -1 EINTR (Interrupted system call)
| [pid  6453] accept(5, 0xbffff908, [16]) = ? ERESTARTSYS (To be restarted)
+=============================================================================

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
