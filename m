Return-Path: <linux-kernel-owner+w=401wt.eu-S932666AbWLMScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWLMScK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWLMScK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:32:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:55878 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbWLMScI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:32:08 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 13:32:07 EST
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Bug: early_pfn_in_nid() called when not early
Date: Wed, 13 Dec 2006 19:20:57 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andy Whitcroft <apw@shadowen.org>, mkravetz@us.ibm.com,
       hch@infradead.org, Jeremy Kerr <jk@ozlabs.org>,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612131920.59270.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a lot of debugging in spufs, I found that a crash that we encountered
on Cell actually was caused by a change in the memory management.

The patch that caused it is archived in http://lkml.org/lkml/2006/11/1/43,
and this one has been discussed back and forth, but I fear that the current
version may be broken for all setups that do memory hotplug with sparsemen
and NUMA, at least on powerpc.

What happens exactly is that the spufs code tries to register the memory
area owned by the SPU as hotplug memory in order to get page structs (we
probably shouldn't do it that way, but that's a separate discussion).

memmap_init_zone now calls early_pfn_valid() and early_pfn_in_nid()
in order to determine if the page struct should be initialized. This
is wrong for two reasons:

- early_pfn_in_nid checks the early_node_map variable to determine
  to which node the hot plugged memory belongs. However, the new
  memory never was part of the early_node_map to start with, so
  it incorrectly returns node zero, and then fails to initialize
  the page struct if we were trying to add it to a nonzero node.
  This is probably not a problem for pseries, but it is for cell.

- both early_pfn_{in,to}_nid and early_node_map are in the __init
  section and may already have been freed at the time we are calling
  memmap_init_zone().

The patch below is not a suggested fix that I want to get into mainline
(checking slab_is_available is the wrong here), but it is a quick fix
that you should apply if you want to run a recent (post-2.6.18) kernel
on the IBM QS20 blade. I'm sorry for not having reported this earlier,
but we were always trying to find the problem in my own code...

	Arnd <><

--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1962,7 +1962,8 @@ void __meminit memmap_init_zone(unsigned
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!early_pfn_valid(pfn))
 			continue;
-		if (!early_pfn_in_nid(pfn, nid))
+		if (!slab_is_available() &&
+		    !early_pfn_in_nid(pfn, nid))
 			continue;
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
