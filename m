Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266052AbUGVO6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUGVO6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUGVO6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 10:58:44 -0400
Received: from centaur.acm.jhu.edu ([128.220.223.65]:15006 "EHLO
	centaur.acm.jhu.edu") by vger.kernel.org with ESMTP id S266052AbUGVO6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 10:58:43 -0400
Date: Thu, 22 Jul 2004 10:58:43 -0400
From: Jack Lloyd <lloyd@randombit.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040722145843.GA24834@acm.jhu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <Pine.LNX.4.58.0407212319560.13098@devserv.devel.redhat.com> <pan.2004.07.22.07.43.41.872460@smurf.noris.de> <cdoi4i$iic$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdoi4i$iic$1@terminus.zytor.com>
X-GPG-Key-ID: 4DCDF398
X-GPG-Key-Fingerprint: 2DD2 95F9 C7E3 A15E AF29 80E1 D6A9 A5B9 4DCD F398
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 02:14:42PM +0000, H. Peter Anvin wrote:

> So does cryptoloop use a different IV for different blocks?  The need
> for the IV to be secret is different for different ciphers, but for
> block ciphers the rule is that is must not repeat, and at least
> according to some people must not be trivially predictable.  One way
> to do that is to use a secure hash of (key,block #) as the IV.

Using an HMAC for this (with the input being the block #) seems like a better
idea, as there is less risk of leaking bits of the key if any attack on the
hash is found. Since secure hash == SHA-1 or better, you would have to truncate
it to use as an IV for a 64 or 128 bit cipher, which would make it harder for
someone looking at the IVs to make a guess on the key, but HMAC is pretty
cheap.

For block ciphers in CBC mode, simply not repeating and being somewhat
non-predictable is sufficient. That's easy enough.

For something like, say, counter mode, you have to make sure that they never
overlap; not only will a repeated IV cause trouble, but if one block is
encrypted with a particular IV, and another block is encrypted with IV + n
(viewing them as integers), then you'll leak some of the plaintext, because the
cipher stream will get reused. The obvious solution is to just use the (block
ID << log2(sector_size)) as the IV. The IV doesn't have to be unpredictable at
all for counter mode. The shift is needed, otherwise the second block of sector
2 will be encrypted with the same counter as the first block of sector one.

I'm not aware of any cipher or cipher mode where the IV or nonce has to be kept
secret from an attacker.

Jack
