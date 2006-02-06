Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWBFJcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWBFJcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWBFJcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:32:25 -0500
Received: from silver.veritas.com ([143.127.12.111]:54035 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750843AbWBFJcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:32:24 -0500
Date: Mon, 6 Feb 2006 09:32:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Brian King <brking@us.ibm.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
In-Reply-To: <43E66FB6.6070303@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0602060909180.6827@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031953400.14829@goblin.wat.veritas.com> <43E3D3EC.3040006@us.ibm.com>
 <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com> <43E66FB6.6070303@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Feb 2006 09:32:23.0945 (UTC) FILETIME=[3C5E5F90:01C62B00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Brian King wrote:
> 
> No. I can't find any code in any architecture that modifies either the length,
> page, or offset fields in the *_map_sg routines.

>From looking at the source, the architectures I found to be doing
scatterlist coalescing in some cases were alpha, ia64, parisc (some
code under drivers), powerpc, sparc64 and x86_64.

I agree with you that it would be possible for them to do the coalescing
by just adjusting dma_address and dma_length (though it's architecture-
dependent whether there are such fields at all), not interfering with
the input page and length; and maybe some of them do proceed that way.
I didn't find the coalescing code in any of them very easy to follow.

So please examine arch/x86_64/kernel/pci_gart.c gart_map_sg (and
dma_map_cont which it calls): x86_64 was the architecture on which
the problem was really found with drivers/scsi/st.c, and avoided
by that boot option iommu=nomerge.

Lines like "*sout = *s;" and "*sout = sg[start];" are structure-
copying whole scallerlist entries from one position in the list
to another, without explicit mention of the page and length fields.

> I'm still failing to see an actual bug in the ipr driver. Unless there is a
> good reason for pushing additional complexity on every caller of pci_map_sg
> to do additional bookkeeping, such as an architecture that is actually
> modifying
> fields in the scatterlist other than the dma_* fields, then I think it makes
> more sense to clarify the API to say that pci_map_sg will not modify these
> fields.

The API is commendably clear that they may be modified.  Like you I'd
prefer it to be otherwise, and instead guarantee that they won't be:
that would prevent this kind of surprise.  But it's not how it is;
and looking at the various pieces of coalescing code, I quickly
abandoned my first inclination, to adjust them to make it so.

Hugh
