Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314466AbSDRVkA>; Thu, 18 Apr 2002 17:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314467AbSDRVj7>; Thu, 18 Apr 2002 17:39:59 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:1161 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314466AbSDRVj7>;
	Thu, 18 Apr 2002 17:39:59 -0400
Date: Thu, 18 Apr 2002 15:38:14 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] stop NULL pointer dereference in __alloc_pages
Message-ID: <1913040000.1019169494@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch will apply to both 2.4.19-pre7 and 2.5.8 with just line 
offsets. It stops us from following a NULL pointer in classzone in the case 
where there is a pgdat without a fully populated zone list (ie a node with 
no ZONE_NORMAL on an ia32 NUMA machine). Without this patch, ia32 
NUMA machines won't even boot - we dereference the classzone ptr
a few lines further down (or try to ;-) ).

Please apply ...

Thanks,

Martin.

--- linux-2.4.18-memalloc/mm/page_alloc.c.old	Fri Mar  8 18:21:41 2002
+++ linux-2.4.18-memalloc/mm/page_alloc.c	Fri Mar  8 18:23:27 2002
@@ -317,6 +317,8 @@
 
 	zone = zonelist->zones;
 	classzone = *zone;
+	if (classzone == NULL)
+		return NULL;
 	min = 1UL << order;
 	for (;;) {
 		zone_t *z = *(zone++);

