Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUHHNDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUHHNDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 09:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUHHNDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 09:03:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:30628 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265293AbUHHNDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 09:03:17 -0400
Date: Sun, 8 Aug 2004 14:03:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow to disable shmem.o
In-Reply-To: <m3vffulhou.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0408081248560.1443-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please no, not this half-baked patch anyway.

On Sun, 8 Aug 2004, Andi Kleen wrote:
> 
> This patch allows to not compile mm/shmem.o in. It is now dependent on
> CONFIG_TMPFS, which is the main user.

Well, one of its users, yes.

> This allows shrinking the kernel a bit more when needed.

Good.

> Disabling TMPFS disables the mmap
> MAP_ANONYMOUS|MAP_SHARED functionality now. That's ok, because Linux
> 2.2 also didn't have it iirc.

That's not an argument for throwing out support for POSIX/SuS
functionality which 2.4 has supported all along.  But never mind,
embedded may not need it, and your defaults are the right way round.

> To make sure this doesn't happen by
> accident I made the TMPFS configuration dependent on CONFIG_EMBEDDED.
> This means a normal configuration enables TMPFS, which is ok 
> since it is only minor additional overhead to shmem.o and also quite
> useful for shared memory.

At the least you need to add a dependency on CONFIG_SYSVIPC.
And you shouldn't disable standard functionality without
saying so in the Kconfig help.

You're completely changing the meaning and configurability of
CONFIG_TMPFS.  Perhaps it's not a useful config option any more
(too often needed "y", too little saved by "n"), and yours is
more useful.  But if you want to go this way, you must change
its name and Documentation and #ifdefs too.

I do agree that mm/shmem.o is larger (did someone at the back say
"bloated"?) than we'd wish, that embedded in particular would like
it smaller, and embedded might have no need to support SysV IPC
and Posix SHM and shared anonymous and tmpfs.

But I prefer Matt's tiny tiny-shmem.c which does support all those,
using ramfs instead, and says in Kconfig what it's doing.
But perhaps you're wanting to avoid ramfs too?

A lot (but less than I once imagined) of the overhead in mm/shmem.o
does come from its support for swap.  I've not been eager to pepper
it with #ifdef CONFIG_SWAPs; but if there's a real demand for that
I could give it a try (while abstracting away the #ifdefs as much
as possible).

Hugh

