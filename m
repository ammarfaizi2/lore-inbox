Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWJ2Mq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWJ2Mq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWJ2Mq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:46:57 -0500
Received: from web32408.mail.mud.yahoo.com ([68.142.207.201]:58532 "HELO
	web32408.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965171AbWJ2Mq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:46:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AOA3txcDbR5p/yRxqVmJ3yq4ywvf6buJ1I0KojCeD2AWyQygJ/ysziLgJmmd7KAoRJsDp+RVeJB/h1OShV7Q/qO4EDrYE6Ws45ywW+8pYsN96PJkqtOust9sZHsjv92v2wCN7TbrwY4bXz4XJhh2Wz8T3Q9v4eIPBP5gApr4APo=  ;
Message-ID: <20061029124655.7014.qmail@web32408.mail.mud.yahoo.com>
Date: Sun, 29 Oct 2006 04:46:55 -0800 (PST)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
To: Pekka Enberg <penberg@cs.helsinki.fi>,
       "Martin J. Bligh" <mbligh@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>, pgiri@yahoo.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <84144f020610282358p6d2db50ybd1cbfa3716c53fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-295431475-1162126015=:4410"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-295431475-1162126015=:4410
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> Hi,
> 
> On 10/29/06, Martin J. Bligh <mbligh@google.com> wrote:
> > -git4 was fine. -git5 is broken (on PPC64 blade)
> >
> > As -rc2-mm2 seemed fine on this box, I'm guessing it's something
> > that didn't go via Andrew ;-( Looks like it might be something
> > JFS or slab specific. Bigger PPC64 box with different config
> > was OK though
> >
> > Full log is here: http://test.kernel.org/abat/59046/debug/console.log
> > Good -git4 run: http://test.kernel.org/abat/58997/debug/console.log
> >
> > kernel BUG in cache_grow at mm/slab.c:2705!
> > cpu 0x1: Vector: 700 (Program Check) at [c0000000fffb7710]
> >      pc: c0000000000c8ad4: .cache_grow+0x64/0x4f0
> >      lr: c0000000000c91a8: .cache_alloc_refill+0x248/0x2cc
> >      sp: c0000000fffb7990
> >     msr: 8000000000021032
> >    current = 0xc0000000fffab800
> >    paca    = 0xc00000000047e780
> >      pid   = 1, comm = swapper
> > kernel BUG in cache_grow at mm/slab.c:2705!
> > enter ? for help
> > [c0000000fffb7a60] c0000000000c91a8 .cache_alloc_refill+0x248/0x2cc
> > [c0000000fffb7b20] c0000000000c9708 .kmem_cache_alloc_node+0xd0/0x10c
> > [c0000000fffb7bc0] c0000000000b69cc .__get_vm_area_node+0xcc/0x230
> > [c0000000fffb7c70] c0000000000b7640 .__vmalloc_node+0x60/0xc0
> > [c0000000fffb7d10] c0000000001ad4c8 .txInit+0x2a0/0x3a8
> > [c0000000fffb7e20] c00000000044c1ec .init_jfs_fs+0x78/0x27c
> > [c0000000fffb7ec0] c0000000000094c0 .init+0x1f4/0x3e4
> > [c0000000fffb7f90] c000000000027270 .kernel_thread+0x4c/0x68
> 
> I only skimmed through this briefly but it looks like due to
> 52fd24ca1db3a741f144bbc229beefe044202cac __get_vm_area_node is passing
> GFP_HIGHMEM to kmem_cache_alloc_node which is a no-no.
> 

I haven't been able to reproduce this, although I understand why it happens:
vmalloc allocates memory with

GFP_KERNEL | __GFP_HIGHMEM

and with git5, the same flags are passed down to cache_alloc_refill, causing
the BUG. The following patch against 2.6.19-rc3-git5 (also attached as
attachment, as this mailer may mess up inline copying) should fix it.

Note that when calling kmalloc_node, I am masking off __GFP_HIGHMEM with
GFP_LEVEL_MASK, whereas __vmalloc_area_node does the same with

~(__GFP_HIGHMEM | __GFP_ZERO).

IMHO, using GFP_LEVEL_MASK is preferable, but either should fix this problem.

Signed-off-by: Giridhar Pemmasani (pgiri@yahoo.com)

diff -Naur linux-2.6.19-rc3-git5.orig/mm/vmalloc.c
linux-2.6.19-rc3-git5/mm/vmalloc.c
--- linux-2.6.19-rc3-git5.orig/mm/vmalloc.c     2006-10-29 07:26:34.000000000
-0500
+++ linux-2.6.19-rc3-git5/mm/vmalloc.c  2006-10-29 07:28:12.000000000 -0500
@@ -182,7 +182,7 @@
        addr = ALIGN(start, align);
        size = PAGE_ALIGN(size);

-       area = kmalloc_node(sizeof(*area), gfp_mask, node);
+       area = kmalloc_node(sizeof(*area), gfp_mask & GFP_LEVEL_MASK, node);
        if (unlikely(!area))
                return NULL;


 
____________________________________________________________________________________
Access over 1 million songs - Yahoo! Music Unlimited 
(http://music.yahoo.com/unlimited)

--0-295431475-1162126015=:4410
Content-Type: text/x-diff; name="__get_vm_area_node-should-mask-off-gfp-highmem.patch"
Content-Description: 16165293-__get_vm_area_node-should-mask-off-gfp-highmem.patch
Content-Disposition: inline; filename="__get_vm_area_node-should-mask-off-gfp-highmem.patch"

diff -Naur linux-2.6.19-rc3-git5.orig/mm/vmalloc.c linux-2.6.19-rc3-git5/mm/vmalloc.c
--- linux-2.6.19-rc3-git5.orig/mm/vmalloc.c	2006-10-29 07:26:34.000000000 -0500
+++ linux-2.6.19-rc3-git5/mm/vmalloc.c	2006-10-29 07:28:12.000000000 -0500
@@ -182,7 +182,7 @@
 	addr = ALIGN(start, align);
 	size = PAGE_ALIGN(size);
 
-	area = kmalloc_node(sizeof(*area), gfp_mask, node);
+	area = kmalloc_node(sizeof(*area), gfp_mask & GFP_LEVEL_MASK, node);
 	if (unlikely(!area))
 		return NULL;
 

--0-295431475-1162126015=:4410--
