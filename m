Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTKIRnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTKIRnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:43:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:62896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262729AbTKIRnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:43:35 -0500
Date: Sun, 9 Nov 2003 09:43:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: crashme on ARM - unkillable processes
In-Reply-To: <20031109114322.A29553@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0311090927350.1648-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Nov 2003, Russell King wrote:
> 
> Looking at next_signal(), the kernel treats signals 1-8 as having higher
> priority than signal 9.  Since we only ever dequeue one signal on return
> to user space, we always find the SIGILL before SIGKILL, and the kill
> signal remains indefinitely queued.

Interesting. I wonder why it shows up only now. We've run crashme as a 
sanity-test before, and I don't think this is a new thing..

[ Duh dumm.. ]

Ok, I know... I think we used to queue up _all_ the signals onto the stack
frame before. We don't do that any more, and back when we did it we'd
notice that one of the signals was deadly, and just kill the process.

We can't do that any more, because with thread-shared signals one thread 
should _not_ try to hog all pending signals.

This is definitely a bug. I'd be inclined to just special-case SIGKILL in 
next_signal(). Better ideas?

		Linus

