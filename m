Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRKKAGc>; Sat, 10 Nov 2001 19:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280758AbRKKAGW>; Sat, 10 Nov 2001 19:06:22 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:27911 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280725AbRKKAGI>;
	Sat, 10 Nov 2001 19:06:08 -0500
Date: Sun, 11 Nov 2001 11:01:08 +1100
From: Anton Blanchard <anton@samba.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "David S. Miller" <davem@redhat.com>, jakub@redhat.com, bcrl@redhat.com,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 2 of the tr-based current
Message-ID: <20011111110107.A4064@krispykreme>
In-Reply-To: <20011108211143.A4797@redhat.com> <20011109041327.T4087@devserv.devel.redhat.com> <3BEBEE0B.BA1FD7EE@colorfullife.com> <20011109.070312.88700201.davem@redhat.com> <3BEBF730.86CAE1CC@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEBF730.86CAE1CC@colorfullife.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> No. const == never changes.
> get_TR changes if a task calls schedule, and return on another cpu.

Yes, I found this exact problem on ppc64 where we would cache the
processor data area across a schedule(). What was interesting was that
__attribute__ ((pure)) was not enough to fix this.

static inline struct Paca *get_paca(void) __attribute__ ((pure));
static inline struct Paca *get_paca(void)
{
	struct Paca *rval;
	__asm__ ("mfspr %0,0x113" : "=r" (rval));
	return rval;
}

Alan Modra came to the rescue and found that gcc was optimising too much
and since the function did not touch any global variables, it would
upgrade the pure to const. This was on gcc 3.0.X.

Anton
