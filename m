Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLNWWQ>; Thu, 14 Dec 2000 17:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLNWWH>; Thu, 14 Dec 2000 17:22:07 -0500
Received: from gso88-218-036.triad.rr.com ([24.88.218.36]:33036 "HELO
	smtp.mindspring.com") by vger.kernel.org with SMTP
	id <S129773AbQLNWVw>; Thu, 14 Dec 2000 17:21:52 -0500
Message-ID: <3A3940DA.4050001@mindspring.com>
Date: Thu, 14 Dec 2000 16:51:22 -0500
From: Jason Wohlgemuth <jwohlgem@mindspring.com>
Organization: SELF
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test11 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lock_kernel() / unlock_kernel inconsistency
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to stay consistent with the community, I migrated some code 
to a driver to use the daemonize() routine in the function specified by 
the kernel_thread() call.

However, in looking at a few drivers in the system (drivers/usb/hub.c , 
drivers/md/md.c, drivers/media/video/msp3400.c), I noticed some 
inconsistencies.  Specifically with the use of lock_kernel() / 
unlock_kernel().

drivers/md/md.c looks like:
int md_thread(void * arg)
{
   md_lock_kernel();

   daemonize();
   .
   .
   .
   //md_unlock_kernel();
}

this is similiar to drivers/usb/hub.c (which doesn't call unlock_kernel 
following lock_kernel)

however drivers/media/video/msp3400.c looks like:
static int msp3400c_thread(void *data)
{
   .
   .
   .
#ifdef CONFIG_SMP
   lock_kernel();
#endif
   daemonize();
   .
   .
   .
#ifdef CONFIG_SMP
   unlock_kernel();
#endif
}

The latter example seems logically correct to me.  Does this imply that 
after the CPU that is responsible for starting the thread in md.c or 
hub.c claims the global lock it will never be released to any other CPU?

If I am incorrect here please just point out my error, however, I 
figured I would bring this to the mailing list's attention if in fact 
this is truely in error.

Thanks,
Jason

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
