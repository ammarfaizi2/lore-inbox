Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSGGOye>; Sun, 7 Jul 2002 10:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSGGOyd>; Sun, 7 Jul 2002 10:54:33 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:31246 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315971AbSGGOyc>;
	Sun, 7 Jul 2002 10:54:32 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-reply-to: Your message of "Fri, 05 Jul 2002 15:48:17 +0200."
             <20020705134816.GA112@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jul 2002 00:56:53 +1000
Message-ID: <9171.1026053813@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002 15:48:17 +0200, 
Pavel Machek <pavel@ucw.cz> wrote:
>Keith Owens wrote
>> Modules can run their own kernel threads.  When the module shuts down
>> it terminates the threads but we must wait until the process entries
>> for the threads have been reaped.  If you are not careful, the zombie
>> clean up code can refer to the module that no longer exists.  You must
>> not freeze any threads that belong to the module.
>
>Look at the code. freezer will try for 5 seconds, then give up. So, in
>rare case module has some threads, rmmod will simply fail. I believe
>we can fix rare remaining modules one by one.

There is no failure path for rmmod.  Once rmmod sees a use count of 0,
it must succeed.  Which is why both Rusty and I agree that rmmod must
be split in two, one piece that is allowed to fail and a second piece
that is not.

BTW, freeze_processes() silently ignores zombie processes.  The test is
not obvious, it is hidden in the INTERESTING macro which has an
embedded 'continue' to break out of the loop.  Easy to miss.

>> You must not freeze any process that has entered the module but not yet
>> incremented the use count, nor any process that has decremented the use
>> count but not yet left the module.  Simply looking at the EIP after
>
>Look how freezer works. refrigerator() is blocking, by definition. So
>if all processes reach refrigerator(), and the use count == 0, it is
>indeed safe to unload.

freeze_processes()
  signal_wake_up() - sets TIF_SIGPENDING for other task
    kick_if_running()
      resched_task() - calls preempt_disable() for this cpu
        smp_send_reschedule()
	  smp_reschedule_interrupt() - now on another cpu
	    ret_from_intr
	      resume_kernel - on other cpu

With CONFIG_PREEMPT, a process running on another cpu without a lock
when freeze_processes() is called should immediately end up in
schedule.  I don't see anything in that code path that disables
preemption on other cpus.  If I am right, then a second cpu could be in
this window when freeze_processes is called

  if (xxx->func)
    xxx->func()

where func is a module function.  There is still a window from loading
the function address, through calling the function and up to the point
where the function does MOD_INC_USE_COUNT.  Any reschedule in that
window opens a race with rmmod.  Without preemption, freeze might be
safe, with preemption the race is back again.

