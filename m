Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967821AbWK3DiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967821AbWK3DiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 22:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967825AbWK3DiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 22:38:06 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:38547 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S967821AbWK3DiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 22:38:04 -0500
Date: Thu, 30 Nov 2006 06:37:57 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Josh Triplett <josh@freedesktop.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 1/2] qrcu: "quick" srcu implementation
Message-ID: <20061130033757.GA4110@oleg>
References: <20061129235303.GA1118@oleg> <20061130015714.GC1350@oleg> <20061130024621.GL2335@us.ibm.com> <20061130032252.GA4101@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130032252.GA4101@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30, Oleg Nesterov wrote:
>
> On 11/29, Paul E. McKenney wrote:
> >
> > Hmmm...  Now I am wondering if the memory barriers inherent in the
> > __wait_event() suffice for this last barrier...  :-/  Thoughts?
> > 
> > > +	smp_mb();
> 
> Fastpath skips __wait_event(), and it is possible that the reader does
> lock/unlock between the first 'mb()' and 'if (atomic_read() == 1)'.

In fact, a slow path needs (I think) it too. We can have an unrelated
wakeup, and then the reader does unlock() before we check !atomic_read()
in the __wait_event()'s loop. The reader removes us from ->wq, in that
case finish_wait() does nothing.

Oleg.

