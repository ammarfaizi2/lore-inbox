Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUCDRcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUCDRbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:31:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:28568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262038AbUCDRbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:31:41 -0500
Date: Thu, 4 Mar 2004 09:31:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race in nobh_prepare_write
Message-Id: <20040304093153.2c9b4be4.akpm@osdl.org>
In-Reply-To: <1078413178.9164.24.camel@shaggy.austin.ibm.com>
References: <1078413178.9164.24.camel@shaggy.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:
>
> Andrew,
> I discovered a race betwen nobh_prepare_write and end_buffer_read_sync. 
> end_buffer_read_sync calls unlock_buffer, waking the nobh_prepare_write
> thread, which immediately frees the buffer_head.  end_buffer_read_sync
> then calls put_bh which decrements b_count for the already freed
> structure.  The SLAB_DEBUG code detects the slab corruption.

Indeed.

> I was able to fix it with the following patch.  I reversed the order of
> unlock_buffer and put_bh in end_buffer_read_sync.  I also set b_count to
> 1 and later called brelse in nobh_prepare_write, since unlock_buffer may
> expect b_count to be non-zero.  I didn't change the other end_io
> functions, as I'm not sure what effect this may have on other callers.
> 
> Is my fix correct?  Is it complete?

There's still a race, but it is benign.

See unlock_buffer():

	clear_buffer_locked(bh);
	smp_mb__after_clear_bit();
	wake_up_buffer(bh);

versus:

> @@ -2413,6 +2413,7 @@ int nobh_prepare_write(struct page *page
>  			wait_on_buffer(read_bh[i]);
>  			if (!buffer_uptodate(read_bh[i]))
>  				ret = -EIO;
> +			brelse(read_bh[i]);
>  			free_buffer_head(read_bh[i]);
>  			read_bh[i] = NULL;

That free_buffer_head() could get in there before unlock_buffer() runs
wake_up_buffer().

But wake_up_buffer() purely uses the bh address as a hash key, so nothing
bad happens.

It's a bit grubby, but this would be hard to fix otherwise.  I'll slap a big
comment on it.

Thanks.
