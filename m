Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTBLFVG>; Wed, 12 Feb 2003 00:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTBLFVG>; Wed, 12 Feb 2003 00:21:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28166 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263291AbTBLFVF>; Wed, 12 Feb 2003 00:21:05 -0500
Date: Tue, 11 Feb 2003 21:26:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <matthew@wil.cx>
Subject: Re: [PATCH][COMPAT] compat_sys_futex 1/7 generic
In-Reply-To: <20030212154716.7c101942.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0302112122130.3901-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Feb 2003, Stephen Rothwell wrote:
> 
> This patch creates compat_sys_futex and changes the 64 bit architextures
> to use it.  This also changes sys_futex to take a "u32 *" as its first
> argument as discussed with Rusty and yourself.

I'd prefer this much more if it just passed the timout around as jiffies
(unconditionally), instead of converting them from one type of timespec to 
another, and then converting that other timespec to jiffies, and having 
multiple tests for NULL because of all that conversion confusion.

In other words, make the do_futex() prototype be

	extern long do_futex(u32 *, int, int, unsigned long);

and let all the callers simply do something like

	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;

	if (utime) {
		struct timespec ts;
		if (copy_from_user(&ts, utime, sizeof(ts))
			return -EFAULT;
		timeout = timespec_to_jiffies(ts)+1;
	}
	do_futex(.. timeout);

instead. It's kind of silly to convert to kernel mode and carry around a 
whole timespec, when the single actual _user_ doesn't even want one 
anyway.

Hmm?

		Linus

