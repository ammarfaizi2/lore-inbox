Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSJOPWZ>; Tue, 15 Oct 2002 11:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSJOPWZ>; Tue, 15 Oct 2002 11:22:25 -0400
Received: from dsl-213-023-038-160.arcor-ip.net ([213.23.38.160]:35987 "EHLO
	starship") by vger.kernel.org with ESMTP id <S264001AbSJOPWO>;
	Tue, 15 Oct 2002 11:22:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] In-kernel module loader 1/7
Date: Tue, 15 Oct 2002 17:28:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20021015052656.5ED272C18E@lists.samba.org>
In-Reply-To: <20021015052656.5ED272C18E@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E181Tcc-0003k0-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 05:25, Rusty Russell wrote:
> In message <E17w2XF-0005oW-00@starship> you write:
> > Not being able to unload LSM would suck enormously.  At last count, we
> > knew how to do this:
> > 
> >   1) Unhook the function hooks (using a call table simplifies this)
> >   2) Schedule on each CPU to ensure all tasks are out of the module
> >   3) A schedule where the module count is incremented doesn't count
> > 
> > and we rely on the rule that and module code that could sleep must be
> > bracketed by inc/dec of the module count.
> > 
> > Did somebody come up with a reason why this will not work?
> 
> It won't quite work if the hooks can sleep.  You can say "don't sleep"
> or have a wedge which does the "try_inc_mod_count()" then calls into
> the module (and returns some default if it can't inc the module count).

Right.  By coincidence, I found myself thinking about this very problem
as I re-materialized this morning.  If TRY_INC_MOD_COUNT also ors a flag
(which it does now, for other reasons) then:

   1) Clear the mod_inc flag
   2) Unhook the function hooks
   3) Schedule on each CPU
   4) If the mod_inc flag is set, repeat from (1)

This should perform acceptably well, and would only be done in cases
where the existing TRY_INC_MOD_COUNT strategy can't be used.

> You can't disable preemption before calling in, because there is no
> way to sleep with preemption disabled. 8(

Why is that harder than bumping a counter that makes preempt_schedule
return without doing anything?

-- 
Daniel
