Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131952AbQLPOn6>; Sat, 16 Dec 2000 09:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131977AbQLPOnt>; Sat, 16 Dec 2000 09:43:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12094 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131952AbQLPOnb>; Sat, 16 Dec 2000 09:43:31 -0500
Date: Sat, 16 Dec 2000 15:13:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre1
Message-ID: <20001216151303.D25150@inspiron.random>
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 15, 2000 at 07:51:04PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 07:51:04PM +0000, Alan Cox wrote:
> o	Basic page aging				(Neil Schemenauer)
> 	| This is a beginning to trying to get the VM right

(page aging isn't a matter of correctness of the VM, it's only a matter of
performance basically only during swap [for all other usages lru behaviour is
enough])

About the implementation the swapcache aging is going to be wrong and it could
cause swapcache storms during swap. In 2.2.x we can't implement a kind of
deactivate_page that works on lru, because there's no lru, so all we can do is
to ignore the aging for swap_cache that isn't referenced by anybody (either on
swap or on memory).

Also the implementation is dubios and suboptimal (I'd replace PG_referenced
with page->age instead of mixing the two things, plus page->age is set at
page-freeing time while you want to initialize it only when adding swapcache or
pagecache [this save CPU cycles]).

Even if the patch [after fixing the swapout issue pointed out above] looks safe
I need a bit more time to verify that it doesn't change the balancing of the VM
(the point of aging is to make harder the in-core pages to be freed so it will
somehow increase the swapout factor) and so in the very short term I won't
support the VM-global patch on top of page-aging (to avoid invalidating all the
testing and feedback it had).

For 2.2.19pre2 short term I'd suggest to backout the aging patch and to apply
VM-global against 2.2.18. This will make VM behaviour better regardless
of aging, then if you still feel the need of aging on your 486 8mbyte box
I will try to put your patch on top of VM-global at least after addressing
the swapcache shrinking issue and optimizing it a little bit.

Comments?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
