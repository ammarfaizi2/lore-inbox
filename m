Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163344AbWLGVHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163344AbWLGVHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163345AbWLGVHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:07:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39417 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163350AbWLGVHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:07:09 -0500
Date: Thu, 7 Dec 2006 13:06:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than
 cmpxchg()
Message-Id: <20061207130630.6c1a8d32.akpm@osdl.org>
In-Reply-To: <639.1165521999@redhat.com>
References: <20061207085409.228016a2.akpm@osdl.org>
	<20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com>
	<20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com>
	<639.1165521999@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 20:06:39 +0000
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > and we can assume (and ensure) that a failing test_and_set_bit() will not
> > write to the affected word at all.
> 
> You may not assume that; and indeed that is not so in the generic
> spinlock-based bitops or ARM pre-v6 or PA-RISC or sparc32 or ...

Ah.  How obnoxious of them.

> Remember: if you have to put a conditional jump in there, it's going to fail
> one way or the other a certain percentage of the time, and that's going to
> cause a pipeline stall, and these ops are used quite a lot.
> 
> OTOH, I don't know that the stall would be that bad since the spin_lock and
> spin_unlock may cause a stall anyway.
> 

Yes, the branch would cost.  But in not uncommon cases that branch will save
the machine from dirtying a cacheline.

And if we add those branches, we bring those architectures' semantics in
line with all the other architectures.  And we get better semantics
overall.

So I don't think we should rule this out.
