Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVCVSji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVCVSji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVCVShF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:37:05 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:62383
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261630AbVCVSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:35:59 -0500
Date: Tue, 22 Mar 2005 10:34:23 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322103423.53cfaae5.davem@davemloft.net>
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

On Tue, 22 Mar 2005 16:37:09 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> If you and David could try the lame patch below,
> it'll at least give us a slight clue of where to be looking -
> every mm exiting with nr_ptes 1 means something different from
> every mm exiting with nr_ptes -1 means something different from
> occasional mms exiting with nr_ptes something positive.

I didn't use your debugging patch, I used something slightly
more sophisticated to simply traces nr_ptes counter bumps
then halt the system when the BUG_ON(mm->nr_ptes) triggered
so I could analyze things.

What happens is (all virtual addresses are PMD_MASK'd):

1) We map 3 PTE tables.
   0x0000000000000000
   0x0000000070000000
   0x00000000ef800000
2) We only unmap one PTE table.
   0x0000000000000000
3) Then we of course BUG() because nr_ptes is 2

I'm now adding more debugging to figure out why only the
first PTE table is being unmapped.
