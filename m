Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWGET3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWGET3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWGET3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:29:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:32572 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964966AbWGET3O convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:29:14 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="60927617:sNHT9849428680"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Wed, 5 Jul 2006 23:28:34 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CFA4@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcagQ/o/Uh1UoVkASTmrTUwJ0EjD2wAJSghg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2006 19:28:44.0011 (UTC) FILETIME=[3A7FEBB0:01C6A069]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have added proposed by Nikita lines
		if (pdflush_operation(background_writeout, 0))
                writeback_inodes(&wbc);
and tested it with iozone. The throughput is 50-53 MB/sec. It is less
than 74-105 MB/sec results sent earlier.

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
