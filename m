Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVAFFQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVAFFQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVAFFQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:16:58 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24388
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262729AbVAFFQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:16:56 -0500
Date: Thu, 6 Jan 2005 06:17:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106051707.GP4597@dualathlon.random>
References: <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105210539.19807337.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 09:05:39PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > The fix is very simple and it is to call wait_on_page_writeback on one
> >  of the pages under writeback.
> 
> eek, no.  That was causing waits of five seconds or more.  Fixing this
> caused the single greatest improvement in page allocator latency in early
> 2.5.  We're totally at the mercy of the elevator algorithm this way.
> 
> If we're to improve things in there we want to wait on _any_ eligible page
> becoming reclaimable, not on a particular page.

I told you one way to fix it. I didn't guarantee it was the most
efficient one.

I sure agree waiting on any page to complete writeback is going to fix
it too. Exactly because this page was a "random" page anyway.

Still my point is that this is a bug, and I prefer to be slow and safe
like 2.4, than fast and unreliable like 2.6.

The slight improvement you suggested of waiting on _any_ random
PG_writeback to go away (instead of one particular one as I did in 2.4)
is going to fix the write throttling equally too as well as the 2.4
logic, but without introducing slowdown that 2.4 had.

It's easy to demonstrate: exactly because the page we pick is random
anyway, we can pick the first random one that has seen PG_writeback
transitioning from 1 to 0. The guarantee we get is the same in terms of
safety of the write throttling, but we also guarantee the best possible
latency this way. And the HZ/x hacks to avoid deadlocks will magically
go away too.
