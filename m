Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292970AbSCMK4a>; Wed, 13 Mar 2002 05:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292979AbSCMK4V>; Wed, 13 Mar 2002 05:56:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17013 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292970AbSCMK4H>; Wed, 13 Mar 2002 05:56:07 -0500
Date: Wed, 13 Mar 2002 11:57:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020313115713.E1703@dualathlon.random>
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>, <20020312160430.W25226@dualathlon.random>; <20020312233117.E14628@holomorphy.com> <3C8E98B2.159FA546@zip.com.au> <20020313083055.D21589@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313083055.D21589@dualathlon.random>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 08:30:55AM +0100, Andrea Arcangeli wrote:
>  {
>  	clear_bit(BH_Wait_IO, &bh->b_state);
>  	clear_bit(BH_Lock, &bh->b_state);
> +	clear_bit(BH_Launder, &bh->b_state);
>  	smp_mb__after_clear_bit();
>  	if (waitqueue_active(&bh->b_wait))

actually, while refining the patch and integrating it, I audited it some
more carefully and the above was wrong, we must ensure nobody is able to
acquire BH_Lock before BH_Launder. So we must also enforce ordering at
the cpu level.  This is the correct version.

	clear_bit(BH_Wait_IO, &bh->b_state);
	clear_bit(BH_Launder, &bh->b_state);
	/* nobody must acquire BH_Lock again before BH_Launder is clear */
	smp_mb__after_clear_bit();
	clear_bit(BH_Lock, &bh->b_state);

The race would been nearly impossible to trigger during stress testing,
you'd need to BH_Lock + GFP_NOFS + alloc_pages + shrink_cache + the
interesting page is near the end of the lru + try_to_free_buffers +
sync_page_buffers + wait_on_buffer all in a few cycles (irq handlers
could trigger it :), but with the huge userbase somebody I don't exclude
somebody could been really hurted by and anyways it would be still a
common code bug even if it would not be possible to reproduce it with
current available hardware.

Note that the above very same race can happen in mainline too on
architectures where a clear_bit doesn't imply a strong CPU barrier.
So on the paper your same kind of deadlock could happen on mainline as
well but there it is reduced to an SMP race and it would affect only
alpha, ppc and s390. So I'm glad my deadlock is been useful to fix
another SMP race condition at least :)

Andrea
