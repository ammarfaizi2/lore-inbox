Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUCUWFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUCUWFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:05:39 -0500
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:21377 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261355AbUCUWF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:05:27 -0500
Date: Sun, 21 Mar 2004 22:47:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jakob Lell <jlell@JakobLell.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3 doesn't suspend when mysqld is running.
Message-ID: <20040321214700.GB14493@elf.ucw.cz>
References: <200402271049.14014.jlell@JakobLell.de> <200402282143.36048.jlell@JakobLell.de> <20040228204658.GB10530@elf.ucw.cz> <200403141727.03632.jlell@JakobLell.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403141727.03632.jlell@JakobLell.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > even if it might be a problem in mysql, it should not be possible for an
> > > unprivileged process to make the system unable to suspend. Maybe the
> > > kernel should send SIGSTOP to those processes which can't be stopped
> > > otherwise.
> >
> > No, its definitely not problem in mysql.
> >
> > But knowing "where it sleeps in kernel" maybe would make me understand
> > what is going on. And I'm not going to install mysql just to find out.
> 
> Hi,
> now I've examined the code of mysql and it seems to be a problem with signal 
> handling. When a process is calling sigprocmask while suspending, the kernel 
> can't stop it. If you run the code below, the system won't be able to 
> suspend. After the kernel prints an error message that it can't stop the 
> program, it's impossible to terminate it by any signal (even SIGKILL). The 
> only way I've found to terminate the process is to send SIGKILL to it and 
> then suspend the system. After resuming, the process will finally be
> > > killed. 

Can you try this one? (Thanks to Nigel.).

									Pavel

--- tmp/linux/arch/i386/kernel/signal.c	2004-03-11 18:10:38.000000000 +0100
+++ linux/arch/i386/kernel/signal.c	2004-03-21 22:19:23.000000000 +0100
@@ -567,7 +567,8 @@
 
 	if (current->flags & PF_FREEZE) {
 		refrigerator(0);
-		goto no_signal;
+		if (!signal_pending(current))
+			goto no_signal;
 	}
 
 	if (!oldset)

> 
> #include <signal.h>
> #include <errno.h>
> #include <stdlib.h>
> 
> int main(int argc,char ** argv){
>   sigset_t set;
>   int sig;
>   sigemptyset(&set);
>   sigprocmask(SIG_BLOCK,&set,NULL);
>   while(sigwait(&set,&sig)==EINTR);
>   return 0;
> }

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
