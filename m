Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUAERwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUAERwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:52:12 -0500
Received: from magic-mail.adaptec.com ([216.52.22.10]:39828 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S265279AbUAERwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:52:01 -0500
Date: Mon, 05 Jan 2004 10:57:35 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
cc: Berkley Shands <berkley@cs.wustl.edu>
Subject: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple map/unmaps
Message-ID: <2938942704.1073325455@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berkley Shands recently tripped over this problem.  The 2.6.X pci_map_sg
code for x86_64 modifies the passed in S/G list to compact it for mapping
by the GART.  This modification is not reversed when pci_unmap_sg is
called.  In the case of a retried SCSI command, this causes any attempt
to map the command a second time to fail with a BUG assertion since the
nseg parameter passed into the second map call is state.  nseg comes from
the "use_sg" field in the SCSI command structure which is never touched
by the HBA drivers invoking pci_map_sg.

DMA-API.txt doesn't seem to cover this issue.  Should the low-level DMA
code restore the S/G list to its original state on unmap or should the
SCSI HBA drivers be changed to update "use_sg" with the segment count
reported by the pci_map_sg() API?  If the latter, this seems to contradict
the mandate in DMA-API that the nseg parameter passed into the unmap call
be the same as that passed into the map call.  Most of the kernel assumes
that an S/G list can be mapped an unmapped multiple times using the same
arguments.  This doesn't seem to me to be an unreasonable expectation.

--
Justin

