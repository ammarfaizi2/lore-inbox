Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUEDMpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUEDMpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 08:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUEDMpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 08:45:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23951 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264330AbUEDMpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 08:45:10 -0400
Date: Tue, 4 May 2004 13:45:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Brent Cook <busterbcook@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slab cache seems to grow forever - 2.6.6-rc3-mm1
In-Reply-To: <Pine.LNX.4.58.0405040651150.18153@ozma.hauschen>
Message-ID: <Pine.LNX.4.44.0405041343310.5077-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Brent Cook wrote:
> 
> This might be related to the change in fs-writeback.c that fixed
> redirtying inodes on NFS, but I'm not sure. It seems that the Slab cache
> never shrinks. Could this be a memory leak? It definitely affects system
> performance. Here are the numbers after running for about 12 hours with
> heavy NFS traffic (this is the client).

Please apply the patch akpm posted on Saturday:

2.6.6-rc3-mm1 is totally broken in the slab-shrinking area (sorry).

--- 25/mm/vmscan.c~shrink_slab-handle-GFP_NOFS-fix	2004-05-01 14:34:25.446391008 -0700
+++ 25-akpm/mm/vmscan.c	2004-05-01 14:34:37.424570048 -0700
@@ -156,7 +156,7 @@ static int shrink_slab(unsigned long sca
 			shrinker->nr = LONG_MAX;	/* It wrapped! */
 
 		if (shrinker->nr <= SHRINK_BATCH)
-			break;
+			continue;
 		while (shrinker->nr) {
 			long this_scan = shrinker->nr;
 			int shrink_ret;

