Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUHPOjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUHPOjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUHPOjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:39:17 -0400
Received: from holomorphy.com ([207.189.100.168]:34471 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266048AbUHPOjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:39:14 -0400
Date: Mon, 16 Aug 2004 07:39:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing pte locks?
Message-ID: <20040816143903.GY11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Lameter <clameter@sgi.com>,
	"David S. Miller" <davem@redhat.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com> <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com> <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, David S. Miller wrote:
>> munmap() can destroy pmd and pte tables.  somehow we have
>> to protect against that, and currently that is having the
>> VMA semaphore held for reading, see free_pgtables().

On Sun, Aug 15, 2004 at 08:29:11PM -0700, Christoph Lameter wrote:
> It looks to me like the code takes care to provide the correct
> sequencing so that the integrity of pgd,pmd and pte links is
> guaranteed from the viewpoint of the MMU in the CPUs. munmap is there to
> protect one kernel thread messing with the addresses of these entities
> that might be stored in another threads register.
> Therefore it is safe to walk the chain only holding the semaphore read
> lock?

Detached pagetables are assumed to be freeable after a TLB flush IPI.
Previously holding ->page_table_lock would prevent the shootdowns of
links to the pagetable page from executing concurrently with
modifications to the pagetable page. Disabling interrupts or otherwise
inhibiting the progress of the IPI'ing cpu is needed to prevent
dereferencing freed pagetables and incorrect accounting based on
contents of about-to-be-freed pagetables. Reference counting pagetable
pages may help here, where the final put would be responsible for
unaccounting the various things in the pagetable page.


-- wli
