Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSK0RKO>; Wed, 27 Nov 2002 12:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSK0RKO>; Wed, 27 Nov 2002 12:10:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264001AbSK0RKN>; Wed, 27 Nov 2002 12:10:13 -0500
Date: Wed, 27 Nov 2002 09:18:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] Start of compat32.h (again)
In-Reply-To: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Nov 2002, Stephen Rothwell wrote:
> 
> How's this one :-)

Better.

> This patch does:
> 	introduces CONFIG_COMPAT32
> 	introduces linux/compat32.h - which contains only struct timespec32
> 		for now
> 	creates an architecture independent version of sys32_nanosleep
> 		in kernel/timer.c

May I just suggest doing a

	kernel/compat32.c

and doing most everything there? I think we're better off that way, even 
if it means that "do_nanosleep()" etc cannot be static.

> I make the follwing assumptions:
> 	returning s32 from a 32 bit compatibility system call is the same
> 		as returning long or int.

You should make system call returns always be of type "long". Some
architectures may well require that (I know that the alpha calling
conventions do require it, even when using the 32-bit user land. I don't
think Linux has ever really supported the 32-bit stuff on alpha, but the
theory is the same).

And it means that the upper bits are well-defined.

In other words, instead of doing

	s32 sys_xxx(..)
	{
		return xxxx
	}

you should make them be

	long sys_xxx(...)
	{
		s32 retval;
		...
		return retval;
	}

> Should the new do_nanosleep function be inlined?

Well, since I want it used in another file, it can't be.

		Linus

