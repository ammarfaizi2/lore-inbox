Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbSJQI0g>; Thu, 17 Oct 2002 04:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJQI0g>; Thu, 17 Oct 2002 04:26:36 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:13809 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261862AbSJQI0d>; Thu, 17 Oct 2002 04:26:33 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com> 
References: <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Oct 2002 09:32:25 +0100
Message-ID: <22897.1034843545@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002, Linus Torvalds wrote:
> Actually, i fyou read my original email on this thread, I actually
> suggested splitting up the "INTERRUPTIBLE" vs "UNINTERRUPTIBLE" into
> three different cases and one extra bit.
>
> Sending somebody a SIGKILL (or any signal that kills the process) is
> different (in my opinion) from a signal that interrupts a system call
> in order to run a signal handler.
>
> So my original suggestion on this thread was to make 
> 
>         TASK_WAKESIGNAL - wake on all signals
>         TASK_WAKEKILL   - wake on signals that are deadly
>         TASK_NOSIGNAL   - don't wake on signals
>         TASK_LOADAVG    - counts toward loadaverage
>
>         #define TASK_UNINTERRUPTIBLE    (TASK_NOSIGNAL | TASK_LOADAVG)
>         #define TASK_INTERRUPTIBLE      TASK_WAKESIGNAL
>
> and then let code like generic_file_write() etc use other combinations
> than the two existing ones, ie
>
> 	(TASK_WAKEKILL | TASK_LOADAVG) 
>
> results in a process that is woken up by signals that kill it (but not
> other signals), and is counted towards the loadaverage. Which is what we
> want in generic_file_read() (and _probably_ generic_file_write() as well,
> but that's slightly more debatable).

I like this, but perhaps with a slight modification. I think that instead of
being a flag in the task state, the 'can we deal with being interrupted'
should instead be a _counter_, and the process in question can be woken 
by signals only if it's zero. For the following reason:

In the world you describe above, a function sets the NOSIGNAL flag when
sleeping if it can't deal with being interrupted -- presumably because it 
has no simple way to clean up its state in that case.

But we should remain aware that the ability to clean up on being interrupted
is not a function of only the bottom-most function on the call stack; it is
actually a function of the _entire_ call stack, in some cases all the way
back up to the userspace program making the system call. Every function in
the call stack needs to be able to deal with the -EINTR return and clean up
appropriately, not just the bottom-most function.

Consider the case where function A() sleeps, and can perfectly happily deal
with being interrupted. It is called from function B() which can also deal
with an -EINTR return from A(), and in fact _wants_ to do so because it can
take a long time and being uninterruptible would suck. The majority of 
callers of function A() are of this nature, and want to be interruptible.

But there exists a function C() which also calls function A(), and which 
_cannot_ deal with being interrupted.

What we actually tend to do in this case is make function A()
uninterruptible at all times (or -- ugh -- pass an extra argument all the
way down telling it which type of sleep to use and not to check
signal_pending()).

My suggested alternative is to have the afore-mentioned'interruptible_count'
in the task struct, and each function that cannot deal with receiving -EINTR
from the other functions it calls shall increase this count accordingly.

So sys_write() would increase current->interruptible_count, and then 
nothing called from there would upset the user by returning -EINTR.

Similarly, down() would just increase the count before calling what's 
currently down_interruptible(), etc.

--
dwmw2


