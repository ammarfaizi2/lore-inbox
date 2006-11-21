Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030827AbWKUKUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030827AbWKUKUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030828AbWKUKUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:20:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39599 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030827AbWKUKUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:20:00 -0500
Date: Tue, 21 Nov 2006 10:06:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] WorkStruct: Shrink work_struct by two thirds
Message-ID: <20061121100642.GA580@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <1164040326.5700.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164040326.5700.46.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 11:32:06AM -0500, Trond Myklebust wrote:
> On Mon, 2006-11-20 at 14:27 +0000, David Howells wrote:
> > 
> > The workqueue struct is huge, and this limits it's usefulness.  On a 64-bit
> > architecture it's nearly 100 bytes in size, of which the timer_list is half.
> > These patches shrink work_struct by 8 of the 12 words it ordinarily consumes.
> > This is done by:
> > 
> >  (1) Splitting the timer out so that delayable work items are defined by a
> >      separate structure which incorporates a basic work_struct and a timer.
> 
> Why not simply add a timer argument to 'queue_delayed_work()' and
> 'cancel_delayed_work()'? That may allow you to reuse an existing timer
> struct if you already have it embedded somewhere else.

I doubt we can really reuse an existing timer, but this seems to be
the cleanest way despite that.  Let's follow the philosophy of builing
from small building blocks for our kernel APIs aswell.

Doing it this way will also ease the transition, we can the new API
that takes a timer first and then once all old queue_delayed_work users
are gone remove that API and the timer from work_struct.

As a second benefit it also makes handling the case of having both delayed
and immediate items on a single workqueue trivial.
