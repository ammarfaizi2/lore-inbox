Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315624AbSENLwL>; Tue, 14 May 2002 07:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSENLwK>; Tue, 14 May 2002 07:52:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17171 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315624AbSENLv4>; Tue, 14 May 2002 07:51:56 -0400
Subject: Re: [PATCH] 2.5.15 IDE 61
To: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 14 May 2002 13:10:58 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        nconway.list@ukaea.org.uk (Neil Conway), linux-kernel@vger.kernel.org
In-Reply-To: <20020514123830.A18118@flint.arm.linux.org.uk> from "Russell King" at May 14, 2002 12:38:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177b8s-0007lm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something here smells fishy here - you shouldn't hold a spinlock for a long
> time (a long time === spinlocking, setting up the drive, possibly scheduling,

You can't hold it while scheduling or you may deadlock

> transferring data, getting status, then unlocking).  Also, remember,
> spinlocks are no-ops on uniprocessor systems.

Its possible it can be done with a semaphore but the whole business is
pretty tricky. IDE command processing occurs a fair bit at interrupt level
and you definitely don't want to block interrupts for long periods.

If the queue abstraction is right then the block layer should do all the
synchronization work that is required. It may cost a few cycles on the odd
case you can do overlapped command setup but that versus a nasty locking
mess its got to be better to lose those few cycles.

I don't even Martin here, the ide locking is currently utterly vile
