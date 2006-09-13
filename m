Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWIMIAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIMIAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWIMIAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:00:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:63513 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750706AbWIMIAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:00:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SrGXEU25fwk440sKfONA16+SO0A+NF+i6of4wl6UHCt/9LO4imo1oapi64yD489drWbve4m8SJQ+qm4Iz2x9r9x6AM4XXMzdY5T1yG2yIF0D9+n846osE5tdneiZUpfBbi3zjKlYR71wuPRuPHmuof5cCAkPbxrJesRrRKds93A=
Message-ID: <6d6a94c50609130100v3041513ap68cdf646f9ad9d66@mail.gmail.com>
Date: Wed, 13 Sep 2006 16:00:23 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Kobjsize issue
Cc: "David Howells" <dhowells@redhat.com>, "Matt Mackall" <mpm@selenic.com>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Many embedded systems are using their own algorithm to mange one block
of memory for DMA ops, which is uncached and usually behind of the
kernel memory heap.

So, here, kobjsize will run into kernel BUGs, too.
Because the allocated memory comes from behind memory_end, and doesn't
have the appropriate structures initialized used by the kernel to
maintain memory. And then, kobjsize triggers BUG_ON(page->index
>=MAX_ORDER);

My current solution is a patch as follows. That's really an ugly
workaround, evey kobjsize call will return 0 if the address is behind
of the kernel system memory heap.
What's your thoughts?

Thanks,
-Aubrey
=============================================================
diff --git a/mm/nommu.c b/mm/nommu.c
index c576df7..f4cc8a9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -109,7 +109,7 @@ unsigned int kobjsize(const void *objp)
 {
        struct page *page;

-       if (!objp || !((page = virt_to_page(objp))))
+       if (!objp || !((page = virt_to_page(objp))) || (unsigned
long)objp >= memory_end)
                return 0;

        if (PageSlab(page))
=============================================================
