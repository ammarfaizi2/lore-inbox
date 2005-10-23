Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVJWW4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVJWW4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 18:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVJWW4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 18:56:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11166 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750846AbVJWW4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 18:56:14 -0400
Date: Mon, 24 Oct 2005 08:54:51 +1000
From: Nathan Scott <nathans@sgi.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       debian-user@lists.debian.org
Subject: Re: xfs_db -c frag -r /dev/hda1 - Segmentation fault
Message-ID: <20051024085451.C5863161@wobbly.melbourne.sgi.com>
References: <4080C826.F4C53CD@dmministries.org> <Pine.LNX.4.64.0510230736490.30489@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.64.0510230736490.30489@p34>; from jpiszcz@lucidpixels.com on Sun, Oct 23, 2005 at 07:39:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 07:39:34AM -0400, Justin Piszcz wrote:
> p34:~# xfs_db -c frag -r /dev/hda1
> Segmentation fault
> p34:~# xfs_db -c frag -r /dev/hde1
> Segmentation fault
> p34:~# xfs_db -c frag -r /dev/hdk1
> Segmentation fault
> p34:~#
> 
> Debian Etch, 2.6.13.4, stopped working a while ago, either before newer 
> debian packages or a newer kernel, does anyone who uses Debian+XFS have 
> this problem as well?

I see it too - this looks like an endian issue in xfs_db, this patch
should fix it (Works For Me).

cheers.

-- 
Nathan


Index: xfsprogs/db/frag.c
===================================================================
--- xfsprogs.orig/db/frag.c
+++ xfsprogs/db/frag.c
@@ -294,7 +294,7 @@ process_exinode(
 	xfs_bmbt_rec_32_t	*rp;
 
 	rp = (xfs_bmbt_rec_32_t *)XFS_DFORK_PTR(dip, whichfork);
-	process_bmbt_reclist(rp, XFS_DFORK_NEXTENTS(dip, whichfork), extmapp);
+	process_bmbt_reclist(rp, XFS_DFORK_NEXTENTS_HOST(dip, whichfork), extmapp);
 }
 
 static void
@@ -305,7 +305,7 @@ process_fork(
 	extmap_t	*extmap;
 	int		nex;
 
-	nex = XFS_DFORK_NEXTENTS(dip, whichfork);
+	nex = XFS_DFORK_NEXTENTS_HOST(dip, whichfork);
 	if (!nex)
 		return;
 	extmap = extmap_alloc(nex);
