Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWE3T6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWE3T6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWE3T6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:58:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4322 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932456AbWE3T6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:58:46 -0400
Date: Tue, 30 May 2006 21:59:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: 2.6.17-rc5-mm1
Message-ID: <20060530195902.GD22742@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {in-hardirq-W} -> {hardirq-on-W} usage.

sorry - the messages are indeed cryptic, partly because there are lots 
of illegal state transitions and the printout is atomated, and partly to 
keep the already sizable lockdep printouts as compact as possible.

What happened here is that a lock (-type) that had the {in-hardirq-W} 
state bit set, and lockdep observed an event that also sets the 
{hardirq-on-W} state bit: illegal.

here is a rough translation of the usage history state bits:

 {in-hardirq-W}: lock was exclusively acquired in hardirq context
 {in-hardirq-R}: lock was read-acquired in hardirq context
 {in-softirq-W}: lock was exclusively acquired in softirq context
 {in-softirq-R}: lock was read-acquired in softirq context
 {hardirq-on-W}: lock was held exclusively with hardirqs enabled
 {hardirq-on-R}: lock was read-held with hardirqs enabled
 {softirq-on-W}: lock was held exclusively with softirqs enabled
 {softirq-on-R}: lock was read-held with softirqs enabled

to interpret the lock state at a glance, there's an even shorter 
representation of the state bits:

 (&base->lock#2){++..}
                 ^^^^

'+' : irq-safe [lock was taken in irq context]
'-' : irq-unsafe [lock was taken with irqs enabled]
'.' : unknown [lock has not yet become irq-safe or irq-unsafe]

'?' : read-locked with both hardirq context and with irqs enabled

the first character is for exclusive-locking in hardirqs, the second for 
exclusive-locking in softirqs, the third is for read-locking in 
hardirqs, the fourth is for read-locking in softirqs.

this means that the "{++..}" sequence shows that this lock is 
hardirq-safe and softirq-safe, and was never read-locked. [the later one 
is not surprising from a spinlock - but lockdep doesnt know that it's a 
spinlock, it deals with all lock types in a unified way]

(more details about the usage history state bits are in 
Documentation/lockdep-design.txt and in include/linux/lockdep.h)

	Ingo
