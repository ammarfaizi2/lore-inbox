Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUAMPUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 10:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUAMPUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 10:20:30 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:63420 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S263823AbUAMPU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 10:20:27 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Tue, 13 Jan 2004 07:20:26 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: initializing a task
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040113152026.34ADA3966@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having severe severe issues with my jail.  Inside do_fork() I have code for
forking with jails:

#ifdef CONFIG_LINUX_JAIL
                /*
                 * I want a NULL jail if there's no parent.
                 *
                 * Also, init seems to just get a jail for no apparent reason,
                 * and its parent seems to be 1.  init itself should never be
                 * jailed, so for a quick fix, anything having parent as 1 gets
                 * away without a jail.  PLEASE FIX THIS BAD HACK ASAP.
                 */
                p->pjail = NULL; /*has to be null or else we'll try to free up
                        the jail*/
                if (p->parent && p->parent->pid == 1 && p->parent->pjail) {
                        printk("pid: %l   parent pid: %l  parent jail: %08lx\n",p->pid,p->parent->pid,p->parent->pjail);
                        panic("Holy shit.  How did the init process get jailed?\n");
                }
                if (p->parent && p->parent->pid > 1)
                        linux_jail_attatch(p->parent->pjail, p);
#endif


Now, without the if() { panic(); } condition, init forks with a strange jail that
it magically gets from somewhere.  The STRANGE part is that it gets to printing
out "init 2.87 booting", but then dies on the next fork.

It seems that this random, uninitialized jail has FL_JAIL_MKNOD set (unitit'd data
is weird :/) and so init can't create /dev/inittab (so, I can't shut down).

I've tried a lot of bad hacks, from going into sched.c and setting current->pjail =
NULL before wake_up_forked_process(current) in sched_init, and just setting
current->pjail = null at the top of start_kernel() in init/main.c, but I can't
figure this out.  In theory, the following should replace the above block of code
from do_fork():

                p->pjail = NULL; /*has to be null or else we'll try to free up
                        the jail*/
                linux_jail_attatch(p->parent->pjail, p);

And work properly.  So, where's this magical task get created, and where can I
change it?  Any ideas?

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
