Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVCTWjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVCTWjA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCTWiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:38:54 -0500
Received: from fmr16.intel.com ([192.55.52.70]:46976 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261315AbVCTWiq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:38:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] arch hook for notifying changes in PTE protections bits
Date: Sun, 20 Mar 2005 14:38:11 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB7506494303346A10@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] arch hook for notifying changes in PTE protections bits
Thread-Index: AcUs5QH45zo5EUbeR/++xnSW/E/69AAr9EWw
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "David S. Miller" <davem@davemloft.net>, <davidm@hpl.hp.com>
Cc: <davidm@napali.hpl.hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Mar 2005 22:38:12.0779 (UTC) FILETIME=[7FD63FB0:01C52D9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <mailto:davem@davemloft.net> wrote on Saturday, March
19, 2005 4:27 PM:

> On Sat, 19 Mar 2005 12:30:05 -0800
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> 
>> I agree about your concern about cost.  Accessing the page_map is
>> expensive (integer division + memory access) and we have to do that
>> in order to find out if the page is i-cache clean.
> 
> First, it's a multiply by reciprocol.  At least on sparc64 I get
> this emitted by the compiler.
> 
> Secondly, if you're willing to sacrifice 8 bytes per page struct
> simply define WANT_PAGE_VIRTUAL and page struct will be exactly
> 64 bytes and thus the divide a will turn into a simple shift.

As said earlier, set_pte_at is getting called from different places.
Not all of these times, we are actually installing valid page entries in
page tables.  Validating the incoming entry for all of these scenarois
(or changing page struct) is an extra overhead that should be
avoided...besides being less palatable as compared to new API.

The recent changes in interfaces, because of set_pte_at, does provide an
opportunity though to handle mprotect issue little differently.  We
could call update_mmu_cache after setting the new protections in
change_pte_range function.....similar to the way update_mmu_cache gets
called at fault and any other times......though for this solution, we
need to extend change_pte_range interface to have vma parameter as well.



-rohit
