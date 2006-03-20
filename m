Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWCTAGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCTAGb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 19:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCTAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 19:06:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61608 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751224AbWCTAGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 19:06:31 -0500
Date: Mon, 20 Mar 2006 11:05:54 +1100
From: David Chinner <dgc@sgi.com>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
Subject: Re: xfs cluster rewrites is broken?
Message-ID: <20060320000553.GY1173973@melbourne.sgi.com>
References: <200603171532.04385.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603171532.04385.gluk@php4.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Fri, Mar 17, 2006 at 03:32:03PM +0300, Alexander Y. Fomichev wrote:
> Hello,
> 
> Two days ago i've try 2.6.16-rc5 on 2-way dual-core Opteron server
> and faced with a strange system behaviour. 
.....
>     [XFS] cluster rewrites      We can cluster mapped pages aswell, this 
> improves
>     performances on rewrites since we can reduce the number of allocator
>     calls.

FYI, prior to this mod, XFS never clustered rewrites, so it's not surprising
that this particular issue has only recently come to light.

> diff -urN a/fs/xfs/linux-2.6/xfs_aops.c b/fs/xfs/linux-2.6/xfs_aops.c
> --- a/fs/xfs/linux-2.6/xfs_aops.c	2006-03-17 13:13:53.000000000 +0300
> +++ b/fs/xfs/linux-2.6/xfs_aops.c	2006-03-17 15:12:12.000000000 +0300
> @@ -616,8 +616,6 @@
>  				acceptable = (type == IOMAP_UNWRITTEN);
>  			else if (buffer_delay(bh))
>  				acceptable = (type == IOMAP_DELAY);
> -			else if (buffer_mapped(bh))
> -				acceptable = (type == 0);
>  			else
>  				break;
>  		} while ((bh = bh->b_this_page) != head);

Well, that switches off rewrite clustering altogether, so it's
not surprising that it fixed your problem. It also points out the
problem as well - we don't every check if the buffer is dirty before
declaring that the page is acceptible for write clustering.

The other cases checked here (buffer_unwritten() and buffer_delay())
are, by defintition, dirty buffers and so they only ever cluster
dirty pages. buffer_mapped(), OTOH, could be clean or dirty.....

Can you try the patch below, and see if that fixes the problem
you are seeing?

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group


Index: 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/xfs/linux-2.6/xfs_aops.c	2006-03-17 13:16:13.000000000 +1100
+++ 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_aops.c	2006-03-20 10:51:36.906723758 +1100
@@ -647,7 +647,7 @@ xfs_is_delayed_page(
 				acceptable = (type == IOMAP_UNWRITTEN);
 			else if (buffer_delay(bh))
 				acceptable = (type == IOMAP_DELAY);
-			else if (buffer_mapped(bh))
+			else if (buffer_mapped(bh) && buffer_dirty(bh))
 				acceptable = (type == 0);
 			else
 				break;
