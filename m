Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317725AbSFSBfr>; Tue, 18 Jun 2002 21:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317727AbSFSBfq>; Tue, 18 Jun 2002 21:35:46 -0400
Received: from pc132.utati.net ([216.143.22.132]:56193 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S317725AbSFSBfo>; Tue, 18 Jun 2002 21:35:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: zaimi@pegasus.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
Date: Tue, 18 Jun 2002 15:37:23 -0400
X-Mailer: KMail [version 1.3.1]
References: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu>
In-Reply-To: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020619010945.6725B7D9@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 June 2002 05:21 pm, zaimi@pegasus.rutgers.edu wrote:
> Hi all,
>
>  has anybody worked or thought about a property to upgrade the kernel
> while the system is running?  ie. with all processes waiting in their
> queues while the resident-older kernel gets replaced by a newer one.

Thought about, yes.  At length.  That's why it hasn't been done. :)

Closest you'll get at the moment is some variant of two kernel monte, I.E. a 
reboot to a new kernel with all processes offed, but at least without 
involving the bios.

The new swsup infrastructure from pavel machek theoretically lets you freeze 
the state of your system to disk, so we're a heck of a lot farther ahead then 
we were.  If you want to re-open this can of worms, the only way to go is to 
start with some combination of these two projects:

http://falcon.sch.bme.hu/~seasons/linux/swsusp.html
http://sourceforge.net/projects/monte/

That said, the fundamental problem is that when you change kernels, run-time 
state structures change.  Parsing your run-time state from oldvers to feed 
into newvers can't really be done automatically because your tool wouldn't 
know what any of the changes MEAN, so you would probably have to write a 
custom frozen process converter, which would be a pain and a half to debug, 
to say the least.  (And by the time you've got that even half debugged you 
need to do it for the NEXT kernel...)

Of course software suspend theoretically deals with at least some of the 
device driver issues, so there's a certain amount of handwaving you can do on 
that end.  And migrating hot network connections is something people have in 
fact done before, although you'll have to ask around about who.  (Ask the 
security nuts, they consider it a bad thing. :)

Nothing is impossible for anyone impervious to reason, and you might suprise 
us (it'd make a heck of a graduate project).  Hot migration isn't IMPOSSIBLE, 
it's just a flipping pain in the ass.  But the issue's a bit threadbare in 
these parts (somewhere between "are we there yet mommy?" and "can I buy a 
pony?").  Try the swsup mailing list, they might be willing to humor you...

(And the people most likely to WANT this feature ("this system never goes 
down" types) are also the least likely to want to deal with subtle bugs from 
a bad conversion that don't manifest until a week after the new system comes 
up when cron goes nuts at 3 am.  Of course whether hot migration it's more 
dangerous to your data than the interaction between Andre's and Martin's 
egoes in the ATAPI layer is an open question... :)  Ahem.  Right...)

The SANE answer always has been to just schedule some down time for the box.  
The insane answer involves giving an awful lot of money to Sun or IBM or some 
such for hot-pluggable backplanes.  (How do you swap out THE BACKPLANE?  
That's an answer nobody seems to have...)

Clusters.  Migrating tasks in the cluster, potentially similar problem.  Look 
at mosix and the NUMA stuff as well, if you're actually serious about this.  
You have to reduce a process to its vital data, once all the resources you 
can peel away from it have been peeled away, swapped out, freed, etc.  If you 
can suspend and save an individual running process to a disk image (just a 
file in the filesystem), in such a way that it can be individually re-loaded 
later (by the same kernel), you're halfway there.  No, it's not as easy as it 
sounds. :)

> I can see the advantage of such a thing when a server can have the kernel
> upgraded (major or minor upgrade) without disrupting the ongoing services
> (ok, maybe a small few-seconds delay). Another instance would be to
> switch between different kernels in the /boot/ directory (for testing
> purposes, etc.) without rebooting the machine.

See "belling the cat".  Yeah, it's a great idea.  The implementation's the 
tricky bit.

> Would anybody else think this to be an interesting property to have for
> the linux kernel or care to comment on this idea?
>
> Cheers,
>
> Adi Zaimi
> Rutgers University

Don't you guys have professors you can ask about this sort of thing?  (Or are 
you going to the camden campus, says the alumni who survived the first year 
of Whitman's budget cuts...)

Rob
