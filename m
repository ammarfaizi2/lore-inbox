Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318976AbSIJDWT>; Mon, 9 Sep 2002 23:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319019AbSIJDWS>; Mon, 9 Sep 2002 23:22:18 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:11688 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318976AbSIJDWR>; Mon, 9 Sep 2002 23:22:17 -0400
Date: Tue, 10 Sep 2002 04:26:22 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Message-ID: <20020910042622.A6616@kushida.apsleyroad.org>
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17oa11-0006ww-00@starship> <20020910025602.A6343@kushida.apsleyroad.org> <E17ob9w-0006xb-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17ob9w-0006xb-00@starship>; from phillips@arcor.de on Tue, Sep 10, 2002 at 04:53:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Locking
> has been arranged by module.c such that this won't increase during the
> course of the cleanup_module call.  The module exit routine does:
> 
> 	if (module->count)
> 		return module->count;
> 
> 	return clean_up_whatever();

If any code within the module does `MOD_DEC_USE_COUNT; return;', you
have a race condition.

That's why nowadays you shouldn't see this.  The main reference points
to a module are either function calls from another module (already count
as references), or a file/filesystem/blockdev/netdevice: these all have
an `owner' field now, so that the MOD_DEC_USE_COUNT can take place
outside their modules.

If you do still see MOD_DEC_USE_COUNT in a module, then there's a race
condition.  Some task calls the function which does MOD_DEC_USE_COUNT,
and some _other_ task calls sys_delete_module().  Lo, the module is
cleaned up and destroyed by the second task while it's in the small
window just before `return' in the first task.

Given that, you need to either (a) not call MOD_DEC_USE_COUNT in the
module, and use the `owner' fields of various structures instead, or (b)
something quite clever involving a quiescent state and some flags.

Note that (b) is not trivial, as you can't just do
`wait_for_quiescent_state()' followed by `if (module->count)': it's
possible that someone may call MOD_INC_USE_COUNT after the quiescent
state has passed, but before you finish cleaning up.

-- Jamie

ps. I'm not sure what "SCM" means, so can't comment on that.
