Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVCCFIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVCCFIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVCCFFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:05:33 -0500
Received: from ozlabs.org ([203.10.76.45]:60378 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261265AbVCCE7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:59:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.39386.686708.768378@cargo.ozlabs.ibm.com>
Date: Thu, 3 Mar 2005 16:00:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, benh@kernel.crashing.org, anton@samba.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
In-Reply-To: <20050302201425.2b994195.akpm@osdl.org>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	<20050302174507.7991af94.akpm@osdl.org>
	<Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	<20050302185508.4cd2f618.akpm@osdl.org>
	<Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
	<20050302201425.2b994195.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> But if the approach which these patches take is not suitable for these
> architectures then they have no solution to the scalability problem.  The
> machines will perform suboptimally and more (perhaps conflicting)
> development will be needed.

We can do a pte_cmpxchg on ppc64.  We already have a busy bit in the
PTE and do most operations atomically, in order to ensure that we
don't get races or inconsistencies due to accesses to the PTE by the
low-level hash_page() routine (which instantiates a hardware PTE in
the hardware hash table based on a Linux PTE), because it already
accesses the linux page tables without taking the mm->page_table_lock.

However, there are other developments we are considering in this area:
notably Ben wants to change things so that when we invalidate a Linux
PTE we leave it busy until we actually remove the hardware PTE from
the hash table.  Also we are looking forward to DaveM's patch which
will change the generic MM code to give us the mm and address on all
PTE operations, which will simplify some things for us.  I don't
really want to have to think about pte_cmpxchg until those other
things are sorted out.

More generally, I would be interested to know what sorts of
applications or benchmarks show scalability problems on large machines
due to contention on mm->page_table_lock.

Paul.
