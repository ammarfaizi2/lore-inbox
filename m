Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272259AbTG3Vuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272260AbTG3Vuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:50:35 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:6788 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S272259AbTG3Vue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:50:34 -0400
Date: Wed, 30 Jul 2003 23:50:32 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730215032.GA18892@vana.vc.cvut.cz>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <20030730202822.GG1873@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730202822.GG1873@lug-owl.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 10:28:22PM +0200, Jan-Benedict Glaw wrote:
> On Wed, 2003-07-30 20:45:29 +0200, Adrian Bunk <bunk@fs.tum.de>
> >   When used on a 386, Linux can emulate 3 instructions from the 486 set.
> >   This allows user space programs compiled for 486 to run on a 386
> >   without crashing with a SIGILL. As any emulation, performance will be
> >  very low, but since these instruction are not often used, this might
> >   not hurt.  The emulated instructions are:
> >      - bswap (does the same as htonl())
> >      - cmpxchg (used in multi-threading, mutex locking)
> >      - xadd (rarely used)
> 
> libstdc++ (and it's main user, apt-get) break at a LOCK insn.

There is no such instruction. Skip LOCK prefix and decode again,
you'll get either cmpxchg or xadd (or cmpxchg8b, but then it does
not work on i486 too).

And yes, it speeds some workloads a lot. Best to look at code,
with these instructions you can do couple of operations without
doing IPC to synchronize with other threads.

And as far as I know, userspace solution does not qualify: major user
is synchronization between threads, so with userspace solution you
will have to do very hard job to get it right (first implement your
own synchronization, if possible without busy waiting... and then
implement cmpxchg on the top of it), while kernel solution can do 
that simple & correct for UP case.
				Best regards,
					Petr Vandrovec
					vandrove@vc.cvut.cz
