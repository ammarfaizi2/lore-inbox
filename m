Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTDPVcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTDPVcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:32:24 -0400
Received: from [12.47.58.203] ([12.47.58.203]:14401 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261464AbTDPVcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:32:23 -0400
Date: Wed, 16 Apr 2003 14:43:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Matthew Wilcox <willy@debian.org>
Cc: willy@debian.org, ak@muc.de, davem@redhat.com,
       linux-kernel@vger.kernel.org, anton@samba.org, schwidefsky@de.ibm.com,
       davidm@hpl.hp.com, matthew@wil.cx, ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-Id: <20030416144311.46f32253.akpm@digeo.com>
In-Reply-To: <20030416212651.GF1505@parcelfarce.linux.theplanet.co.uk>
References: <20030415112430.GA21072@averell>
	<20030416.054521.26525548.davem@redhat.com>
	<20030416140715.GA2159@averell>
	<20030416.072638.65480350.davem@redhat.com>
	<20030416144312.GA2327@averell>
	<20030416145532.GA1505@parcelfarce.linux.theplanet.co.uk>
	<20030416150427.GA2496@averell>
	<20030416151112.GB1505@parcelfarce.linux.theplanet.co.uk>
	<20030416133539.0ac01968.akpm@digeo.com>
	<20030416212651.GF1505@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2003 21:44:12.0319 (UTC) FILETIME=[518F4AF0:01C30461]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> On Wed, Apr 16, 2003 at 01:35:39PM -0700, Andrew Morton wrote:
> > Matthew Wilcox <willy@debian.org> wrote:
> > >
> > > Jacob's would break if we hashed to different spinlocks.  But we don't, we
> > > shift right by 8, so we get the same spinlock for atomic things that are on
> > > the same "cacheline" (i think PA cachelines are actually 64 or 128 bytes,
> > > depending on model).
> > > 
> > 
> > Are you prepared to cast this in stone?
> 
> I think so.  It makes sense to me that we lock an entire cacheline for
> this kind of thing.  Indeed, locking a smaller amount would probably break
> other stuff.  Remember set_bit() et al take a pointer to an unsigned long...
> but can take a bit number > number of bits in an unsigned long.  If anything,
> we should maybe expand the range covered by a single lock to a larger amount
> than 256 bytes.

Well are we sure that the `flags' and `count' fields will always fall into
the same 256-byte range?  Wouldn't it subtly break if sizeof(struct page)
became not a multiple of eight?  Will the compiler pad it out anyway?

> How big are ext2 bitmaps, for example?

They can be 8k, rarely.  Usually 4k.  But ext2_set_bit() and friends are
nonatomic - the filesystem does the locking.

We just added the new ext2_set/clear_bit_atomic() functions which _are_
supposed to be atomic.  The architecture is passed a spinlock which it can
use for that, but only big-endian architectures are likely to need it.


