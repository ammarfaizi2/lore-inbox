Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWKHKTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWKHKTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965335AbWKHKTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:19:37 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:13744 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964857AbWKHKTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:19:36 -0500
In-Reply-To: <aday7qngiuf.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page
 mode
To: Roland Dreier <rdreier@cisco.com>
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org, rolandd@cisco.com
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 8 Nov 2006 11:22:27 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 08/11/2006 11:22:38
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland Dreier wrote on 07.11.2006 20:25:12:

>  > -   *mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
>  > +   *mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
>  > +      (physaddr & (~PAGE_MASK));
>
> I'm confused -- shouldn't ioremap() do the right thing even if
> physaddr isn't page-aligned?  Why is this needed?
>
>  - R.

ioremap maps 4k pages on 4k kernels and on 64k pages on 64k kernels. So far
the theory.

This is true for memory.

For mapped PCI or ebus registers things are a bit different.
Some PCI adapters expect that every other 4k page is a new area with
different meaning starts
(some PCI adapters are definetly ehca and mellanox here). The consequence
is you have to map
only 4k instead of 64k, otherwise you'd map 15 other "access areas" are
also mapped.

On POWER the ebus memory is mapped by H_ENTER.
The hypervisor checks for 4k page size on H_ENTER, reason see above.

The nopage handler now does seperate 4k H_ENTERs even for 64k pages in the
ebus area,
therefore we have to register a 64k page on a 64k boundary, and the nopage
triggers the right H_ENTER
as soon as we access the page at the right offset.

We plan to change that as soon as the base kernel can handle mixed
pagesizes in a more official way.

Christop R.


