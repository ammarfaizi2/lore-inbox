Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWGDUZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWGDUZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWGDUZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:25:38 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:26317 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932387AbWGDUZi
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 4 Jul 2006 16:25:38 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17578.52643.364026.64265@gargle.gargle.HOWL>
Date: Wed, 5 Jul 2006 00:20:51 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06CCF2@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06CCF2@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > When queue is congested---it is, because meta-data (indirect blocks in
 > > ext[23] case) have to be read in synchronously before page can be
 > paged
 > > out (see comment in mm/vmscan.c:pageout()).
 > 
 > Actually a queue is congested ---it is, because the queue is too long or
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
