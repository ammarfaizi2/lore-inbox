Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbTH1MBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTH1MBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:01:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64134 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263939AbTH1MBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:01:43 -0400
Date: Thu, 28 Aug 2003 13:01:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Timo Sirainen <tss@iki.fi>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828120135.GA6800@mail.jlokier.co.uk>
References: <MDEHLPKNGKAHNMBLJOLKEEJEFLAA.davids@webmaster.com> <1062066411.1451.319.camel@hurina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062066411.1451.319.camel@hurina>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Sirainen wrote:
> Reorder on per-byte basis? Per-page/block would still be acceptable.

The _CPUs_ can reorder on a per-byte basis, on a multiprocessor.  It
has nothing to do with the kernel.

> Anyway, the alternative would be shared mmap()ed file. You can trust
> 32bit memory updates to be atomic, right?

Atomic yes (if aligned), weakly ordered though.

> Or what about: write("12"), fsync(), write("12")? Is it still possible
> for read() to return "1x1x"?

Yes it is possible, in principle.

This is what happens: the writing CPU writes "1", "2" in order.  The
reading CPU reads bytes 1, 3 before the writes are
observed and bytes 0, 2 after.  The CPU can do this.

The kernel doesn't prevent this, because it doesn't hold any exclusive
lock between the writer and reader during the data transfers.
Furthermore the kernel transfers a byte at a time, on some
architecture (including x86), if any buffer is not aligned.

It is very unlikely to return "1x1x", but you should know it is not
architecturally impossible.  Given your incomplete knowledge of every
architectural quirk, it is more likely to occur than an MD5 collision.

On 32-bit aligned atomicity: if the block of 4 bytes is aligned in
memory, then with shared mmap you will only see whole words
transferred because all (current) Linux SMP-capable architectures
offer 32 bit atomicity.  It is not a very nice assumption: it doesn't
hold for 16 bits or 64 bits, and may not hold for a future 64 bit
architecture.  Keep in mind the words stay whole, but multiple words
are read out of order.

With read() and write(), even aligned 32-bit words don't work.  On
some 64-bit architectures, a 32-bit word read() will be issued as 4
byte reads at the machine level, with weak memory ordering.  (I'm
reading Alpha and IA64 __copy_user right now, and they both do that).

Enjoy :)
-- Jamie
