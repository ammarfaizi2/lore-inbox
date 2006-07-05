Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWGEPss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWGEPss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWGEPss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:48:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:48397 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932166AbWGEPsr convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:48:47 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="93470953:sNHT21024283"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Wed, 5 Jul 2006 19:48:39 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CF71@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcagQ/o/Uh1UoVkASTmrTUwJ0EjD2wABFEfg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2006 15:48:45.0184 (UTC) FILETIME=[7F62C000:01C6A04A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
> What about replacing
>		pdflush_operation(background_writeout, 0);
> with
>  		if (pdflush_operation(background_writeout, 0))
>
>                 writeback_inodes(&wbc);
The is a latency betwean pdflush_operation() call and
writeback_in_progress(bdi) returns true.
As a result writeback_inodes() may be called in next loop before pdflush
is started. Pdflush detects that writeback_in_progress() returns true
for it and will exit.

Leonid
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Wednesday, July 05, 2006 6:57 PM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > suppose you have more than MAX_PDFLUSH_THREADS
 > Do you consider that the drawback of the patch is in that the value
 > MAX_PDFLUSH_THREADS is not well known high or this limit is not
deleted

I am more concerned, that this patch _limits_ maximal possible writeback
concurrency to MAX_PDFLUSH_THREADS.

 > at all? The limit could be deleted after patching because the line 

That sounds a bit too extreme, given that pdflush is used for a lot of
things other than background write-out.

 > +	if (writeback_in_progress(bdi)) {
 > keeps off creating extra pdflush threads.

What about replacing

 		pdflush_operation(background_writeout, 0);

with

 		if (pdflush_operation(background_writeout, 0))
                /*
                 * Fall back to synchronous writeback if all pdflush
                 * threads are busy.
                 */
                writeback_inodes(&wbc);

? This will combine increased concurrency in your target case (single
writer) with some safety net in the case of multiple writers and
multiple devices.

 > 
 > Leonid

Nikita.
