Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVLKKtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVLKKtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 05:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVLKKtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 05:49:14 -0500
Received: from gold.veritas.com ([143.127.12.110]:61497 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751327AbVLKKtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 05:49:13 -0500
Date: Sun, 11 Dec 2005 10:49:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
cc: Martin Drab <drab@kepler.fjfi.cvut.cz>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5 bad page with fglrx on Radeon X300
In-Reply-To: <439B475F.2050901@ens-lyon.org>
Message-ID: <Pine.LNX.4.61.0512111038510.3858@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org> <439B475F.2050901@ens-lyon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Dec 2005 10:49:08.0744 (UTC) FILETIME=[837F3080:01C5FE40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2005, Brice Goglin wrote:
> Does anybody out there have ATI drivers working on Radeon X300
> on 2.6.15-rc5 (or -rc[234]) ? They released fglrx 8.20.8 on december 8th.
> I thought they would have fixed the driver for 2.6.15.
> But, I still get bad page and X programs freezing.

The ATI wrapper source is carefully "#if 0"ing a get_page because of the
traditional anomalous behaviour of PageReserved.  2.6.15-rc killed that
anomalous behaviour, so their "#if 0" needs to become a version test.

Big thanks to Martin Drab for testing this (and correcting the stupidity
of my original inverted patch) - tell us if it does not work for you too.

Hugh

--- fglrx.orig/build_mod/firegl_public.c	2005-12-05 15:47:41.000000000 +0000
+++ fglrx/build_mod/firegl_public.c	2005-12-05 17:18:12.000000000 +0000
@@ -2586,7 +2586,7 @@ static __inline__ vm_nopage_ret_t do_vm_
 
     pMmPage = virt_to_page(kaddr);
 
-#if 0
+#if LINUX_VERSION_CODE >= 0x02060f
     // WARNING WARNINIG WARNNING WARNNING WARNNING WARNNING WARNNING WARNNING
     // Don't increment page usage count, cause ctx pages are allocated
     // with drm_alloc_pages, which marks all pages as reserved. Reserved
