Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVAYUQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVAYUQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVAYUQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:16:18 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.24]:7019 "EHLO
	lilzmailso02.liwest.at") by vger.kernel.org with ESMTP
	id S262103AbVAYUQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:16:08 -0500
Message-ID: <41F6A90B.4020005@liwest.at>
Date: Tue, 25 Jan 2005 21:16:11 +0100
From: Robert Szeleney <skyos@liwest.at>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Register saving and signal handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is my first time posting to the Linux kernel mailing-list, and I 
hope someone can help me or at least explain following to me.

When a task gets interrupted by a signal, the do_signal() function is 
called. Now, when the signal is not handled by the task and the 
interrupted function returned -EINTR, the syscall gets restarted by 
modifying the user mode EIP to point to the int 0x80 again.

When the task leaves the do_signal function, it will pop the saved 
registers and return to the user mode and immediately do the syscall again.

But now to the actual question:

Let's make a new "test" system call function. Let's call it: sys_test

asmlinkage int sys_test(int para1, int para2)
{
    para1++;
    para2++;

    kill( current->pid, SIGCHLD);
    return -EINTR;
}

When compiling this function, GCC increments para1 and para2 by one. 
para1 and para2 are stored on the kernel stack. The system call entry 
assembler function pushed the registers containing this values from the 
usermode on the stack.
But GCC actually modified the values on the stack here, the "live" data. 
(which will be poped later again, right before returning to user mode)

After returning from this function, the system call wrapper checks for a 
signal and calls do_signal. The do_signal call will restart the system 
call by modifying the user mode EIP. Then, the system call wrapper will 
pop the saved registers from the stack. But here I see this problem. The 
already modified values for para1 and para2 will be popped. When the 
system call is then start again, para1 and para2 don't have to original 
value.

One can say, why are you modifying para1 and para2 then?  Yes, this is 
correct, but after compiling a few more test sources, I got following 
problem:

asmlinkage int sys_test(int iSize)
{
     printk("Size is: %d\n", iSize * sizeof(any_structure));
}

When compiling this, GCC produces following assembler:

....
sall    $4, 8(%ebp)
....

which actually modifies the content of the stack holding the iSize 
again. It is very difficult to keep track of such implicit stack 
argument modifications.
Thus, when a signal is waiting and the syscall is restarted, iSize 
contains a different value already.

So, does anyone else have such a problem? Is there any compiler flag 
missing? Is this possible at all?

Thank you very much!
Robert!

Btw,  please CC to mf204005@liwest.at  too.






