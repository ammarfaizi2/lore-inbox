Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311006AbSCHTAJ>; Fri, 8 Mar 2002 14:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311007AbSCHS77>; Fri, 8 Mar 2002 13:59:59 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:18957 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S311006AbSCHS7l>; Fri, 8 Mar 2002 13:59:41 -0500
Date: Fri, 8 Mar 2002 19:59:39 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Danek Duvall <duvall@emufarm.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020308195939.A6295@devcon.net>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020308100632.GA192@lorien.emufarm.org>; from duvall@emufarm.org on Fri, Mar 08, 2002 at 02:06:32AM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 02:06:32AM -0800, Danek Duvall wrote:
> 
> > > I just upgraded from 2.4.8-pre3-ac2 to 2.4.19-pre2-ac2, and found that
> > > for threaded programs like mozilla and xmms, files in /proc/<pid> are
> > > owned by root, even if the process belongs to another user.  I
> > > particularly wanted to be able to read /proc/<pid>/environ, but I can't.
> Ok, I found the responsible hunk, though I haven't any idea why it would
> make a difference:
> 
> 	diff -durp linux-2.4.18-pre7-ac2/kernel/kmod.c linux-2.4.18-pre7-ac3/kernel/kmod.c
> 	--- linux-2.4.18-pre7-ac2/kernel/kmod.c Tue Jul 17 18:23:50 2001
> 	+++ linux-2.4.18-pre7-ac3/kernel/kmod.c Thu Mar  7 23:05:34 2002
> 	@@ -111,15 +111,8 @@ int exec_usermodehelper(char *program_pa
> 			if (curtask->files->fd[i]) close(i);
> 		}
> 
> 	-       /* Drop the "current user" thing */
> 	-       {
> 	-               struct user_struct *user = curtask->user;
> 	-               curtask->user = INIT_USER;
> 	-               atomic_inc(&INIT_USER->__count);
> 	-               atomic_inc(&INIT_USER->processes);
> 	-               atomic_dec(&user->processes);
> 	-               free_uid(user);
> 	-       }
> 	+       /* Become root */
> 	+       set_user(0, 1);
> 
> 		/* Give kmod all effective privileges.. */
> 		curtask->euid = curtask->fsuid = 0;

The problem arises when a threaded process calls request_module().
request_module() calls kernel_thread(), which does a clone(CLONE_VM).
The created kernel thread in turn executes exec_usermodehelper, this
calls set_user() with dumpclear=1, which leads to set_user() marking
the current task as not dumpable.

The problem is, that current->mm of the kernel thread is shared (from
the clone(CLONE_VM)) with the task doing the request_module() (and in
turn with all other threads of the process). As the dumpable flag
happens to be a property of the tasks mm, set_user also marks the
process (and all threads) as not dumpable.

Then see the following piece of code in proc_pid_make_inode()
(fs/proc/base.c):

        inode->i_uid = 0;
        inode->i_gid = 0;
        if (ino == PROC_PID_INO || task_dumpable(task)) {
                inode->i_uid = task->euid;
                inode->i_gid = task->egid;
        }

set_user() just marked the tasks mm as not dumpable, so the files in
/proc/<pid> (where ino != PROC_PID_INO) get UID 0.

BTW, the problem should also occur with _every_ process running into a
request_module().

Danek, can you please try changing the second argument to set_user()
into 0, ie.

        /* Become root */
        set_user(0, 0);

Apart from not setting current as not dumpable (which wasn't done by
the old code anyway), this should not change anything.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
