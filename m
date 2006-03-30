Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWC3I4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWC3I4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWC3I4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:56:35 -0500
Received: from wproxy.gmail.com ([64.233.184.225]:51634 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932100AbWC3I4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:56:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=cXB8WtrIadwa1zjD3NoDJbxLlLTNC6PsaPSSQ4zG5pKWvQovM2eD80mnD53foMI8LQXuUp7KXWe7MLJZh0bqPOb9El58jFGR3ZBI5Ic6NetWHrc+SJt0VPLWI6efALWDbVxrKKAXsQxCUnOFmayspMvW1M+GPl2budHMPXRem8Y=
Message-ID: <489ecd0c0603300056t272b4d22g8501302f4f86fc85@mail.gmail.com>
Date: Thu, 30 Mar 2006 16:56:34 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] nommu page refcount bug fixing
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <npiggin@suse.de>
In-Reply-To: <442B4EEB.6020407@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_797_11725657.1143708994175"
References: <489ecd0c0603291905m7ebffff2j83809cc3c93595f1@mail.gmail.com>
	 <442B4EEB.6020407@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_797_11725657.1143708994175
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/30/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Luke Yang wrote:
>
> Yep, sorry this slipped into the kernel. It's my fault for not giving
> Andrew a fix for it.
>
> As you might know, page refcounting in nommu was already broken, so
> I'm working on a proper solution to fix it.
>
> In the meantime though, this is a step backwards and reintroduces
> NOMMU special-casing in page refcounting. As a temporary fix, what I
> think should happen is simply for all slab allocations to ask for
> __GFP_COMP pages.
>
> Could you check that fixes your problem?
  It works.  What's your plan to modify nommu mm? I would like to
help. And I am also interested in implementing the "non-power-of-2"
allocator in 2.6.

  New patch:
Signed-off-by: Luke Yang <luke.adi@gmail.com>

diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..f93d3d5 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1454,7 +1454,7 @@ static void *kmem_getpages(struct kmem_c
        int i;

        flags |=3D cachep->gfpflags;
-       page =3D alloc_pages_node(nodeid, flags, cachep->gfporder);
+       page =3D alloc_pages_node(nodeid, (flags | __GFP_COMP), cachep->gfp=
order);
        if (!page)
                return NULL;
        addr =3D page_address(page);

--
Best regards,
Luke Yang (Kernel for Blackfin maintainer)
luke.adi@gmail.com

------=_Part_797_11725657.1143708994175
Content-Type: text/x-patch; name=nommu_use_compound_page_in_slab.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eleupogg
Content-Disposition: attachment; filename="nommu_use_compound_page_in_slab.patch"

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..f93d3d5 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1454,7 +1454,7 @@ static void *kmem_getpages(struct kmem_c
 	int i;
 
 	flags |= cachep->gfpflags;
-	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	page = alloc_pages_node(nodeid, (flags | __GFP_COMP), cachep->gfporder);
 	if (!page)
 		return NULL;
 	addr = page_address(page);

------=_Part_797_11725657.1143708994175--
