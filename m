Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWGDLnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWGDLnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGDLnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:43:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:8001 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932214AbWGDLnX convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:43:23 -0400
X-IronPort-AV: i="4.06,204,1149490800"; 
   d="scan'208"; a="60368190:sNHT19201910"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Tue, 4 Jul 2006 15:43:16 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC0541AB@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcafUgtfV3FK6V9tQBSYitmrOPffHAADKoaw
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jul 2006 11:43:22.0072 (UTC) FILETIME=[0D506580:01C69F5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wtites:
>> Pdflush thread functions as before patching. Pdflush tends to make
pages
>> un-dirty without overload memory or IO and it is not need to let
pdflush

> This assumption is valid for ext2

The assumption that pdflush should to make pages un-dirty without
overload memory or IO is not for ext2 but for it sense. I'm working with
ext3. A lot of work it does while writepages(). pdflush is throttled:
while vmscan have sorted 32 page for paging-out it calls
blk_congestion_wait() nevertheless had it put one of 32 page into
congested queue or had not. pdflush is throttled.

Leonid
 

-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Tuesday, July 04, 2006 1:55 PM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov wtites:
 > > performs page-out even if queue is congested.
 > 	Yes. If user thread which generates dirty pages need in
 > reclaimed memory it consider own dirty page as candidate for
page-out.
 > It functions as before patching.
 > 
 > > Intent of this is to throttle writers.
 > I suppose you means dirtier or write(2) caller but not writepage()
 > caller. The dirtier  is throttled  with backing_dev_info logic as
before
 > patching.

I meant ->writepages() used by balance_dirty_pages(), see below.

 > 
 > 	While pdflush thread sorts pages for page-out it does not
 > consider as a candidate a page to be written with congested queue.
 > Pdflush thread functions as before patching. Pdflush tends to make
pages
 > un-dirty without overload memory or IO and it is not need to let
pdflush

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
