Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUJ1Ovc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUJ1Ovc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUJ1OtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:49:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24968 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261683AbUJ1OsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:48:22 -0400
Date: Thu, 28 Oct 2004 10:06:51 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, javier@marcet.info,
       linux-kernel@vger.kernel.org, kernel@kolivas.org,
       barry <barry@disus.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
Message-ID: <20041028120650.GD5741@logos.cnet>
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:33:35PM -0400, Rik van Riel wrote:
> On Mon, 25 Oct 2004, Rik van Riel wrote:
> > On Mon, 25 Oct 2004, Andrew Morton wrote:
> > > Rik van Riel <riel@redhat.com> wrote:
> > > >
> > > > -		if (referenced && page_mapping_inuse(page))
> > > > +		if (referenced && sc->priority && page_mapping_inuse(page))
> > > 
> > > Makes heaps of sense, but I'd like to exactly understand why people are
> > > getting oomings before doing something like this.  I think we're still
> > > waiting for a testcase?
> > 
> > I'm now running Yum on a (virtual) system with 96MB RAM and
> > 100MB swap.  This used to get an OOM kill very quickly, but
> > still seems to be running now, after 20 minutes.
> 
> It completed, without being OOM killed like before.

Barry,

Can you please test Rik's patch with your spurious OOM kill testcase?

===== mm/vmscan.c 1.231 vs edited =====
--- 1.231/mm/vmscan.c	Sun Oct 17 01:07:24 2004
+++ edited/mm/vmscan.c	Mon Oct 25 17:38:56 2004
@@ -379,7 +379,7 @@
 
 		referenced = page_referenced(page, 1);
 		/* In active use or really unfreeable?  Activate it. */
-		if (referenced && page_mapping_inuse(page))
+		if (referenced && sc->priority && page_mapping_inuse(page))
 			goto activate_locked;
 
 #ifdef CONFIG_SWAP
@@ -715,7 +715,7 @@
 		if (page_mapped(page)) {
 			if (!reclaim_mapped ||
 			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0)) {
+			    (page_referenced(page, 0) && sc->priority)) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}

