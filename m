Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270233AbRHISNT>; Thu, 9 Aug 2001 14:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270528AbRHISNK>; Thu, 9 Aug 2001 14:13:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12621 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270233AbRHISM6>; Thu, 9 Aug 2001 14:12:58 -0400
Date: Thu, 9 Aug 2001 19:04:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
Message-ID: <20010809190434.P4895@athlon.random>
In-Reply-To: <20010809183634.K4895@athlon.random> <Pine.LNX.3.96.1010809172609.6560B-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010809172609.6560B-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Thu, Aug 09, 2001 at 05:33:27PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 05:33:27PM +0200, Bjorn Wesen wrote:
> I realised I'm not entirely sure on if it's ok to do such "dangerous"
> functions inside, say, tq_immediate using queue_task even ? Doesn't that
> run in the interrupt context also, upon exit of the interrupt before going
> back ?

Yes it does, also you should use tasklets, never tq_immediate, these days
(tasklets can run in parallel and they're serialized only against
themself).

> IOW I want the irq to "trigger" the freeing of the iovecs but it's ok if
> it's done later, as long as it's done without any races :)

Your design looks suspect, but you can do that safely (at least as far
as vfree is concerned) with keventd's schedule_task().

> BTW how does vfree cope with not walking all tasks pgd's to remove the
> relevant pte's ? Doesn't that give exactly this kind of problem ? (pte's

vfree as usual walks the pgd/pmd to reach the pte. It knows the
pgd/pmd/pte cannot go away and it serlializes against vmalloc with the
vmlist_lock, it sounds ok.

Andrea
