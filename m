Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUA2Tzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266350AbUA2Tzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:55:38 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38746 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266337AbUA2Tzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:55:36 -0500
Date: Thu, 29 Jan 2004 19:55:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: SysV shm device number
In-Reply-To: <1075388721.15653.124.camel@cube>
Message-ID: <Pine.LNX.4.44.0401291931100.9070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jan 2004, Albert Cahalan wrote:
> I'd like to reliably identify SysV shared memory
> in the /proc/*/maps files. On one system, the entries
> look like this:
> 
> 40014000-40015000 r--s 00000000 00:04 0          /SYSV00000000 (deleted)
> 40015000-40016000 rw-s 00000000 00:04 32769      /SYSV000000ff (deleted)
> 
> On my system, they look like this:
> 
> 30016000-30017000 r--s 00000000 00:06 870318096  /SYSV00000000\040(deleted)
> 30017000-30018000 rw-s 00000000 00:06 870350865  /SYSV000000ff\040(deleted)
> 
> So the key number is in the name, and the shmid
> number is the inode number. The device major number
> is 0, and the device minor number is 4 or 6.

I'm sure you don't mean to rely on it being 4 or 6: it just depends
on where in the init sequence init_tmpfs gets called, who else has
already allocated anon supers before it.

> Other than by creating my own SysV shared memory,
> is there a way to tell what the minor number should be?

I can't think of a better way.  I presume you're focussing on that
minor number because you don't want to be fooled by an mmap of a
regular file at root named /SYSVnnnnnnnn.  Beware that a shared
writable mmap of /dev/zero (or MAP_ANONYMOUS) also appears on
that major:minor, but named /dev/zero (deleted).

You might prefer to identify the minor number that way, via an
mmap(0, 1, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0),
I can't see any reason for their minors to diverge (so long as
minors make any sense at all here).

Hugh

