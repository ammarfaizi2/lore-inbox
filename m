Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVAFGQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVAFGQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 01:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVAFGQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 01:16:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11595
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262744AbVAFGP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 01:15:57 -0500
Date: Thu, 6 Jan 2005 07:16:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106061608.GU4597@dualathlon.random>
References: <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org> <20050106051707.GP4597@dualathlon.random> <41DCCA68.3020100@yahoo.com.au> <20050105213207.721b1aae.akpm@osdl.org> <20050106054659.GS4597@dualathlon.random> <20050105215909.7ac1f8b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105215909.7ac1f8b1.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 09:59:09PM -0800, Andrew Morton wrote:
> But we do need to watch the CPU consumption in there - end_page_writeback()
> already figures fairly high sometimes.

The check for waitqueue_active will avoid all wake_up calls if nobody is
waiting in blk_congestion_wait. Plus it won't need to wakeup on all
classzones, if we have the other side to reigster on all the zones
composing the classzone.

The wakeup is going to be more frequent than the waiter registration.

So we can register the waiter on _all_ the "interested" zones that
composes the classzone, instead of the other way around that you
suggested in the previous email.

That will reduce the wakeup to a single waitqueue_active, and it
shouldn't be too bad.

Same goes for the number of outstanding writebacks, we can collect that
number per zone and have blk_congestion_wait returning immediatly if it
went to zero on all zones composing the classzone after registering.
