Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVI0R2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVI0R2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVI0R2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:28:20 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:33155 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965021AbVI0R2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:28:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:To:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=U/nqf5zCg0+hn8FVN0vUaIaoMZEUZ/q+mfvGmCADRz+45QuTDa+JLVfWUFgN79zzDejo3Lxcy28hSbrjO3z9oMOb4xFRsh9aJhuJpALcmmgc523kLL44nXDhiIZQHdCieUMGqex2OhE0cW1pFZa09ticH700++WHKX2d2lYX4pQ=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for UML), try 3
Date: Mon, 26 Sep 2005 17:58:22 +0200
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>, Ulrich Drepper <drepper@redhat.com>
References: <200508262023.29170.blaisorblade@yahoo.it> <200509042110.01968.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Disposition: inline
To: Hugh Dickins <hugh@veritas.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509261758.23705.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 September 2005 14:00, Hugh Dickins wrote:
> On Sun, 4 Sep 2005, Blaisorblade wrote:
> > > This seems reasonable to me.  I was afraid you were going to extend
> > > VM_NONLINEAR to private maps, but no, you're just letting private maps
> > > be populated linearly, that's fine.

> > Would that be a real problem, when limited to readonly mappings?
> > There's some interest in that, for library loading - a binary with 100
> > dso's has 300 vmas...

> You seem to see vmas as nothing but obstacles.
> Perhaps there is a reason 
> we divide the mm into vmas?
Let's not exaggerate, I've not suggested dropping VMA entirely.

It's just that UML is a workload suffering for the tree lookup, and Ulrich 
Drepper found another case where the tree lookup was a problem.

I also thought to the lookup function in itself, but I've no easy road to go 
(I've been thinking to radix trees, but they can be way worse on 64bit with 
many little mappings) and that is even more invasive (though it would 
theoretically be a cleaner solution).

> But perhaps there is a better way of doing it. 
For instance, replacing PROT_NONE vmas, which are inserted just to prevent 
mappings in those areas (which must be instead left as guard pages), with 
simple PROT_NONE ptes, is fairly simple.

[...]
> I think I get the picture now: you start with a dark sky, then insert the
> stars one by one.  Yes, I accept what I proposed would be of no use to you.

> Okay, so as well as the VM_FAULT_SIGSEGV case, you do need to add that
> preliminary check to each arch.

> So far as I can see (I may have missed it), you really don't need to
> change from the write boolean

> (perhaps -1 for exec in one arch??)
? Not understood this part, ignoring it?
Maybe you mean "except one arch, x86_64, which supports exec protection?"
> to the  
> write_access mask: it's not a bad change, but the less you have to modify
> each of the architectures, the better for now.
Yes, I see your point. Using VM_READ, especially, is often unneeded (I think 
we don't do "executable, not readable" or "writable, not readable"). I've now 
simplified the handling for the arches, allowing them to be changed much 
less.

However, I think it's better to leave the generic code as-is, while extending 
the wrapper, to pass VM_READ too. So, only archs wanting to do execute 
protection, or to support strange things as "write allowed, read disallowed", 
will need to use access_mask.
> > That check may be moved later, to beginning of bad_area, if you say
> > "default prots are the minimum one, I can only remap with more permissive
> > settings". That would avoid affecting the fast path - even if the branch
> > is clearly an "unlikely" one, so shouldn't give mispredictions at least.

> Would it?  Anyway, although it fits with UML's particular usage (starting
> from PROT_NONE), your minimum permissions idea seems neither natural nor
> useful to me (and I don't think you're convinced by it either, just trying
> to offer a constructive alternative).

Exactly... I don't like it, even because it would disallow using 
r_f_p(PROT_NONE) in place of PROT_NONE vma for guard pages.

> No, just stick with the "unlikely" test in the obvious place where you
> already put it, and leave it for later optimization to rearrange that if
> necessary: perhaps Christoph L will want modify the ia64 path, to move
> that test down into the bad_area handling, to jump back if manyprots;
That is not an optimization, but a breakage, for the case where I have (say) a 
readable mapping, but a PROT_NONE page in it. I know because I've hit this 
problem with my testprogram.

Unless you use the "minimum prots" ideas, or there is something I'm missing in 
ia64 (it seems not - and IIRC it supports branch prediction hints from the 
compiler).
> but no need for spaghetti in the initial implementation.

> > > Sorry, I do not know when I can next face going over this,
> > > it's a hard task for me: perhaps someone else can take over.

> I get very sick of holding up 
> other people's requirements, but yours is not the first in line.
Don't worry for that, and I really appreciate your review on my first VM work. 
Thanks a lot!
> Hugh

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
