Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUCHXJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUCHXJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:09:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63497
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261156AbUCHXIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:08:07 -0500
Date: Tue, 9 Mar 2004 00:08:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040308230845.GD12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078781318.4678.9.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 10:28:38PM +0100, Arjan van de Ven wrote:
> > . Basically without
> > this fix it's like 2.6 is running w/o pte-highmem. 700 tasks with 2.7G
> > of shm mapped each would run the box out of zone-normal even with 4:4.
> > With 3:1 100 tasks would be enough. Math is easy:
> > 
> > 	2.7*1024*1024*1024/4096*8*100/1024/1024/1024
> > 	2.7*1024*1024*1024/4096*8*700/1024/1024/1024
> 
> 
> not saying your patch is not useful or anything,but there is a less
> invasive shortcut possible. Oracle wants to mlock() its shared area, and
> for mlock()'d pages we don't need a pte chain *at all*. So we could get
> rid of a lot of this overhead that way.

I agree that works fine for Oracle, that's becase Oracle is an extreme
special case since most of this shared memory is an I/O cache, this is
not the case of other apps, and those other apps really depends on the
kernel vm paging algorithms for things more than istantiating a pte (or
a pmd if it's a largepage). Other apps can't use mlock. Some of these
apps works closely with oracle too.

dropping pte_chains through mlock was suggested around april 2003
originally by Wli and I didn't like that idea since we really want to
allow swapping if we run short of ram. And it doesn't solve the
scalability slowdown on the 32-way for kernel compiles either.
