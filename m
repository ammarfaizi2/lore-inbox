Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRC0Nhb>; Tue, 27 Mar 2001 08:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRC0NhV>; Tue, 27 Mar 2001 08:37:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:59658 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131276AbRC0NhO>; Tue, 27 Mar 2001 08:37:14 -0500
Message-ID: <3AC09480.E8317507@evision-ventures.com>
Date: Tue, 27 Mar 2001 15:24:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <l03130332b6e632432b9f@[192.168.239.101]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:
> 
> >Out of Memory: Killed process 117 (sendmail).
> >
> >What we did to run it out of memory, I don't know. But I do know that
> >it shouldn't be killing one process more than once... (the process
> >should not exist after one try...)
> 
> This is a known bug in the Out-of-Memory handler, where it does not count the buffer and cache memory as "free" (it should), causing premature OOM killing.  It is, however, normal for the OOM killer to attempt to kill a process more than once - it takes a few scheduler cycles for the SIGKILL to actually reach the process and take effect.
> 
> Also, it probably shouldn't have killed Sendmail, since that is usually a long-running, low-UID (and important) process.  The OOM-kill selector is another thing that wants fixing, and my patch contains a *very rough* beginning to this.
> 
> The following patch should solve your problem for now, until a more detailed fix (which also clears up many other problems) is available in the stable kernel.
> 
> Alan and/or Linus may wish to apply this patch too...
> 
> (excerpt from my original patch from Saturday follows)
> 
> --- start ---
> diff -u linux-2.4.1.orig/mm/oom_kill.c linux/mm/oom_kill.c
> --- linux-2.4.1.orig/mm/oom_kill.c      Tue Nov 14 18:56:46 2000
> +++ linux/mm/oom_kill.c Sat Mar 24 20:35:20 2001
> @@ -76,7 +76,9 @@
>         run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
> 
>         points /= int_sqrt(cpu_time);
> -       points /= int_sqrt(int_sqrt(run_time));
> +
> +       /* Long-running processes are *very* important, so don't take the 4th root */
> +       points /= run_time;
> 
>         /*
>          * Niced processes are most likely less important, so double
> @@ -93,6 +95,10 @@
>                                 p->uid == 0 || p->euid == 0)
>                 points /= 4;
> 
> +       /* Much the same goes for processes with low UIDs */
> +       if(p->uid < 100 || p->euid < 100)
> +         points /= 2;
> +

Plase change to 100 to 500 - this would make it consistant with
the useradd command, which starts adding new users at the UID 500
