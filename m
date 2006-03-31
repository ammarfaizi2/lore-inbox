Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWCaId5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCaId5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWCaId4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:33:56 -0500
Received: from wproxy.gmail.com ([64.233.184.235]:13144 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751271AbWCaId4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:33:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=JCwApybw1jBbGJHuK6WynePuhlmko9iABSwXsMPasyGJ1q9lrgI8LGrrkackP1gig7pCU7JYGXExNjIqKOGQM5i8fu2CPvMHH8QUcfV0wNUlwAxK/ii7V6ZE5wtWKD1v4fjsAPxr5ibbqcjAP1zmpKoT85RaOQY5PoXCMr6bg5w=
Message-ID: <489ecd0c0603310033x7edcddebi48d6fbb62528a392@mail.gmail.com>
Date: Fri, 31 Mar 2006 16:33:55 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Nick Piggin" <npiggin@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix mm regression bug: nommu use compound page in slab allocator -- added one comment
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13293_15369861.1143794035377"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_13293_15369861.1143794035377
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

 The earlier patch to consolidate mmu and nommu page allocation
and refcounting by using compound pages for nommu allocations
had a bug: kmalloc slabs who's pages were initially allocated
by a non-__GFP_COMP allocator could be passed into mm/nommu.c
kmalloc allocations which really wanted __GFP_COMP underlying
pages. Fix that by having nommu pass __GFP_COMP to all higher order
slab allocations.

 Thanks Nick!

Signed-off-by: Luke Yang <luke.adi@gmail.com>
Acked-by: Nick Piggin <npiggin@suse.de>

 slab.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..5a782ff 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1454,7 +1454,14 @@ static void *kmem_getpages(struct kmem_c
        int i;

        flags |=3D cachep->gfpflags;
+#ifndef CONFIG_MMU
+       /* nommu uses slab's for process anonymous memory allocations, so
+        * requires __GFP_COMP to properly refcount higher order allocation=
s"
+        */
+       page =3D alloc_pages_node(nodeid, (flags | __GFP_COMP), cachep->gfp=
order);
+#else
        page =3D alloc_pages_node(nodeid, flags, cachep->gfporder);
+#endif
        if (!page)
                return NULL;
        addr =3D page_address(page);

--
Best regards,
Luke Yang,  Kernel for Blackfin maintainer
luke.adi@gmail.com

------=_Part_13293_15369861.1143794035377
Content-Type: text/x-patch; name=nommu_use_compound_page_in_slab.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elg9cv1j
Content-Disposition: attachment; filename="nommu_use_compound_page_in_slab.patch"

diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..5a782ff 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1454,7 +1454,14 @@ static void *kmem_getpages(struct kmem_c
 	int i;
 
 	flags |= cachep->gfpflags;
+#ifndef CONFIG_MMU
+	/* nommu uses slab's for process anonymous memory allocations, so
+	 * requires __GFP_COMP to properly refcount higher order allocations"
+	 */
+	page = alloc_pages_node(nodeid, (flags | __GFP_COMP), cachep->gfporder);
+#else
 	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+#endif
 	if (!page)
 		return NULL;
 	addr = page_address(page);

------=_Part_13293_15369861.1143794035377--
