Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTFPNu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 09:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTFPNu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 09:50:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19433 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262176AbTFPNuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 09:50:22 -0400
Date: Mon, 16 Jun 2003 19:39:07 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock_buffer_wq do lock
Message-ID: <20030616193907.A10977@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.44.0306161435110.1846-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306161435110.1846-100000@localhost.localdomain>; from hugh@veritas.com on Mon, Jun 16, 2003 at 02:47:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 02:47:32PM +0100, Hugh Dickins wrote:
> I've twice got fs/buffer.c:2668 submit_bh BUG_ON(!buffer_locked(bh)):
> when called from sync_dirty_buffer which clearly does the lock_buffer.
> My suspicion falls on lock_buffer_wq (whereas __lock_page_wq looks OK).
> 
> I'm leaving a test running,
> can't judge until tomorrow whether this is indeed the fix to that.
> 
> Hugh
> 
> --- 2.5.71-mm1/include/linux/buffer_head.h	Sun Jun 15 12:36:11 2003
> +++ linux/include/linux/buffer_head.h	Mon Jun 16 14:13:25 2003
> @@ -291,9 +291,11 @@
>  
>  static inline int lock_buffer_wq(struct buffer_head *bh, wait_queue_t *wait)
>  {
> -	if (test_set_buffer_locked(bh))
> -		return __wait_on_buffer_wq(bh, wait);
> -
> +	while (test_set_buffer_locked(bh)) {
> +		int ret = __wait_on_buffer_wq(bh, wait);
> +		if (ret)
> +			return ret;
> +	}
>  	return 0;
>  }

You are right - this should be a while loop mirroring what
lock_buffer does.

Actually, I probably ought to just avoid the dual paths,
and make lock_buffer a wrapper for lock_buffer_wq -- less
chances of divergence between the two. 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

