Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWGDTMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWGDTMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWGDTMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:12:44 -0400
Received: from mga03.intel.com ([143.182.124.21]:13400 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932342AbWGDTMo convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:12:44 -0400
X-IronPort-AV: i="4.06,205,1149490800"; 
   d="scan'208"; a="61200472:sNHT19309465"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Tue, 4 Jul 2006 23:12:36 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CCF2@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcafbC73n7XuBcVKRn+K8Z7rwHTmFgALcuCg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jul 2006 19:12:43.0097 (UTC) FILETIME=[D3565490:01C69F9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
> When queue is congested---it is, because meta-data (indirect blocks in
> ext[23] case) have to be read in synchronously before page can be
paged
> out (see comment in mm/vmscan.c:pageout()).

Actually a queue is congested ---it is, because the queue is too long or
bit BDI_write[read]_congested is set.

> But much more importantly: when direct reclaim skips writing dirty
pages
> from tail of the inactive list,

The  direct reclaim does not skip any page in pdflush thread because
may_write_to_queue() returns true
if (current->flags & PF_SWAPWRITE) and: __pdflush() sets this flag:
See pfflush.c: __pdflush() first line
current->flags |= PF_FLUSHER | PF_SWAPWRITE;

> Wouldn't this interfere with current->backing_dev_info logic?
> Maybe pdflush threads should set this field too?
It is not need to set current->backing_dev_info for pdflush because
PF_SWAPWRITE is set for pdflush.
The proposed patch does not concern of backing_dev_info logic.

Leonid 

-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Tuesday, July 04, 2006 5:12 PM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > 
 > > With your patch, this work is done from
 > > pdflush, and won't be throttled by may_write_to_queue() check, thus
 > > increasing a risk of allocation failure.
 > ....
 > After Nikita Danilov agrees that
 > > pdflush is throttled through blk_congestion_wait(), but it is not
 > > throttled by writing dirty from the tail of inactive list
 > 
 > The 'writing dirty from the tail of inactive list' is asynchronous
 > writing and it is not applicable for throttling.

When queue is congested---it is, because meta-data (indirect blocks in
ext[23] case) have to be read in synchronously before page can be paged
out (see comment in mm/vmscan.c:pageout()).

But much more importantly: when direct reclaim skips writing dirty pages
from tail of the inactive list, it instead moves these pages to the head
of this list, and reclaims clean pages instead. These clean pages are
"hotter" than skipped dirty pages, and as has been checked many times
already, this is bad, because doing reclaim in LRU order is important.

 > 
 > Leonid

Nikita.
