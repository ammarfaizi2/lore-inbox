Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268748AbTBZNny>; Wed, 26 Feb 2003 08:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268749AbTBZNny>; Wed, 26 Feb 2003 08:43:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50262 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S268748AbTBZNnw>; Wed, 26 Feb 2003 08:43:52 -0500
Date: Wed, 26 Feb 2003 13:55:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Jari Ruusu <jari.ruusu@pp.inet.fi>, "Adam J. Richter" <adam@yggdrasil.com>,
       Jonah Sherman <jsherman@stuy.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.5.63 - NULL pointer dereference in loop device
In-Reply-To: <20030226025216.114d4f2c.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302261332550.1614-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> > On Mon, 24 Feb 2003, Jonah Sherman wrote:
> > 
> > > I have come across a bug in the loop driver.  To reproduce this bug,
> > > simply do:
> > ...
> > I can't reproduce this, and I don't understand it: please help me!
> 
> Well I can't make it happen either now.  It went pop first time I tried it
> yesterday.

Thanks for trying again.  Strange.

> That being said, I can still trigger it by mmapping /dev/loop0 MAP_SHARED and
> dirtying it all.  That triggers the problematic PF_MEMALLOC path much more easily.
> 
> 	mem=256M
> 	losetup /dev/loop0 /dev/hda5
> 	usemem  -m 300 -f /dev/loop0
> 	<oops>

Yes, that's better, I can easily reproduce and understand that one, thanks.

> (gdb) p/x lo->lo_flags
> $3 = 0x0
> 
> Userspace is passing in lo_encrypt_type == 0, so loop_init_xfer() never calls the transfer
> init function.

Yes, Jonah enlightened me on that little detail.

I notice that Jari's loop.c, incorporating some or all of Adam's mods,
http://loop-aes.sourceforge.net/updates/2003-02-19/loop-AES/loop.c-2.5.patched.bz2
suffers from neither of these problems: it preallocates, and survives
the usemem; and has no LO_FLAGS_BH_REMAP to deceive me.

Should we reconsider switching to that version of loop.c?  You backed
it (or a relative) out of -mm a couple of months back, but given the
changes currently going on, an updated loop.c doesn't seem so wild.

I'd still expect (perhaps unjustly, testing hasn't got that far) it
to suffer from some "cp /dev/zero" problems, but no more than the
present one, since clearly Jari/Adam have given some thought there.

It does look like it's the _maintained_ version of loop.c, so a bit
disheartening to be fixing up problems on the version in the main tree.
(It would also make the recent NFS change for loop unnecessary?)

Hugh

