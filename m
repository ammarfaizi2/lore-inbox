Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTLOPUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTLOPUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:20:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:52902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263810AbTLOPUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:20:07 -0500
Date: Mon, 15 Dec 2003 07:20:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Toad <toad@amphibian.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11,
 reading an apparently duff DVD-R
In-Reply-To: <20031215135802.GA4332@amphibian.dyndns.org>
Message-ID: <Pine.LNX.4.58.0312150715410.1488@home.osdl.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Toad wrote:
>
> I got the following when trying to mount a particular DVD-R on Linux
> 2.6.0-test11, using an IDE DVD-RW drive, using SCSI emulation, with the
> preempt kernel option enabled, and taskfile I/O:
> (the middle bit was repeated several times):

ide-scsi does

        spin_lock_irqsave(&ide_lock, flags);
        while (HWGROUP(drive)->handler) {
                HWGROUP(drive)->handler = NULL;
                schedule_timeout(1);
        }

which is obvious crap. Scheduling while holding a spinlock is not a good
idea.

You could try dropping the lock over the schedule and re-aquire it
afterwards, but the comment tries to say that it is required for avoiding
new requests.

This is why ide-scsi needs a maintainer, btw - somebody who cares about
it, and actually tries to resolve the current mess.

		Linus
