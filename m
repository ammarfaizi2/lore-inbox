Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbQLOSxk>; Fri, 15 Dec 2000 13:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130848AbQLOSxV>; Fri, 15 Dec 2000 13:53:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16195 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129585AbQLOSxO>; Fri, 15 Dec 2000 13:53:14 -0500
Date: Fri, 15 Dec 2000 19:22:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: J Sloan <jjs@toyota.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lkml]Re: VM problems still in 2.2.18
Message-ID: <20001215192207.E17781@inspiron.random>
In-Reply-To: <20001215152908.M11505@inspiron.random> <E146z6f-0001ZD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E146z6f-0001ZD-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 15, 2000 at 05:57:18PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 05:57:18PM +0000, Alan Cox wrote:
> How hard is it to seperate losing kpiod (optimisation) from the MAP_SHARED 
> changes ? I am assuming they are two seperate issues, possibly wrongly

Losing kpiod isn't an optimization ;(. Losing kpiod is the MAP_SHARED bugfix.

The problem was:

o	swap_out
o	wants to flush a MAP_SHARED dirty page to disk
o	so allocate kpiod-struct
o	sumbit the page-flush request to kpiod
o	don't wait I/O completion to avoid deadlocking on the i_sem
o	swap_out returns 1 and memory balancing code so thinks we did progress
	in freeing memory and goes to allocate memory from the freelist
	without waiting I/O completion
o	repeat N times the above

o	in the meantime kpiod has a big queue but it's blocked slowly writing
	those pages to disk
o	while it writes a few pages swap_out floods again the queue
	without waiting and it empties the freelist (task killed)

The problem was the lack of write throttling due the kpiod async-only nature.

> Providing no inode semaphore is upped from a different task , which seems
> currently quite a valid legal thing to do (ditto doing the up on completion of
> something in bh or irq context)

Yes, the same `current' context must run the down/up pair of calls and as you
said it is legal to rely on it on all the places it's used.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
