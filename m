Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWC3JAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWC3JAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWC3JAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:00:11 -0500
Received: from wproxy.gmail.com ([64.233.184.234]:63414 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932118AbWC3JAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:00:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=pTK9p9CTupLc35lHaDHZJGVN2NMhUfNMc2lAS6dsTW3qoCimtyyjEKq0G4ALhsFo7iyr0RTDlktoXI+IEgVSPSjdKxo3oWNOYpKrFaLtNAZupq9trgjHUJzZ1U/JEIuUxWUW0/8+P2D0LVkwaOR9SjOCve5lKtdke/vteYQhyRk=
Message-ID: <489ecd0c0603300100o7e9293b4mbde4340b0129e5d5@mail.gmail.com>
Date: Thu, 30 Mar 2006 17:00:09 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] nommu page refcount bug fixing
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <npiggin@suse.de>
In-Reply-To: <489ecd0c0603300056t272b4d22g8501302f4f86fc85@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_809_3329942.1143709209525"
References: <489ecd0c0603291905m7ebffff2j83809cc3c93595f1@mail.gmail.com>
	 <442B4EEB.6020407@yahoo.com.au>
	 <489ecd0c0603300056t272b4d22g8501302f4f86fc85@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_809_3329942.1143709209525
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > NOMMU special-casing in page refcounting. As a temporary fix, what I
> > think should happen is simply for all slab allocations to ask for
> > __GFP_COMP pages.
> >
> > Could you check that fixes your problem?
>   It works.  What's your plan to modify nommu mm? I would like to
> help. And I am also interested in implementing the "non-power-of-2"
> allocator in 2.6.
>
>   New patch:
  Sorry! Previous patch only works for nommu...  Here's the correct one:
Signed-off-by: Luke Yang <luke.adi@gmail.com>

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

> --
> Best regards,
> Luke Yang (Kernel for Blackfin maintainer)
> luke.adi@gmail.com
>
>
>


--
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_809_3329942.1143709209525
Content-Type: text/x-patch; name=nommu_use_compound_page_in_slab.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eleuuzzp
Content-Disposition: attachment; filename="nommu_use_compound_page_in_slab.patch"

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
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

------=_Part_809_3329942.1143709209525--
