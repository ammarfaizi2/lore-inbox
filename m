Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130989AbQKWXSq>; Thu, 23 Nov 2000 18:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130987AbQKWXSi>; Thu, 23 Nov 2000 18:18:38 -0500
Received: from [194.213.32.137] ([194.213.32.137]:14340 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S129698AbQKWXST>;
        Thu, 23 Nov 2000 18:18:19 -0500
Message-ID: <20001123232333.A6426@bug.ucw.cz>
Date: Thu, 23 Nov 2000 23:23:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: kernel_thread bogosity
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You see? Kernel_thread does not check is sys_clone() worked! Aha,
caller is responsible for that, but init/main.c does not seem too
carefull. Maybe kernel_thread should at least print a warning?

Plus, can someone explain me why it does not need to setup %%ecx with
either zero or address of stack?
								Pavel

int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
{
        long retval, d0;

        __asm__ __volatile__(
                "movl %%esp,%%esi\n\t"
                "int $0x80\n\t"         /* Linux/i386 system call */
                "cmpl %%esp,%%esi\n\t"  /* child or parent? */
                "je 1f\n\t"             /* parent - jump */
                /* Load the argument into eax, and push it.  That way,
it does
                 * not matter whether the called function is compiled
with
                 * -mregparm or not.  */
                "movl %4,%%eax\n\t"
                "pushl %%eax\n\t"
                "call *%5\n\t"          /* call fn */
                "movl %3,%0\n\t"        /* exit */
                "int $0x80\n"
                "1:\t"
                :"=&a" (retval), "=&S" (d0)
                :"0" (__NR_clone), "i" (__NR_exit),
                 "r" (arg), "r" (fn),
                 "b" (flags | CLONE_VM)
                : "memory");
        return retval;
}

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
