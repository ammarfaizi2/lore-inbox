Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317535AbSGJQab>; Wed, 10 Jul 2002 12:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSGJQaa>; Wed, 10 Jul 2002 12:30:30 -0400
Received: from [195.223.140.120] ([195.223.140.120]:60781 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317535AbSGJQa2>; Wed, 10 Jul 2002 12:30:28 -0400
Date: Wed, 10 Jul 2002 18:34:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Austin Gonyou <austin@digitalroadkill.net>,
       linux-kernel@vger.kernel.org, linux-scsi@dualathlon.random
Subject: Re: Terrible VM in 2.4.11+ again?
Message-ID: <20020710163422.GB2513@dualathlon.random>
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es> <20020709124807.D1510@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020709124807.D1510@mail.muni.cz>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 12:48:08PM +0200, Lukas Hejtmanek wrote:
> On Tue, Jul 09, 2002 at 12:58:16AM +0200, J.A. Magallon wrote:
> > Seriously, if you have that kind of problems, take the -aa kernel and use it.
> > I use it regularly and it behaves as one would expect, and fast.
> > And please, report your results...
> 
> I've tried 2.4.19rc1aa2, it swaps even when I have 512MB ram and xcdroast with
> scsi-ide emulation cd writer reports to syslog:
> Jul  9 12:45:02 hell kernel: __alloc_pages: 3-order allocation failed
> (gfp=0x20/0)
> Jul  9 12:45:02 hell kernel: __alloc_pages: 3-order allocation failed
> (gfp=0x20/0)
> Jul  9 12:45:02 hell kernel: __alloc_pages: 2-order allocation failed
> (gfp=0x20/0)
> Jul  9 12:45:02 hell kernel: __alloc_pages: 1-order allocation failed
> (gfp=0x20/0)
> Jul  9 12:45:02 hell kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x20/0)
> 
> Am I something missing?

you may want to reproduce with vm_debug set to 1, but I'm pretty sure
it's a scsi generic issue, they are allocating ram with GFP_ATOMIC, and
they may eventually fail if kswapd cannot keep up with the other
GFP_ATOMIC allocations. They should use GFP_NOIO, with -aa it won't even
try to unmap pages.  It will just try to shrink clean cache and it
should work fine for the above purpose where the allocation needs low
latency (the local_pages per-task ensures their work won't be stolen by
the GFP_ATOMIC users).  I asked for that change some time ago but it
never happened apparently. However I assume the sr layer tried some more
after failing, sg has a quite large queue so some delay isn't fatal, and
you can probably safely ignore the above messages, they're just warnings
for you. nevertheless GFP_NOIO would make the allocations more reliable.

Andrea
