Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVCVTDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVCVTDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVCVTDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:03:30 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:7579
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261657AbVCVTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:03:23 -0500
Date: Tue, 22 Mar 2005 11:01:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322110144.3a3002d9.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here is a full dump of a free_pgtables() run that
fails to clear out all the PMD's.

It gets called with this VMA list (each entry is a
vm_start/vm_end tuple)

[0x00010000:0x000a4000]
[0x000b2000:0x000b8000]
[0x000b8000:0x000de000]
[0x70000000:0x7001a000]
[0x70028000:0x7002a000]
[0x7002c000:0x7006a000]
[0x7006a000:0x7006c000]
[0x7006c000:0x70084000]
[0x70084000:0x70088000]
[0x70088000:0x70094000]
[0x70094000:0x70098000]
[0x70098000:0x701da000]
[0x701da000:0x701e8000]
[0x701e8000:0x701f2000]
[0x701f2000:0x701f4000]
[0x701f4000:0x701fc000]
[0x701fc000:0x70204000]
[0x70204000:0x7020c000]
[0x7020c000:0x7021e000]
[0x7021e000:0x7022c000]
[0x7022c000:0x70230000]
[0x70230000:0x70232000]
[0x70234000:0x7023e000]
[0x7023e000:0x70244000]
[0x70244000:0x7024e000]
[0x70250000:0x7025a000]
[0x7025a000:0x70260000]
[0x70260000:0x7026c000]
[0xefbfe000:0xefc28000]

And then we start to iterate, here is the trace I got:

free_pgd_range(addr[0x1000],end[0xde000],floor[0x0],ceiling[0x70000000])
free_pud_range(addr[0x0],end[0xde000],floor[0x0],ceiling[0x70000000])
free_pmd_range(addr[0],end[0xde000],floor[0x0],ceiling[0x70000000])
free_pte_range(addr[0x0],next[0xde000],end[0xde000])   /* nr_ptes-- */

free_pgd_range(addr[0x70000000],end[0x7026c000],floor[0x0],ceiling[0xefbfe000])
free_pud_range(addr[0x70000000],end[0x7026c000],floor[0x0],ceiling[0xef800000])
/* does not do free_pmd_range() for some reason)

free_pgd_range(addr[0xefbfe000],end[0xefc28000],floor[0x0],ceiling[0x0])
free_pud_range(addr[0xef800000],end[0xefc28000],floor[0x0],ceiling[0x0])
/* also do not do free_pmd_range() */

Whoa, how does that work?  We are calling free_pgtables() at
exit_mmap() time with a 0 floor _and_ ceiling?

Oh I see, the tests are against "ceiling - 1".
Hmmm...

