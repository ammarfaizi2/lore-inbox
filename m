Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVHZSaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVHZSaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbVHZSaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:30:12 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:34644 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751338AbVHZSaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:30:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:User-Agent:Cc:MIME-Version:Date:Content-Type:Message-Id;
  b=whwh3pouKu62HX22T4r/zOcsF19JhCr+YW2ypcJahdxsSTjYkHf7kOiRHQ5XwKDQSaZ47A99HrejQx9tui3Iktr1noahyCk7ZwO4EnqxVbHTcA0qwSvT3yY0yaZQkFA1VNOJHaOLrXKCqqctaoZQO8fU6eGFQjcj0NdJEocohQE=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: [RFC] [patch 0/18] remap_file_pages protection support (for UML), try 3
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, Hugh Dickins <hugh@veritas.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Date: Fri, 26 Aug 2005 20:23:28 +0200
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_h41DDOjqMm6ujqo"
Message-Id: <200508262023.29170.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_h41DDOjqMm6ujqo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a followup to my post of last week (Aug 12) about remap_file_pages 
protection support. I've improved and consolidated the patches and updated 
them against 2.6.13-rc6/rc7 (the same patches apply against both versions).
I'm sending the full patch series only to akpm, mingo and LKML.

I've also reduced them to only 18, and made the splitting more significant. 
I'm not resending all the patches for foreign architectures, because they're 
almost unchanged since last time (there's just a trivial reject from ppc32, 
because one change has already been done after -rc4).

I'm working on this to provide support for UML, which currently easily creates 
more than 64K (the default limit) vma's for a single process. Actually, it 
needs one VMA per each page. So, with this patch and specific UML support, 
which Ingo wrote and which I'm porting to recent UMLs.

Some highlights:

* The first 2 patches modify the PTE encoding macros and start preparing the 
VM for the new situation (i.e. VMA which have variable protections, which are 
called VM_NONUNIFORM. I dropped the early VM_MANYPROTS name).

Patch number 2 will require fixing up all arches like in 2.6.4-rc2-mm1, to 
provide the new PTE encoding macros.

* Patch 5 allows the syscall to actually create such VMAs. Before that, 
there's no difference in behaviour with the current kernel (except that 
there's less space for file offset encoding in PTEs). And even here, the new 
operations are only enabled for arch explicitly supporting it (see patch #7).

* Patch 8 and 9 change the path for handling page faults, since the permission 
checking on nonuniform vmas cannot be done until the PTE entry has been read.

This is the most intrusive part, but
a) archs are not required to adequate to this immediately
b) it isn't so difficult in practice.

* Patch 11 is a big simplification. Since we must encode the PTE's on swapout 
like in VM_NONLINEAR vmas, the simplest way to reuse the existing code is to 
make sure that VM_NONUNIFORM vmas are also marked as VM_NONLINEAR.

It is possible to avoid this, as in patch #18, but it's just a bit scary, and 

Then there are 4 optimization patches and 3 fixups for some odd cases that we 
maybe won't support. They are namely:
*) vmas with default PROT_NONE protection (I actually feel we're going to 
support this, the only patch which has problems is an optimization)

*) MAP_POPULATE on private VMA (no problem on this) and consequently 
remap_file_pages on private VMA to install linear uniform mappings (since 
MAP_POPULATE is implemented in terms of remap_file_pages): there's a patch to 
stop this from truncating COW pages away, but I don't think it's worth it.

*) linear nonuniform vmas. I initially created them because there's no 
relation between being nonlinear and nonuniform, but it later turned out 
supporting them is intrusive.

I have improved even more the patches, and understood better some changes from 
Ingo which I didn't last time, and fixed their bugs.

I hope these changes can be reviewed, and included inside -mm, even if they'll 
conflict with pagefault scalability patches (even if I think the conflicts 
are not difficult to solve).

Still, the patch is IMHO in better shape, in many ways, than when it was in 
-mm last time. To handle properly all possibilities it has become a bit more 
intrusive.

The original one was designed to handle only the simpler needs of 
UML (an mmap'ing with PROT_NONE followed by nonlinear and nonuniform 
remappings), but it still failed in some cases. I've taken original Ingo's 
test-program and significantly extended it, it's attached to this patch.

I'll appreciate any comments.

==============
Changes from 2.6.5-mm1/dropped version of the patches:
==============
*) Actually implemented _real_ and _anal_ protection support, safe against 
swapout; programs get SIGSEGV *always* when they should. I've used the 
attached test program (an improved version of Ingo's one) to check that.
I tested just until patch 25, onto UML. The subsequent ones are either patches 
for foreign archs or proposed

*) Fixed many changes present in the patches.
*) Fixed UML bits
*) Added some headaches for arches ports. I've also included some patches 
which reduce this.

*) No more usage of a new syscall slot: to use the new interface, application 
will use the new MAP_NOINHERIT flag I've added. I've still the patches to use 
the old -mm ABI, if there's any reason they're needed.

*) Fixed a regression wrt using mprotect() against remapped area (see patch 
15)

======
Changes from my last patch-bomb of the patches:
======
*) fixed mprotect VS remap_file_pages(MAP_NOINHERIT) interaction

*) fixed truncation (with madvise_dontneed or truncate()) of nonuniform but 
linear vmas. Either with patch 11, by removing "nonuniform but linear VMAs", 
or with patch 18.

======
Still todo
======
*) ->populate flushes each TLB individually, instead of using mmu_gathers as 
it should; this was suggested even by Ingo when sending the patch, but it 
seems he didn't get the time to finish this. And I'm now wondering how would 
that relate with I/O... at each I/O point we should finish and regather the 
mmu_gather, as in zap_page_range. But here we are reading pages, not the 
reverse!

Seems rewriting the kernel locking is a quite time-consuming task!
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_h41DDOjqMm6ujqo
Content-Type: application/x-bzip2;
  name="fremap-test-complete.c.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="fremap-test-complete.c.bz2"

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
pVsg4rGMU/+LuSKcKEhBkyJvgA==

--Boundary-00=_h41DDOjqMm6ujqo--


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
