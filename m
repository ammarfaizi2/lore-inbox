Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWEQRmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWEQRmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWEQRmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:42:37 -0400
Received: from silver.veritas.com ([143.127.12.111]:1335 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750794AbWEQRmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:42:36 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,138,1146466800"; 
   d="scan'208"; a="38255344:sNHT21434272"
Date: Wed, 17 May 2006 18:42:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, discuss@x86-64.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage boundries
 when needed
In-Reply-To: <1147885316.26468.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 May 2006 17:42:36.0027 (UTC) FILETIME=[48A4ECB0:01C679D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Eric Paris wrote:
> sys_m{,un}lock and do_mlock all align memory references and the length
> of the mlock given by userspace to page boundaries.  If the page being
> mlocked is a hugepage instead of a normal page the start and finish of
> the mlock will still only be aligned to normal page boundaries.
> Ultimately upon the process exiting we will eventually call unmap_vmas
> which will call unmap_hugepage_range for all of the ranges.
> unmap_hugepage_range checks to make sure the beginning and the end of
> the range are actually hugepage aligned and if not will BUG().  Since we
> only aligned to a normal page boundary the end of the first range and
> the beginning of the second will likely (unless userspace passed of
> values already hugepage aligned) not be hugepage aligned and thus we
> bomb.

When did you test this?  It should have been fixed in 2.6.11 onwards
by split_vma()'s simple:

	if (is_vm_hugetlb_page(vma) && (addr & ~HPAGE_MASK))
		return -EINVAL;

Hugh
