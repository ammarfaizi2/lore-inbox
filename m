Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135699AbRDXQZQ>; Tue, 24 Apr 2001 12:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135701AbRDXQYz>; Tue, 24 Apr 2001 12:24:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135699AbRDXQYw>; Tue, 24 Apr 2001 12:24:52 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: BUG: Global FPU corruption in 2.2
Date: 24 Apr 2001 09:24:20 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9c49bk$fd3$1@penguin.transmeta.com>
In-Reply-To: <cpxu23etpmc.fsf@goat.cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Alan, I'm lazy and only have 2.2.14 sources on-line. Maybe this has
  been fixed already and there's something else going on. Worth a look ]

In article <cpxu23etpmc.fsf@goat.cs.wisc.edu>,
Victor Zandy  <zandy@cs.wisc.edu> wrote:
>
>Someone else here traced the process flags of a FP-intensive program
>on a machine before and after it is put in the faulty FPU state.  He
>periodically sampled /proc/pid/stat while the program was running.
>
>He found that PF_USEDFPU was always set before the machine was broken.
>After he found that it was set about 70% of the time.

[ Looks closer at the ptrace synchronization ]

Ahh.. This actually _does_ look like a race on "current->flags":
PTRACE_ATTACH will do a

	child->flags |= PF_PTRACED;

without waiting for the child to have stopped.

(Aside: thinking more about the stopping logic - I'm not actually sure
the ptrace synchronization is complete wrt scheduling, as there will be
a window when the process has set the task state to TASK_STOPPED but
hasn't actually yet scheduled away. Oh, well).

All other ptrace operations (not counting killing the child) will check
that the child is quiescent.  But PTRACE_ATTACH will not, as we're just
setting up the stopping.

In 2.4.x, this bug doesn't happen because "flags" was split up into
"current->ptrace" and "current->flags".  Exactly because of locking
concerns.

			Linus
