Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSFXOs4>; Mon, 24 Jun 2002 10:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSFXOsz>; Mon, 24 Jun 2002 10:48:55 -0400
Received: from n123.ols.wavesec.net ([209.151.19.123]:5249 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S313698AbSFXOsz>;
	Mon, 24 Jun 2002 10:48:55 -0400
Date: Sat, 22 Jun 2002 10:40:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <landley@trommello.org>
Cc: John Alvord <jalvo@mbay.net>, zaimi@pegasus.rutgers.edu,
       linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
Message-ID: <20020622084014.GG102@elf.ucw.cz>
References: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu> <20020619010945.6725B7D9@merlin.webofficenow.com> <l8f1hu0ptese1cie90tnvathd36jqc41ca@4ax.com> <20020619222836.078946A2@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619222836.078946A2@merlin.webofficenow.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>  has anybody worked or thought about a property to upgrade the kernel
> > >> while the system is running?  ie. with all processes waiting in their
> > >> queues while the resident-older kernel gets replaced by a newer one.
> > >
> > >Thought about, yes.  At length.  That's why it hasn't been done. :)
> >
> > IMO the biggest reason it hasn't been done is the existence of
> > loadable modules. Most driver-type development work can be tested
> > without rebooting.
> 
> That's part of it, sure.  (And I'm sure the software suspend work is 
> leveraging the ability to unload modules.)
> 
> There's a dependency tree: processes need resources like mounted filesystems 
> and open file handles to the network stack and such, and you can't unmount 
> filesystems and unload devices while they're in use.  Taking a running system 
> apart and keeping track of the pieces needed to put it back together again is 
> a bit of a challenge.

It depends on what limitations you can live with.

> The software suspend work can't freeze processees individually to seperate 
> files (that I know of), but I've heard blue-sky talk about potentially adding 
> it.  (Dunno what the actual plans are, pavel machek probably would).
> If 

Its not software suspend's goal; something similar can be done from
userspace using ptrace, try googling for freezer. Martin Mares did that.

> processes could be frozen in a somewhat kernel independent way (so that their 
> run-time state was parsed in again in a known format and flung into any 
> functioning kernel), then upgrading to a new kernel would just be a question 
> of suspending all the processes you care about preserving, doing a two kernel 
> monte, and restoring the processes.  Migrating a process from one machine to 
> another in a network clsuter would be possible too.

Yeah, that would be very nice.

> Hmmm, what would be involved in serializing a process to disk?  Obviously you 
> start by sending it a suspend signal.  There's the process stuff, of
> course.  

You don't. You don't want process being frozen known it was
freezed. You just stop it in a special way.

> (Priority, etc.)  That's not too bad.  You'd need to record all the memory 
> mappings (not just the contents of the physical and swapped out
> memory 

Doable from userspace, its in /proc.

> You'd need to record all the open file handles, of course. (For actual files 
> this includes position in file, corresponding locks, etc.  For the zillions 
> of things that just LOOK like files, pipes and sockets and character and 
> block devices, expect special case code).

There's not enough info in /proc to do this, I believe. Plus this is
nasty to restore -- like forcing code into processes's address space
to do opening for you.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
