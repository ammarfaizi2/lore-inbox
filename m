Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSL2Xqi>; Sun, 29 Dec 2002 18:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSL2Xqi>; Sun, 29 Dec 2002 18:46:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:31479 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262296AbSL2Xqh>;
	Sun, 29 Dec 2002 18:46:37 -0500
Message-ID: <3E0F8B4C.568C018C@digeo.com>
Date: Sun, 29 Dec 2002 15:54:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
References: <20021229202610.GA24554@lnuxlab.ath.cx> <3E0F5E2C.70F7D112@digeo.com> <20021229233236.GA25035@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2002 23:54:52.0801 (UTC) FILETIME=[AE3CE710:01C2AF95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> On Sun, Dec 29, 2002 at 12:42:20PM -0800, Andrew Morton wrote:
> > khromy wrote:
> > >
> > > Running 2.5.53-mm3, I found the following in dmesg.  I don't remember
> > > getting anything like this with 2.5.53-mm3.
> > >
> > > xmms: page allocation failure. order:5, mode:0x20
> >
> > gack.  Someone is requesting 128k of memory with GFP_ATOMIC.  It fell
> > afoul of the reduced memory reserves.  It deserved to.
> >
> > Could you please add this patch, and make sure that you have set
> > CONFIG_KALLSYMS=y?  This will find the culprit.
> 
> XFree86: page allocation failure. order:0, mode:0xd0
> Call Trace:
>  [<c012a3dd>] __alloc_pages+0x255/0x264
>  [<c012a414>] __get_free_pages+0x28/0x60
>  [<c012c7e6>] cache_grow+0xb6/0x20c
>  [<c012c9cf>] __cache_alloc_refill+0x93/0x220
>  [<c012cb96>] cache_alloc_refill+0x3a/0x58
>  [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
>  [<c017e36c>] journal_alloc_journal_head+0x10/0x68
>  [<c017e458>] journal_add_journal_head+0x80/0x120

oops, sorry.  They're all expected.  I'd like to know where
the 5-order failure during xmms usage came from.  Were you
using a CDROM at the time??

This should tell us, thanks:


--- 25/mm/page_alloc.c~a	Sun Dec 29 15:52:29 2002
+++ 25-akpm/mm/page_alloc.c	Sun Dec 29 15:52:47 2002
@@ -547,6 +547,8 @@ nopage:
 		printk("%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
 			current->comm, order, gfp_mask);
+		if (order > 3)
+			dump_stack();
 	}
 	return NULL;
 }

_
