Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTDXGuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTDXGuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 02:50:14 -0400
Received: from mail.eskimo.com ([204.122.16.4]:10507 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S261338AbTDXGuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 02:50:12 -0400
Date: Thu, 24 Apr 2003 00:01:26 -0700
To: David Ford <david+cert@blue-labs.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424070126.GA30867@eskimo.com>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <3EA75EDD.20605@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA75EDD.20605@blue-labs.org>
User-Agent: Mutt/1.5.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You would have already OOM-killed them if you pre-reserved space, since
instead of using that space for swap like you should have, you reserved
it for swsusp.  This means that if swsusp had to OOM-kill in the swap
scenario, the system would already have run out of memory and had to
oom-kill in the reserved partition scenario.

It's just a matter of whether the system lets you start some tasks it 
can't suspend, in which case it has to shut them down during the suspend
stage, or it doesn't let you run those tasks, in which case you've
already run out of memory and had to terminate them.

It seems to me the real thing you want here is growable swap files in
the kernel.  This would let both cases succeed, provided there's enough
disk space sitting around in some filesystem which is marked for swap.

Of course, if you run out of disk, you'd still hit OOM in either case,
and disk full too.  And of course, if swap is allowed to grow without
bound, the system will thrash itself to death instead of OOM-ing
whenever a process goes wild.

-J

On Wed, Apr 23, 2003 at 11:49:49PM -0400, David Ford wrote:
> I honestly don't see OOMing as an acceptable practice.  If I wanted to 
> kill a bunch of stuff just to suspend, I would have simply shut the 
> system down.  That isn't my intent or desire.  I want to suspend the 
> system just as it is without OOMing a bunch of programs.
> 
> David
> 
> Pavel Machek wrote:
> 
> >Hi!
> >
> > 
> >
> >>>From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> >>>Can't you just create a pre-reserved separate swsusp area on 
> >>>disk the size 
> >>>of RAM (maybe a partition rather than a file to make things 
> >>>easier), and 
> >>>then you know you're safe (basically what Marc was 
> >>>suggesting, except pre-allocated)? Or does that make me the 
> >>>prince of all evil? ;-)
> >>>
> >>>However much swap space you allocate, it can always all be 
> >>>used, so that seems futile ...
> >>>     
> >>>
> >>This is what Other OSes do, and I believe this is the correct path.
> >>Using swap for swsusp is a clever hack but not a 100% solution.
> >>   
> >>
> >
> >Well, for normal use its clearly inferior -- suspend partition is unused
> >when it could be used for speeding system up by swapping out unused
> >stuff.
> >
> >OtherOS approach is better because it can guarantee suspend-to-disk
> >for critical situations like overheat or battery-critical.
> >
> >But we can get best of both worlds if we OOM-kill during critical
> >suspend. [If suspend partition was not used for swapping, machine
> >would *already* OOM-killed someone, so we are only improving stuff].
> >
> >						Pavel  
> >
> > 
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
