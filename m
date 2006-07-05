Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWGEPBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWGEPBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWGEPBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:01:52 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:2538 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964902AbWGEPBv
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 5 Jul 2006 11:01:51 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17579.54077.486411.474731@gargle.gargle.HOWL>
Date: Wed, 5 Jul 2006 18:57:01 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06CF51@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06CF51@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > suppose you have more than MAX_PDFLUSH_THREADS
 > Do you consider that the drawback of the patch is in that the value
 > MAX_PDFLUSH_THREADS is not well known high or this limit is not deleted

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
