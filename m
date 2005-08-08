Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVHHQsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVHHQsb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVHHQsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:48:31 -0400
Received: from graphe.net ([209.204.138.32]:40881 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932112AbVHHQsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:48:30 -0400
Date: Mon, 8 Aug 2005 09:48:22 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-arm@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1123422275.7800.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508080945100.19665@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net>  <1122930474.7648.119.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011414480.7574@graphe.net>  <1122931637.7648.125.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011438010.7888@graphe.net>  <1122933133.7648.141.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011517300.8498@graphe.net>  <1122937261.7648.151.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508031716001.24733@graphe.net>  <1123154825.8987.33.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508040703300.3277@graphe.net>  <1123166252.8987.50.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508050817060.28659@graphe.net> <1123422275.7800.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005, Richard Purdie wrote:

> > > We know the the failure case can be identified by the
> > > cmpxchg_fail_flag_update condition being met. Can you provide me with a
> > > patch to dump useful debugging information when that occurs?
> 
> Ok, this results in an infinite loop of one message with no change to
> the numbers:
> 
> cmpxchg fail mm=c3455ae0 vma=c355517c addr=4025f000 write=2048
> ptep=c2f0597c pmd=c2b79008 entry=88000f7 new=8800077

Ok. So we cannot set the dirty bit.

Here is a patch that also prints the pte status immediately before 
ptep_cmpxchg. I guess this will show that dirty bit is already set.

Does the ARM have some hardware capability to set dirty bits?

Index: linux-2.6.13-rc4-mm1/mm/memory.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/mm/memory.c	2005-08-05 08:38:10.000000000 -0700
+++ linux-2.6.13-rc4-mm1/mm/memory.c	2005-08-08 09:46:12.000000000 -0700
@@ -2104,6 +2104,8 @@
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
 	} else {
+		printk(KERN_CRIT "cmpxchg fail fault mm=%p vma=%p addr=%lx write=%d ptep=%p pmd=%p entry=%lx new=%lx current=%lx\n",
+				mm, vma, address, write_access, pte, pmd, pte_val(entry), pte_val(new_entry), *pte);
 		inc_page_state(cmpxchg_fail_flag_update);
 	}
 
