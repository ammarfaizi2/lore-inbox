Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbTHKFSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270997AbTHKFSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:18:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:35461 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270984AbTHKFSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:18:04 -0400
Date: Mon, 11 Aug 2003 06:17:48 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030811051748.GJ10446@mail.jlokier.co.uk>
References: <20030809074459.GQ31810@waste.org> <20030809010418.3b01b2eb.davem@redhat.com> <20030809140542.GR31810@waste.org> <20030809103910.7e02037b.davem@redhat.com> <20030809194627.GV31810@waste.org> <20030809131715.17a5be2e.davem@redhat.com> <20030810081529.GX31810@waste.org> <20030811021512.GF10446@mail.jlokier.co.uk> <20030810215422.0db6192a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810215422.0db6192a.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> > Why so complicated?  Just move the "sha1_transform" function to its
> > own file in lib, and call it from both drivers/char/random.c and
> > crypto/sha1.c.
> 
> This is also broken.

Not wanted, perhaps, but there is nothing broken about it.

> The whole point of the 'tfm' the Crypto API makes you allocate is
> that it provides all of the state and configuration information
> needed to do the transforms.

That'll be the array of 5 u32s, then.

> There is no reason why random.c's usage of the crypto-API cannot be
> done cleanly and efficiently such that it is both faster and resulting
> in smaller code size than what random.c uses now.

I don't disagree that Crypto API is flexible, possibly desirable for
being able to change which algorithm random.c uses, and using it will
certainly remove a lot of lines from random.c.

But the registration and lookup part just so random.c can ultimately
call sha1_transform with its well known 5-word state and 16-word data
input can't possibly be as small as calling sha1_transform directly.

> All of this _WITHOUT_ bypassing and compromising the well designed
> crypto API interfaces to these transformations.

I don't believe you'll get "all of this", i.e. the smaller code size.

The state for sha1_transform is an array of 5 u32s, that's all.  Going
via Crypto API is just a complicated way to call it in this case.

random.c does not use it in the conventional way, as a hash over an
arbitrary number of bytes, so that part of CryptoAPI is not relevant.
random.c also uses the intermediate states of the hash, to feed them
back into the pool.

I shall be very surprised if the supposed hardware acceleration can
make random.c faster with its current algorithm, because it operates
on such small chunks or data (16 bytes at a time - more I/O overhead
than crypto time, with hardware).  A change of algorithm might do it though.

I shall be even more surprised if calling sha1_transform through
CryptoAPI results in a smaller kernel than what is done now (without
CryptoAPI linked in).

-- Jamie
