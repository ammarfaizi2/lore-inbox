Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUCWRFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbUCWRFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:05:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:4242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262712AbUCWRFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:05:05 -0500
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mason@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040323012514.7670f622.akpm@osdl.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <20040317123324.46411197.akpm@osdl.org>
	 <1079563568.4185.1947.camel@watt.suse.com>
	 <20040317150909.7fd121bd.akpm@osdl.org>
	 <1079566076.4186.1959.camel@watt.suse.com>
	 <20040317155111.49d09a87.akpm@osdl.org>
	 <1079568387.4186.1964.camel@watt.suse.com>
	 <20040317161338.28b21c35.akpm@osdl.org>
	 <1079569870.4186.1967.camel@watt.suse.com>
	 <20040317163332.0385d665.akpm@osdl.org>
	 <1079572511.6930.5.camel@ibm-c.pdx.osdl.net>
	 <1079632431.6930.30.camel@ibm-c.pdx.osdl.net>
	 <1079635678.4185.2100.camel@watt.suse.com>
	 <1079637004.6930.42.camel@ibm-c.pdx.osdl.net>
	 <1079714990.6930.49.camel@ibm-c.pdx.osdl.net>
	 <1079715901.6930.52.camel@ibm-c.pdx.osdl.net>
	 <1079879799.11062.348.camel@watt.suse.com>
	 <1079979016.6930.62.camel@ibm-c.pdx.osdl.net>
	 <1079980512.11058.524.camel@watt.suse.com>
	 <1079981473.6930.71.camel@ibm-c.pdx.osdl.net>
	 <20040322151312.6b629736.akpm@osdl.org>
	 <1080003067.6930.78.camel@ibm-c.pdx.osdl.net>
	 <20040323012514.7670f622.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080061501.6930.84.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2004 09:05:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Just to confirm my tests ran overnight without errors.

So the !wbc->nonblocking lowers the cpu utilization.
What does sync_mode=WB_SYNC_ALL and nonblocking=1 mean?

Daniel

On Tue, 2004-03-23 at 01:25, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > The test has been running over 5 hours now without seeing uninitialized
> >  data.  I'll let it run overnight, but it looks like the small 
> >  __block_write_full_page patch fixes the problem.
> 
> OK, thanks.  It does cause gargantuan amounts of CPU consumption as
> expected.  The below version fixes that up.  I'm not 100% happy with it,
> but it seems OK on the profiles.
> 
> 
> diff -puN fs/buffer.c~block_write_full_page-redirty fs/buffer.c
> --- 25/fs/buffer.c~block_write_full_page-redirty	2004-03-23 01:06:59.281253176 -0800
> +++ 25-akpm/fs/buffer.c	2004-03-23 01:09:11.313181272 -0800
> @@ -1810,14 +1810,18 @@ static int __block_write_full_page(struc
>  		get_bh(bh);
>  		if (!buffer_mapped(bh))
>  			continue;
> -		if (wbc->sync_mode != WB_SYNC_NONE) {
> +		/*
> +		 * If it's a fully non-blocking write attempt and we cannot
> +		 * lock the buffer then redirty the page.  Note that this can
> +		 * potentially cause a busy-wait loop from pdflush and kswapd
> +		 * activity, but those code paths have their own higher-level
> +		 * throttling.
> +		 */
> +		if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
>  			lock_buffer(bh);
> -		} else {
> -			if (test_set_buffer_locked(bh)) {
> -				if (buffer_dirty(bh))
> -					__set_page_dirty_nobuffers(page);
> -				continue;
> -			}
> +		} else if (test_set_buffer_locked(bh)) {
> +			__set_page_dirty_nobuffers(page);
> +			continue;
>  		}
>  		if (test_clear_buffer_dirty(bh)) {
>  			if (!buffer_uptodate(bh))
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

