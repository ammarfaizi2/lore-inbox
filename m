Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319678AbSIMPWX>; Fri, 13 Sep 2002 11:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319683AbSIMPWX>; Fri, 13 Sep 2002 11:22:23 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:41197 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319678AbSIMPWW>; Fri, 13 Sep 2002 11:22:22 -0400
Date: Fri, 13 Sep 2002 09:27:16 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17psBv-0008AP-00@starship>
Message-ID: <Pine.LNX.4.44.0209130919480.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Daniel Phillips wrote:
> I'd be surprised if Rusty can do it any better than you.  It's hard to
> show a race that doesn't exist, even harder to prove that a four-prong
> interface is necessary in order to be able to handle it.  The latter is
> the question on the table.

Not as easy as missing ones point, yes.

> > However, there might be some weird situations. For example, take
> > someone trying to bring all modules down the moment we init. We might
> > start running in unchecked environment, and there we fail because
> > there is no 'we' any more.
> 
> Oh indeed, there are weird situations, but they apply equally to the
> two-prong and the four-prong interfaces.
> 
> > Thus rather module->init(). if (module) module->start(). Since then we can 
> > be sure that the module is locked, and if somebody unloads it, he'll have 
> > to wait for the use count to drop.
> 
> This applies equally to the two-prong interface.
> 
> > Or as another example, take someone trying to use the resources we claimed
> > before the module is really up. If you can rely on the module to be known
> > to be up, you know what do do. Yes, usually that's no real good example, 
> > since resources ought to be locked as well.
> 
> This applies equally to the two-prong interface.  Do you see the pattern
> yet?

Yes, but you don't seem to. (No, I don't want to insult you here.)

Just to draw that:

2p:

thread1						thread2
struct x *y = malloc(sizeof(struct x));
check y;
blah();						cleanup(y et al);
touch y->blah; /* bang */

4p:

thread1						thread2

struct x *y = malloc(sizeof(struct x));
check y;
struct z *a = malloc(sizeof(struct z));
check a;					cleanup(y et al);
struct u *v = malloc(sizeof(struct u));
check v;

return success;

(back in caller - from that moment we're protected against arbitrariness 
from other threads)

check y; <-- detected

You know? We allocate, we lock, we check, we win.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

