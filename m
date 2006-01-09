Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWAIUPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWAIUPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWAIUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:15:36 -0500
Received: from silver.veritas.com ([143.127.12.111]:13196 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751298AbWAIUPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:15:35 -0500
Date: Mon, 9 Jan 2006 20:15:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Doug Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm
In-Reply-To: <9a8748490601091139pf5fb6a0v3c8b3bcb41b85940@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601092005510.16057@goblin.wat.veritas.com>
References: <20060107052221.61d0b600.akpm@osdl.org> 
 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com> 
 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com> 
 <20060109175748.GD25102@redhat.com>  <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
  <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com> 
 <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com> 
 <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com>
 <9a8748490601091139pf5fb6a0v3c8b3bcb41b85940@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2006 20:15:35.0012 (UTC) FILETIME=[72DEE240:01C61559]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Jesper Juhl wrote:
> On 1/9/06, Hugh Dickins <hugh@veritas.com> wrote:
> >
> > Remove sg_rb_correct4mmap() and its nasty __put_page()s, which are liable
> > to do quite the wrong thing.  Instead allocate pages with __GFP_COMP, then
> > high-orders should be safe for exposure to userspace by sg_vma_nopage(),
> > without any further manipulations.  Based on original patch by Nick Piggin.
> 
> Unfortunately that patch doesn't change a thing (except some
> addresses, but that's exected) :-(

Okay, thanks for trying.  Maybe you need to revert to the 2.6.15
drivers/scsi/sg.c for now (does that work for you in the 2.6.15-mm2
kernel?), or you could first try this little patch on 2.6.15-mm2
(either with or without my earlier patch - which will be wanted,
but not so urgently).  I've not attempted to review the changes
in detail, but this change (if no more) looks to be badly needed...
And it's 2.6.15-git needing the fix, not just -mm.


sg_page_malloc clear the data buffer, not that extent of mem_map.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.15-mm2/drivers/scsi/sg.c	2006-01-07 14:05:49.000000000 +0000
+++ linux/drivers/scsi/sg.c	2006-01-09 20:03:59.000000000 +0000
@@ -2493,7 +2493,7 @@ sg_page_malloc(int rqSz, int lowDma, int
 	}
 	if (resp) {
 		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
-			memset(resp, 0, resSz);
+			memset(page_address(resp), 0, resSz);
 		if (retSzp)
 			*retSzp = resSz;
 	}
