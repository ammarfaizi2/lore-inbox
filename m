Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUFQOyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUFQOyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUFQOyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:54:18 -0400
Received: from magic.adaptec.com ([216.52.22.17]:5265 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S266524AbUFQOww convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:52:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Proposal for new generic device API: dma_get_required_mask()
Date: Thu, 17 Jun 2004 10:52:49 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189FD24032@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Proposal for new generic device API: dma_get_required_mask()
Thread-Index: AcRUdS/kP+2zVmFbTsucpZBldt84egAA/XWg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "James Bottomley" <James.Bottomley@steeleye.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I said in the other thread, if the SG list was not the descending
order page and instead was in ascending order allocations, we would have
a major reduction in the quantity of SG elements thus not having to make
this performance tradeoff. Not making the request moot, still worth
doing for other optimizations such as preventing DAC cycles with the
upper 32 bits all zero, but the real hit in performance for the aacraid
driver is the shear quantity of increased sized SG elements.

Currently, large requests come through as follows:

SG#	Size	Phys
0	4096	ef400000
1	4096	ef3ff000
2	4096	ef3fe000
3	4096	ef3fd000
. . .

Another change in F/W that is altering the interface to deal with this
problem allows us to negotiate a larger FIB (adapter command packet)
size to accommodate a huge number of SG elements. We can dodge this
bullet as well for Linux if this SG element allocation issue is
resolved.

FYI, when we allow 4M I/O to occur with this new larger FIB size, the
system performance drops to its knees. Mouse movement is sluggish etc.
there appears to be some scaling issues that I have yet to understand or
characterize to root cause.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of James Bottomley
Sent: Thursday, June 17, 2004 10:09 AM
To: Linux Kernel; SCSI Mailing List
Subject: Proposal for new generic device API: dma_get_required_mask()

Background:

We have a large number of devices in scsi: aacraid, aic7xxx, qla1280,
qla2xxx which can all do full 64 bit DMA, but which pay a performance
penalty for using the larger descriptors (aic7xxx is stranger in that it
has three modes of operation: 32 bit, 39 bit and 64 bit each with an
increasing performance penalty).

What all these devices would like to do is instead of simply trying the
64 bit mask first and having the platform accept it, even if it only has
< 4GB of memory, they'd like to be able to have the platform tell them,
given my current dma mask setting, what's the actual number of bits you
need me to DMA to.

This is precisely what the API would do.  It would return a bit mask
(never over the current dma_mask) that the platform considers optimal. 
The platform has complete freedom in this: it may return a mask covering
the total physical memory, or a mask covering all the bits it needs
setting for some weird numa scheme.

If the driver decides to use the mask, it would do another
dma_set_mask() to confirm it (this gives the platform the opportunity if
it so chooses to return a mask that doesn't quite cover memory, but
would be more optimal...say for platforms that have all memory under 4GB
bar one small chunk at 64GB or something).

Once the driver has the platform's optimal mask, it can use this to
decide on the correct descriptor size.

Comments?

James



-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
