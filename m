Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131038AbQLOTkf>; Fri, 15 Dec 2000 14:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLOTk0>; Fri, 15 Dec 2000 14:40:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:52302 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131051AbQLOTkG>; Fri, 15 Dec 2000 14:40:06 -0500
Date: Fri, 15 Dec 2000 20:09:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: J Sloan <jjs@toyota.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lkml]Re: VM problems still in 2.2.18
Message-ID: <20001215200906.H17781@inspiron.random>
In-Reply-To: <20001215192207.E17781@inspiron.random> <E146zsJ-0001fT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E146zsJ-0001fT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 15, 2000 at 06:46:32PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 06:46:32PM +0000, Alan Cox wrote:
> so the actual problem is either - the returning 1 when it is the wrong answer
> - or the failure to block somewhere else (where its safe) based on a kpiod
> maintained semaphore ?

The problem is not to find a safe place where to wait, the problem is to know
"when" we can block. That's the only thing current->fs_locks tells us. Sometime
we simply can't wait because I/O can't start until we return (it would deadlock
regardless we wait on a kpiod semaphore or in down(i_sem) ourselfs).

Once we know "if" we can't wait or not the whole point of kpiod is lost
as kpiod exists only because we didn't know that and so we were not able
to wait.

Now we know when we can block so we can run f_ops->write ourselfs that's also
more efficient in terms of both performance and also memory pressure during
swap of course.

> I assume thats not an issue to reiserfs ?

As said reiserfs AFIK didn't need any change, so only VFS is using
fs_down/fs_up from the point of view of reiserfs.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
