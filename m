Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271311AbRHOROH>; Wed, 15 Aug 2001 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271316AbRHORN5>; Wed, 15 Aug 2001 13:13:57 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34035 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271311AbRHORNp>; Wed, 15 Aug 2001 13:13:45 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108151713.f7FHDg0n013420@webber.adilger.int>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.4.21.0108151622570.2107-100000@sorbus.navaho>
 "from Steve Hill at Aug 15, 2001 04:27:04 pm"
To: Steve Hill <steve@navaho.co.uk>
Date: Wed, 15 Aug 2001 11:13:41 -0600 (MDT)
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Hill writes:
> On Wed, 15 Aug 2001, Richard B. Johnson wrote:
> > Same problem on 2.4.1. The first 512 bytes comes right away if
> > /dev/random hasn't been accessed since boot, then the rest trickles
> > a few words per second.
> 
> Hmm...  Well, ATM I've kludged a fix by using /dev/urandom instead, but
> it's not ideal because it's being used to generate cryptographic keys, and
> urandom isn't cryptographically secure.
> 
> I might have a look into increasing the size of the entropy pool so
> there's more data to access at once...

Yes, it is possible to increase the size of the in-kernel entropy pool
by changing the value in linux/drivers/char/random.c.  You will likely
also need to fix up the user-space scripts that save and restore the
entropy on shutdown/startup (they can check /proc/sys/kernel/random/poolsize,
if available, to see how many bytes to read/write).

> Are you seeing the problem on a normal machine? (I assumed I was seeing it
> because I'm using Cobalt hardware that's not going to get much entropy
> data due to the lack of keyboard, etc)...  although when I'm generating
> this data I'm using a root NFS filesystem, so there should be plenty of
> network interrupts happening,which should generate some entropy...

Note that network interrupts do NOT normally contribute to the entropy
pool.  This is because of the _very_theoretical_ possibility that an
attacker can "control" the network traffic to such a precise extent as
to flush or otherwise contaminate the entropy from the pool by sending
packets with very precise intervals and generating interrupts so exactly
as to fill the entropy pool with known data.  IMVHO, this is basically
impossible, as the attacker could not possibly control ALL of the network
traffic, and you could optionally define "safe" and "unsafe" interfaces
for terms of entropy.

It is basically inconcievable (IMHO) that anything but a machine connected
via a single crossover cable could "attack" a system precisely enough to
actually compromise the entropy pool because of network interrupts, but
then again people with more knowledge of this than I are in charge.

That said, if you are running on a machine with an Intel i81[05]
chipset, it has a hardware random number generator (I doubt Cobalt boxes
have these).  Alternately, you you need to add SA_SAMPLE_RANDOM to the
request_irq() call of the network card in your system.

You may also want to add a kernel/module parameter to make this flag
conditional on a per-controller basis, so for example it will only add
entropy from the internal interface of a firewall, and not the external
interface (if you have identical NICs on both).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

