Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTBICIW>; Sat, 8 Feb 2003 21:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbTBICIW>; Sat, 8 Feb 2003 21:08:22 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37778 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267141AbTBICIV>; Sat, 8 Feb 2003 21:08:21 -0500
Date: Sat, 8 Feb 2003 18:17:52 -0800
Message-Id: <200302090217.h192Hqi04174@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Linus Torvalds's message of  Saturday, 8 February 2003 18:00:01 -0800 <Pine.LNX.4.44.0302081754340.5231-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Compliant sleeve ink
   (2) Nylon logs
   (3) Mexican Disorienting porno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> By then we also have local interrupts disabled, and we've explicitly 
> disabled preemption, so I don't see how anything could ever wake us up any 
> more. 

We already know how this happens.  I think it's only possible with SMP.  
I described this very problem in the final paragraph of my penultimate
message on the signals changes:

    Incidentally, I've run across another bug introduced by the last rework of
    handle_stop_signal (or perhaps similar races have always been there, I'm
    not quite sure at the moment).  It can call wake_up_process on a zombie
    that's on its way to exit, triggering the BUG at the end of do_exit.  I
    think this race may be possible in all of the signal_wake_up calls for
    SIGKILL cases, and other uses of wake_up_process like PTRACE_KILL.
    Some such places check ->state, but they do not lock out exit races.
    Perhaps having wake_up_process itself be race-proof would be simplest.
    I don't have a good sense of how best to fix this one yet.

This will probably stop biting anyone in practice after the most recent new
plan for SIGKILL we've just been discussing.  For signals, the race will
only be possible for SIGCONT sent when a thread is on its way to die.  That
can be avoided by checking PF_EXITING in handle_stop_signal, because after
setting PF_EXITING any thread in do_exit will take the siglock and thus
can't have gotten far enough to go to TASK_ZOMBIE without being serialized
after the loop in handle_stop_signal.

As I said above, I think this race is possible in other uses of
wake_up_process.  PTRACE_KILL is one example, but there are others and I
would have to check carefully to be convinced that other factors rule out
this exit race for them.  I think that BUG_ON check should definitely go
into try_wake_up so that it hits should any of these other races ever
actually bite.  Unless I am missing something, it won't necessarily catch
all races unless you use xchg to set TASK_RUNNING and then check the old value.
