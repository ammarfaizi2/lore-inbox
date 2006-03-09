Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWCIJIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWCIJIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWCIJIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:08:41 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:9601 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751461AbWCIJIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:08:40 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Thu, 9 Mar 2006 20:08:16 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
References: <200603081013.44678.kernel@kolivas.org> <200603081212.03223.kernel@kolivas.org> <440FEDF7.2040008@aitel.hist.no>
In-Reply-To: <440FEDF7.2040008@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603092008.16792.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 19:57, Helge Hafting wrote:
> Con Kolivas wrote:
> >On Wed, 8 Mar 2006 12:11 pm, Andrew Morton wrote:
> >>but, but.  If prefetching is prefetching stuff which that game will soon
> >>use then it'll be an aggregate improvement.  If prefetch is prefetching
> >>stuff which that game _won't_ use then prefetch is busted.  Using yield()
> >>to artificially cripple kprefetchd is a rather sad workaround isn't it?
> >
> >It's not the stuff that it prefetches that's the problem; it's the disk
> >access.
>
> Well, seems you have some sorry kind of disk driver then?
> An ide disk not using dma?
>
> A low-cpu task that only abuses the disk shouldn't make an impact
> on a 3D game that hogs the cpu only.  Unless the driver for your
> harddisk is faulty, using way more cpu than it need.
>
> Use hdparm, check the basics:
> unmaksirq=1, using_dma=1, multcount is some positive number,
> such as 8 or 16, readahead is some positive number.
> Also use hdparm -i and verify that the disk is using some
> nice udma mode.  (too old for that, and it probably isn't worth
> optimizing this for...)
>
> Also make sure the disk driver isn't sharing an irq with the
> 3D card.
>
> Come to think of it, if your 3D game happens to saturate the
> pci bus for long times, then disk accesses might indeed
> be noticeable as they too need the bus.  Check if going to
> a slower dma mode helps - this might free up the bus a bit.

Thanks for the hints. 

However I actually wrote the swap prefetch code and this is all about changing 
its behaviour to make it do what I want. The problem is that nice 19 will 
give it up to 5% cpu in the presence of a nice 0 task when I really don't 
want swap prefetch doing anything. Furthermore because it is constantly 
waking up from sleep (after disk activity) it is always given lower latency 
scheduling than a fully cpu bound nice 0 task - this is normally appropriate 
behaviour. Yielding regularly works around that issue. 

Ideally taking into account cpu usage and only working below a certain cpu 
threshold may be the better mechanism and it does appear this would be more 
popular. It would not be hard to implement, but does add yet more code to an 
increasingly complex heuristic used to detect "idleness". I am seriously 
considering it.

Cheers,
Con
