Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVLYWzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVLYWzj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 17:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVLYWzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 17:55:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54705 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750950AbVLYWzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 17:55:39 -0500
Date: Sun, 25 Dec 2005 23:54:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051225225446.GA10877@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org> <200512251708.16483.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512251708.16483.zippel@linux-m68k.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > c) semaphores are total overkill for 99% percent of the users.  Remember
> > this thing about optimizing for the common case?
> 
> [...] I also haven't hardly seen any discussion about why semaphores 
> the way they are. Linus did suspect there is a wakeup bug in the 
> semaphore, but there was no conclusive followup to that.

no conclusive follow-up because ... they are too complex for people to 
answer such questions off the cuff? Something so frequently used in 
trivial ways should have the complexity of that typical use, not the 
complexity of the theoretical use. There is no problem with semaphores, 
other than that they are not being used as semaphores all that often.

for which i think there is a rather simple practical reason: if i want 
to control a counted resource within the kernel, it is rarely the 
simplest solution to use a semaphore for it, because a semaphore cannot 
be used to protect data structures in the 'resource is available' stage 
[i.e. when the semaphore count is above zero]. It does decrement the 
counter atomically, but that is just half of the job i have to do.

to control (allocate/free) the resource i _have to_ add some other 
locking mechanism anyway in most cases (a spinlock most likely, to 
protect the internal list and other internal state) - at which point 
it's simpler and faster to simply add a counter and a waitqueue to those 
existing internal variables, than to add a separate locking object to 
around (or within) the whole construct.

semaphores would be nice in theory, if there was a way to attach the 
'decrement counter atomically' operation to another set of atomic ops, 
like list_del() or list_add(), making the whole thing transactional.  
[this would also be a wholly new API, so it only applies to semaphores 
as a concept, not our actual semaphore incarnation] So i see the 
theoretical beauty of semaphores, but in practice, CPUs force us to work 
with much simpler constructs.

there are some exceptions: e.g. when the resource is _nothing else_ but 
a count.

	Ingo
