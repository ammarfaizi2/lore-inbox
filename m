Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSFESoA>; Wed, 5 Jun 2002 14:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFESn7>; Wed, 5 Jun 2002 14:43:59 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:23037 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315929AbSFESn4>; Wed, 5 Jun 2002 14:43:56 -0400
Date: Wed, 5 Jun 2002 14:43:57 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020605144357.A4697@redhat.com>
In-Reply-To: <20020604225539.F9111@redhat.com> <Pine.LNX.4.44.0206050820100.2941-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 08:33:13AM -0700, Linus Torvalds wrote:
> So, as far as I can tell, we now get a nasty aliasing issue on
> "current_thread_info()->flags", and information like NEED_RESCHED and
> SIGPENDING end up being set in the wrong place. They get set on the
> _interrupt_ thread_info, not the "process native" thread_info.
> 
> Or did I miss some subtlety?

Ah, you're right.  If anyone uses current_thread_info from IRQ context 
it will set the flags in the wrong structure.  However, it actually 
works because nobody does that currently: all of the _thread_flag users 
appear to be coming in from task context.  Mostly that's luck as I 
didn't change the smp ipis to switch stacks, so the only place that 
is an interrupt and needs to access the actual thread data, does.

> Comments? We can deprecate "current_thread_info()", but that would make
> some things slightly less efficient.

I think we can keep it and flush out any misuse by a couple of 
carefully placed BUG() checks (ie anyone using current_thread_info 
directly from IRQ context really needs to go via current->thread_info, 
so that could be made a BUG()).  The only bit I'm not certain about 
is the preempt_count handling.  I rather like having addr_limit set 
to 0 as it will prevent copy*user from working in IRQ context.

Another alternative is to move the task structure back into the same 
page as the stack, but that would require a commitment to fix the 
large stack users (there aren't many, and I'm certainly willing).  This 
approach would work well with a guard page and the task struct at the 
top.  Also, there is at least 348 bytes of task_struct which should be
moved out: io_bitmaps should only be allocated for the tasks that use 
it (its 132 bytes, and we copy it into the per cpu tss nowadays, so 
making it a pointer should be fine), and the credentials (groups + 
rlim + user ids: >216) need to move to a struct cred for use by NFS, 
AIO and pthreads.  That alone would get task_struct down to 1072 bytes 
on x86 UP (1328 bytes on SMP), which leaves almost 3KB for the task 
context stack.

Thoughts?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
