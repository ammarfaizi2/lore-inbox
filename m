Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVIDTNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVIDTNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 15:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVIDTNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 15:13:13 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:52325 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751036AbVIDTNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 15:13:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=h0lrFJ+NnbGKLDhhx07/qRM93l4YuO6vq4XuFKOjrRNNHZTLaJe9AI4Tx5KReUAudKYmSXZktJjXzhfLyxMjB9vOwv/xcbbXzEevqtHzeiHzoOR3v8IurTTTU355lbxtQVh7FAlqy6pActHETFYNv0xSEemuvL7gbYCt0Qear9I=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for UML), try 3
Date: Sun, 4 Sep 2005 21:10:01 +0200
User-Agent: KMail/1.8.1
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200508262023.29170.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509022201020.11937@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509022201020.11937@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509042110.01968.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 23:02, Hugh Dickins wrote:
> On Fri, 26 Aug 2005, Blaisorblade wrote:
> > * The first 2 patches modify the PTE encoding macros and start preparing
> > the VM for the new situation (i.e. VMA which have variable protections,
> > which are called VM_NONUNIFORM. I dropped the early VM_MANYPROTS name).

> What a pity: please revert.  VM_NONUNIFORM sounds impressive, but might
> mean all kinds of things, maybe to do with NUMA.  VM_MANYPROTS is good,
> it says what it means.
Ok. Btw, before I forget: I assume I should redo the patches rather than fix 
what you say on top of mine, (at least when not changing behaviour), right?
> > * Patch 11 is a big simplification. Since we must encode the PTE's on
> > swapout like in VM_NONLINEAR vmas, the simplest way to reuse the existing
> > code is to make sure that VM_NONUNIFORM vmas are also marked as
> > VM_NONLINEAR.

> In some places you seem to say that you (UML) only need VM_MANYPROTS vmas
> linear, in other places you seem to say that your VM_MANYPROTS vmas will
> be nonlinear.  I've no idea which way round it is.  Perhaps the "non"
> sometimes goes missing (another reason to avoid NONUNIFORM).

> I wrote that yesterday.  Thanks, you've cleared it up in private mail:
> the VM_MANYPROTS vmas that UML wants are VM_NONLINEAR anyway.

> Yes, I see your dilemma there: you rightly want to avoid adding bloat
> by distinguishing cases that you don't need distinguished; but equally
> rightly fear that someone somewhere will start using the VM_MANYPROTS
> for other reasons, and hit the inefficiencies of VM_NONLINEAR
> unnecessarily.  I share your uncertainty, I don't have an immediate
> feel for the right direction on that.
We'll see later if we can cater to this case without messing up zap_pte_range 
as I did in last patch (that is the only one with which I was able to break 
something - not in the version I sent, however).
> > *) No more usage of a new syscall slot: to use the new interface,
> > application will use the new MAP_NOINHERIT flag I've added. I've still
> > the patches to use the old -mm ABI, if there's any reason they're needed.

> I'm glad you've scrapped the new syscall slot, that really put me off
> the old patch (though I was probably being silly about it).  This way
> is much better, but again I quarrel with your naming.

> "Inherit" is about parents and children, this is not; and furthermore,
> some UNIXes had a MAP_INHERIT (see asm-alpha/mman.h) which was about
> passing an mmap across exec.  Your MAP_NOINHERIT has nothing to do
> with that.  MAP_MANYPROTS would help us to follow the trail more
> easily (though it's true that you can't actually pass many prots
> in to a single remap_file_pages call).
MAP_CHGPROT? MAP_CHANGEPROT? MAP_REPROT?
VM_MANYPROTS is internal name, so there's no reason to have the same name 
either.
> > Subject: [patch 01/18] remap_file_pages protection support: uml, i386,
> > x64 bits
> >
> > Update pte encoding macros for UML, i386 and x86-64.
> > Also, add the MAP_NOINHERIT flag to arch headers.
>
> Well, I don't find your patch division very helpful, since you introduce
> these without us seeing what use is made of them.  And the MAP_NOINHERIT
> additions cover a different subset of arches (ppc, ppc64, s390 in there):
> those should be in some other patch.
For this patch, I joined up everything because people get scared when they see 
39 patches (and I've not really removed code, apart for things which were 
introduced and later rewritten, just changed the presentation between the two 
sends).
> Usually we just do the i386 arch first, and supply some other patch(es)
> for all the others.  But you've good reason to start with UML too, and
> it makes sense to include x86_64 along too if you're happy to do so.

