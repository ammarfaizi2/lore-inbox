Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268507AbTBOCSi>; Fri, 14 Feb 2003 21:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268509AbTBOCSi>; Fri, 14 Feb 2003 21:18:38 -0500
Received: from almesberger.net ([63.105.73.239]:29711 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268507AbTBOCSh>; Fri, 14 Feb 2003 21:18:37 -0500
Date: Fri, 14 Feb 2003 23:28:18 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030214232818.J2092@almesberger.net>
References: <20030214120628.208112C464@lists.samba.org> <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net> <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net> <Pine.LNX.4.44.0302142106140.1336-100000@serv> <20030214211226.I2092@almesberger.net> <Pine.LNX.4.44.0302150148010.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302150148010.1336-100000@serv>; from zippel@linux-m68k.org on Sat, Feb 15, 2003 at 01:51:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Yes, and now compare how the solutions differ when the data is static and 
> when it's allocated.

Do they ? Even if the data is static, it can become invalid
(in the sense that accessing it from a callback would lead
to some kind of undesirable behaviour, even though the access
itself would work), so I don't quite see why the difference
would matter.

Example:

	static ... common_callback(...)
	{
		switch (my_state) {
			...
		}
	}

	...
	my_state = A;
	register_fancy_timer_A(&me_A,common_callback);
	...
	unregister_fancy_timer_A(&me_A);
	my_state = B;
	/* stray fancy_timer_A call to common_callback would
	   trigger action for state B */
	...
	register_fancy_timer_B(&me_B,common_callback);
	...

Depending on "my_state", the callback would perform different
actions. (The "fancy timers" would be some timer-like service
that doesn't del_timer_sync.)

This is getting to abstract. Why don't you just say where you
see the difference ? :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
