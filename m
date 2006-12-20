Return-Path: <linux-kernel-owner+w=401wt.eu-S964944AbWLTJC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWLTJC7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWLTJC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:02:59 -0500
Received: from amsfep19-int.chello.nl ([62.179.120.14]:61581 "EHLO
	amsfep19-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944AbWLTJC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:02:57 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 10:01:36 +0100
Message-Id: <1166605296.10372.191.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 16:23 -0800, Linus Torvalds wrote:
> 
> On Wed, 20 Dec 2006, Peter Zijlstra wrote:
> > On Mon, 2006-12-18 at 12:14 -0800, Linus Torvalds wrote:
> > > OR:
> > > 
> > >  - page_mkclean_one() is simply buggy.
> > 
> > GOLD!
> 
> Ok. I was looking at that, and I wondered..
> 
> However, if that works, then I _think_ the correct sequence is the 
> following..
> 
> The rule should be:
>  - we flush the tlb _after_ we have cleared it, but _before_ we insert the 
>    new entry.
> 
> But I dunno. These things are damn subtle. Does this patch fix it for you?

I will try, but I had a look around the different architectures
implementation of ptep_clear_flush_dirty() and saw that not all do the
actual flush. So if we go down this road perhaps we should introduce
another per arch function that does the potential flush. like
flush_tlb_on_clear_dirty() or something like that.

Then we could write:

  entry = ptep_get_and_clear(mm, address, ptep)
  flush_tlb_on_clear_dirty(vma, address);
  entry = pte_mkclean(entry);
  entry = pte_wrprotect(entry);
  set_pte_at(mm, address, ptep, entry);

> I actually suspect we should do this as an arch-specific macro, and 
> totally replace the current "ptep_clear_flush_dirty()" with one that does 
> "ptep_clear_flush_dirty_and_set_wp()".
> 
> Because what I'd _really_ prefer to do on x86 (and probably on most other 
> sane architectures) is to do
> 
>  - atomically replace the pte with the EXACT SAME ONE, but one that 
>    has the writable bit clear.
> 
> 	bit_clear(_PAGE_BIT_RW, &(ptep)->pte_low);
> 
>  - flush the TLB, making sure that all CPU's will no longer write to it:
> 
> 	flush_tlb_page(vma, address);
> 
>  - finally, just fetch-and-clear the dirty bit (and since it's no longer 
>    writable, nobody should be settign it any more)
> 
> 	ret = bit_clear(__PAGE_BIT_DIRTY, &(ptep)->pte_low);
> 
> and now we should be all done.

Hmm, should we not flush after clearing the dirty bit? That is, why does
ptep_clear_flush_dirty() need a flush after clearing that bit? does it
leak through in the tlb copy?

Also, what is this page_test_and_clear_dirty() business, that seems to
be exclusively s390 btw. However they do seem to need this.

> But the "ptep_get_and_clear() + flush_tlb_page()" sequence should 
> hopefully also work.

Yeah, probably, not optimally so on some archs that don't actually need
the flush though. And as above, I wonder about s390.

(added our s390 friends to the CC list)

