Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132722AbRDILc1>; Mon, 9 Apr 2001 07:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132725AbRDILcR>; Mon, 9 Apr 2001 07:32:17 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:40835 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S132722AbRDILb7>;
	Mon, 9 Apr 2001 07:31:59 -0400
Message-Id: <5.0.2.1.2.20010409115354.00a311a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 09 Apr 2001 12:32:02 +0100
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Q: process concurrency and sigaction()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I use sigaction() to install a handler for SIGALRM, which is triggered 
periodically by a timer created using setitimer(ITIMER_REAL). The handler 
modifies the same data that my program (that registered the signal handler) 
modifies. So I need to lock one against the other. (The program has not 
executed clone(), nor is it using any threading libraries.)

My questions are:

1. On SMP, is it guaranteed that only one (handler vs. normal program code) 
executes at the same time? (Or is it possible, for example, that signal 
handler runs on CPU1 while the normal program code is executing on CPU2?)

2. Is it guaranteed that execution of the normal program code is only 
resumed when the handler "return"s? (Or is it possible, for example, that 
while the handler is running, a reschedule occurs in such a way as that 
normal program code is executed before a subsequent reschedule continues 
with the handler code?)

I am asking so I know how simple/complex the locking between the two has to 
be... - I suspect that it is guaranteed that only one executes at any one 
time on the system and that the normal code can never be executing while a 
signal handler is executing.

If this is correct, the program (non-handler) code can assume for sure that 
it will never encounter any of the locks held as the handler will have 
finished and unlocked them before execution is returned.

This would mean 1) I can grab locks in normal program code knowing that 
they will succeed immediately and 2) the signal handler doesn't need to do 
any locking at all. Just need to check if lock is held and if it is return 
immediately as it is impossible that the lock is unlocked while we are in 
the handler or that any code executes which would necessitate the lock to 
be held. - This would mean I can use a simple spinlock and use spin_lock() 
and spin_unlock() in the normal code and just a spin_is_locked() test in 
the handler. Anyone can see anything wrong with this? (Apart from the usual 
flames about using kernel headers as part of a program... Using kernel 
headers/code has a big advantage IMO, in that it gives you efficient, while 
at the same time multi arch code, but lets not get into this flame war now).

Thanks in advance.

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

