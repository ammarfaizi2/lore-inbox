Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFTLyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFTLyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFTLye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:54:34 -0400
Received: from ngate.noida.hcltech.com ([202.54.110.230]:42713 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S261211AbVFTLyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:54:24 -0400
Message-ID: <8A6EB6A72A5C774C8814DDC1501FC90E97C07B@exch-01.noida.hcltech.com>
From: "Parveen  Verma, Noida" <Parveenv@noida.hcltech.com>
To: linux-kernel@vger.kernel.org
Cc: "Parveen  Verma, Noida" <Parveenv@noida.hcltech.com>,
       "Shilpi Jaiswal, Noida" <shilpij@noida.hcltech.com>,
       linux.guy@rediffmail.com
Subject: __alloc_pages ()
Date: Mon, 20 Jun 2005 17:23:53 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found that while allocating (mostly it is done) the pages in
__alloc_pages(), after successfully allocating the page the
zone_statistics() function is called.

static void zone_statistics(struct zonelist *zonelist, struct zone *z)
{
#ifdef CONFIG_NUMA
.....
#endif
}
The whole body of this function is enclosed b/w #ifdef ... #endif.
This function is called each time and does nothing if we don't have a NUMA
machine.
Can we put the call for this b/w #ifdef ... #endif?
Although the gcc -O3 option does not generate a function call if the
function body is nil.

The patch for the same is given below:

diff -Nru linux-2.6.11.11.orig/mm/page_alloc.c
linux-2.6.11.11/mm/page_alloc.c
--- linux-2.6.11.11.orig/mm/page_alloc.c        2005-05-27
01:06:46.000000000 -0400
+++ linux-2.6.11.11/mm/page_alloc.c     2005-06-20 17:07:41.000000000 -0400
@@ -851,7 +851,9 @@
        }
        return NULL;
 got_pg:
+#ifdef CONFIG_NUMA
        zone_statistics(zonelist, z);
+#endif
        return page;
 }


Further, I have not removed the #ifdef ... #endif from zone_statistics() as
in future some other function might call this function, but in present
kernel no one calls this.

Comments are invited..

-- 
Praveen Verma
(Hare Rama Hare Krishna)
