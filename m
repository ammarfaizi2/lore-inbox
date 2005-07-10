Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVGJGOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVGJGOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 02:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGJGOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 02:14:03 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:18305 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261852AbVGJGOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 02:14:01 -0400
Date: Sat, 9 Jul 2005 23:13:57 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: guorke <gourke@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I confused about diff(simple question)
Message-Id: <20050709231357.01680297.rdunlap@xenotime.net>
In-Reply-To: <d73ab4d005070922413fb0dbba@mail.gmail.com>
References: <d73ab4d005070922413fb0dbba@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2005 13:41:40 +0800 guorke wrote:

| like:
| 
|  /*
| @@ -220,9 +232,8(HERE: why not -220,9 +220,8) @@ fastcall notrace void
| do_page_fault(stru
|        struct vm_area_struct * vma;
|        unsigned long address;
|        unsigned long page;
| -       int write;
| -       siginfo_t info;
| -
| +       int write, si_code;
| +
|        /* get the address */
|        __asm__("movl %%cr2,%0":"=r" (address));
|        trace_special(regs->eip, error_code, address);
| @@ -236,7 +247,7 (HERE: why not -236,7,+236,7) @@ fastcall notrace
| void do_page_fault(stru
| 
|        tsk = current;
| 
| -       info.si_code = SEGV_MAPERR;
| +       si_code = SEGV_MAPERR;
| 
|        /*
|         * We fault-in kernel-space virtual memory on-demand. The
| @@ -316,7 +327,7 (HERE -316,7, +316,7) @@ fastcall notrace void
| do_page_fault(stru
|  * we can handle it..
|  */
|  good_area:
| -       info.si_code = SEGV_ACCERR;
| +       si_code = SEGV_ACCERR;
|        write = 0;
|        switch (error_code & 3) {
|                default:        /* 3: write, present */
| @@ -390,11 +401,7 (HERE:why not -390,11,+390,11) @@ bad_area_nosemaphore:
|                /* Kernel addresses are always protection faults */
|                tsk->thread.error_code = error_code | (address >= TASK_SIZE);
|                tsk->thread.trap_no = 14;
| -               info.si_signo = SIGSEGV;
| -               info.si_errno = 0;
| -               /* info.si_code has been set above */
| -               info.si_addr = (void __user *)address;
| -               force_sig_info(SIGSEGV, &info, tsk);
| +               force_sig_info_fault(SIGSEGV, si_code, address, tsk);
|                return;
|        }
| 
| @@ -500,11 +507,7(HERE: why not -500,11,+500,7) @@ do_sigbus:
|        tsk->thread.cr2 = address;
|        tsk->thread.error_code = error_code;
|        tsk->thread.trap_no = 14;
| -       info.si_signo = SIGBUS;
| -       info.si_errno = 0;
| -       info.si_code = BUS_ADRERR;
| -       info.si_addr = (void __user *)address;
| -       force_sig_info(SIGBUS, &info, tsk);
| +       force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
|        return;
| 
| ...
| 
| in :-220,9 +232,8
|  I think the old file from the line 220,and have 9 lines,then the
| newfile have 8 lines
| so must delete one line. but why +232,it from the line 232 ?

That patch segment begins at line 232 in the new file because the
previous patch segments added 12 lines (232 - 220).

Now, were there some previous patch segments (that you omitted) or
not?  If not, it is confusing...

| like this..
| 
| maybe it's very very simple.but i really confused it.wishes helps,



---
~Randy
