Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268441AbUHLA2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268441AbUHLA2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUHLA2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:28:03 -0400
Received: from mpls-qmqp-04.inet.qwest.net ([63.231.195.115]:39684 "HELO
	mpls-qmqp-04.inet.qwest.net") by vger.kernel.org with SMTP
	id S268442AbUHLABp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:01:45 -0400
Date: Wed, 11 Aug 2004 18:01:47 -0600
Message-ID: <006101c47fff$8feedac0$0200000a@torin>
From: "Torin Ford" <code-monkey@qwest.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.x Fork Problem?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
   We've got an application (we'll call it AppB) based on apache and a
proprietary module that we push to other Linux boxes.  The way we do this is
first push a proprietary executable (we'll call it AppA) to the Linux box
via rexec or some other mechanism.  We then send messages to AppA and tell
it to pull AppB from some place.  AppA will pull AppB and run its installer,
and then starts AppB via a shell script.  So process wise, we have a tree
like this:

init
  |
  |-AppA
  |
  |-AppB

Once AppB is running, the apache module will periodically call fork and one
of the execs to execute some other process.  AppB will execute code like
this to fork the process:

pid = fork();
switch (pid)
{
   case -1:
      blah; /* big trouble */
      break;
   case 0: /* Child */
      blah;
      blah;
      exec(some command here)
      blah; /* If we get here, we're in big trouble. */
      break;
   default: /* Parent */
      pid2 = waitpid(pid, &status, 0);
      if (pid2 == -1)
      {
         blah;  /* check out errno */
      }
}

On 2.4.x, this code works great.  But now with 2.6.x (stock SuSE 9.1 and FC2
kernels, as well as home grown kernels), waitpid will always return -1, and
errno will be 10 (ECHILD, No child processes).  We know for a fact that the
fork and exec calls succeed due to debug print outs.  Here's the real
kicker.  We only see this problem when we first push the software and start
it.  If we push the software and start it, stop it and start it again, then
allow it to try the fork/exec again, it succeeds.  We have the same problem
if we bundle the entire application (AppA and AppB) into an installer and
use that to install it on a machine.  The installer will start the
application, and the fork/exec calls will fail with ECHILD.  If we then stop
the App and start it again, everything is fine.

I've widdled the code down to just do this:

pid = fork();
switch (pid)
{
   case -1:
      blah; /* big trouble */
      break;
   case 0: /* Child */
      exit(1);
      break;
   default: /* Parent */
      pid2 = waitpid(pid, &status, 0);
      if (pid2 == -1)
      {
         blah;  /* check out errno */
      }
}

and I get the same results, so I now the exec has nothing to do with it.

Anyone have any ideas on why this would happen?

Thanks,

Torin Ford
Venturi Technology Partners


