Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbQK3V60>; Thu, 30 Nov 2000 16:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129426AbQK3V6Q>; Thu, 30 Nov 2000 16:58:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15682 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129740AbQK3V6D>; Thu, 30 Nov 2000 16:58:03 -0500
Date: Thu, 30 Nov 2000 22:27:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: V Ganesh <ganesh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: beware of add_waitqueue/waitqueue_active
Message-ID: <20001130222725.F18804@athlon.random>
In-Reply-To: <200011301332.TAA00277@vxindia.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011301332.TAA00277@vxindia.veritas.com>; from ganesh@veritas.com on Thu, Nov 30, 2000 at 07:02:56PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 07:02:56PM +0530, V Ganesh wrote:
> 3. add_wait_queue adds this process to the waitqueue. but all the writes
>    are in write-buffers and have not gone down to cache/memory yet.
> 4. PageLocked() finds that the page is locked.

Right.

> [..] speculative execution
> of PageLocked() even before add_wait_queue returns [..]

Right.

Both could happen because of the new spin_unlock implementation that doesn't
take anymore the lock on the bus:

	#define spin_unlock_string \
		"movb $1,%0"

With the previous `lock ; btrl' 4) couldn't happen with pending
writes on the write buffer because spin_unlock was a full barrier too...

Alpha was safe because it has to imply an mb() in spin_unlock (but
sparc64 was hurted too for example).

As you say the problematic construct is not used anymore into 2.4.0-test12-pre2
in filemap.c so such deadlock can't happen anymore but it's been useful that
you pointing out the problem, thanks.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
