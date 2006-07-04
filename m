Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWGDKJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWGDKJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGDKJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:09:55 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:6876 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932200AbWGDKJy
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 4 Jul 2006 06:09:54 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17578.15694.155328.809225@gargle.gargle.HOWL>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Tue, 4 Jul 2006 13:55:04 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov wtites:
 > > performs page-out even if queue is congested.
 > 	Yes. If user thread which generates dirty pages need in
 > reclaimed memory it consider own dirty page as candidate for page-out.
 > It functions as before patching.
 > 
 > > Intent of this is to throttle writers.
 > I suppose you means dirtier or write(2) caller but not writepage()
 > caller. The dirtier  is throttled  with backing_dev_info logic as before
 > patching.

I meant ->writepages() used by balance_dirty_pages(), see below.

 > 
 > 	While pdflush thread sorts pages for page-out it does not
 > consider as a candidate a page to be written with congested queue.
 > Pdflush thread functions as before patching. Pdflush tends to make pages
 > un-dirty without overload memory or IO and it is not need to let pdflush

This assumption is valid for ext2, where ->writepages() simply sends
pages to the storage, but other file systems (like reiser4) do a *lot*
of work in ->writepages() path, allocating quite an amount of memory
before starting write-out. With your patch, this work is done from
pdflush, and won't be throttled by may_write_to_queue() check, thus
increasing a risk of allocation failure.

 > do page-out with congested queue as you have proposed.
 > 	
 > Leonid

Nikita.
