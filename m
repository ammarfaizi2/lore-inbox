Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTDYO2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbTDYO2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:28:24 -0400
Received: from d101.x-mailer.de ([212.162.12.2]:23475 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id S263172AbTDYO2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:28:18 -0400
From: Andreas Gietl <Listen@e-admin.de>
Organization: e-admin internet gmbh
To: Bernhard Kaindl <kaindl@telering.at>
Subject: Re: [PATCH][2.4-rc1] fix side effects of the kmod/ptrace secfix
Date: Fri, 25 Apr 2003 16:40:22 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304250037.45133.Listen@e-admin.de> <Pine.LNX.4.53.0304251215200.2582@hase.a11.local>
In-Reply-To: <Pine.LNX.4.53.0304251215200.2582@hase.a11.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304251640.22021.Listen@e-admin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 April 2003 12:40, Bernhard Kaindl wrote:
> On Fri, 25 Apr 2003, Andreas Gietl wrote:
> > > system monitoring stuff this way(I've even heard shutdown is affected)
> >
> > i can confirm that shutdown (halt|reboot) does not work on my
> > 2.4.21-rc1-ac1 boxes. (gentoo + redhat).
>
> Thanks for the info!
>
> > But your patch does not seem to fix it.
>
> Very interesting also, the two liner adressed only the well-known problems.
> To fix the other not so well-known side effects, a real cleanup is the way
> to go.
>
> Can you try the attached cleanup patch instead of the two-liner?
>
> It's an inital cleanup and should fix the other side effects which
> I described in my mails.
>
> Bernhard Kaindl
>
> PS: If either patch is applied correctly, this
>
> 	su guest -c 'ps $PPID;wc -m </proc/$PPID/cmdline'
>
> should give:
>
>   PID TTY      STAT   TIME COMMAND
>  2452 pts/2    S      0:00 su bin -c ps $PPID;wc -m </proc/$PPID/cmdline
>      46

it shows:
  PID TTY      STAT   TIME COMMAND
 2092 ttyp0    S      0:00 su guest -c ps $PPID;wc -m </proc/$PPID/cmdline
      0

but cat shows:
su guest -c 'ps $PPID; cat /proc/$PPID/cmdline'
  PID TTY      STAT   TIME COMMAND
 2144 ttyp0    S      0:00 su guest -c ps $PPID; cat /proc/$PPID/cmdline
suguest-cps $PPID; cat /proc/$PPID/cmdline

what happened?

>
> If it does not, access_process_vm is not fixed properly.
>
> Second, calling this as root:
>
> 	strace -fewrite su -c /bin/echo 2>&1 | grep pid
>
> should give:
>
> [pid  2599] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
> [pid  2599] write(1, "\n", 1

it shows:
localhost root # strace -fewrite su -c /bin/echo 2>&1 | grep pid
[pid  2159] write(1, "\n", 1

>
> If it does not, ptrace_check_attach is not fixed properly.
>
> (These are only the checks for the well known side
> effects which should be fixed even with the short
> is_dumpable() -> task_dumpable patch.)

Looks like my results are slightly diffent, Does this mean i did not apply the 
patch correctly? I applied it twice manually, because patch did not succeed 
and compiled the kernel 3 times... 

-- 
e-admin internet gmbh
Andreas Gietl                                            tel +49 941 3810884
Ludwig-Thoma-Strasse 35                      fax +49 89 244329104
93051 Regensburg                                  mobil +49 171 6070008

PGP/GPG-Key unter http://www.e-admin.de/gpg.html




