Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWGEFoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWGEFoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 01:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWGEFoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 01:44:04 -0400
Received: from mga03.intel.com ([143.182.124.21]:65377 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932386AbWGEFoD convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 01:44:03 -0400
X-IronPort-AV: i="4.06,206,1149490800"; 
   d="scan'208"; a="61336702:sNHT6097922194"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Wed, 5 Jul 2006 09:40:02 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CD4C@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcafqCPHuXZa/mpQRxaM+Sr78D7EZAARxSZw
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2006 05:40:03.0438 (UTC) FILETIME=[76BA90E0:01C69FF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nikita Danilov writes:
> Doing large amounts of writeback from pdflush threads makes situation
> only worse: suppose you have more than MAX_PDFLUSH_THREADS devices on
> the system, and large number of writing threads. If some devices
become
> congested, then *all* pdflush threads may easily stuck waiting on
queue
> congestion and there will be no IO going on against other devices.
This
> would be especially bad, if system is a mix of slow and fast devices.

*all* pdflush threads may NOT waiting on single queue because function
balance_dirty_pages() tests it:

	if (writeback_in_progress(bdi))
		return;		/* pdflush is already working this queue
*/

> Yes, that was silly proposal. I think your patch contains very useful
> idea, but it cannot be applied to all file systems. Maybe
> wait-for-pdflush can be made optional, depending on the file system
> type?

I suppose MS DOS was the last operating system which had considered
that parallelism is not applicable.

Leonid
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Wednesday, July 05, 2006 12:21 AM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > When queue is congested---it is, because meta-data (indirect blocks
in
 > > ext[23] case) have to be read in synchronously before page can be
 > paged
 > > out (see comment in mm/vmscan.c:pageout()).
 > 
 > Actually a queue is congested ---it is, because the queue is too long
or
 > bit BDI_write[read]_congested is set.
 > 
 > > But much more importantly: when direct reclaim skips writing dirty
 > pages
 > > from tail of the inactive list,
 > 
 > The  direct reclaim does not skip any page in pdflush thread because
 > may_write_to_queue() returns true
 > if (current->flags & PF_SWAPWRITE) and: __pdflush() sets this flag:
 > See pfflush.c: __pdflush() first line
 > current->flags |= PF_FLUSHER | PF_SWAPWRITE;

Hm.. indeed it is. But this is quite strange. This means, that if some
device queues are congested, pdflush threads will be stuck waiting for
these queues to drain, and as there is only limited number of pdflush
threads in the system, write-out to the non-congested devices will not
progress too.

Doing large amounts of writeback from pdflush threads makes situation
only worse: suppose you have more than MAX_PDFLUSH_THREADS devices on
the system, and large number of writing threads. If some devices become
congested, then *all* pdflush threads may easily stuck waiting on queue
congestion and there will be no IO going on against other devices. This
would be especially bad, if system is a mix of slow and fast devices.

In the original code, threads writing into fast devices are not impacted
by congestion of slow devices.

You can deal with that particular situation in your patch by checking
return value of

        pdflush_operation(background_writeout, 0);

and falling back to synchronous write-back if it fails to find worker
thread.

 > 
 > > Wouldn't this interfere with current->backing_dev_info logic?
 > > Maybe pdflush threads should set this field too?
 > It is not need to set current->backing_dev_info for pdflush because

Yes, that was silly proposal. I think your patch contains very useful
idea, but it cannot be applied to all file systems. Maybe
wait-for-pdflush can be made optional, depending on the file system
type?

 > PF_SWAPWRITE is set for pdflush.
 > The proposed patch does not concern of backing_dev_info logic.
 > 
 > Leonid 

Nikita.
