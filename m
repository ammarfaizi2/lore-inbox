Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWAILPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWAILPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 06:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAILPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 06:15:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10371 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932228AbWAILPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 06:15:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060108000021.588c6f5f.akpm@osdl.org> 
References: <20060108000021.588c6f5f.akpm@osdl.org>  <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com> <20060107143722.25afd85d.akpm@osdl.org> <20060108074356.GM26499@krispykreme> 
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, jes@trained-monkey.org,
       rmk+lkml@arm.linux.org.uk, ak@suse.de, linux-kernel@vger.kernel.org,
       hch@infradead.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       linuxppc64-dev@ozlabs.org, mingo@elte.hu, nico@cam.org, oleg@tv-sign.ru,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org
Subject: Re: PowerPC fastpaths for mutex subsystem 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 09 Jan 2006 11:13:52 +0000
Message-ID: <923.1136805232@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > Wasnt most of the x86 mutex gain a result of going from fair to unfair
> > operation? The current ppc64 semaphores are unfair.
> > 
> 
> What's "unfair"?  Mutexes are FIFO, as are x86 semaphores.

No, strictly Ingo's mutexes are neither completely fair nor completely FIFO.
It's possible for a process to jump the queue because unlock() always sets the
counter back to 1 before waking up the process at the front of the queue. This
means that the lock() fastpath in another process may steal the mutex out of
sequence before the wakee has a chance to grab it.

I'm not 100% convinced that x86 counting semaphores are completely fair or
completely FIFO. It's possible that they are because up() never arbitrarily
sets the count back to >0.

R/W semaphores are completely fair, but only as completely FIFO as the unfair
spinlocks permit. This is because it's much easier to guarantee their behaviour
(writer-starvation is a real problem with unfair rwsems). I have a simple
implementation of totally fair spinlocks for x86 which would also work on
anything that can emulate XADD, but I don't think it's worth the trouble.

However, for Ingo's mutexes, I suspect this queue-jumping feature is
sufficiently low probability that we can ignore it. It is theoretically
possible to induce livelock, but in reality I think it extremely unlikely to
happen for any significant length of time.

David
