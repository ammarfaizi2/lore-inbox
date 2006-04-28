Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWD1PzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWD1PzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWD1PzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:55:00 -0400
Received: from amdext4.amd.com ([163.181.251.6]:18382 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030446AbWD1Py7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:54:59 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] [1/1] slab: fix crash on __drain_alien_cahce() during
 CPU Hotplug
Date: Fri, 28 Apr 2006 10:54:37 -0500
Message-ID: <B3870AD84389624BAF87A3C7B83149930293583F@SAUSEXMB2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [1/1] slab: fix crash on __drain_alien_cahce()
 during CPU Hotplug
Thread-Index: AcZq3A0GXCLHYlL3TJKw8dMonPWNtg==
From: "shin, jacob" <jacob.shin@amd.com>
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, clameter@sgi.com,
       ak@suse.de, "Langsdorf, Mark" <mark.langsdorf@amd.com>
X-OriginalArrivalTime: 28 Apr 2006 15:54:37.0828 (UTC)
 FILETIME=[0D7CF440:01C66ADC]
X-WSS-ID: 684CE5374KW4803087-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

transfer_objects should only be called when all of the cpus in the
node are online.  CPU_DEAD notifier callback marks l3->shared to NULL.

Signed-off-by: Jacob Shin <jacob.shin@amd.com>

---
 mm/slab.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux.orig/mm/slab.c	2006-04-26 21:19:25.000000000 -0500
+++ linux/mm/slab.c	2006-04-28 09:45:53.000000000 -0500
@@ -979,7 +979,8 @@ static void __drain_alien_cache(struct k
 		 * That way we could avoid the overhead of putting the objects
 		 * into the free lists and getting them back later.
 		 */
-		transfer_objects(rl3->shared, ac, ac->limit);
+		if (rl3->shared)
+			transfer_objects(rl3->shared, ac, ac->limit);
 
 		free_block(cachep, ac->entry, ac->avail, node);
 		ac->avail = 0;

