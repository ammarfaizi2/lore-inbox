Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSFEPdB>; Wed, 5 Jun 2002 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSFEPdA>; Wed, 5 Jun 2002 11:33:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315458AbSFEPc7>; Wed, 5 Jun 2002 11:32:59 -0400
Date: Wed, 5 Jun 2002 08:33:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <20020604225539.F9111@redhat.com>
Message-ID: <Pine.LNX.4.44.0206050820100.2941-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jun 2002, Benjamin LaHaise wrote:
>
> Below is a patch against 2.5.20 that implements 4KB stacks for tasks,
> plus a seperate 4KB irq stack for use by interrupts.

Hmm.. Interesting.

However, you seem to be moving only the task structure pointer into the
new interrupt stack thread info, which seems to ignore all the "flags"
things.

So, as far as I can tell, we now get a nasty aliasing issue on
"current_thread_info()->flags", and information like NEED_RESCHED and
SIGPENDING end up being set in the wrong place. They get set on the
_interrupt_ thread_info, not the "process native" thread_info.

Or did I miss some subtlety?

Note that some of this may be hidden by the fact that not everybody uses
the "current_thread_info()" thing, most people still use the old format
"tsk->thread_info".

For example: "set_need_resched()" -> "set_thread_flag(TIF_NEED_RESCHED)"
-> "set_bit(fTIF_NEED_RESCHED,&current_thread_info()->flags)".

So any interrupt causing a "set_need_resched()" would appear to not do the
right thing now.

Comments? We can deprecate "current_thread_info()", but that would make
some things slightly less efficient.

		Linus

