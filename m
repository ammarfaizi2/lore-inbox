Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966063AbWKIVwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966063AbWKIVwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966064AbWKIVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:52:16 -0500
Received: from ozlabs.org ([203.10.76.45]:20628 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S966063AbWKIVwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:52:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17746.52343.815568.368590@cargo.ozlabs.ibm.com>
Date: Thu, 9 Nov 2006 17:36:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Raisch <RAISCH@de.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k
	page mode
In-Reply-To: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
References: <aday7qngiuf.fsf@cisco.com>
	<OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Raisch writes:

> ioremap maps 4k pages on 4k kernels and on 64k pages on 64k kernels. So far
> the theory.
> 
> This is true for memory.

And for I/O. :)  ioremap updates the (Linux) page tables that map the
vmalloc/ioremap area, and that is at page granularity.  So there is in
fact no difference in the end result in the page tables whether you
ask to map a small amount inside a page, or the whole page.

> On POWER the ebus memory is mapped by H_ENTER.
> The hypervisor checks for 4k page size on H_ENTER, reason see above.

The next part of the story is that the low-level MMU code on System-P
(pSeries) machines only does the H_ENTER when you access an I/O
mapping.  It does H_ENTER for 4k pages for non-cacheable mappings,
and it only does the H_ENTER for the 4k subpages of a 64k page that
the kernel actually accesses.

So Roland is correct in his comment about how ioremap is called.

Regards,
Paul.