> But it'll probably waste your time and mine to go on discussng patch
> division, let's leave it at that.

> > *** remap_file_pages protection support: improvement for UML bits

> > Recover one bit by additionally using _PAGE_NEWPROT. Since I wasn't sure
> > this would work, I've split this out, but it has worked well. We rely on
> > the fact that pte_newprot always checks first if the PTE is marked
> > present.

> And we never hear of _PAGE_NEWPROT or pte_newprot again.  Ah, they're
> already defined in and peculiar to UML, I see.  Well, if this some
> UML improvement change, please put that in a separate UML patch.
As above, I joined altogether more patches to reduce noise. And after proper 
unit testing and checking, it was safe anyway to join it.

> > -#define pte_to_pgoff(pte) (pte_val(pte) >> 4)
> > +#define pte_to_pgoff(pte) (((pte_val(pte) >> 6) << 1) | ((pte_val(pte)
> > >> 2) & 0x1)) +#define pte_to_pgprot(pte) \
> > +	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
> > +		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
> > +			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)

> It took me a long time to get past this!  But it's not your fault
> at all, you are just tweaking what's there.  In the end I decided
> I'd do better to take it on trust and move along.

> (I realize that PROTNONE is a specially awkward case, but I keep
> feeling that we make it even more awkward than it need be.  But
> again, if so, that's not your fault.  And I've never been forced
> to think it through here, as you have.)
Actually I first just included this piece from Ingo, while changing shifts - 
one week later I was astonished about where we put _PAGE_USER, until 
realizing it's not read from the PTE but synthetized above.

I should put a comment there, anyway.
> > -#define PTE_FILE_MAX_BITS	29
> > +#define PTE_FILE_MAX_BITS	28
>
> That being the i386 2-level case.  I think that one less bit there is
> probably okay, since wli changed the 3-level case to use all 32 bits
> of the high word.  The people needing 29 file offset bits are probably
> already using PAE, and can be directed to it if not.

