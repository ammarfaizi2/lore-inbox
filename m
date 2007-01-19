Return-Path: <linux-kernel-owner+w=401wt.eu-S964783AbXASSIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbXASSIK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbXASSIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:08:10 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:18522 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783AbXASSII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:08:08 -0500
X-AuditID: d80ac287-9f49fbb0000026f2-fd-45b10aa825e3 
Date: Fri, 19 Jan 2007 18:08:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Alexey Dobriyan <adobriyan@openvz.org>
cc: Andrew Morton <akpm@osdl.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Richard Purdie <richard@openedhand.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't map random pages if swapoff errors
In-Reply-To: <20070119163030.GA12507@localhost.sw.ru>
Message-ID: <Pine.LNX.4.64.0701191754020.10013@blonde.wat.veritas.com>
References: <20070119163030.GA12507@localhost.sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Jan 2007 18:08:06.0029 (UTC) FILETIME=[C4A0F3D0:01C73BF4]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Alexey Dobriyan wrote:

> From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> 
> If read failed we cannot map not-uptodate page to user space.

Good point.

> Actually, we are in serious troubles, we do not even know what
> process to kill.

True, though we don't really want to kill anything yet: the process
may never need that page again.  Better to let it continue until it
exits, or hits Kirill's check in do_swap_page.  But sure, that's not
going to happen without us making some change here.

> So, the only variant remains: to stop swapoff()
> and allow someone to kill processes to zap invalid pages.

Simple as it is, no, I don't like this patch at all.
Getting an error there is all the more reason to proceed
with the swapoff, not to give up and break out of it.

Let me think a little.

CC'ed Richard, since he's also interested in bad swap, and this
reminds me to look at his patches (though he's been concerned with
when the writeout fails, rather than when the readin fails).

Hugh

> 
> Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
> ---
> 
>  mm/swapfile.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -766,6 +766,19 @@ static int try_to_unuse(unsigned int typ
>  		lock_page(page);
>  		wait_on_page_writeback(page);
>  
> +		/* If read failed we cannot map not-uptodate page to
> +		 * user space. Actually, we are in serious troubles,
> +		 * we do not even know what process to kill. So, the only
> +		 * variant remains: to stop swapoff() and allow someone
> +		 * to kill processes to zap invalid pages.
> +		 */
> +		if (unlikely(!PageUptodate(page))) {
> +			unlock_page(page);
> +			page_cache_release(page);
> +			retval = -EIO;
> +			break;
> +		}
> +
>  		/*
>  		 * Remove all references to entry.
>  		 * Whenever we reach init_mm, there's no address space
