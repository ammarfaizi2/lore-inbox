Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPAuv>; Fri, 15 Dec 2000 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLPAuk>; Fri, 15 Dec 2000 19:50:40 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:36104 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129228AbQLPAu2>; Fri, 15 Dec 2000 19:50:28 -0500
Message-ID: <3A3AB515.26227812@mvista.com>
Date: Fri, 15 Dec 2000 16:19:33 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Wohlgemuth <jwohlgem@mindspring.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: lock_kernel() / unlock_kernel inconsistency Don't do this!
In-Reply-To: <3A3940DA.4050001@mindspring.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Wohlgemuth wrote:
> 
> In an effort to stay consistent with the community, I migrated some code
> to a driver to use the daemonize() routine in the function specified by
> the kernel_thread() call.
> 
> However, in looking at a few drivers in the system (drivers/usb/hub.c ,
> drivers/md/md.c, drivers/media/video/msp3400.c), I noticed some
> inconsistencies.  Specifically with the use of lock_kernel() /
> unlock_kernel().
> 
> drivers/md/md.c looks like:
> int md_thread(void * arg)
> {
>    md_lock_kernel();
> 
>    daemonize();
>    .
>    .
>    .
>    //md_unlock_kernel();
> }
> 
> this is similiar to drivers/usb/hub.c (which doesn't call unlock_kernel
> following lock_kernel)
> 
> however drivers/media/video/msp3400.c looks like:
> static int msp3400c_thread(void *data)
> {
>    .
>    .
>    .
> #ifdef CONFIG_SMP
>    lock_kernel();
> #endif
>    daemonize();
>    .
>    .
>    .
> #ifdef CONFIG_SMP
>    unlock_kernel();
> #endif
> }
> 
> The latter example seems logically correct to me.  Does this imply that
> after the CPU that is responsible for starting the thread in md.c or
> hub.c claims the global lock it will never be released to any other CPU?
> 
> If I am incorrect here please just point out my error, however, I
> figured I would bring this to the mailing list's attention if in fact
> this is truely in error.

Both of these methods have problems, especially with the proposed
preemptions changes.  The first case causes the thread to run with the
BKL for the whole time.  This means that any other task that wants the
BKL will be blocked.  Surly the needed protections don't require this. 
These locks should be replaced with fine grain locking and once taken,
they should be released ASAP.

The second practice will not provide the needed protection in a
preemptable UP system.  The BKL on a UP is just a NOP anyway.  On the
other hand we want to use these lock points to disable preemption. 
Letting the defining code for the lock decide the SMP/UP issue allows
the preemption code to do the right thing.  This said, still, the BKL
should go away, see above.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
