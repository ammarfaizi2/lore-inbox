Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUIMG41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUIMG41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUIMG41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:56:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:7111 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266183AbUIMG4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:56:22 -0400
Date: Mon, 13 Sep 2004 08:56:21 +0200
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Brent Casavant <bcasavan@sgi.com>,
       Andi Kleen <ak@suse.de>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: more numa maxnode confusions
Message-ID: <20040913065621.GB12185@wotan.suse.de>
References: <20040912200253.3d7a6ff5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912200253.3d7a6ff5.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 08:02:53PM -0700, Paul Jackson wrote:
>  2) About Aug 9, Brent Casavant sent in a patch changing the set (not get)
>     side calls, sys_mbind and sys_set_mempolicy, to N64.  This patch
>     removed the following line from the implementation of get_nodes() in
>     mm/mempolicy.c:
> 
> 	--maxnode;

Ah, I wasn't aware that this patch got merged into mainline. 
That was a bad thing, because it broke the ABI used by libnuma
subtly.

Please whoever merged it revert it.

> Currently, by my reading, Linus' bk tree has the mixed N64/N65
> interfaces, since it has Brent's patch, but not my cpuset patch.
> Andrew's *-mm tree has the pure N65 interface, due to my cpuset patch
> reversing Brent's patch.
> 
> My guess is that Andi wants this all N65, and that he didn't agree to
> Brent's patch.  If Andi understands different, that's fine -- I'm not
> trying to reopen that battle.

Correct.


> 
> Andi:
> 
>  0) Are my above statements anywhere close to correct?

Yes.

> 
>  1) Should the "--maxnode" be re-inserted in get_nodes()?

Yes.

> 
>  2) Should it be re-inserted by a separate patch from you,
>     rather than as a hidden side affect of my cpuset patch?
>     I will gladly remove that line from my cpuset patch, in
>     favor of a one-liner from you that re-inserts that line.

Yes. I appended a patch. Linus or Andrew, please apply it.

Thanks for catching this.

-Andi


----------------------------------------------------------------

Fix ABI in set_mempolicy() that got broken by an earlier change.

Add a check for very big input values and prevent excessive
looping in the kernel.


diff -u linux-2.6.9rc1-bk19/mm/mempolicy.c-o linux-2.6.9rc1-bk19/mm/mempolicy.c
--- linux-2.6.9rc1-bk19/mm/mempolicy.c-o	2004-09-13 08:51:46.000000000 +0200
+++ linux-2.6.9rc1-bk19/mm/mempolicy.c	2004-09-13 08:53:58.000000000 +0200
@@ -132,6 +132,7 @@
 	unsigned long nlongs;
 	unsigned long endmask;
 
+	--maxnode;
 	bitmap_zero(nodes, MAX_NUMNODES);
 	if (maxnode == 0 || !nmask)
 		return 0;
@@ -145,6 +146,8 @@
 	/* When the user specified more nodes than supported just check
 	   if the non supported part is all zero. */
 	if (nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
+		if (nlongs > PAGE_SIZE/sizeof(long))
+			return -EINVAL;
 		for (k = BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
 			unsigned long t;
 			if (get_user(t,  nmask + k))





