Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSH0Prz>; Tue, 27 Aug 2002 11:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSH0Prz>; Tue, 27 Aug 2002 11:47:55 -0400
Received: from crack.them.org ([65.125.64.184]:21516 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S316430AbSH0Pry>;
	Tue, 27 Aug 2002 11:47:54 -0400
Date: Tue, 27 Aug 2002 11:39:57 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave McCracken <dmccr@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <20020827153957.GA9953@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0208191427220.1484-100000@penguin.transmeta.com> <Pine.LNX.4.44.0208201634410.22388-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208201634410.22388-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 04:36:19PM +0200, Ingo Molnar wrote:
> 
> the attached patch ontop of BK-curr fixes the ptrace wait4() anomaly that
> can be observed in any previous Linux kernel i could get my hands at. So
> in fact ->ptrace_children, besides being a speedup, also fixed a bug that
> couldnt be fixed in any satisfactory way before.
> 
> 	Ingo
> 
> --- linux/kernel/exit.c.orig	Tue Aug 20 16:28:57 2002
> +++ linux/kernel/exit.c	Tue Aug 20 16:30:13 2002
> @@ -731,7 +731,7 @@
>  		tsk = next_thread(tsk);
>  	} while (tsk != current);
>  	read_unlock(&tasklist_lock);
> -	if (flag) {
> +	if (flag || !list_empty(&current->ptrace_children)) {
>  		retval = 0;
>  		if (options & WNOHANG)
>  			goto end_wait4;

Ingo,

At this point your ptrace changes have completely broken both
_TRACEME/exec and _ATTACH debugging.  If an attached process finishes
while a debugger is attached, its parent no longer gets the proper wait
result for it:

wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478

etc.  It is never removed from the list.  _TRACEME/exec debugging
appears to have the same problem but it's harder to tell, since one can
not strace GDB in 2.5 without the patch I posted here two weeks ago. 
If you don't have a chance to look at this I'll investigate later
today.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
