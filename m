Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278565AbRJ3Wve>; Tue, 30 Oct 2001 17:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278551AbRJ3WvY>; Tue, 30 Oct 2001 17:51:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56077 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278565AbRJ3WvL>; Tue, 30 Oct 2001 17:51:11 -0500
Date: Tue, 30 Oct 2001 14:49:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: pre5 VM livelock
In-Reply-To: <3BDF1999.CAF5D101@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110301436550.1188-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Jeff Garzik wrote:
>
> Key symptoms:  Free swab 0Kb according to sysrq-m, and several processes
> in run state according to sysrq-t.

What are the stack traces for the processes (ie "Ctrl-ScrollLock")

It actually _sounds_ like you're out-of-memory for real, you have no swap
left, and you have only four pages in the swap cache which implies that
the system has tried very very hard to get rid of the pages you _did_
write to swap.

That, in turn, sounds like a memory leak. You've got 38578 pages on the
inactive list (300MB worth of memory).

The fact that they _are_ on the inactive list means that the kernel
certainly sees them. They just aren't freeable for some reason - possibly
because they are mapped and dirty in some process (and you're out of
swap so the kernel cannot put them anywhere). And if the oom() killer
doesn't react, you're sol.

Question: did you have some big process that you tried to test the VM
with? Did you expect the oom killer to kill it?

OR there is a leak inside the kernel, where we forget to decrement the
count for certain pages in certain circumstances. Not unlikely.

		Linus

