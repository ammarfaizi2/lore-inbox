Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751979AbWCKMOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWCKMOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 07:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWCKMOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 07:14:20 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:20117 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751433AbWCKMOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 07:14:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M5+OgA5wJgsZRS2nXSW/w1FMtypGKwS8iYzt2Owj5Nnjdeuu+pVL/M91dCDS1XXs93W8NZ7TYlpOE3SEVu1MLUV0vl4CpskgSAqxQ7fFKKtHM9W2m9YUNXnjny0qIK1esgfpO68vcoS1Y6QM2J0JK/T+5S+eG9RZ1xXL1vZ6RYA=
Message-ID: <aec7e5c30603110414m1690ecd4qf2dcd545858cc8a5@mail.gmail.com>
Date: Sat, 11 Mar 2006 21:14:14 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [PATCH 01/03] Unmapped: Implement two LRU:s
Cc: "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
In-Reply-To: <Pine.LNX.4.64.0603101113210.28805@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <20060310034417.8340.49483.sendpatchset@cherry.local>
	 <Pine.LNX.4.64.0603101113210.28805@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Fri, 10 Mar 2006, Magnus Damm wrote:
>
> > Use separate LRU:s for mapped and unmapped pages.
> >
> > This patch creates two instances of "struct lru" per zone, both protected by
> > zone->lru_lock. A new bit in page->flags named PG_mapped is used to determine
> > which LRU the page belongs to. The rmap code is changed to move pages to the
> > mapped LRU, while the vmscan code moves pages back to the unmapped LRU when
> > needed. Pages moved to the mapped LRU are added to the inactive list, while
> > pages moved back to the unmapped LRU are added to the active list.
>
> The swapper moves pages to the unmapped list? So the mapped LRU
> lists contains unmapped pages? That would get rid of the benefit that I
> saw from this scheme. Pretty inconsistent.

The first (non released) versions of these patches modified rmap.c to
move the pages between the LRU:s both during adding and removing
rmap:s, so the mapped LRU would in that case keep mapped pages only.
This did however introduce more overhead, because pages only mapped by
a single process would bounce between the LRU:s when a such process
starts or terminates.

The split active list implementation by Nick Piggin did however only
move pages between the active lists during vmscan (if I understood the
patch correctly), which is something that I have not tried yet.

I think it would be interesting with 3 active lists, one for unmapped
pages, one for mapped file-backed pages and one for mapped anonymous
pages. And then let the vmscan code move pages between the lists.

Thank you for the comments!

/ magnus
