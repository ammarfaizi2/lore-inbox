Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUG3ABq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUG3ABq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUG3ABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:01:46 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:57069 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S267541AbUG2X5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:57:05 -0400
Date: Fri, 30 Jul 2004 01:56:54 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-ID: <20040729235654.GA19664@k3.hellgate.ch>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200407222204.46799.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407222204.46799.rob@landley.net>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2004 22:04:46 -0500, Rob Landley wrote:
> I just saw a funky thing.  Here's the cut and past from the xterm...
> 
> [root@(none) root]# ps ax | grep hack
>  9964 pts/1    R      0:00 grep hack HOSTNAME= SHELL=/bin/bash TERM=xterm HISTSIZE=1000 USER=root LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=
> [root@(none) root]# ps ax | grep hack
>  9966 pts/1    S      0:00 grep hack
> 
> Seems like some kind of race condition, dunno if it's in Fedore Core 1's ps
> or the 2.6.7 kernel or what...

If somebody posted a solution for this, I didn't see it. There's a race in
the kernel, and considering the permissions on /proc/PID/{cmdline,environ}
a security bug as well: If you win the race with a starting process, you
can read its environment.

This should plug the hole. Can you give it a spin?

Roger

--- linux-2.6.8-rc2-bk1/fs/proc/base.c.orig	2004-07-30 01:43:23.535967505 +0200
+++ linux-2.6.8-rc2-bk1/fs/proc/base.c	2004-07-30 01:43:27.428303752 +0200
@@ -329,6 +329,8 @@ static int proc_pid_cmdline(struct task_
 	struct mm_struct *mm = get_task_mm(task);
 	if (!mm)
 		goto out;
+	if (!mm->arg_end)
+		goto out;	/* Shh! No looking before we're done */
 
  	len = mm->arg_end - mm->arg_start;
  
