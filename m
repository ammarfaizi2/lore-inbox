Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWGDJpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWGDJpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGDJpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:45:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:3701 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750883AbWGDJpL convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:45:11 -0400
X-IronPort-AV: i="4.06,203,1149490800"; 
   d="scan'208"; a="60330812:sNHT1681035937"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Tue, 4 Jul 2006 13:44:04 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC054117@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcafRbNvhTAS63C/S1SXScY8eFPbzAAAKtLA
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jul 2006 09:44:13.0527 (UTC) FILETIME=[6872FE70:01C69F4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wtites:
> performs page-out even if queue is congested.
	Yes. If user thread which generates dirty pages need in
reclaimed memory it consider own dirty page as candidate for page-out.
It functions as before patching.

> Intent of this is to throttle writers.
I suppose you means dirtier or write(2) caller but not writepage()
caller. The dirtier  is throttled  with backing_dev_info logic as before
patching. 

	While pdflush thread sorts pages for page-out it does not
consider as a candidate a page to be written with congested queue.
Pdflush thread functions as before patching. Pdflush tends to make pages
un-dirty without overload memory or IO and it is not need to let pdflush
do page-out with congested queue as you have proposed.
	
Leonid
	
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Tuesday, July 04, 2006 12:33 PM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely


[Please, don't trim CC/To fields: LKML is too high traffic to read in
its entirety.]

Ananiev, Leonid I writes:
 >  Nikita Danilov writes:
 > > Wouldn't this interfere with current->backing_dev_info logic?
 > 
 > The proposed patch does not modify that logic.

Indeed, it *interferes* with it: in the original code, process doing
direct reclaim during balance_dirty_pages()

 
generic_file_write()->balance_dirty_pages()->...->__alloc_pages()->...->
pageout()

performs page-out even if queue is congested. Intent of this is to
throttle writers, and reduce risk of running oom (certain file systems,
especially ones with delayed allocation, tend to allocate a lot of
memory in balance_dirty_pages()->writepages() paths).

Your patch breaks this mechanism.

Nikita.
