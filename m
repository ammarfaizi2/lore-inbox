Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSJ1EXq>; Sun, 27 Oct 2002 23:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262841AbSJ1EXq>; Sun, 27 Oct 2002 23:23:46 -0500
Received: from ns.suse.de ([213.95.15.193]:33032 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262838AbSJ1EXp>;
	Sun, 27 Oct 2002 23:23:45 -0500
Date: Mon, 28 Oct 2002 05:30:04 +0100
From: Andi Kleen <ak@suse.de>
To: andrew@pimlott.net, linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021028053004.C2558@wotan.suse.de>
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <p7365vptz49.fsf@oldwotan.suse.de> <20021026190906.GA20571@pimlott.net> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027152038.GA26297@pimlott.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 10:20:38AM -0500, Andrew Pimlott wrote:
> 
> I'm sure there is a case where this is true, but my imagination and
> googling failed to provide one.  Even the messages to the GNU make

foo: bar
	action1 <something that takes less than a second> 

frob: foo
	action2 <something that takes a long time>


action1 is executed. foo and bar have the same time stamp. action2 
is executed.


make runs again. Default rule sees foo.mtime == bar.mtime and starts
action1 and action2 again. action2 takes a long time. But it's unnecessary,
because bar has not really changed.


> Example problem case (assuming a fs that stores only seconds, and a
> make that uses nanoseconds):
> 
> - I run the "save and build" command while editing foo.c at T = 0.1.
> - foo.o is built at T = 0.2.
> - I do some read-only operations on foo.c (eg, checkin), such that
>   foo.o gets flushed but foo.c stays in memory.
> - I build again.  foo.o is reloaded and has timestamp T = 0, and so
>   gets spuriously rebuilt.

Yes, when you file system has only second resolution then you can get
spurious rebuilds if your inodes get flushed. There is no way my patch
can fix that. While some of the cases may be avoided by better
rounding, it would be better to handle such heuristics in user space
if you really wanted to be clever. Or just make sure you have enough
ram.

The point of my patchkit is to allow the file systems
who support better resolution to handle it properly. Other filesystems
are not worse than before when they flush inodes (and better off when
they keep everything in ram for your build because then they will enjoy 
full time resolution) 

My notes about possible problems with older fs were really not about 
make, but about other programs that could see inconsistencies

It's a fairly obscure case because the inode has to be flushed
and reloaded in less than a second (so not likely to trigger
often in practice) 


> 
> > Another way would be to round on flush, but that also has some problems :-
> > for example you can get timestamps which are ahead of the current
> > wall clock.
> 
> Only if the flush is less than a second after the write, right?
> How likely is that in Linux?

Not very, but could happen in extreme cases.


> 
> I tend to prefer the proposal to set the nanosecond field to 10^9-1.
> At least my scenario above doesn't happen.

If you really wanted that I would recommend to change make.
When all nanosecond parts are 0 it is reasonable for make to assume that
the fs doesn't support finegrained resolution. But I'm not sure it's 
worth it.

-Andi
