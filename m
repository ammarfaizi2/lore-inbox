Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUHLOj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUHLOj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 10:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUHLOjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 10:39:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:36759 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268574AbUHLOjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 10:39:41 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Torin Ford" <code-monkey@qwest.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x Fork Problem?
Date: Thu, 12 Aug 2004 09:26:27 -0500
X-Mailer: KMail [version 1.2]
References: <006101c47fff$8feedac0$0200000a@torin>
In-Reply-To: <006101c47fff$8feedac0$0200000a@torin>
MIME-Version: 1.0
Message-Id: <04081209262700.19998@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 August 2004 19:01, Torin Ford wrote:
> All,
>    We've got an application (we'll call it AppB) based on apache and a
> proprietary module that we push to other Linux boxes.  The way we do this
> is first push a proprietary executable (we'll call it AppA) to the Linux
> box via rexec or some other mechanism.  We then send messages to AppA and
> tell it to pull AppB from some place.  AppA will pull AppB and run its
> installer, and then starts AppB via a shell script.  So process wise, we
> have a tree like this:
>
> init
>
>   |-AppA
>   |
>   |-AppB
>
> Once AppB is running, the apache module will periodically call fork and one
> of the execs to execute some other process.  AppB will execute code like
> this to fork the process:
>
> pid = fork();
> switch (pid)
> {
>    case -1:
>       blah; /* big trouble */
>       break;
>    case 0: /* Child */
>       blah;
>       blah;
>       exec(some command here)
>       blah; /* If we get here, we're in big trouble. */
>       break;
>    default: /* Parent */
>       pid2 = waitpid(pid, &status, 0);
>       if (pid2 == -1)
>       {
>          blah;  /* check out errno */
>       }
> }
>
> On 2.4.x, this code works great.  But now with 2.6.x (stock SuSE 9.1 and
> FC2 kernels, as well as home grown kernels), waitpid will always return -1,
> and errno will be 10 (ECHILD, No child processes).  We know for a fact that
> the fork and exec calls succeed due to debug print outs.  Here's the real
> kicker.  We only see this problem when we first push the software and start
> it.  If we push the software and start it, stop it and start it again, then
> allow it to try the fork/exec again, it succeeds.  We have the same problem
> if we bundle the entire application (AppA and AppB) into an installer and
> use that to install it on a machine.  The installer will start the
> application, and the fork/exec calls will fail with ECHILD.  If we then
> stop the App and start it again, everything is fine.
>
> I've widdled the code down to just do this:
>
> pid = fork();
> switch (pid)
> {
>    case -1:
>       blah; /* big trouble */
>       break;
>    case 0: /* Child */
>       exit(1);
>       break;
>    default: /* Parent */
>       pid2 = waitpid(pid, &status, 0);
>       if (pid2 == -1)
>       {
>          blah;  /* check out errno */
>       }
> }
>
> and I get the same results, so I now the exec has nothing to do with it.
>
> Anyone have any ideas on why this would happen?

Yup - the parent process executed waitpid before the child process finished 
the setup. This can happen in a multi-cpu environment or even a single, if
the scheduler puts the parent process higher than the child in the queue.

I seem to remember there was a change in the fork handling in 2.5 that allowed
this to happen. It does allow for faster server response since the parent 
(assumed to be a server) can spin on the socket requests and fork handler 
servers without a delay between the fork and re-examining the incoming 
request socket.

The way I've been doing the delay is a signal handler (SIGCHLD) to catch the
signal, then a "while( 0 < (pid = waitpid(-1,&stat, WNOHANG)))..." loop to
catch any/all children. The parent process ends up sleeping in a select until
the signal occurs (and the handler executes). Then resumes.

This way the parent process is waiting for ANY child to terminate, not just
the one specified, and it waits for a signal - which can't be generated until
the/a process fully exists and terminates.
