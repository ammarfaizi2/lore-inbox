Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbUCCFaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUCCFaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:30:24 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:4101 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S262352AbUCCFaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:30:22 -0500
Date: Wed, 3 Mar 2004 00:30:20 -0500
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: bad: scheduling while atomic in nfs with 2.6.3
Message-ID: <20040303053020.GB12137@fieldses.org>
References: <40454C6F.5020901@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40454C6F.5020901@matchmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 07:09:35PM -0800, Mike Fedyk wrote:
> I'm running 2.6.3-zonebal-lofft-slabfaz
> 
> That's with the nfsd loff_t patch and two VM patches from -mm.
> 
> Call Trace:
>  [<c012258d>] __might_sleep+0x9d/0xe0
>  [<c01651d8>] deactivate_super+0x58/0x100
>  [<f89e9fba>] svc_export_put+0x7a/0x80 [nfsd]
>  [<f898167c>] cache_clean+0x18c/0x2e0 [sunrpc]
>  [<f89817d9>] do_cache_clean+0x9/0x50 [sunrpc]
>  [<c0136128>] worker_thread+0x1b8/0x260
>  [<f89817d0>] do_cache_clean+0x0/0x50 [sunrpc]
>  [<c0120750>] default_wake_function+0x0/0x20
>  [<c0109e16>] ret_from_fork+0x6/0x20
>  [<c0120750>] default_wake_function+0x0/0x20
>  [<c0135f70>] worker_thread+0x0/0x260
>  [<c0107d95>] kernel_thread_helper+0x5/0x10

This is fixed in 2.6.4-rc1, with the following patch.

--Bruce Fields



We currently call cache_put, which can schedule(), under a spin_lock.  This
patch moves that call outside the spinlock.

(From neilb)


 net/sunrpc/cache.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff -puN net/sunrpc/cache.c~neil_cache_clean_fix net/sunrpc/cache.c
--- linux-2.6.2/net/sunrpc/cache.c~neil_cache_clean_fix	2004-02-11 12:44:13.000000000 -0500
+++ linux-2.6.2-bfields/net/sunrpc/cache.c	2004-02-11 12:44:13.000000000 -0500
@@ -325,6 +325,7 @@ int cache_clean(void)
 	
 	if (current_detail && current_index < current_detail->hash_size) {
 		struct cache_head *ch, **cp;
+		struct cache_detail *d;
 		
 		write_lock(&current_detail->hash_lock);
 
@@ -354,12 +355,14 @@ int cache_clean(void)
 			rv = 1;
 		}
 		write_unlock(&current_detail->hash_lock);
-		if (ch)
-			current_detail->cache_put(ch, current_detail);
-		else
+		d = current_detail;
+		if (!ch)
 			current_index ++;
-	}
-	spin_unlock(&cache_list_lock);
+		spin_unlock(&cache_list_lock);
+		if (ch)
+			d->cache_put(ch, d);
+	} else
+		spin_unlock(&cache_list_lock);
 
 	return rv;
 }

_
