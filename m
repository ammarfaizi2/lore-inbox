Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWBGHt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWBGHt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWBGHt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:49:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43169 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964997AbWBGHt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:49:27 -0500
Date: Tue, 7 Feb 2006 18:49:14 +1100
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-ID: <20060207074914.GY58731470@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <20060206054815.GJ43335175@melbourne.sgi.com> <20060205222215.313f30a9.akpm@osdl.org> <20060206115500.GK43335175@melbourne.sgi.com> <20060206151435.731b786c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206151435.731b786c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 03:14:35PM -0800, Andrew Morton wrote:
> 
> So to fix both these problems we need to be smarter about terminating the
> wb_kupdate() loop.  Something like "loop until no expired inodes have been
> written".
> 
> Wildly untested patch:

>  		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
> +		wbc.wrote_expired_inode = 0;
>  		writeback_inodes(&wbc);
> -		if (wbc.nr_to_write > 0) {
> +		if (wbc.wrote_expired_inode == 0) {
>  			if (wbc.encountered_congestion)
>  				blk_congestion_wait(WRITE, HZ/10);
>  			else

FWIW, Theres a problem with the logic here - if we've encountered congestion,
we want to wait even if we wrote back expired inodes. Should it be:

		if (!wbc.wrote_expired_inode && !wbc.encountered_congestion)
 				break;	/* All the old data is written */
		if (wbc.encountered_congestion)
			blk_congestion_wait(WRITE, HZ/10);


Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
