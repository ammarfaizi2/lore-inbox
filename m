Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbULXX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbULXX2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbULXX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 18:28:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:52167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261455AbULXX2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 18:28:42 -0500
Date: Fri, 24 Dec 2004 15:28:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jim Nelson <james4765@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: A general question on SMP-safe driver code.
In-Reply-To: <41CC9F2A.9080905@verizon.net>
Message-ID: <Pine.LNX.4.58.0412241522110.2353@ppc970.osdl.org>
References: <41CC9F2A.9080905@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Dec 2004, Jim Nelson wrote:
> 
> work if all other areas of the driver that send commands to the board also try for 
> the semaphore?

The most common reason _not_ to use a semaphore, but a single simple 
spinlock is:
 - spinlocks are generally faster. 
 - you can't use semaphores to protect against interrupts, as interrupts 
   cannot take semaphores.

> Is there an easier way of doing this?

The simplest approach tends to be to just have a single spinlock per
driver (or, if the driver can drive multiple independent ports, one per
port).

The only advantage of semaphores is that you can do user accesses and you 
can sleep during them, but if you're looking at converting a driver that 
used to just depend on the global interrupt lock, that shouldn't be an 
issue anyway. Generally, the semaphores are more useful at a higher level 
(ie there is almost never any reason to protect actual _IO_ accesses with 
a semaphore).

The biggest problem with converting old-style irq locks into spinlocks
tends to be that the irq locking allowed nesting (though the use of
save_flags/restore_flags), and normal spinlocks don't.

You can make your own nesting spinlocks, of course, but the reason there
aren't any standard nesting locks in the kernel is that in pretty much all
cases you can trivially avoid the nesting by just moving the lock
sufficiently far out, or just re-organizing the source a bit.

			Linus
