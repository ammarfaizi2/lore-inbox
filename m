Return-Path: <linux-kernel-owner+w=401wt.eu-S932832AbWL1Jwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbWL1Jwc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbWL1Jwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:52:32 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:44131 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932832AbWL1Jwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:52:31 -0500
Date: Thu, 28 Dec 2006 12:50:44 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061228095044.GA26314@2ka.mipt.ru>
References: <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru> <4564CE00.9030904@redhat.com> <20061123122225.GD20294@2ka.mipt.ru> <456605EA.5060601@redhat.com> <20061124105856.GE13600@2ka.mipt.ru> <456B2D2B.9080502@redhat.com> <20061128101327.GE15083@2ka.mipt.ru> <4592DB7E.4090100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4592DB7E.4090100@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 28 Dec 2006 12:50:58 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 12:45:50PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> > Why do we want to inject _ready_ event, when it is possible to mark
> > event as ready and wakeup thread parked in syscall?
> 
> Going back to this old one:
> 
> How do you want to mark an event ready if you don't want to introduce
> yet another layer of data structures?  The event notification happens
> through entries in the ring buffer.  Userlevel code should never add
> anything to the ring buffer directly, this would mean huge
> synchronization problems.  Yes, one could add additional data structures
> accompanying the ring buffer which can specify userlevel-generated
> events.  But this is a) clumsy and b) a pain to use when the same ring
> buffer is used in multiple threads (you'd have to have another shared
> memory segment).
> 
> It's much cleaner if the userlevel code can get the kernel to inject a
> userlevel-generated event.  This is the equivalent of userlevel code
> generating a signal with kill().

Existing possibility to mark event as ready works following way:
event is queued into storage queue (socket, inode or some other queue),
when readiness condition becomes true, event is queued into ready queue
(although it is still in the storage queueu). It happens completely
asynchronosu to _any_ kind of userspace processing.
When userspace calls apropriate syscall, event is being copied into ring
buffer.

Thus userspace readiness will just mark event as ready, i.e. it queues
event into ready queue, so later usersapce will callsyscall to actually
get the event.

When one thread is parked in the syscall and there are _no_ events
which should be marked as ready (for example only sockets are there, and
it is not a good idea to wakeup the whole socket processing state machine), 
then there is no possibility to receive such event (although it is
possible to interrupt and break syscall).

So, according to injecting ready events, it can be done - just an
addition of special flag which will force kevent core to move event into
ready queue immediately. In this case userspace can event prepare a
needed event (like signal event) and deliver it to process, so it will
think (only from kevent point of view) that real signal has been arrived.

I will also add special type of events - userspace events - which will
not have empty callbacks, which will be intended to use for user-defined
way (i.e. for inter thread communications).

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
> 



-- 
	Evgeniy Polyakov
