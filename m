Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbUATMAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUATMAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:00:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:12502 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265391AbUATMAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:00:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Fw: Slab coruption and oops with 2.6.1-mm4
Date: 20 Jan 2004 12:51:26 +0100
Organization: SuSE Labs, Berlin
Message-ID: <877jzmn8ht.fsf@bytesex.org>
References: <20040118220051.3f3d8420.akpm@osdl.org> <20040119121546.GD5498@bytesex.org> <20040119160512.GB8321@bytesex.org> <Pine.LNX.4.53.0401200219170.293@grinch.ro>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1074599486 19472 127.0.0.1 (20 Jan 2004 11:51:26 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

caszonyi@rdslink.ro writes:

> yes
> bug is reproduceable with preempt turned off

Ok.  Makes a locking flaw less likely as those tend to trigger with
preemp or smp only.

> MCE: The hardware reports a non fatal, correctable incident occurred on
> CPU 0.
> Bank 1: 9400000000000151

That pretty much looks like it is really a hardware issue.

> > > > Slab corruption: start=c57c2000, len=4096
> >                            ^^^^^^^^

> > Who is this?  Is this allocated by bttv?  Or someone else corrupts
> > memory here?

> [ bttv load messages ]
> btcx: riscmem alloc size=2320 [2]

That isn't a fresh booted box, is it?  Please reboot the machine after
every oops and before continuing testing.  With known-corrupted memory
it can oops basically everythere and those oops reports don't help
much.

> btcx: skips line 0-9999:
> btcx: riscmem free [1]
> vbuf: init user [0x43267008+0x6c000 => 109 pages]
> btcx: riscmem alloc size=3184 [2]
> btcx: riscmem free [1]
> btcx: riscmem alloc size=2320 [2]
> btcx: skips line 0-9999:
> btcx: riscmem free [1]
> vbuf: init user [0x43267008+0x6c000 => 109 pages]
> btcx: riscmem alloc size=3184 [2]
> btcx: riscmem free [1]

That was xawtv I guess?  Now transcode starting?

> vbuf: mmap setup: 32 buffers, 2129920 bytes each
> vbuf: mmap c9cfc96c: 422fd000-463fd000 pgoff 00000000 bufs 0-31
> vbuf: init user [0x42505000+0x208000 => 520 pages]
> btcx: riscmem alloc size=7820 [2]
> btcx: riscmem alloc size=7820 [3]

Oh, doesn't print the riscmem addresses.  The blocks are two-page
sized through, so the one-page allocation slab complains about above
likely doesn't come from this.

> Unable to handle kernel paging request at virtual address 25262e29
                                                            ^^^^^^^^
strange value for a kernel address, probably some corrupted pointer.

> EIP is at videobuf_dma_free+0x33/0xc0 [video_buf]
> eax: 00000000   ebx: c45a7000   ecx: 00000208   edx: 25262e29
> esi: 00000000   edi: c817cf54   ebp: d0a35720   esp: c4135c18

in edx.  "objdump -Sd video-buf.o" should help finding the instruction
and corrospending source line, but I fear that wouldn't help much as
that isn't the source of the problem but the place where it shows up.

> btcx: riscmem free [64]
> [ ... ]
> btcx: riscmem free [3]

cleanups due to transcode being killed ...

> Unable to handle kernel paging request at virtual address 25262e29

... and here it hits the very same corrupted pointer again.

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
