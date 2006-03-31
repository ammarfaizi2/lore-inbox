Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWCaCLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWCaCLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWCaCLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:11:46 -0500
Received: from wproxy.gmail.com ([64.233.184.226]:59919 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751108AbWCaCLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:11:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ZuPoBJ+k4mm4zMvKZ9A+mmH4v4Tift6mXwfriN9znQ79ELuXloyJtB481hVTlusNJ9sc1IeX8c6QKaglMi4egWvlQeYXBPqZz/EvIFtiJ9gpLqGyWbtR3adDEb/JNU0lc5uTLt2ArdXq84/7l07wSweDUAH38nvxlQJt3usQvlo=
Message-ID: <489ecd0c0603301811u3c8b6ac3lbe03a93a92bebf44@mail.gmail.com>
Date: Fri, 31 Mar 2006 10:11:45 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Nick Piggin" <npiggin@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix mm regression bug: nommu use compound page in slab allocator
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11631_27981299.1143771105196"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_11631_27981299.1143771105196
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

 slab.c |    4 ++++
1 files changed, 4 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..388a6a9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1454,7 +1454,11 @@ static void *kmem_getpages(struct kmem_c
        int i;

        flags |=3D cachep->gfpflags;
+#ifdef CONFIG_MMU
        page =3D alloc_pages_node(nodeid, flags, cachep->gfporder);
+#else
+       page =3D alloc_pages_node(nodeid, (flags | __GFP_COMP), cachep->gfp=
order);
+#endif
        if (!page)
                return NULL;
        addr =3D page_address(page);

--
Best regards,
Luke Yang,  Kernel for Blackfin maintainer
luke.adi@gmail.com

------=_Part_11631_27981299.1143771105196
Content-Type: text/x-patch; name=nommu_use_compound_page_in_slab.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elfv9v2t
Content-Disposition: attachment; filename="nommu_use_compound_page_in_slab.patch"

diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..388a6a9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1454,7 +1454,11 @@ static void *kmem_getpages(struct kmem_c
 	int i;
 
 	flags |= cachep->gfpflags;
+#ifdef CONFIG_MMU
 	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+#else
+	page = alloc_pages_node(nodeid, (flags | __GFP_COMP), cachep->gfporder);
+#endif
 	if (!page)
 		return NULL;
 	addr = page_address(page);



------=_Part_11631_27981299.1143771105196--
