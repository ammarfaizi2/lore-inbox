Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbWH2S5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbWH2S5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWH2S5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:57:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58271 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965251AbWH2S5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:57:07 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608292033.25194.ak@suse.de> 
References: <200608292033.25194.ak@suse.de>  <200608292018.01602.ak@suse.de> <Pine.LNX.4.64.0608291033380.19174@schroedinger.engr.sgi.com> <809.1156876259@warthog.cambridge.redhat.com> 
To: Andi Kleen <ak@suse.de>
Cc: David Howells <dhowells@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 19:56:52 +0100
Message-ID: <3450.1156877812@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:

> > > BTW maybe it would be a good idea to switch the wait list to a hlist,
> > > then the last user in the queue wouldn't need to 
> > > touch the cache line of the head. Or maybe even a single linked
> > > list then some more cache bounces might be avoidable.
> > 
> > You need a list_head to get O(1) push at one end and O(1) pop at the other.
> 
> The poper should know its node address already because it's on its own stack.

No.  The popper (__rwsem_do_wake) runs in the context of up_xxxx(), not
down_xxxx().  Remember: up() may need to wake up several processes if there's
a batch of readers at the front of the queue.

Remember also: rwsems, unlike mutexes, are completely fair.

> > In addition a singly-linked list makes interruptible ops non-O(1) also.
> 
> When they are interrupted I guess? Hardly a problem to make that slower.

Currently interruptible rwsems are not available, but that may change, and
whilst I agree making it slower probably isn't a problem, it's still a point
that has to be considered.

David
