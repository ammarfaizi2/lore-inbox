Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWDKVeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWDKVeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWDKVeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:34:36 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:47580 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751126AbWDKVef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:34:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Userland swsusp failure (mm-related)
Date: Tue, 11 Apr 2006 23:33:22 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Fabio Comolli <fabio.comolli@gmail.com>,
       linux-kernel@vger.kernel.org
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604090047.17372.rjw@sisk.pl> <443868A5.1020503@yahoo.com.au>
In-Reply-To: <443868A5.1020503@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112333.22677.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 09 April 2006 03:51, Nick Piggin wrote:
> Rafael J. Wysocki wrote:
> >>>Well, it looks like we didn't free enough RAM for suspend in this case.
> >>>Unfortunately we were below the min watermark for ZONE_NORMAL and
> >>>we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
> >>>ZONE_DMA in this case?).
> >>>
> >>>I think we can safely ignore the watermarks in swsusp, so probably
> >>>we can set PF_MEMALLOC for the current task temporarily and reset
> >>>it when we have allocated memory.  Pavel, what do you think?
> >>
> >>Seems little hacky but okay to me.
> >>
> >>Should not fixing "how much to free" computation to free a bit more be
> >>enough to handle this?
> > 
> > 
> > Yes, but in that case we'll leave some memory unused. ;-)
> > 
> 
> Probably doesn't fall back to ZONE_DMA because of lowmem reserve.
> Yes, PF_MEMALLOC sounds like it might do what you want. A little
> hackish perhaps, but better than putting swsusp special cases
> into page_alloc.c.

The appended patch contains the changes I'd like to make.  Pavel, is that
acceptable?

Rafael

---
 kernel/power/snapshot.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/kernel/power/snapshot.c	2006-04-08 21:29:55.000000000 +0200
+++ linux-2.6.17-rc1-mm2/kernel/power/snapshot.c	2006-04-11 22:09:28.000000000 +0200
@@ -461,17 +461,23 @@ static struct pbe *swsusp_alloc(unsigned
 {
 	struct pbe *pblist;
 
+	/* We don't want to be affected by zone watermarks etc. */
+	current->flags |= PF_MEMALLOC;
+
 	if (!(pblist = alloc_pagedir(nr_pages, GFP_ATOMIC | __GFP_COLD, 0))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
-		return NULL;
+		goto out;
 	}
 
 	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, 0)) {
 		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
 		swsusp_free();
-		return NULL;
+		pblist = NULL;
 	}
 
+out:
+	current->flags &= ~PF_MEMALLOC;
+
 	return pblist;
 }
 
