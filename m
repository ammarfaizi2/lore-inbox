Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTBCJUK>; Mon, 3 Feb 2003 04:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTBCJUK>; Mon, 3 Feb 2003 04:20:10 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:40353 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261908AbTBCJUJ>; Mon, 3 Feb 2003 04:20:09 -0500
Date: Mon, 3 Feb 2003 10:29:38 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
In-Reply-To: <20030202172005.25758831.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302031015290.11750-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003, Andrew Morton wrote:

> Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
> >
> > > void wait_and_rw_block(...)
> > > {
> > > 	wait_on_buffer(bh);
> > > 	ll_rw_block(...);
> > > }
> >
> > It would fail if other CPU submits IO with ll_rw_block after
> > wait_on_buffer but before ll_rw_block.
>
> In that case, the caller's data gets written anyway, and the caller will wait
> upon the I/O which the other CPU started.  So the ll_rw_block() behaviour is
> appropriate.

You are partly right, but it suffers from smp memory ordering bug:

CPU 1
write data to buffer (but they are
in cpu-local buffer and do not go
to the bus)

tests buffer_locked in
wait_and_rw_block->wait_on_buffer,
sees unlocked

					CPU 2
					starts to write the buffer, but
					does not see data written by CPU 1
					yet

cpu flushes data to bus
calls ll_rw_block, it sees
buffer_locked, exits.
new data are lost.

There should be smp_mb(); before wait_on_buffer in wait_and_rw_block.


BTW. why don't you just patch ll_rw_block so that it waits if it sees a
locked buffer -- you get much cleaner code with only one test for locked
buffer.

Mikulas

