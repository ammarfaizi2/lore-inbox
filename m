Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVCCQwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVCCQwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVCCQwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:52:43 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57048 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261980AbVCCQwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:52:35 -0500
Date: Thu, 3 Mar 2005 08:52:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "David S. Miller" <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
In-Reply-To: <1109830313.5680.183.camel@gaston>
Message-ID: <Pine.LNX.4.58.0503030852020.8941@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com> 
 <20050302174507.7991af94.akpm@osdl.org>  <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
  <20050302185508.4cd2f618.akpm@osdl.org>  <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
  <20050302201425.2b994195.akpm@osdl.org>  <16934.39386.686708.768378@cargo.ozlabs.ibm.com>
  <20050302213831.7e6449eb.davem@davemloft.net> 
 <Pine.LNX.4.58.0503022149210.4272@schroedinger.engr.sgi.com>
 <1109830313.5680.183.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:

> > There is no need to provide pte_cmpxchg. If the arch does not support
> > cmpxchg on ptes (CONFIG_ATOMIC_TABLE_OPS not defined)
> > then it will fall back to using pte_get_and_clear while holding the
> > page_table_lock to insure that the entry is not touched while performing
> > the comparison.
>
> Nah, this is wrong :)
>
> We actually _want_ pte_cmpxchg on ppc64, because we can do the stuff,
> but it requires some careful manipulation of some bits in the PTE that
> are beyond linux common layer understanding :) Like the BUSY bit which
> is a lock bit for arbitrating with the hash fault handler for example.
>
> Also, if it's ever used to cmpxchg from anything but a !present PTE, it
> will need additional massaging (like the COW case where we just
> "replace" a PTE with set_pte). We also need to preserve some bits in
> there that indicate if the PTE was in the hash table and where in the
> hash so we can flush it afterward.

You can define your own pte_cmpxchg without a problem ...
