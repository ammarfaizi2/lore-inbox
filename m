Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131178AbQL3Tkb>; Sat, 30 Dec 2000 14:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135434AbQL3TkV>; Sat, 30 Dec 2000 14:40:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45065 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131178AbQL3TkQ>; Sat, 30 Dec 2000 14:40:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.2.19pre3 and poor reponse to RT-scheduled processes?
Date: 30 Dec 2000 11:09:24 -0800
Organization: Transmeta Corporation
Message-ID: <92lbt4$rd$1@penguin.transmeta.com>
In-Reply-To: <20001229161927.A560@xi.linuxpower.cx> <200012292154.QAA17527@ninigret.metatel.office> <20001230191639.E9332@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001230191639.E9332@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>On Fri, Dec 29, 2000 at 04:54:23PM -0500, Rafal Boni wrote:
>> Now my box behaves much more reasonably... I'll just have to beat harder
>> on it and see what happens.
>
>Another thing: while writing to disk if you want low latency readers you can
>do:
>
>	elvtune -r 1 /dev/hd[abcd]
>
>The 1/2 seconds stalls you see could be just because of applications that waits
>I/O synchronously while the elevator is reodering I/O requests (and even if the
>elevator wouldn't reorder anything the new requests would go to the end of the
>I/O queue so they would have some higher latency anyways).

That sounds like too long a stall to be due to elevator ordering except
with some _really_ unlucky access patterns (or with slow disks). 

There are other, equally likely, candidates for these kinds of stalls:

 - filesystem locks. Especially the ext2 superblock lock. You can easily
   hit this one, as some ext2 functions actually do a lot of IO while
   holding the lock.

 - synchronously waiting for bdflush with balance_dirty_buffers().
   Especially mixed with the above.

A mixture of the two above will bascally stall the whole machine: almost
any non-cached file access ends up waiting for the superblock lock and
bdflush, and it can easily get quite unfair.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