> But there may be other 32-bit arches, without a 3-level alternative,
> which are impacted.  (I don't think I'm telling you anything you
> don't already know, just highlighting a point for others to comment.)
s390/31 bit would suffer even more (they go 26->25). But on this, it can be 
avoided (for who doesn't use the new API) as explained below.

> > +#define MAP_NOINHERIT	0x20000		/* don't inherit the protection bits of
> > the underlying vma*/

> As above, MAP_MANYPROTS or something better please.  And please make it
> clear in the comment that it's a flag to remap_file_pages and nothing else.
Ok.
> > Subject: [patch 02/18] remap_file_pages protection support: handle
> > nonuniform VMAs

> > * (TODO?) avoid regression in max file offset with r_f_p() for older
> > mappings; we could use either the old offset encoding or the new
> > offset-prot encoding depending on this flag.
> >   It's trivial to do, just I don't know whether existing apps will
> > overflow the new limits. They go down from 2Tb to 1Tb on i386 and 512G on
> > PPC, and from 256G to 128G on S390/31 bits. Give me a call in case.

> Spare me!  That would make those macros even worse.
> I hope noone will demand it.
It's just what you remarked above. But we'd have separate macros and code 
paths (not hugely separate): use the old macro version if VM_MANYPROTS clear, 
use the new one if VM_MANYPROTS set.
> > mprotect alters the VMA prots and walks each present PTE, ignoring
> > installed ones; their saved prots will be restored on faults, ignoring
> > VMA ones and losing the mprotect() on them. So, we must restore VMA prots
> > when the VMA is uniform, as we used to do.

> If I understand it, you're here commenting on the history of these
> remap_file_pages patches.  That's okay in the 0/18 introducing
> a new version, but please, in the comment on the patch itself,
> explain what it's doing, not how you've been changing it around.
> Oh, mm/mprotect.c doesn't even come in this patch, you're writing
> about the next one.
"We used to do" refers to before the patches themselves, i.e. with current 
r_f_p() code.
> > +	pgprot = vma->vm_flags & VM_NONUNIFORM ? pte_to_pgprot(*pte):
> > vma->vm_page_prot;
>
> Personally I find "(vma->vm_flags & VM_NONUNIFORM)" more reassuring there.
Ok.
> > Subject: [patch 03/18] remap_file_pages protection support: make mprotect
> > skip pagetables on nonuniform

> > There is IMHO no reason to support using mprotect on non-uniform VMAs.
> > The only exception is to change the VMA's default protection (which is
> > used for non-individually remapped pages), but it must still ignore the
> > page tables, as done in this patch.

> > The only unsatisfied need is if I want to change protections without
> > changing the indexes, which with remap_file_pages you must do one page at
> > a time and re-specifying the indexes.

> > It is more reasonable to allow remap_file_pages to change protections on
> > a PTE range without changing the offsets. I've not implemented this, but
> > if wanted I can. For sure, UML doesn't currently need this interface.

> > However, for now I've implemented only this change to mprotect(), I'd
> > like to get some feedback about this choice.

> No, I think I disagree with your choice here.  A reasonable person,
> doing a successful, prohibitive (e.g. remove write access) mprotect
> on a range, would expect those prohibitions then to be enforced across
> the range.  Whereas you're letting existing entries (whether present
> or paged out) retain the permissions they were given earlier with
> remap_file_pages.
A reasonable person using VM_MANYPROTS must study the new API anyway - and if 
he went even to the trouble of writing twice the code to support even older 
kernels (UML does), and he wants to prohibit access to a range, he'd rather 
go with remap_file_pages (PROT_NONE), which does exactly what you expect, or 
it would waste the advantage of avoiding VMA splitting.

My point is that after I set some PTEs individually with RFP, while some 
others are installed by do_no_page() with the default VMA prot, how can the 
kernel distinguish between them? Because (say) I don't want to change the 
ones I installed separately. Should the kernel cater to this need?

However, changing the default VMA prot is very reasonable. And with the way I 
chose the user is given more flexibility.

Random example: a profiler/debugger lets the app run for a while and fault in 
some pages, on a nonuniform vma, and/or maps some ones by hand, and then 
wants to protect the rest without touching present ones - it'd use 
mprotect(), but if that's done your way it becomes impossible.

Don't know if this will ever be useful, but that's why the API is more 
powerful.

However without that new "remap range changing permissions without changing 
offset" we have a problem on the other side.

So, since we have no use for it currently, I'll choose -EINVAL.
> I think mprotect should remove the VM_MANYPROTS attribute of each
> vma in the range, and give all the present entries the new pgprot
> (in the same way that it normally does).

> Or, if that would really bloat the implementation (I don't see why,
> but perhaps the encoding of absent entries, maybe manyprots, maybe
> nonlinear, might do so), just fail with -EACCES when sys_mprotect
> meets a manyprots vma, until someone asks for better.
That is reasonable; -EINVAL makes more sense for me in this case (why 
permission denied?)
> As to letting remap_file_pages change permissions without changing
> file offsets somehow (another MAP_ flag I suppose), yes, it could
> be done but don't bother until/unless there is such need.
Agreed.
> > [PATCH] remove implied vm_ops check

> This one was missing from the sequence, and you supplied privately.
> Remove implied vm_ops check??  No, that belongs to something else.
Ahr - sorry, that's an old bug of my SCM scripts.
> > Even now, we'll sometimes take the write lock, and maybe go to sleep with
> > it for I/O.

