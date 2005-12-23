Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbVLWXpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbVLWXpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbVLWXpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:45:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44935
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161127AbVLWXpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:45:11 -0500
Date: Fri, 23 Dec 2005 15:45:09 -0800 (PST)
Message-Id: <20051223.154509.86780332.davem@davemloft.net>
To: torvalds@osdl.org
Cc: michael.bishop@APPIQ.com, linux-kernel@vger.kernel.org, hugh@veritas.com,
       nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
References: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
	<20051223.111940.17674086.davem@davemloft.net>
	<Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 23 Dec 2005 12:53:16 -0800 (PST)

> So it may be that the insane sparc remap_pfn_range() users need to set the 
> dirty/accessed bits in the page protection flags by hand before to avoid 
> that. David?

I'm pretty sure we set the dirty accessed bits at mapping time, so
that shouldn't be an issue.

But I wonder whether any of this is necessary at all.

I did some digging to see how far back the "fall back to MAP_SHARED
if MAP_PRIVATE fails" logic is in the X11R6 tree.

I went back as far as I could in the XORG and XFree86 CVS for
that SBUS support code, and the fallback to MAP_SHARED code has
always been there.

So I think something as simple as returning -EINVAL in the SBUS
framebuffer mmap() driver if VM_SHARED is not set would be sufficient
to deal with this.

Something like this patch below.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
index 646c43f..ac937da 100644
--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -46,6 +46,9 @@ int sbusfb_mmap_helper(struct sbus_mmap_
 	unsigned long off;
 	int i;
                                         
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
 	size = vma->vm_end - vma->vm_start;
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
 		return -EINVAL;
