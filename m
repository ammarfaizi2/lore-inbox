Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLAPHL>; Fri, 1 Dec 2000 10:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbQLAPHC>; Fri, 1 Dec 2000 10:07:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24146 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129895AbQLAPG7>; Fri, 1 Dec 2000 10:06:59 -0500
Date: Fri, 1 Dec 2000 15:18:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Phillip Ezolt <ezolt@perf.zko.dec.com>, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com, linux-alpha@vger.kernel.org
Subject: mm->context[NR_CPUS] and pci fix check [was Re: Alpha SCSI error on 2.4.0-test11]
Message-ID: <20001201151842.C30653@athlon.random>
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random> <20001201145619.A553@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001201145619.A553@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Dec 01, 2000 at 02:56:19PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 02:56:19PM +0300, Ivan Kokshaysky wrote:
> Andrea, could you try this?

that's the right fix thanks (please send to Linus).

BTW, here is a preview of the asn SMP race fix for 2.4.x:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test12-pre2/alpha-ASN-SMP-races-2.4.x-1

I'm still left the #ifdef __alpha__ around the context[NR_CPUS] to avoid
breakage of other archs but that should be probably removed: any CPU with
per-CPU ASNs like alpha needs per-CPU per-MM context information to avoid
wasting ASNs when the task migrate CPU or with threads.

The ASN race fix for 2.4.x is implemented differently than the 2.2.x previous
version, in 2.4.x I'm avoiding the __cli, so the whole context switch runs with
irq _enabled_ as usual (unlike in the 2.2.x version). I'm also taking care not
to waste any ASN than strictly necessary while doing the race-check after the
context switch completed.

And here a new version of the 2.2.x one (I was clearing all other cpu context
from activate_context, and that wasn't necessary but it couldn't hurt so
it's a minor update):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre23/alpha-ASN-SMP-races-3

(the cli-less logic could be backported to 2.2.x but OTOH the cli way looks
simpler so more appropriate for 2.2.x)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
