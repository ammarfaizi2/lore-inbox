Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310787AbSCHKHE>; Fri, 8 Mar 2002 05:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310791AbSCHKGz>; Fri, 8 Mar 2002 05:06:55 -0500
Received: from adsl-209-233-33-110.dsl.snfc21.pacbell.net ([209.233.33.110]:9464
	"EHLO lorien.emufarm.org") by vger.kernel.org with ESMTP
	id <S310787AbSCHKGk>; Fri, 8 Mar 2002 05:06:40 -0500
Date: Fri, 8 Mar 2002 02:06:32 -0800
From: Danek Duvall <duvall@emufarm.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020308100632.GA192@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16iyBW-0002HP-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 01:43:54PM +0000, Alan Cox wrote:

> > I just upgraded from 2.4.8-pre3-ac2 to 2.4.19-pre2-ac2, and found that
> > for threaded programs like mozilla and xmms, files in /proc/<pid> are
> > owned by root, even if the process belongs to another user.  I
> > particularly wanted to be able to read /proc/<pid>/environ, but I can't.
> >
> > [ ... ]
> 
> Thanks - that will really help. There are several sets of thread related
> changes in -ac. Its all working for me however 8)

Ok, I found the responsible hunk, though I haven't any idea why it would
make a difference:

	diff -durp linux-2.4.18-pre7-ac2/kernel/kmod.c linux-2.4.18-pre7-ac3/kernel/kmod.c
	--- linux-2.4.18-pre7-ac2/kernel/kmod.c Tue Jul 17 18:23:50 2001
	+++ linux-2.4.18-pre7-ac3/kernel/kmod.c Thu Mar  7 23:05:34 2002
	@@ -111,15 +111,8 @@ int exec_usermodehelper(char *program_pa
			if (curtask->files->fd[i]) close(i);
		}

	-       /* Drop the "current user" thing */
	-       {
	-               struct user_struct *user = curtask->user;
	-               curtask->user = INIT_USER;
	-               atomic_inc(&INIT_USER->__count);
	-               atomic_inc(&INIT_USER->processes);
	-               atomic_dec(&user->processes);
	-               free_uid(user);
	-       }
	+       /* Become root */
	+       set_user(0, 1);

		/* Give kmod all effective privileges.. */
		curtask->euid = curtask->fsuid = 0;

This hunk shows up for the first time in 2.4.18-pre7-ac3, which shows
the behavior, while prior versions do not.  If I revert this hunk from
ac3, I get the behavior I expect.  It also fixes my problem when I
revert this from 2.4.19-pre2-ac2, which is where I first saw the
problems.

I don't see why mozilla would even touch this path of execution, so I
don't know why it would make a difference there, but it makes some sense
in the case of xmms, as my sound support is in modules.  But it shows up
both places.

I also checked to see if the CLONE_THREAD change in kernel/fork.c in the
same patch had any effect, because that looked more relevant to
threading, but it didn't.

So now I guess I get to help you reproduce it on your end.  Let me know
what you need from me.

Thanks,
Danek
