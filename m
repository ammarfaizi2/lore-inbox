Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRDFExt>; Fri, 6 Apr 2001 00:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRDFExk>; Fri, 6 Apr 2001 00:53:40 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:11004 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131248AbRDFExV>; Fri, 6 Apr 2001 00:53:21 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104060451.f364pGE27769@webber.adilger.int>
Subject: Re: [PATCH] Revised memory-management stuff
In-Reply-To: <l03130300b6f2ad1d4782@[192.168.239.105]> from Jonathan Morton at
 "Apr 5, 2001 07:10:40 pm"
To: Jonathan Morton <chromi@cyberspace.org>
Date: Thu, 5 Apr 2001 22:51:16 -0600 (MDT)
CC: chromatix@penguinpowered.com,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> Can you copy me your reply(s) to my post?  For some unknown reason, I am
> getting very few messages from the list, and I saw your reply in the
> archives.  So far I haven't even got my own post back...

That's because the last time I replied to your email, it bounced.  Something
bad with your outgoing mail headers, or your ISP.  I'm cc'ing you twice.

> >I'm not sure I follow this one. Granted it punishes larger programs,
> >but is this really good? If I read it correctly, it essentially means
> >that it is impossible for a single process to use > 80% of the VM.
> 
> The rationale for the 4x rule is that 4/5ths of the VM space is usually
> bigger than the physical memory of a machine (thanks to swap).  For most
> applications, allowing a single process to grow beyond the physical memory
> size is a poor idea and will normally lead to thrashing.  If you absolutely
> need your application to be able to grow to that kind of size, add more
> swap or turn vm_overcommit_memory to 1 with it's associated warnings.

I suppose it makes sense if you consider you don't want a single application
using > 80% of RAM + SWAP.  I was more thinking about a limit of 80% RAM,
which would be a big hassle.

> >If you allow process names into the picture, it opens an easy DOS attack.
> >A memory hog simply runs under one of the "protected" names and is
> >immune from being killed, but causes every other process on the box to
> >die. I'm pretty sure this idea was suggested and previously shot down
> >at least once.
> 
> Noted, but I would expect the sysadmin to be aware of this and thus only
> use the PID-based system on machines with untrusted local users.  Having
> the ability to specify process names should make it easier on sysadmins who
> *don't* have untrusted local users but *do* have rapidly-changing lists of
> PIDs that need protection.

I still dislike the use of a static list, because as soon as you put any
PIDs on it, you end up with stale entries at some point.  Names may help
in this regard, but then there is the issue that some processes change
their process name, etc...

> >The OOM-unkillable trait would be stored as a per-process flag, rather
> >than a list to be checked against.  It means that we don't have stale
> >OOM-unkillable entries in the list. The non-OOM trait would be inherited
> >across fork() (but cleared on set*uid(), or maybe it should be a capability)
> >so that processes (e.g. httpd) which spawn/kill helper tasks do not have
> >to keep updating a list. This also prevents the situation where PID X is
> >protected from OOM, but is stopped and later another process takes its PID.
> 
> Interesting idea, which does sound sensible.  There would have to be a
> mechanism for an external process to set this flag, so that the application
> need not explicitly have to support this in order to use it.  Cf. nice and
> renice.
> 
> I don't quite agree on the "clear on setuid()" idea though.  Critical
> processes can and do drop su privileges for normal operation, which doesn't
> make them non-critical in any way.  If the critical process needs to spawn
> a non-critical thread or new process, have it explicitly drop the flag
> after forking.

OK, that was just something I put in there, because I was thinking if you
make init() OOM-unkillable, then everything it spawns would inherit this
trait.  There are probably standard ways that processes inherit or drop
other priveleges (i.e. capabilities), so no point in inventing something
new.  I just wanted to point out that not everything should inherit this.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
