Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbUBAFMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 00:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUBAFMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 00:12:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:57762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265217AbUBAFMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 00:12:35 -0500
Date: Sat, 31 Jan 2004 21:12:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: <20040201044331.GA27271@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0401312107440.2033@home.osdl.org>
References: <20040201032525.GA10254@nevyn.them.org>
 <Pine.LNX.4.58.0401312014420.2033@home.osdl.org> <20040201044331.GA27271@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 31 Jan 2004, Daniel Jacobowitz wrote:
> > 
> > Can you verify that that process doesn't have any sub-threads? (Again, 
> > that should be easily visible in /proc/<pid>/task/).
> 
> It is quite easily visible - in fact, it's hilarious.
> 
>  8454 pts/8    Z      0:00 [linux-dp] <defunct>
> 
> drow@nevyn:~% ls /proc/8454
> auxv  cmdline  cwd@  environ  exe@  fd/  maps  mem  mounts  root@  stat
> 
> drow@nevyn:~% ls /proc/8454/task
> ls: /proc/8454/task: No such file or directory

Oh damn. Yeah, we don't allow you to even see the threads in this case (it
checks "pid_alive(task)". We don't want you to try to confuse things by 
opening files of processes that we think are dead.

For the case of trying to figure out sub-threads of a dead thread group
leader, that may actually be a bug.

Just for testing this, you might remove the check for

        if (!pid_alive(task))
                goto out;

in proc_pident_lookup() in fs/proc/base.c.

Ingo - comments? We really want the sysadmin to be able to find threads 
that have a dead group leader, and right now that seems to be impossible.

		Linus
