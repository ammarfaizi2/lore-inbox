Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWECApN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWECApN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWECApM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:45:12 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:23736 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964983AbWECApK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:45:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=sup27AEJf3KgddDKVNZOsGTg0ejcZnCP8vrwykN8ObGbRCOP5MjugOQ5wDSHWpnoHPVp9yD8R+beXE9zMoAL5Vej42HF6yP1LLRRhxWEU3lBTyQGtLkvuf74MRLLcU5BwdQ9A2VYIlf/3Hht7vzNEINe/wBEq9j5/NPKI+y0zRA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 00/14] remap_file_pages protection support
Date: Wed, 3 May 2006 02:44:58 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Ulrich Drepper <drepper@redhat.com>, Val Henson <val.henson@intel.com>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au>
In-Reply-To: <4456D5ED.2040202@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030245.01457.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 05:45, Nick Piggin wrote:
> blaisorblade@yahoo.it wrote:
> > The first idea is to use this for UML - it must create a lot of single
> > page mappings, and managing them through separate VMAs is slow.

> I think I would rather this all just folded under VM_NONLINEAR rather than
> having this extra MANYPROTS thing, no? (you're already doing that in one
> direction).

That step is _temporary_ if the extra usages are accepted.

Also, I reported (changelog of patch 03/14) a definite API bug you get if you 
don't distinguish VM_MANYPROTS from VM_NONLINEAR. I'm pasting it here because 
that changelog is rather long:

"In fact, without this flag, we'd have indeed a regression with
remap_file_pages VS mprotect, on uniform nonlinear VMAs.

mprotect alters the VMA prots and walks each present PTE, ignoring installed
ones, even when pte_file() is on; their saved prots will be restored on 
faults,
ignoring VMA ones and losing the mprotect() on them. So, in do_file_page(), we
must restore anyway VMA prots when the VMA is uniform, as we used to do before
this trail of patches."

> > Additional note: this idea, with some further refinements (which I'll
> > code after this chunk is accepted), will allow to reduce the number of
> > used VMAs for most userspace programs - in particular, it will allow to
> > avoid creating one VMA for one guard pages (which has PROT_NONE) -
> > forcing PROT_NONE on that page will be enough.

> I think that's silly. Your VM_MANYPROTS|VM_NONLINEAR vmas will cause more
> overhead in faulting and reclaim.

I know that problem. In fact for that we want VM_MANYPROTS without 
VM_NONLINEAR.

> It loooks like it would take an hour or two just to code up a patch which
> puts a VM_GUARDPAGES flag into the vma, and tells the free area allocator
> to skip vm_start-1 .. vm_end+1
we must refine which pages to skip (the example I saw has only one guard page, 
if I'm not mistaken) but 
> . What kind of troubles has prevented 
> something simple and easy like that from going in?

Fairly better idea... It's just the fact that the original proposal was wider, 
and that we looked to the problem in the wrong way (+ we wanted anyway to 
have the present work merged, so that wasn't a problem).

Ulrich wanted to have code+data(+guard on 64-bit) into the same VMA, but I 
left the code+data VMA joining away, to think more with it, since currently 
it's too slow on swapout.

The other part is avoiding guard VMAs for thread stacks, and that could be 
accomplished too by your proposal. Iff this work is held out, however.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
