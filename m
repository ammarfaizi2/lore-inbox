Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUJVRLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUJVRLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271451AbUJVRC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:02:59 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:64397 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S271450AbUJVQ5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:57:07 -0400
Date: Fri, 22 Oct 2004 18:58:09 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041022165809.GH14325@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41787840.3060807@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 01:02:24PM +1000, Nick Piggin wrote:
> I don't agree, there are times when you need to know the bare pages_xxx
> watermark, and times when you need to know the whole ->protection thing.

we'll see, I agree current alloc_pages is quite clean but I'm quite
tempted to have a strightforward alloc_pages as clean as 2.4:

	for (;;) {
		zone_t *z = *(zone++);
		if (!z)
			break;

		if (zone_free_pages(z, order) > z->watermarks[class_idx].low) {
			page = rmqueue(z, order);
			if (page)
				return page;
		}
	}

2.6 is like this:

	/* Go through the zonelist once, looking for a zone with enough * free */
	for (i = 0; (z = zones[i]) != NULL; i++) {
		min = z->pages_low + (1<<order) + z->protection[alloc_type];

		if (z->free_pages < min)
			continue;

		page = buffered_rmqueue(z, order, gfp_mask);
		if (page)
			goto got_pg;
	}


I don't see any benefit in limiting the high order, infact it seems a
bad bug. If something you should limit the _small_ order, so that the
high order will have a slight chance to succeed. You're basically doing
the opposite.

The pages_low is completely useless too for example and it could go.
pages_min has some benefit for some more feature 2.6 provides (that
could be translated in more watermarks, to separate the "settings of
the watermarks" from the alloc_page user of the watermarks).

> OK I dont disagree that your setup calculations are much nicer, and
> the current ones are pretty broken...

ok cool.
