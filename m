Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWHBFFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWHBFFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWHBFFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:05:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34244
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751184AbWHBFFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:05:32 -0400
Date: Tue, 01 Aug 2006 22:05:38 -0700 (PDT)
Message-Id: <20060801.220538.89280517.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: frequent slab corruption (since a long time)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060802021617.GH22589@redhat.com>
References: <20060802021617.GH22589@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Tue, 1 Aug 2006 22:16:17 -0400

> Anyone have any clues where that value could be coming from?

Some of the dumps in there looks like ethernet headers.  For example,
in comment #7:

000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
010: 5a 5a 00 11 85 6a 0f ef 00 e0 52 cf 6c 00 08 00
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That looks like an ethernet header for an IPv4 packet to ethernet
destination MAC 00:11:85:6a:0f:ef from ethernet source MAC
00:e0:52:cf:6c:00

But this chunk is OK since we are looking at a neighbouring
INUSE object.

The reocurring corruption:

0b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
0c0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

is less identifyable.  Although tg3_alloc_rx_skb() shows up
consistently in the neighbouring objects, the actually
corrupted piece is marked by release_mem() which is the
TTY layer.

The corruption is always a 32-bit 0xffffffff followed by
a 32-bit 0x00000000, 12 bytes into the object.

If it's sitting next to RX ethernet packets, it's probably
something in the vacinity of 1500+ bytes in size as that's
how large the RX skb data areas will be that the tg3 driver
allocates unless it is in Jumbo MTU mode.

By default, do_tty_write() will use a chunk size of 2048 for the write
buffer, tty->write_buf, and this is freed up as part of release_mem()
processing.

Another possibility, is the struct tty_struct itself since that is a
sizable structure too.  And this theory is supported by
alloc_tty_struct() being in some of the triggering backtraces.

Perhaps a TTY refcounting problem or race condition of some sort.

What is 12-bytes into the tty_struct on x86?  The struct tty_ldisc,
"ldisc" is.  Oddly enough, this doesn't match up, since we'd expect
TTY_LDISC_MAGIC (0x5403) and instead we see 0xffffffff there.
Also, after the magic, we'd expect the address of the "n_tty"
string in tty_ldisc_N_TTY to show up in the next word, instead
we find NULL (0x00000000) there.

Something is clobbering the ldisc member of this free'd tty_struct is
seems.  Maybe there is some problem with ldisc refcounting.

