Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUAGUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUAGUP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:15:56 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:61161 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S266219AbUAGUPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:15:53 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Wed, 7 Jan 2004 12:15:35 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Entry points for execution
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040107201535.13922393A@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to make a slight alteration to every task_struct for every task.  I've put my code into do_fork() but it seems that init (pid 1) has a parent process, as I checked for if (p->parent) and it evidently connected to. . . something.

#ifdef CONFIG_LINUX_JAIL
                /*
                 * If we have no parent (parent == 0, i.e. init), then NULL our
                 * jail.  Else, connect to the jail of the parent.
                 */
                 p->pjail = NULL;
                 if (p->parent)
                        linux_jail_attatch(p->parent->pjail, p);
#endif

The thing is, it denies me chroot when I try to choot with restricted chroot (no chroot in chroot).  Now, the code I have all looks correct, so I'm thinking, it has to be that init is the child of pid 0, and that pid 0 is started in some other way, and thus I'm not clipping the tsk->pjail.

My new code is:

#ifdef CONFIG_LINUX_JAIL
                /*
                 * If we have no parent (parent == 0, i.e. init), then NULL our
                 * jail.  Else, connect to the jail of the parent.
                 */
                 p->pjail = NULL;
                 if (p->pid != 1 && p->parent)
                        linux_jail_attatch(p->parent->pjail, p);
#endif

I'm thinking, the idle task maybe?  Or does that "not exist" physically?  If init has a parent then I'd PREFER to set that parent's pjail to NULL, not because it's magic and might blow up, but because I want things done *cleanly*, and even if the pointer will *NEVER* be examined, having a pointer pointing to something that doesn't belong to the struct is NOT my style.

Can anyone give me all of the lowest level entry points for tasks (i.e. all the places where I can modify a task_struct->* before the task begins execution at its earliest point in creation)?

--Bluefox

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
