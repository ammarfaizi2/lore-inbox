Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318805AbSIITol>; Mon, 9 Sep 2002 15:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSIITol>; Mon, 9 Sep 2002 15:44:41 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:20390 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318805AbSIIToj>; Mon, 9 Sep 2002 15:44:39 -0400
Date: Mon, 9 Sep 2002 20:48:34 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Message-ID: <20020909204834.A5243@kushida.apsleyroad.org>
References: <20020907192736.A22492@kushida.apsleyroad.org> <Pine.GSO.4.21.0209071544090.23598-100000@weyl.math.psu.edu> <20020908032121.A23455@kushida.apsleyroad.org> <E17o4UE-0006Zh-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17o4UE-0006Zh-00@starship>; from phillips@arcor.de on Sun, Sep 08, 2002 at 06:00:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> > But you've rather cutely arranged that these kinds of mount _do_
> > disappear when the last file being used on them disappears.  Clever, if
> > a bit disturbing.
> 
> And it's not a good way to drive module unloading.  It is rmmod that
> should cause a module to be unloaded, not close.  The final close
> *allows* the module to be unloaded, it does not *cause* it to be.  So
> to get the expected behaviour, you have to lather on some other fanciful
> construction to garbage collect modules ready to be unloaded, or to let
> rmmod inquire the state of the module in the process of attempting to
> unload it, and not trigger the nasty races we've discussed.  Enter
> fancy locking regime that 3 people in the world actually understand.

Eh?  In this case, Al Viro's scheme is really simple and works: the
kern_mount keeps the module use-count non-zero so long as any file
descriptors are using the module's filesystem.  fput() decrements the
use-count at a safe time -- no race conditions.

The expected behaviour is as it has always been: rmmod fails if anyone
is using the module, and succeeds if nobody is using the module.  The
garbage collection of modules is done using "rmmod -a" periodically, as
it always has been.

-- Jamie
