Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUAHRnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUAHRli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:41:38 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:61390 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265784AbUAHRhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:37:53 -0500
Date: Thu, 8 Jan 2004 11:36:40 -0600
From: Robin Holt <holt@sgi.com>
To: sena <auntvini@sedal.usyd.edu.au>
Cc: Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uid- task_struct --The results of the code sent by you
Message-ID: <20040108173640.GA9110@lnx-holt>
References: <3FFC3EE4.3000809@sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFC3EE4.3000809@sedal.usyd.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Telnet and login are always going to be uid 0.  The telnet
process is handling socket IO and handling telnet escape
sequences.  When the telnet process is started, the user
isn't even known to the system.

telnet forks and execs login.  Login does the password
prompting and establishes a session.  The login process
needs to stay around to cleanup the session when the user
logs off.  Once the password is authenticated, login does
a fork and the child execs the users shell.  They child
is the first process which actually _SHOULD_ be not
root.

Everything is as you would expect.  Telnet will accumulate
nearly no cpu time.  login will accumulate none until
the user logs off.  These will not be significant in
process accounting or load average.  You should be able
to safely ignore them.

Now, back to the original question.  What are you trying
to accomplish?

Thanks,
Robin

On Thu, Jan 08, 2004 at 04:16:20AM +1100, sena wrote:
> Hi Robin,
> 
> (As previously I could not copy to linux-kernel I am sending it again)
> 
> Thanks for your time.
> 
> I have loaded the module sent with some changes and got some results.
> 
> I got 2 people to login remotely using telnet.
> 
> as herft and as herft1
> 
> herft runs a small executable called ./myprog.
> 
> The reseults I got is as follows in var/log/messages
> 
> Jan 8 03:46:23 sena kernel: Pid 1193 uid 0 euid 0
> Jan 8 03:46:23 sena kernel: Pid 1220 uid 0 euid 0
> Jan 8 03:46:23 sena kernel: Pid 1251 uid 0 euid 0--->this is telnet
> Jan 8 03:46:23 sena kernel: Pid 1252 uid 0 euid 0
> Jan 8 03:46:23 sena kernel: Pid 1253 uid 500 euid 500 --->this is bash
> Jan 8 03:46:23 sena kernel: Pid 1381 uid 500 euid 500--->This is exec
> Jan 8 03:46:23 sena kernel: Pid 1383 uid 0 euid 0---->telnet
> Jan 8 03:46:23 sena kernel: Pid 1384 uid 0 euid 0
> Jan 8 03:46:23 sena kernel: Pid 1385 uid 501 euid 501---->This is bash
> Jan 8 03:46:23 sena kernel: Pid 1417 uid 0 euid 0
> 
> 
> Then I ps -ale
> 
> The result is as follows
> UID PID
> 100 S 0 1251 638 0 69 0 - 426 do_sel ? 00:00:00 
> in.telnetd-----------This is telnet
> 100 S 0 1252 1251 0 69 0 - 599 wait4 ? 00:00:00 login
> 100 S 500 1253 1252 0 69 0 - 1009 wait4 pts/4 00:00:00-------- bash
> 000 S 500 1381 1253 0 69 0 - 309 nanosl pts/4 00:00:00----------- myprog
> 100 S 0 1383 638 0 69 0 - 426 do_sel ? 00:00:00 in.telnetd----------This 
> is telnet
> 100 S 0 1384 1383 0 69 0 - 599 wait4 ? 00:00:00 login
> 100 S 501 1385 1384 0 68 0 - 1009 read_c pts/5 00:00:00--------- bash
> 100 R 0 1795 1220 0 74 0 - 762 - pts/3 00:00:00 ps
> 
> 
> 
> I probably got the same thing as yours. This means task_struct uid has 
> got its owners uids in the processes started through telnet. but telnet 
> servers uid=0
> 
> This means either I will have to consider telnet thing as root (though 
> it is started by the user login)
> 
> or
> 
> What do you think Robin?
> 
> 
> THE CODE:
> // count_active_tasks.c -
> 
> #include <linux/sched.h>
> #include <linux/module.h> // Needed by all modules
> #include <linux/kernel.h> // Needed for KERN_ALERT
> #include <linux/init.h> // Needed for the macros
> 
> #define DRIVER_AUTHOR "Sena Seneviratne/Robin Holt"
> 
> 
> #define DRIVER_DESC "A sample Test driver"
> 
> #define _LOOSE_KERNEL_NAMES
> /* With some combinations of Linux and gcc, tty.h will not compile without
> _LOOSE_KERNEL_NAMES.
> */
> #include <linux/tty.h> /* console_print() interface */
> 
> static int
> count_active_tasks_init(void)
> {
> struct task_struct *p;
> 
> read_lock(&tasklist_lock);
> 
> for_each_task(p) {
> printk(KERN_EMERG "Pid %d uid %d euid %d\n",
> p->pid, p->uid, p->euid);
> 
> //console_print("Hellow");
> 
> }
> read_unlock(&tasklist_lock);
> return 0;
> }
> 
> static void count_active_tasks_exit(void)
> {
> printk(KERN_ALERT "Goodbye, world 2\n");
> }
> 
> module_init(count_active_tasks_init);
> module_exit(count_active_tasks_exit);
> 
> MODULE_LICENSE("GPL");
> 
> MODULE_AUTHOR(DRIVER_AUTHOR); // Robin/sena wrote this module
> MODULE_DESCRIPTION(DRIVER_DESC); // What does this module do?
> 
> MODULE_SUPPORTED_DEVICE("dummy testdevice");
> 
> Thanks
> Sena Seneviratne
> Computer Engineering Lab
> Sydney University