> You're writing about sys_remap_file_pages.
Yes, the real title is more meaningful.
> > So, in that case, we could downgrade it; after a tiny bit of thought,
> > I've choosen doing that when we'll either do any I/O or we'll alter a lot
> > of PTEs. About how much "a lot" is, I've copied the values from this code
> > in mm/memory.c, but note they're about mm->page_table_lock, a spinlock,
> > not a semaphore:
> >
> > #ifdef CONFIG_PREEMPT
> > # define ZAP_BLOCK_SIZE	(8 * PAGE_SIZE)
> > #else
> > /* No preempt: go for improved straight-line efficiency */
> > # define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
> > #endif

> > I'm not sure about the trade-offs - we used to have a down_write, now we
> > have a down_read() and a possible up_read()-down_write(), and with this
> > patch, the fast-path still takes only down_read, but the slow path will
> > do down_read(), up_read(), down_write(), downgrade_write(). This will
> > increase by one the number of atomic operation but increase concurrency
> > wrt mmap and similar operations - I don't know how much contention there
> > is on that lock.

> Please drop all this, it's overengineered.  A semaphore is not a spinlock,
> it's not adding to the latency of the system as a whole, just preventing
> concurrent page faults on that mm
Don't know if this is casual - but have you anything personal against 
Christoph Lameter ;-)?
> (if you downgrade_write, you're still 
> excluding concurrent mmaps, mprotects etc., and necessarily so).
Yes, correct, I missed that.
> Originally every sys_remap_file_pages did down_write, and there was a
> downgrade_write before the populate.  Doing down_write every time did
> hurt, so it was changed only to do that when first going nonlinear
> (to respect the locking on vm_flags), and we didn't bother to downgrade
> in that one instance.

> I don't mind you just adding a simple
> 		if (has_write_lock)
> 			downgrade_write(&mm->mmap_sem);
> before the populate (and getting rid of the has_write_lock condition
> further down), but anything more seems overkill to me.
Ok, will see with Ingo. The fact that it's done only on first time and it's 
not a spinlock agrees with you, anyway.
> > Also, drop a bust comment: we cannot clear VM_NONLINEAR simply because
> > code elsewhere is going to use it. At the very least, madvise_dontneed()
> > relies on that flag being set (remaining non-linear truncation read the
> > mapping list), but the list is probably longer, and going to increase.

> You misunderstand the comment (it could indeed be clearer), but you're
> right that the bit about downgrading the lock is out-of-date.
> I suggest you insert this comment instead.
> 		/*
> 		 * We would like to clear VM_NONLINEAR, in the case when
> 		 * sys_remap_file_pages covers the whole vma, so making
> 		 * it linear again.  But cannot do so until after a
> 		 * successful populate, and have no way to upgrade sem.
> 		 */
Aaaaaaaaah, ok.
> > Subject: [patch 04/18] remap_file_pages protection support: cleanup
> > syscall checks

> > This patch reorganizes the code only, without differences in behaviour.
> > It makes the code more readable on its own, and is needed for next
> > patches. I've split this out to avoid cluttering real patches.

> Okay, you're breaking up conditions nicely, but please break this one up
> too

> > +	if (!vma->vm_ops || !vma->vm_ops->populate || end <= start || start <
> > +			vma->vm_start || end > vma->vm_end)
> > +		goto out_unlock;
>
> into a vm_ops part and a start/end part.
Ok.
> > Subject: [patch 05/18] remap_file_pages protection support: enhance
> > syscall interface

