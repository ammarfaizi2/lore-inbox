Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUITUlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUITUlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUITUlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:41:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48568 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267343AbUITUl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:41:26 -0400
Date: Mon, 20 Sep 2004 13:22:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Ray Bryant <raybry@sgi.com>
Cc: wli@holomorphy.com, mbligh@aracnet.com, akpm@osdl.org, ak@suse.de,
       raybry@austin.rr.com, linux-mm@kvack.org, jbarnes@sgi.com, djh@sgi.com,
       lse-tech@lists.sourceforge.net, bcasavan@sgi.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, raybry@sgi.com,
       haveblue@us.ibm.com
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache
 allocation
Message-Id: <20040920132250.251736d0.pj@sgi.com>
In-Reply-To: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nits ... 

1) better change this line in mempolicy.h

	#define MPOL_MAX MPOL_INTERLEAVE

   to be instead

	#define MPOL_MAX MPOL_ROUNDROBIN 

2) Why change the alloc_page_vma() code structure for
   MPOL_INTERLEAVE from starting with:

	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {

   to starting with:

	switch (pol->policy) {
		case MPOL_INTERLEAVE:

   Doesn't the original way work just as well (and keep the patch
   smaller)?  Just add another 'if(...MPOL_ROUNDROBIN)' section
   following the MPOL_INTERLEAVE section.  And the other switch
   statements in this file don't indent the case lines a tab further.

3) The following line looks like it could trigger after a
   hotplug node removal (not that I know how to do that yet):

	BUG_ON(!test_bit(nid, (const volatile void *) &node_online_map));

   Should the '(const volatile void *)' cast be a nodes_addr() wrapper? 

   Can this entire line be dropped, or turned into a test:

	if (!node_isset(nid, node_online_map))
		continue;

4) Patches done with the 'diff -p' option are slightly easier to
   read, as they show the procedure the diff seems to appear in.

5) I see no need for the 'else' in:

	-	if (pol->policy == MPOL_INTERLEAVE)
	+	if (pol->policy == MPOL_INTERLEAVE) {
	 		return alloc_page_interleave(gfp, order, interleave_nodes(pol));
	+	} else if (pol->policy == MPOL_ROUNDROBIN) {
	+		return alloc_page_roundrobin(gfp, order, pol);
	+	}

   Couldn't one just have this less intrusive patch instead:

		if (pol->policy == MPOL_INTERLEAVE)
			return alloc_page_interleave(gfp, order, interleave_nodes(pol));
	+	if (pol->policy == MPOL_ROUNDROBIN)
	+		return alloc_page_roundrobin(gfp, order, pol);
		return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
	 }

6) Can the added rr_next in task_struct be shared with il_next?

7) Why doesn't alloc_page_roundrobin() have its own accounting, like
   alloc_page_interleave() does?

8) Could you explain the for loop in alloc_page_roundrobin()?  Won't
   the first call to __alloc_pages() within the loop search down all
   the nodes in the system, in a numa friendly order (closer nodes
   first)?  Why then pick another node to search from, in the next
   pass of the for loop, which will again search down the same nodes,
   using a differently sorted zonelist.  Obviously I'm missing something
   here.

9) Too bad there's not some pseudo-random value floating around somewhere,
   such as a per-node clock or something, that could be used to drive a
   pseudo-uniform distribution, without any need for the additional rr_next
   state?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
