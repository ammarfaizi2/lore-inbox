Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVCCGzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVCCGzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVCCGxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:53:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:44244 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261540AbVCCGOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:14:47 -0500
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Anton Blanchard <anton@samba.org>
In-Reply-To: <Pine.LNX.4.58.0503022149210.4272@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	 <20050302174507.7991af94.akpm@osdl.org>
	 <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	 <20050302185508.4cd2f618.akpm@osdl.org>
	 <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
	 <20050302201425.2b994195.akpm@osdl.org>
	 <16934.39386.686708.768378@cargo.ozlabs.ibm.com>
	 <20050302213831.7e6449eb.davem@davemloft.net>
	 <Pine.LNX.4.58.0503022149210.4272@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 17:11:53 +1100
Message-Id: <1109830313.5680.183.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 21:51 -0800, Christoph Lameter wrote:
> On Wed, 2 Mar 2005, David S. Miller wrote:
> 
> > Actually, I guess I could do the pte_cmpxchg() stuff, but only if it's
> > used to "add" access.  If the TLB miss handler races, we just go into
> > the handle_mm_fault() path unnecessarily in order to synchronize.
> >
> > However, if this pte_cmpxchg() thing is used for removing access, then
> > sparc64 can't use it.  In such a case a race in the TLB handler would
> > result in using an invalid PTE.  I could "spin" on some lock bit, but
> > there is no way I'm adding instructions to the carefully constructed
> > TLB miss handler assembler on sparc64 just for that :-)
> 
> There is no need to provide pte_cmpxchg. If the arch does not support
> cmpxchg on ptes (CONFIG_ATOMIC_TABLE_OPS not defined)
> then it will fall back to using pte_get_and_clear while holding the
> page_table_lock to insure that the entry is not touched while performing
> the comparison.

Nah, this is wrong :)

We actually _want_ pte_cmpxchg on ppc64, because we can do the stuff,
but it requires some careful manipulation of some bits in the PTE that
are beyond linux common layer understanding :) Like the BUSY bit which
is a lock bit for arbitrating with the hash fault handler for example.

Also, if it's ever used to cmpxchg from anything but a !present PTE, it
will need additional massaging (like the COW case where we just
"replace" a PTE with set_pte). We also need to preserve some bits in
there that indicate if the PTE was in the hash table and where in the
hash so we can flush it afterward.

Ben.


