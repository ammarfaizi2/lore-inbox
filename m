Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTKTM3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 07:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTKTM3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 07:29:06 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:40355 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S261686AbTKTM3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 07:29:01 -0500
Date: Thu, 20 Nov 2003 12:28:38 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, ink@jurassic.park.msu.ru
Subject: Simplification in pbus_size_mem
Message-ID: <20031120122838.GA4575@malvern.uk.w2k.superh.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, ink@jurassic.park.msu.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OS: Linux 2.4.22 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 20 Nov 2003 12:29:45.0741 (UTC) FILETIME=[FB2FD3D0:01C3AF61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is against 2.4, but the 2.6 code looks identical.

===== setup-bus.c 1.6 vs edited =====
--- 1.6/drivers/pci/setup-bus.c Thu Dec 12 22:14:01 2002
+++ edited/setup-bus.c  Thu Nov 20 11:54:28 2003
@@ -311,18 +311,8 @@
                }
        }
 
-       align = 0;
-       min_align = 0;
-       for (order = 0; order <= max_order; order++) {
-               unsigned long align1 = 1UL << (order + 20);
+       min_align = 1UL << (max_order + 20);
 
-               if (!align)
-                       min_align = align1;
-               else if (ROUND_UP(align + min_align, min_align) < align1)
-                       min_align = align1 >> 1;
-               align += aligns[order];
-       }
-       size = ROUND_UP(size, min_align);
        if (!size) {
                b_res->flags = 0;
                return;


This is fixing the allocation on a system which looks like this

* 96Mb PCI memory aperture
* Kyro graphics card, requiring 64Mb + 768kb prefetchable
* USB card requiring 4x4k non-prefetchable

Without the change, 'min_align' is computed as 32Mb (the algorithm in the
loop basically seems to make 'min_align' end up as 1/2 the largest
alignment requirement that was found?), hence in the pass where the
prefetchable block is sized, 'size' ends up as 96Mb, which means there
is no space left in which to place the non-prefetchable blocks for the
USB card.

With the patch above, the alignment requirement for the prefetchable
memory actually ends up as the alignment required for the framebuffer,
and the size isn't rounded up unnecessarily.  The USB card gets
allocated successfully as a result.

I couldn't be sure what the code in the loop is attempting to do, so I'm
sure I'm overlooking something subtle.  Any comments?

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
