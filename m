Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRD1HdK>; Sat, 28 Apr 2001 03:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRD1Hc7>; Sat, 28 Apr 2001 03:32:59 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:32253 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131459AbRD1Hcq>; Sat, 28 Apr 2001 03:32:46 -0400
Message-Id: <5.0.2.1.2.20010428092215.00a68b30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sat, 28 Apr 2001 09:32:36 +0100
To: Steffen Persvold <sp@scali.no>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Question regarding kernel threads and userlevel
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3AEA11F5.3D54828@scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:42 28/04/2001, Steffen Persvold wrote:
>I have a question regarding kernel threads : Are kernel threads treated 
>equally in terms of scheduling as normal userlevel processes ??

I'm sure someone will correct me if I am wrong but I would think that 
kernel threads are treated the same as the kernel, i.e. they are not 
pre-emptied unless you call schedule yourself or you sleep.

>kernel thread gets scheduled and tries to get the same lock it will 
>deadlock because the userlevel process never gets back control and 
>releases the lock.

It never gets pre-emptied according to the above so it would spin for ever. 
You would need a SMP system which would be running the user space code on a 
second CPU to unlock again. (And if your kernel thread is holding any other 
locks which the user mode thread will take along it's kernel code path you 
will deadlock, too.)

If my suggestion above is correct then you can fix this by doing:

while (!spin_trylock())
         schedule();

Which will forcefully schedule to allow your processes to run and you know 
that as soon as you drop out of the loop you are holding the lock. If you 
want you could also add in a counter a display a warning or something if 
you don't manage to acquire a lock after several tries, perhaps just for 
debugging purposes.

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

