Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289104AbSAGDcn>; Sun, 6 Jan 2002 22:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289103AbSAGDcd>; Sun, 6 Jan 2002 22:32:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9564 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289104AbSAGDcS>; Sun, 6 Jan 2002 22:32:18 -0500
Date: Mon, 7 Jan 2002 04:32:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
Message-ID: <20020107043236.J1561@athlon.random>
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>; from akpm@zip.com.au on Sat, Jan 05, 2002 at 03:08:25AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 03:08:25AM -0800, Andrew Morton wrote:
>  	}
>  	return 0;
>  out:
> +	bh = head;
> +	block_start = 0;
> +	do {
> +		if (buffer_new(bh) && !buffer_uptodate(bh)) {
> +			memset(kaddr+block_start, 0, bh->b_size);
> +			set_bit(BH_Uptodate, &bh->b_state);
> +			mark_buffer_dirty(bh);
> +		}
> +		block_start += bh->b_size;
> +		bh = bh->b_this_page;
> +	} while (bh != head);
>  	return err;
>  }

the above code will end marking uptodate (zeroed) buffers relative to
blocks that cannot be read from disk. So a read-retry won't hit the disk
and that's wrong.

I think that will be fixed by additionally also return -EIO in the
wait_on_buffer loop (instead of goto out), so we won't generate zeroed
uptodate cache in case of read failure.

Andrea
