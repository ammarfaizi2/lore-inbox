Return-Path: <linux-kernel-owner+w=401wt.eu-S1762996AbWLKRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762996AbWLKRhg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762995AbWLKRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:37:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45194 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762997AbWLKRhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:37:35 -0500
Date: Mon, 11 Dec 2006 09:37:23 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Jay Cliburn <jacliburn@bellsouth.net>
cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] commit 3c517a61, slab: better fallback allocation behavior
In-Reply-To: <Pine.LNX.4.64.0612110855380.500@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612110930180.500@schroedinger.engr.sgi.com>
References: <457C64C5.9030108@bellsouth.net> <20061210124907.60c4a0aa.pj@sgi.com>
 <20061210141435.afac089d.akpm@osdl.org> <Pine.LNX.4.64.0612110855380.500@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh. Fallback_alloc() does not do the check for GFP_WAIT as done in 
cache_grow(). Thus interrupts are disabled when we call kmem_getpages() 
which results in the failure.

Duplicate the handling of GFP_WAIT in cache_grow().

Jay could you try this patch?

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-12-11 09:25:57.000000000 -0800
+++ linux-2.6/mm/slab.c	2006-12-11 09:34:08.000000000 -0800
@@ -3252,6 +3252,7 @@
 	struct zone **z;
 	void *obj = NULL;
 	int nid;
+	gfp_t local_flags = (flags & GFP_LEVEL_MASK);
 
 retry:
 	/*
@@ -3275,7 +3276,12 @@
 		 * We may trigger various forms of reclaim on the allowed
 		 * set and go into memory reserves if necessary.
 		 */
+		if (local_flags & __GFP_WAIT)
+			local_irq_enable();
+		kmem_flagcheck(cache, flags);
 		obj = kmem_getpages(cache, flags, -1);
+		if (local_flags & __GFP_WAIT)
+			local_irq_disable();
 		if (obj) {
 			/*
 			 * Insert into the appropriate per node queues