> > @@ -203,7 +203,7 @@ asmlinkage long sys_remap_file_pages(uns
> >  	/* Can we represent this offset inside this architecture's pte's? */
> >  #if PTE_FILE_MAX_BITS < BITS_PER_LONG
> >  	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
> > -		return err;
> > +		return -EOVERFLOW;
> >  #endif

> In the last patch you replaced all(?) the early returns by gotos;
> now in this one you reintroduce an early return.  Better be consistent
> and make this one a goto too.
Ok.
> > +	if (flags & MAP_NOINHERIT) {
> > +		err = -EPERM;
> > +		if (((prot & PROT_READ) && !(vma->vm_flags & VM_MAYREAD)))
> > +			goto out_unlock;
> > +		if (((prot & PROT_WRITE) && !(vma->vm_flags & VM_MAYWRITE)))
> > +			goto out_unlock;
> > +		if (((prot & PROT_EXEC) && !(vma->vm_flags & VM_MAYEXEC)))
> > +			goto out_unlock;
> > +		err = -EINVAL;
> > +		pgprot = protection_map[calc_vm_prot_bits(prot) | VM_SHARED];

> Please follow mprotect's way of doing this, calc_vm_prot_bits first then
> 		if ((newflags & ~(newflags >> 4)) & 0xf) {
> Except please do NOT say 0xf!  Use VM_READ|VM_WRITE|VM_EXEC instead
> (yeah, yeah, I know that only comes to 7).
Ok - nice trick hardcoding the shift between MAY and base flags.... when 
constants are hardcoded in assembler, nobody forgets comments.
> > Subject: [patch 06/18] remap_file_pages protection support: support
> > private vma for MAP_POPULATE

> > Fix MAP_POPULATE | MAP_PRIVATE. We don't need the VMA to be shared if we
> > don't rearrange pages around. And it's trivial to do.

> This seems reasonable to me.  I was afraid you were going to extend
> VM_NONLINEAR to private maps, but no, you're just letting private maps
> be populated linearly, that's fine.
Would that be a real problem, when limited to readonly mappings?
There's some interest in that, for library loading - a binary with 100 dso's 
has 300 vmas...

I see the problem with anonymous memory is bigger (not entirely different from 
the current situation).
> (Really we ought then also to 
> allow anonymous maps be pre-populated also, but that's a different
> patch, which wouldn't touch sys_remap_file_pages at all: forget it.)

> > --- linux-2.6.git/mm/mmap.c~rfp-private-vma-2	2005-08-24
> > 20:57:13.000000000 +0200 +++ linux-2.6.git-paolo/mm/mmap.c	2005-08-24
> > 20:57:13.000000000 +0200 @@ -1124,6 +1124,10 @@ out:
> >  	}
> >  	if (flags & MAP_POPULATE) {
> >  		up_write(&mm->mmap_sem);
> > +		/*
> > +		 * remap_file_pages() works even if the mapping is private,
> > +		 * in the linearly-mapped case:
> > +		 */

> But that's one of your historical comments.  The point of the patch is
> that it's peculiar not to populate the private mappings, so why comment
> when we're no longer doing something peculiar?  Please leave it out.
Ok.
> >  		sys_remap_file_pages(addr, len, 0,
> >  					pgoff, flags & MAP_NONBLOCK);
> >  		down_write(&mm->mmap_sem);

> > Subject: [patch 07/18] remap_file_pages protection support: safety net
> > for lazy arches

> > Since proper support requires that the arch at the very least handles
> > VM_FAULT_SIGSEGV, as in next patch (otherwise the arch may BUG), and
> > things are even more complex (see next patches), and it's triggerable
> > only with VM_NONUNIFORM vma's, simply refuse creating them if the arch
> > doesn't declare itself ready.

> > This is a very temporary hack, so I've clearly marked it as such. And,
> > with current rythms, I've given about 6 months for arches to get ready.
> > Reducing this time is perfectly ok for me.

> > +#ifndef __ARCH_SUPPORTS_VM_NONUNIFORM
> > +	if (flags & MAP_NOINHERIT)
> > +		goto out;
> > +#endif

> Any arch that doesn't have a definition of MAP_MANYPROTS in its asm/mman.h
> has its build broken anyways.  While you're giving them all MAP_MANYPROTS
> definitions, please just modify their fault handlers, as simply as
> possible. So skip the __ARCH_SUPPORTS_VM_NONUNIFORM business.
Argh, ok.
> > +++
> > linux-2.6.git-paolo/Documentation/feature-removal-schedule.txt	2005-08-24
> > 20:57:18.000000000 +0200 +
[...]
> This is very thorough and well-intentioned, but skip it - we do that
> for old features from which many drivers need converting, but it's
> not like that with the architectures.  Just supply the simple patches.

> > Subject: [patch 08/18] remap file pages protection support: use
> > FAULT_SIGSEGV for protection checking

> Ah ha, now we get to the heart of it.  (And nothing wrong with such a lead
> up, I too like a number of patches to set the stage before the big one.)

> Well, this is two patches.  First there's handling VM_FAULT_SIGSEGV in
> various arches.  Please minimize those patches for now: VM_FAULT_SIGSEGV
> is very sensible in itself, and with its help we might be able to move
> more code from arches to common in future; but for now, try to keep it
> to adding the
> 		case VM_FAULT_SIGSEGV:
> 			goto bad_area;
> in each arch fault handler.  Resist changing "survive" to "handle_fault".
> Resist adding "access_mask" and passing it in place of "write": that may
> be necessary later to handle VM_EXEC properly on a few architectures,
> but I suggest (particularly given the subset of arches of interest)
> that you start with just the read/write distinction, and if exec needs
> more add it later (even if it's just a later patch of the same series).

> And resist adding a preliminary VM_MANYPROTS check to each fault
> handler.  Let's say instead that the mmap/mprotect permissions are the
> maximum that the area can take (and therefore modify the check done on
> prots in sys_remap_file_pages, to make sure they do not exceed "default").

> Would that work out?
No, absolutely not, I'm sorry. Since I may have sparse mappings (I'll use this 
to emulate TLBs), we have a huge PROT_NONE mapping and then remap individual 
pages, after their allocation, at fault time, with more permissive settings.

That check may be moved later, to beginning of bad_area, if you say "default 
prots are the minimum one, I can only remap with more permissive settings". 
That would avoid affecting the fast path - even if the branch is clearly an 
"unlikely" one, so shouldn't give mispredictions at least.

If your problem is just avoiding changing all arch handlers, that amounts to 
letting the new API misbehave on them (a bit of an hack, but with 
 		case VM_FAULT_SIGSEGV:
 			goto bad_area;
everywhere it's still safe) or using my arch_supports trick.
> And then there's the core patch, to mm/memory.c.  But I'm afraid at this
> point, just when it gets interesting, my time and my patience run out.

> I still haven't come to a conclusion on the most interesting lines of
> all, do_no_page's
> 		if (write_access || unlikely(vma->vm_flags & VM_NONUNIFORM))
> 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> but I suspect you're wrong to be avoiding do_wp_page at all costs,
> should instead be adapting do_wp_page to do the right thing with the
> faults which arrive there.
Actually, today (in your discussion with "Heff" Dike) I realized the above 
change is redundant. pte_mkdirty is only needed if VM_WRITE (and not even 
there), and in that case, since we are doing shared mappings, the write 
access is already set in vma->vm_page_prot.

> And I think there's a serious flaw in handle_pte_fault, where it says

> > +	/* VM_NONUNIFORM vma's have PTE's always installed with the correct
> > +	 * protection. So, generate a SIGSEGV if a fault is caught there. */
> > +	if (unlikely(vma->vm_flags & VM_NONUNIFORM))
> > +		goto out_segv;

> Consider two threads faulting on the same pte on different cpus.
> One of them fixes it up, you're giving the other SIGSEGV?
> I think this runs quite deep and will need a rework.
Not so deep.
Weeeell, I was ready to ripping this out (even if for other reasons), I assume 
that comparing write_access/access_mask and the protections in the PTE is 
perfectly ok and fixes this.

Luckily, even here we have no regression wrt other apps.
> Sorry, I do not know when I can next face going over this,
> it's a hard task for me: perhaps someone else can take over.
For me is ok - just tell Andrew who should be appointed at this. There's not 
an "official" list of VM maintainers anywhere, even if I'm under the 
impression you're currently the top one.
> Hugh
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
