Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTDUSKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTDUSKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:10:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9741 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261825AbTDUSKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:10:51 -0400
Date: Mon, 21 Apr 2003 11:22:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Roman Zippel <zippel@linux-m68k.org>, "David S. Miller" <davem@redhat.com>,
       <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <20030421191013.A9655@infradead.org>
Message-ID: <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Christoph Hellwig wrote:
> 
> Not anymore for blockdevices.  And now that Al's back not anymore soon
> for charater devices, too :)

Actually, we still do it for both block _and_ character devices.

Look at "nfs*xdr.c" to see what's up.

In other words, that split is definitely not virtual. It's a real thing 
with real visibility for users.

The fact that the kernel internally has generalized it away doesn't 
matter. Any kernel virtualization of the number still _has_ to account for 
the fact that it's a real thing.

Put another way:

	0x0000000000000101

_has_ to open the same file as

	0x0000000100000001

because otherwise the kernel virtualization is broken (since they will
look the same to a user, and they will end up being written to disk the
same way).

Thus any code that only looks at 64-bit dev_t without taking this into 
account is BUGGY. 

One way to avoid the bug is to always keep all dev_t numbers in "canonical 
format". Which happens automatically if the interface is <major, minor> 
rather than a 64-bit blob.

I personally think that anything that uses "dev_t" in _any_ other way than 
<major,minor> is fundamentally broken.

		Linus

