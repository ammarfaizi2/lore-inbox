Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTAPSv1>; Thu, 16 Jan 2003 13:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTAPSuW>; Thu, 16 Jan 2003 13:50:22 -0500
Received: from almesberger.net ([63.105.73.239]:50180 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267199AbTAPSt0>; Thu, 16 Jan 2003 13:49:26 -0500
Date: Thu, 16 Jan 2003 15:58:15 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030116155815.A29595@almesberger.net>
References: <20030115063349.A1521@almesberger.net> <20030116013125.ACE0F2C0A3@lists.samba.org> <20030115234258.E1521@almesberger.net> <3E26F6DC.D9150735@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E26F6DC.D9150735@linux-m68k.org>; from zippel@linux-m68k.org on Thu, Jan 16, 2003 at 07:15:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> >  - prepare_deregister (like "deregister", but reversible)
> >  - commit_deregister
> >  - undo_deregister
> 
> You can simplify this. All you need are the following simple functions:
> 
> - void register();
> - void unregister();
> - int is_registered();
> - void inc_usecount();
> - void dec_usecount();
> - int get_usecount();

I'm not sure if you, you're not changing the semantics. What I was
describing was a non-blocking interface, e.g.

	if (!prepare_deregister(foo))
		return -E...;
	if (!prepare_deregister(bar)) {
		undo_deregister(foo);
		return -E...;
	}
	commit_deregister(foo);
	commit_deregister(bar);
	return 0;

With your interface, you're not guaranteed that you can re-register.
Well, you could externalize this, e.g. with

	int error = 0;

	inc_usecount(foo);
	inc_usecount(bar);
	unregister(foo); /* does nothing irrevokable since use count > 0 */
	unregister(bar);
	if (get_usecount(foo) > 1 || get_usecount(bar) > 1) {
		register(foo); /* re-registers foo */
		register(bar); /* re-registers bar */
		error = E...;
	}
	dec_usecount(foo);
	dec_usecount(bar);
	return error;

Is that what you had in mind ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
