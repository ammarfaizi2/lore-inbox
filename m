Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318813AbSIISk4>; Mon, 9 Sep 2002 14:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSIISkz>; Mon, 9 Sep 2002 14:40:55 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:34239 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318813AbSIISkl>;
	Mon, 9 Sep 2002 14:40:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Question about pseudo filesystems
Date: Sun, 8 Sep 2002 18:00:12 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <Pine.GSO.4.21.0209071544090.23598-100000@weyl.math.psu.edu> <20020908032121.A23455@kushida.apsleyroad.org>
In-Reply-To: <20020908032121.A23455@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17o4UE-0006Zh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 September 2002 04:21, Jamie Lokier wrote:
> Alexander Viro wrote:
> > It is neither safe nor needed.  Please, look at the previous posting again -
> > neither variant calls mntput() in ->release().
> > 
> > Now, __fput() _does_ call mntput() - always.  And yes, if that happens to
> > be the final reference - it's OK.
> 
> Thanks, that's really nice.
> 
> I'd assumed `kern_mount' was similar to mounting a normal filesystem,
> but in a non-existent namespace.  Traditionally in unix you can't
> unmount a filesystem when its in use, and mounts don't disappear when
> the last file being used on them disappears.
> 
> But you've rather cutely arranged that these kinds of mount _do_
> disappear when the last file being used on them disappears.  Clever, if
> a bit disturbing.

And it's not a good way to drive module unloading.  It is rmmod that
should cause a module to be unloaded, not close.  The final close
*allows* the module to be unloaded, it does not *cause* it to be.  So
to get the expected behaviour, you have to lather on some other fanciful
construction to garbage collect modules ready to be unloaded, or to let
rmmod inquire the state of the module in the process of attempting to
unload it, and not trigger the nasty races we've discussed.  Enter
fancy locking regime that 3 people in the world actually understand.

-- 
Daniel
