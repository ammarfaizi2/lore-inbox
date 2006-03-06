Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWCFTQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWCFTQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWCFTQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:16:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932336AbWCFTQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:16:19 -0500
Date: Mon, 6 Mar 2006 11:16:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paolo Ornati <ornati@fastwebnet.it>
cc: Dean Roe <roe@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/slab.c:2564 - 2.6.16-rc5-g7b14e3b5
In-Reply-To: <20060302090728.2fee8f3c@localhost>
Message-ID: <Pine.LNX.4.64.0603061112470.13139@g5.osdl.org>
References: <20060301160656.370e1ee0@localhost> <20060301173636.GA20861@sgi.com>
 <20060302090728.2fee8f3c@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Mar 2006, Paolo Ornati wrote:
> 
> Something is happened again here!

I think you have bad ram.

> Slab corruption: start=ffff81000d0ffb30, len=104
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
> 000: 6b 6b 6b 2b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

> Slab corruption: start=ffff81000d0ffb30, len=104
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<ffffffff8015caac>](end_bio_bh_io_sync+0x35/0x39)
> 000: 6b 6b 6b 2b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

It's the same corruption both times, and the exact same slab entry.

And it's a single-bit error: the "2b" should be a "6b".

Now, if could have been a software error, clearing that one bit, but the 
thing is, that is the first word in a "struct bio", which should be a 
"sector_t bi_sector". The entries around it are also "struct bio"s, and we 
don't do any bit-operations on anything in that area (on "bi_flags", yes).

The fact that it was the very same bit both times (not just the same 
offset: the same physical address) makes me suspect bad RAM.

		Linus
