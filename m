Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVIHROm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVIHROm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVIHROm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:14:42 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:22353 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964954AbVIHROl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:14:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cwBmVihmq+WCAOjb+kw8FpWLwohmTW/5r7ikQrPdeGTGdvQ9dcXgwcB4Cg50FW4NA1nQh7fx3A7eFP7cYemrqJhgoD60jBH3pKfiK5hwVVL6nzqmb2821PG6n4TJVrOuyxVr8yHHzQLgKBfK/ULb6fnE4c2N9jtSsbVrLQGx2gk=
Message-ID: <4789af9e05090810142bd3531d@mail.gmail.com>
Date: Thu, 8 Sep 2005 11:14:36 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: jim.ramsay@gmail.com
To: linux-usb-users@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Possible bug in usb storage (2.6.11 kernel)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have found a possible bug:

In usb/storage/transport.c, the routine usb_stor_Bulk_transport (and
perhaps other releated routines as well) has the following in the
"DATA STAGE" (around line 1020 in my file):

result = usb_stor_bulk_transfer_sg(us, pipe,
                                        srb->request_buffer, transfer_length,
                                        srb->use_sg, &srb->resid);

This looks fine, except that there is no guarantee that
srb->request_buffer is page-aligned or cache-aligned, as is required
according to Documentation/DMA-API.txt

In fact, on my MIPS platform, I sometimes get odd hangs and panics
because the later call to "dma_map_single" on this buffer causes a
cache invalidation, and since this memory is not necessarily
cache-aligned, sometimes too much cache is invalidated, which causes
interesting (and annoying) memory corruptions.  Usually I've seen it
change the 'request' pointer in us->current_urb to something slightly
different, or zero, depending on the system's mood, but I'm sure there
are other possible ugly side-effects of this.

The solution, as suggested by Documentation/DMA-API.txt is to ensure
that all buffers passed into dma_map_single are always cache-aligned
(or at least page-aligned).

I would suggest this should be fixed by using a new buffer allocated
by the usb storage layer and then copying the result back into the
srb->request_buffer.

I suppose the scsi code could be changed to guarantee that
srb->request_buffer is page-aligned or cache-aligned, but that seems
like the wrong solution for this bug.

Questions?  Comments?  Is this the right way to fix it?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
