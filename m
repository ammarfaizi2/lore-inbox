Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293028AbSCRVgg>; Mon, 18 Mar 2002 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293035AbSCRVg1>; Mon, 18 Mar 2002 16:36:27 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:15879 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293028AbSCRVgM>;
	Mon, 18 Mar 2002 16:36:12 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 18 Mar 2002 14:34:31 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020318143431.E4783@host110.fsmlabs.com>
In-Reply-To: <20020318124215.C4155@host110.fsmlabs.com> <Pine.LNX.4.33.0203181146070.4783-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with you there.  On many PowerPC's, we're screwed.  The best thing
I can think of is the clever VSID allocation and trying to make a sane data
structure out of the hash table but that would involve a _lot_ of work with
very likely no reward.

} Hashes simply do not do the right thing. You cannot do a speculative load
} from a hash, and the hash overhead gets _bigger_ for TLB loads that miss
} (ie they optimize for the hit case, which is the wrong optimization if the
} on-chip TLB is big enough - and since Moore's law says that the on-chip
} TLB _will_ be big enough, that's just stupid).

What's the alternative for some PowerPC's?  Every shared library program
likes to use the exact same addresses which load (and thus create htab
entries) at exactly the same location.  A machine running 100+ processes is
not going to be usable because the every process is sharing the same 8 PTE
slots.

} But the whole point of _scattering_ is so incredibly broken in itself!
} Don't do it.

Yes, that is indeed correct theoretically.  The problem is that we actually
measured it and there was very little locality.  When I added some
multiple-tlb loads it actually decreased wall-clock performance for nearly
every user load I put on the machine.  The common apps now-a-days are using
10's of shared libs so that would make it even worse.

} You can load many TLB entries in one go, if you just keep them close-by to
} each other. Load them into a prefetch-buffer (so that you don't dirty your
} real TLB with speculative TLB loads), and since there tends to be locality
} to TLB's, you've just automatically speeded up your hardware walker.
} 
} In contrast, a hash algorithm automatically means that you cannot sanely
} do this _trivial_ optimization.

Linus, I knew that deep in my heart 8 years ago when I started in on all
this.  I'm with you but I'm not good enough with a soldering iron to fix
every powerpc out there that forces that crappy IBM spawned madness upon
us.

I even wrote a paper about how bad a design is and how the designers should
be whipped for their foolish choices on the PPC.  I'll hold the torch if
you knock on the castle door...

} Face it, hashes are BAD for things like this.
