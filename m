Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWFMUWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWFMUWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWFMUWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:22:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6618 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932224AbWFMUWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:22:38 -0400
Message-ID: <448F1E8A.3030202@fr.ibm.com>
Date: Tue, 13 Jun 2006 22:22:34 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.16-rc6-mm2
References: <20060609214024.2f7dd72c.akpm@osdl.org> <448DA5DD.203@fr.ibm.com> <Pine.LNX.4.64.0606121511090.21172@schroedinger.engr.sgi.com> <448E6798.3020104@fr.ibm.com> <Pine.LNX.4.64.0606131049270.29947@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0606131234010.31186@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606131234010.31186@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 13 Jun 2006, Christoph Lameter wrote:
> 
>> On Tue, 13 Jun 2006, Cedric Le Goater wrote:
>>
>>> thanks for the patch ! I gave it a try but req->wb_page seems bogus ?
>> It seems that req->wb_page is bogus after nfs_clear_page_writeback()
>> has run. So we need to do the statistics before.
> 
> But then we miss the decrement of NR_UNSTABLE when a page is freed before 
> we get to that function. NR_UNSTABLE grows beyond bounds and the write 
> throttling stalls processes.
> 
> So we need an additional dec_zone_state..
> 
> Index: linux-2.6.17-rc6-mm2/fs/nfs/write.c
> ===================================================================
> --- linux-2.6.17-rc6-mm2.orig/fs/nfs/write.c	2006-06-10 11:11:53.051397816 -0700
> +++ linux-2.6.17-rc6-mm2/fs/nfs/write.c	2006-06-13 10:52:04.428456013 -0700
> @@ -1418,8 +1418,9 @@ static void nfs_commit_done(struct rpc_t
>  		dprintk(" mismatch\n");
>  		nfs_mark_request_dirty(req);
>  	next:
> +		if (req->wb_page)
> +			dec_zone_page_state(req->wb_page, NR_UNSTABLE);
>  		nfs_clear_page_writeback(req);
> -		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
>  	}
>  }
>  
> Index: linux-2.6.17-rc6-mm2/fs/nfs/pagelist.c
> ===================================================================
> --- linux-2.6.17-rc6-mm2.orig/fs/nfs/pagelist.c	2006-06-10 11:11:53.049444812 -0700
> +++ linux-2.6.17-rc6-mm2/fs/nfs/pagelist.c	2006-06-13 12:33:39.545259204 -0700
> @@ -154,6 +154,7 @@ void nfs_clear_request(struct nfs_page *
>  {
>  	struct page *page = req->wb_page;
>  	if (page != NULL) {
> +		dec_zone_page_state(page, NR_UNSTABLE);
>  		page_cache_release(page);
>  		req->wb_page = NULL;
>  	}

NFS write seems to work fine with that patch. No more oops.

thanks !

C.
