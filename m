Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSIJDkY>; Mon, 9 Sep 2002 23:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSIJDkW>; Mon, 9 Sep 2002 23:40:22 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:9925 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317521AbSIJDkV>;
	Mon, 9 Sep 2002 23:40:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Question about pseudo filesystems
Date: Tue, 10 Sep 2002 05:47:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17ob9w-0006xb-00@starship> <20020910042622.A6616@kushida.apsleyroad.org>
In-Reply-To: <20020910042622.A6616@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17obzl-0006yI-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 05:26, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > Locking
> > has been arranged by module.c such that this won't increase during the
> > course of the cleanup_module call.  The module exit routine does:
> > 
> > 	if (module->count)
> > 		return module->count;
> > 
> > 	return clean_up_whatever();
> 
> If any code within the module does `MOD_DEC_USE_COUNT; return;', you
> have a race condition.
> 
> That's why nowadays you shouldn't see this.  The main reference points
> to a module are either function calls from another module (already count
> as references), or a file/filesystem/blockdev/netdevice: these all have
> an `owner' field now, so that the MOD_DEC_USE_COUNT can take place
> outside their modules.

Thanks for telling me this, but I know it.  The manner in which the
module use count is protected is completely irrelvant to the code I
showed.  The cleanup_module just knows the count is protected and
stable.

> If you do still see MOD_DEC_USE_COUNT in a module, then there's a race
> condition.  Some task calls the function which does MOD_DEC_USE_COUNT,
> and some _other_ task calls sys_delete_module().  Lo, the module is
> cleaned up and destroyed by the second task while it's in the small
> window just before `return' in the first task.
> 
> Given that, you need to either (a) not call MOD_DEC_USE_COUNT in the
> module, and use the `owner' fields of various structures instead, or (b)
> something quite clever involving a quiescent state and some flags.
> 
> Note that (b) is not trivial, as you can't just do
> `wait_for_quiescent_state()' followed by `if (module->count)': it's
> possible that someone may call MOD_INC_USE_COUNT after the quiescent
> state has passed, but before you finish cleaning up.

You promised to find a race or some other deficiency in my code and
you pointed out some other interesting, but incidental fact.

If you look at my code snippet for cleanup_module, you'll see it
doesn't decrement anything, though it could if it wanted to, because
it's called under protection provided by module.c.

The way the module keeps track of its unloadable/not unloadable
state is up to it, which makes sense, n'est-ce pas?  Given that
there is no way you can make the MOD_DEC_USE_COUNT concept work
for SCM, for example.

There is in fact no choice other than to bite the bullet and
implement some form of magic_wait_for_quiescent_state(), however
hard that may be, to be used in the cases where some precise
accounting method simply isn't possible.  The alternative is to
forbid unloading of some types of modules, and I hope you
realize what kind of criticism that would invite.

Anyway, solutions to the difficulties are known.  We are simply
quibbling over whether we should use an obscure interface or a
simple, transparent one.

-- 
Daniel
