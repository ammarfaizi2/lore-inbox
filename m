Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVCCFq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVCCFq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVCCFkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:40:52 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:61876
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261475AbVCCFiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:38:50 -0500
Date: Wed, 2 Mar 2005 21:38:31 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, clameter@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, benh@kernel.crashing.org, anton@samba.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
Message-Id: <20050302213831.7e6449eb.davem@davemloft.net>
In-Reply-To: <16934.39386.686708.768378@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	<20050302174507.7991af94.akpm@osdl.org>
	<Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	<20050302185508.4cd2f618.akpm@osdl.org>
	<Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
	<20050302201425.2b994195.akpm@osdl.org>
	<16934.39386.686708.768378@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005 16:00:10 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Andrew Morton writes:
> 
> > But if the approach which these patches take is not suitable for these
> > architectures then they have no solution to the scalability problem.  The
> > machines will perform suboptimally and more (perhaps conflicting)
> > development will be needed.
> 
> We can do a pte_cmpxchg on ppc64.

We really can't make use of this on sparc64.  Unlike ppc64 I don't
have the hash table issue (although sparc64 TLB's have a hash lookup
helping mechanism in hardware, which we ignore since virtually mapped
linear page tables are faster than Sun's bogus TSB table scheme).

I make all real faults go through the handle_mm_fault() path so all
page table modifications are serialized by the page table lock.
The TLB miss handlers never modify PTEs, not even to update access
and dirty bits.

Actually, I guess I could do the pte_cmpxchg() stuff, but only if it's
used to "add" access.  If the TLB miss handler races, we just go into
the handle_mm_fault() path unnecessarily in order to synchronize.

However, if this pte_cmpxchg() thing is used for removing access, then
sparc64 can't use it.  In such a case a race in the TLB handler would
result in using an invalid PTE.  I could "spin" on some lock bit, but
there is no way I'm adding instructions to the carefully constructed
TLB miss handler assembler on sparc64 just for that :-)
