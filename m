Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbREPPzl>; Wed, 16 May 2001 11:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbREPPzb>; Wed, 16 May 2001 11:55:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18307 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261987AbREPPzU>; Wed, 16 May 2001 11:55:20 -0400
Date: Wed, 16 May 2001 11:55:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Possible race in interruptible_sleep_on_timeout()
Message-ID: <Pine.LNX.3.95.1010516114809.32248A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I lifted the following kernel-thread code from
../linux/drivers/net/8139too.c, just added a procedure to call.

static int gpib_thread(void *unused)
{
    unsigned long timeout;

    daemonize();
    spin_lock_irq(&current->sigmask_lock);
    sigemptyset(&current->blocked);
    recalc_sigpending(current);
    spin_unlock_irq(&current->sigmask_lock);
    memcpy(current->comm, task_name, sizeof(task_name));
    for(;;)
    { 
        timeout = 0x02;
        do {
           timeout = interruptible_sleep_on_timeout(&info->twait, timeout);
           } while (!signal_pending(current)&&(timeout > 0)); 
        if(signal_pending(current))
            up_and_exit(&info->quit, 0);
        tinker(info->what_to_do);
    } 
}

It has been observed that, given the conditions of little or no
CPU activity except `top`,  procedure "tinker()" will never get
executed because interruptible_sleep_on_timeout returns the
same timeout value it received. 

This is on kernel version 2.4.1. Maybe this race has been found and
fixed?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


