Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbRDJEoW>; Tue, 10 Apr 2001 00:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132918AbRDJEoM>; Tue, 10 Apr 2001 00:44:12 -0400
Received: from ike-ext.ab.videon.ca ([206.75.216.35]:29093 "HELO
	ike-ext.ab.videon.ca") by vger.kernel.org with SMTP
	id <S132914AbRDJEoE>; Tue, 10 Apr 2001 00:44:04 -0400
Date: Mon, 9 Apr 2001 22:44:02 -0600 (MDT)
From: Jason Gunthorpe <jgg@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Lost O_NONBLOCK (Bug?) 
Message-ID: <Pine.LNX.3.96.1010409223803.3856M-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've run into the following weird behavior on my system with 2.4.0. I have
the following code:

if (fork() == 0)
{
    int Flags,dummy;
    if ((Flags = fcntl(STDIN_FILENO,F_GETFL,dummy)) < 0)
        _exit(100);
    if (fcntl(STDIN_FILENO,F_SETFL,Flags | O_NONBLOCK) < 0)
         _exit(100);
    while (read(STDIN_FILENO,&dummy,1) == 1);
    if (fcntl(STDIN_FILENO,F_SETFL,Flags & (~(long)O_NONBLOCK)) < 0)
         _exit(100);
 
    // exec something
}

Which works fine, unless the parent process was backgrounded by the shell
(^Z then bg).  If that is the case then the O_NONBLOCK seems to be lost. I
straced this: 

fcntl(0, F_GETFL)                       = 0x2 (flags O_RDWR)
fcntl(0, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
read(0, 0xbfffea38, 1)                  = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) ---
--- SIGTTIN (Stopped (tty input)) ---
read(0, 0xbfffea38, 1)                  = ? ERESTARTSYS (To be restarted)
--- SIGTTIN (Stopped (tty input)) ---
--- SIGTTIN (Stopped (tty input)) ---
[.. etc, again and again in a tight loop ..]
--- SIGTTIN (Stopped (tty input)) ---
--- SIGTTIN (Stopped (tty input)) ---
read(0,

The last read was after the process was forgrounded. The read waits
forever, the non-block flag seems to have gone missing. It is also a
little odd I think that it repeated to get SIGTTIN which was never
actually delivered to the program.. Shouldn't SIGTTIN suspend the process?

The signal mask from /proc/xx/status (the child) looks like:

SigPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 8000000000000000
SigCgt: 0000000000000000

Is this the expected behavior of the kernel?

Thanks,
Jason
Please CC me, I'm not on l-k today.


