Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbQKABbE>; Tue, 31 Oct 2000 20:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131006AbQKABaz>; Tue, 31 Oct 2000 20:30:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41065 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130794AbQKABat>; Tue, 31 Oct 2000 20:30:49 -0500
Date: Wed, 1 Nov 2000 02:30:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001101023010.G13422@athlon.random>
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39FF49C8.475C2EA7@timpanogas.org>; from jmerkey@timpanogas.org on Tue, Oct 31, 2000 at 03:38:00PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Larry McVoy wrote:
>> Are there processes with virtual memory?
On Tue, Oct 31, 2000 at 03:38:00PM -0700, Jeff V. Merkey wrote:
> Yes.

If that stack switch is your context switch then you share the same VM for all
tasks. I think the above answer "yes" just means you have pagetables so you can
swap, but you _must_ miss memory protection across different processes.  That
also mean any program can corrupt the memory of all the other programs.  Even
on the Palm that's a showstopper limitation (and on the Palm that's an hardware
limitation, not a software deficiency of PalmOS).

That will never happen in linux, nor in windows, nor internally to kde2. It
happens in uclinux to deal with hardware without MMU. And infact the agenda
uses mips with memory protection even on a organizer with obvious advantages.

Just think kde2 could have all the kde app sharing the same VM skipping all the
tlb flushes by simply using clone instead of fork. Guess why they aren't doing
that? And even if they would do that, the first bug would _only_ destabilize
kde, so kill it and restart and everything else will keep running fine (you
don't even need to kill X). With your ring 0 linux _everything_ will crash, not
just kde.

And on sane architectures like alpha you don't even need to flush the TLB
during "real" context switching so all your worry to share the same VM for
everything is almost irrelevant there since it happens all the time anyways
(until you overflow the available ASN bits that takes a lots of forks to
happen).

So IMHO for you it's much saner to move all your performance critical code into
kernel space (that will be just stability-risky enough as khttpd and tux are).
In 2.4.x that will avoid all the cr3 reloads and that will be enough as what
you really care during fileserving are the copies that you must avoid.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
