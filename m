Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293379AbSCAQuZ>; Fri, 1 Mar 2002 11:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293373AbSCAQuS>; Fri, 1 Mar 2002 11:50:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27411 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293375AbSCAQuA>; Fri, 1 Mar 2002 11:50:00 -0500
Date: Fri, 1 Mar 2002 08:49:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
In-Reply-To: <22820.1014996781@redhat.com>
Message-ID: <Pine.LNX.4.33.0203010838360.3798-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Mar 2002, David Woodhouse wrote:
>
> I appreciate that the old recalc_sigpending(task) needed to stop working,
> to force people to stop doing recalc_sigpending(current). How about
> recalc_sigpending_cur() and recalc_sigpending_tsk() then?

The thing is, I refuse to have the "wrong" interface just because of
backwards compatibility.

And it's just _wrong_ to have to write "_cur" to point out that it's
current, when current is the only thing that makes sense from a conceptual
standpoint (except, as mentioned, in the special "internal signal sending
implementation" case).

But the solution might be a higher-level interface altogether: I don't
think it's a good idea in the first place to have drivers and filesystems
playing directly with the blocked signals or whatever it is that you are
doing that makes you want to use recalc_sigpending() in the first place.

So the basic rule should be: drivers etc should not ever have to touch
"sigmask_lock", because they simply should never even _know_ about things
like that. Agreed?

So I would suggest solving this problem by just adding something like

	/* Block all signals except for mask */
	void sigallow(unsigned long mask)
	{
		spin_lock_irq(&current->sigmask_lock);
		siginitsetinv(current->blocked, mask);
		recalc_sigpending();
		spin_unlock_irq(&current->sigmask_lock);
	}

and be done with it. That seems to be what most of the non-signal.c users
actually _want_.

So let's fix this by improving the interfaces, not by making them less
readable.

		Linus

