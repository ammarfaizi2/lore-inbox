Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTEZXRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTEZXRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:17:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13520
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262323AbTEZXRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:17:32 -0400
Date: Tue, 27 May 2003 01:30:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: AA's 00_backout_gcc_3-0-patch-1
Message-ID: <20030526233045.GY3767@dualathlon.random>
References: <Pine.LNX.4.55L.0305261929460.30175@freak.distro.conectiva> <20030526225445.GV3767@dualathlon.random> <20030526231548.GA14858@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526231548.GA14858@werewolf.able.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:15:48AM +0200, J.A. Magallon wrote:
> 
> On 05.27, Andrea Arcangeli wrote:
> > On Mon, May 26, 2003 at 07:30:44PM -0300, Marcelo Tosatti wrote:
> [...]
> > 
> > Overall in kernel we disagreed to follow the MUST requrested by the gcc
> > developers, we often want to do comparisons of variables out of locks to
> > know if we need to take the lock and work on a garbage collection or
> > stuff like that and we for sure don't want to mark those variables
> > volatile since they must be cached and not spilled all the time, under
> > the locks. Linus as well was against using volatile for every piece of
> > memory that can change under gcc. The decision is been basically to
> > outsmart gcc in choosing if gcc has rights to generate kernel crashing
> > code or not. This makes kernel developement even more difficult since
> > you've to imagine whatever smart thing gcc can do with your not
> > serialized code to know if you're forced to mark the stuff volatile, but
> > it'll generate the very best performance.
> > 
> 
> So you are telling that you are allowed to do something like:
> 
> int* a = 0x320;
> 
> for (i=1000 samples)
> 	v[i] = *a;
> 
> in kernel code and you trust gcc to not optimize the loop away ??
> What is volatile is volatile...

probably I didn't explained correctly but it's not really a matter of
optimizations, it's a matter of "kernel crashing gcc produced asm". I
don't expect gcc to generate kernel crashing code from the above, no
matter if the ram at virtual address 0x320 changes or not. But of course
I expect gcc to optimize the above and to cache the result of *a and to
read from 0x320 only once. Regardless it won't kernel-crash, that's the
bit that matters to me.

to clarify further what is the stuff that we've to care about: if you
wrote this instead of the above:

	int* a = 0x320;

	switch(*a) {

	case 0:
		xx(a);
		break;
	case 1:
		yy(a);
		break;
	default:
		zz(a);
		break;

	}

then you should definitely put a volatile before "int * a" or the kernel
could crash randomly while excuting the above if the ram at address
0x320 can change under gcc (despite both xx,yy,zz would all be robust
internally to whatever value a could have, and xx,yy,zz could even take
a spinlock internally before re-reading a, still the kernel could crash).

Of course the suggestion made from the gcc developers would make it
impossible to run into the kernel crashing asm, because they would
always ask us to define stuff as volatile. We don't obey to that rule so
we must imagine how gcc could ever compile the gcc code _every_ time we
deal with non volatile marked memory that can change under gcc (i.e.
outside locks).

At the moment it seems the only potential kernel crashing optimization
in gcc is while dealing with switch, but it wasn't clear if there could
be more.

Andrea
