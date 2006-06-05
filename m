Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750754AbWFEUoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWFEUoA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFEUoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:44:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37272 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750754AbWFEUn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:43:59 -0400
Date: Mon, 5 Jun 2006 13:43:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Martin Bligh <mbligh@google.com>, Andy Whitcroft <apw@shadowen.org>,
        "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
        ak@suse.de, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh the patch that I sent earlier will make swapon fail when adding more 
entries if 32 entries have been defined before even if some of these are 
later freed. Plus maybe we better leave the probing intact for arches that 
support less than 32 swap devices and also return -EPERM like before. I 
guess we need this one instead:


Do proper boundary checking in sys_swapon().

sys_swapon currently does not limit the number of swap devices. It may as
a result overwrite memory following the swap_info array and get into 
entanglements with page migration since it may usethe swap types reserved 
for page migration.

Fix this by limiting the number of swap devices in swapon to 
MAX_SWAPFILES

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc5-mm2/mm/swapfile.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/mm/swapfile.c	2006-06-01 10:03:07.127259731 -0700
+++ linux-2.6.17-rc5-mm2/mm/swapfile.c	2006-06-05 13:40:45.887291175 -0700
@@ -1408,8 +1408,13 @@ asmlinkage long sys_swapon(const char __
 		spin_unlock(&swap_lock);
 		goto out;
 	}
-	if (type >= nr_swapfiles)
+	if (type >= nr_swapfiles) {
+		if (nr_swapfiles >= MAX_SWAPFILES) {
+			spin_unlock(&swap_lock);
+			goto out;
+		}
 		nr_swapfiles = type+1;
+	}
 	INIT_LIST_HEAD(&p->extent_list);
 	p->flags = SWP_USED;
 	p->swap_file = NULL;
