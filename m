Return-Path: <linux-kernel-owner+w=401wt.eu-S932622AbWLTAXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWLTAXf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWLTAXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:23:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48612 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622AbWLTAXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:23:34 -0500
Date: Tue, 19 Dec 2006 16:23:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166571749.10372.178.camel@twins>
Message-ID: <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
  <1166471069.6940.4.camel@localhost>  <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Peter Zijlstra wrote:
> On Mon, 2006-12-18 at 12:14 -0800, Linus Torvalds wrote:
> > OR:
> > 
> >  - page_mkclean_one() is simply buggy.
> 
> GOLD!

Ok. I was looking at that, and I wondered..

However, if that works, then I _think_ the correct sequence is the 
following..

The rule should be:
 - we flush the tlb _after_ we have cleared it, but _before_ we insert the 
   new entry.

But I dunno. These things are damn subtle. Does this patch fix it for you?

I actually suspect we should do this as an arch-specific macro, and 
totally replace the current "ptep_clear_flush_dirty()" with one that does 
"ptep_clear_flush_dirty_and_set_wp()".

Because what I'd _really_ prefer to do on x86 (and probably on most other 
sane architectures) is to do

 - atomically replace the pte with the EXACT SAME ONE, but one that 
   has the writable bit clear.

	bit_clear(_PAGE_BIT_RW, &(ptep)->pte_low);

 - flush the TLB, making sure that all CPU's will no longer write to it:

	flush_tlb_page(vma, address);

 - finally, just fetch-and-clear the dirty bit (and since it's no longer 
   writable, nobody should be settign it any more)

	ret = bit_clear(__PAGE_BIT_DIRTY, &(ptep)->pte_low);

and now we should be all done.

But the "ptep_get_and_clear() + flush_tlb_page()" sequence should 
hopefully also work.

Pls test.

		Linus

----
diff --git a/mm/rmap.c b/mm/rmap.c
index d8a842a..eec8706 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -448,9 +448,10 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
 		goto unlock;
 
 	entry = ptep_get_and_clear(mm, address, pte);
+	flush_tlb_page(vma, address);
 	entry = pte_mkclean(entry);
 	entry = pte_wrprotect(entry);
-	ptep_establish(vma, address, pte, entry);
+	set_pte_at(mm, address, pte, entry);
 	lazy_mmu_prot_update(entry);
 	ret = 1;
 

