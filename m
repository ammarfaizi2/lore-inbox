Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSAIMqY>; Wed, 9 Jan 2002 07:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286358AbSAIMqF>; Wed, 9 Jan 2002 07:46:05 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:49760 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S286343AbSAIMqC>; Wed, 9 Jan 2002 07:46:02 -0500
Date: Wed, 9 Jan 2002 14:45:49 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>,
        sak@iki.fi
Subject: Re: 2.2.21pre2 oops
Message-ID: <20020109144549.L1331@niksula.cs.hut.fi>
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> <E16O2fD-0007Vn-00@the-village.bc.nu> <20020108221315.U1200@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020108221315.U1200@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Tue, Jan 08, 2002 at 10:13:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 10:13:15PM +0200, you [Ville Herva] claimed:
> On Tue, Jan 08, 2002 at 08:16:03PM +0000, you [Alan Cox] claimed:
> > > essentially cat /dev/md0 > /dev/null kind of test to stress the Via KT133
> > > pci transfers.
> > > 
> > > Rootfs is on ide cdrom, the harddrives had no fs on them.
> > > 
> > > ksymoops 0.7c on i686 2.2.21pre2-ide+e2compr+raid.  Options
> > > used
> > 
> > Can you repeat the test to make sure its replicable, then repeat it again
> > after disabling the new VIA fixups in pci/quirks.c
> 
> The test has been repeated several times even with 2.2.21pre2 (although
> we've run a lot more 2.2.20 tests). This was the first time we saw an oops.
> The difference between this and the former 2.2.21pre2 runs is certain bios
> settings. (We are still trying to isolate the one setting that triggers the
> Via pci transfer corruption on HPT reads.) We'll repeat the test with these
> settings and try to see if it is via bios settings / pci/quirks.c related.
> 
> There seems to be _something_ fishy in the pre2 quirks, since there is at
> least one bios setting combination with which 2.2.20 does not show the pci
> corruption, but 2.2.21pre2 does. It just that it is really tedious to
> isolate. But we are working on it.

Bleah.

It turned out that mere hpt370 read/write test hadn't caused it. My
colleague had launched "ping -f" on background which had immediately
triggered the oops. (When I found the oops on the screen, I initially tought
he had just left the hpt370 read/write test running and left.)

We booted and tried to reproduce it. ping -f didn't immediately trigger it,
but after a while it happened. We got a number of oopses one of which was
similar to the first one and one of which showed process table corruption
(the name of the process in the oops was a random ascii pattern.)

We also got the oops with 2.2.20+patches, so this is not a pre2 thing.
Rather, the difference is that we now ran ping -f on background.

The bad news is that all the bios setting configurations we thought stable
(that had run the hpt370 read/write test without a hitch for days) now give
oopses and corruption pretty quickly when we run ping -f on background :(.

Also, ping -f shows "...EEE.EE.EEE.." which I gather means the packets get
corrupted somewhere.

I'm not too hopeful regarding finding a set of bios settings that would fix
this. It seems the "stable" configuration we found just hid the problem, but
when we push the board further, it appears again.

The two disks on HPT370 read on parallel give about 60MB/s. Add the 10MB/s
from 3c905 to that, and we are pretty close to the 75MB/s number that I've
seen referred somewhere(1) as the maximum Via KT133 can do.

My conclusion at this point is that Via KT133 / Abit KT7-RAID pci transfer
is positively FUBAR, and no sane person should touch the bugger with a ten
foot pole. I'd be happy to be proven wrong, though.


-- v --

v@iki.fi

(1) http://www.tecchannel.de/hardware/817/1.html
