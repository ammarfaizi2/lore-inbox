Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWHPWlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWHPWlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWHPWlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:41:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1449 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932303AbWHPWly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:41:54 -0400
Date: Thu, 17 Aug 2006 08:41:11 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
Subject: Re: 'fbno' possibly used uninitialized in xfs_alloc_ag_vextent_small()
Message-ID: <20060817084111.A2787212@wobbly.melbourne.sgi.com>
References: <200608162327.34420.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200608162327.34420.jesper.juhl@gmail.com>; from jesper.juhl@gmail.com on Wed, Aug 16, 2006 at 11:27:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

On Wed, Aug 16, 2006 at 11:27:34PM +0200, Jesper Juhl wrote:
> (Please keep me on Cc since I'm not subscribed to the XFS lists)
> 
> The coverity checker found what looks to me like a valid case of 
> potentially uninitialized variable use (see below).

It looks invalid, but its not, once again.  To understand why this
isn't a problem requires looking at the xfs_alloc_ag_vextent_small
call sites (there's only two).  If (*flen==0) is passed back out,
then the value in *fbno is discarded, always.

> So basically, if we hit the 'else' branch, then 'fbno' has not been 
> initialized and line 1490 will then use that uninitialized variable.
> 
> What would prevent that from happening at some time??

Nothing.  But its not a problem in practice.  However, that final
else branch is very much unlikely, so theres no real cost to just
initialising the local fbno to NULLAGBLOCK in that branch, and we
future proof ourselves a bit that way I guess (in case the callers
ever change - pretty unlikely, but we may as well).  How does the
patch below look to you?

cheers.

-- 
Nathan


Index: xfs-linux/xfs_alloc.c
===================================================================
--- xfs-linux.orig/xfs_alloc.c	2006-08-17 08:27:26.807943000 +1000
+++ xfs-linux/xfs_alloc.c	2006-08-17 08:39:55.126710000 +1000
@@ -1478,8 +1478,10 @@ xfs_alloc_ag_vextent_small(
 	/*
 	 * Can't allocate from the freelist for some reason.
 	 */
-	else
+	else {
+		fbno = NULLAGBLOCK;
 		flen = 0;
+	}
 	/*
 	 * Can't do the allocation, give up.
 	 */
