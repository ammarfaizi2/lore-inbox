Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVHDTd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVHDTd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVHDTd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:33:27 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:43346 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262644AbVHDTdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:33:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Message-Id;
  b=kb2W6+FPo9OnfmZUCRkhvNpeAlYjnMUz75bPHO/moMEgwl+kIi8ort2mgGQ0JZUdOwvK6c0of9vUl4q4CsRtwKuGpog14OwCVnTcP2KFj9qPJ9mMf8FVRiFtrrobD+k0SYC+b1T7qmJHAdDj6lAzrBfhOrG2jMf1vgos26yzOKY=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Ingo Molnar <mingo@elte.hu>
Subject: Bugs on your remap_file_pages protections implementations
Date: Thu, 4 Aug 2005 21:24:36 +0200
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0tm8CxDNeJ5Qggx"
Message-Id: <200508042124.36786.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_0tm8CxDNeJ5Qggx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ingo, I'm the young UML hacker you met at OLS and who got your UML patches 
sent ;-)

I've been studying your patch (and the whole Linux VM, indeed) in the past 
days, and I have some remarks, about the version of the code in 2.6.4-rc2-mm1 
(which is the same you sent me) - I've now downloaded the version dropped 
from 2.6.5-mm1, but it doesn't seem to address those problems.

Btw, I've now seen why that patch was dropped, but not why it wasn't resubmit.

*) with your patch, remapped pages without MAP_INHERIT are IMHO not safe 
across swapout; re-swapping them in will pass through the arch-specific fault 
handler, which will check VMA's protections, and fail if the VMA originally 
had MAP_NONE. Or am I missing something?

*) with the same binary, a call to mprotect() on a nonlinear VMA will no more 
change the protections over fremap'ed PTEs (more exactly, PTEs going through 
handle_pte_fault->do_file_page(), but it seems that _PAGE_FILE is only set by 
fremap()).

Currently mprotect fixes up the VMA and changes the protections for present 
pages (see mm/mprotect.c:change_pte_range(), it's a no-op on not-present 
pages). On not-present pages, the new VMA protections are loaded, even in 
do_file_page.

I propose adding a VM_NOINHERIT flag (reusing VM_MAPPED_COPY on MMU archs) to 
be set on VMA's on which protections are not to be inherited.

Normal VMA's behave as before, as soon as I remap_file_pages without 
MAP_INHERIT (or with MAP_NOINHERIT, see below) that flag is set on the VMA, 
on which, then, mprotect won't work.

*) btw, adding a new syscall is not needed, adding a MAP_NOINHERIT flag for 
remap_file_pages to ask for the new behaviour is more than enough:

(inside sys_remap_file_pages)
-       if (__prot)
-               return err;
+       if (prot && !(flags & MAP_NOINHERIT))
+               goto out;

Also, I've seen that a lot of fixes from your code haven't been merged; in 
particular, currently MAP_PRIVATE |  MAP_POPULATE is broken (while it was 
fixed by your patch, which only required VM_SHARED on the VMA if there was an 
actual non-linear mapping).

*) I don't understand this hunk (inside filemap_populate, not replicated 
inside shmem_populate):

        struct page *page;
        int err;

+       /*
+        * mapping-removal fastpath:
+        */
+       if ((vma->vm_flags & VM_SHARED) &&
+                       (pgprot_val(prot) == pgprot_val(PAGE_NONE))) {
+               zap_page_range(vma, addr, len);
+               return 0;
+       }
+
        if (!nonblock)
                force_page_cache_readahead(mapping, vma->vm_file,

I understand why it's done, but zap_page_range() will totally clear the PTE's, 
it won't set _PAGE_FILE on the PTEs (as far as I can see), causing the pages 
to be faulted again in, and this time linearly. This hunk is still in 
2.6.5-mm1 (or so it seems).

*) I don't understand at all the attached hunks in your patch (there's a long 
description about them). Verified they hadn't been dropped from the patch in 
2.6.5-mm1 (or so it seems).

Note: for 2.6.5-mm1, I'm referring to the patch inside the "dropped" directory 
in the archives.

Bye and thanks for your attention.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_0tm8CxDNeJ5Qggx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="remap-file-pages-wrong.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remap-file-pages-wrong.patch"

This is wrong because both routines can be called from within do_file_page,
which is called when !pte_present(pte) && !pte_none(pte) && pte_file(pte). I.e.
the pte is not zeroed, so it has been used, but the page has been swapped out,
or .

Actually, in that situation ->populate is called with nonblock == 0, so only
install_page can be called there. If ->populate fails, the faulting process
will get a SIGBUS; and this *could* happen.

The other caller is sys_remap_file_page. In that situation, we fail if
!(vma->vm_flags & VM_SHARED), so we don't call ->populate.

Actually, however, we could be called inside mmap for MAP_POPULATE. However,
even in that case, old mappings have already been unmapped away.

And actually, in Ingo's patch things were different, because if
remap_file_pages was called only to change protections, without creating
non-linear mappings, we didn't punt even if the VM was not shared. So,
currently MAP_POPULATE will fail (though without returning any error) if the VMA
is private and not shared, without a real reason to do so.

But again, after mmap'ing an area, even with MAP_POPULATE, old mappings should
have been cleared, so what are we bothering about here?

diff -puN mm/fremap.c~remap-file-pages-prot-2.6.13-rc3-A2 mm/fremap.c
--- linux-2.6.git/mm/fremap.c~remap-file-pages-prot-2.6.13-rc3-A2	2005-08-03 12:41:36.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-03 12:41:36.000000000 +0200
@@ -90,6 +90,14 @@ int install_page(struct mm_struct *mm, s
 	if (!page->mapping || page->index >= size)
 		goto err_unlock;
 
+	/*
+	 * Only install a new page for a non-shared mapping if it's
+	 * not existent yet:
+	 */
+	err = -EEXIST;
+	if (!pte_none(*pte) && !(vma->vm_flags & VM_SHARED))
+		goto err_unlock;
+
 	zap_pte(mm, vma, addr, pte);
 
 	inc_mm_counter(mm,rss);
@@ -136,6 +146,13 @@ int install_file_pte(struct mm_struct *m
 	err = 0;
 	if (linear && pte_none(*pte))
 		goto err_unlock;
+	/*
+	 * Only install a new page for a non-shared mapping if it's
+	 * not existent yet:
+	 */
+	err = -EEXIST;
+	if (!pte_none(*pte) && !(vma->vm_flags & VM_SHARED))
+		goto err_unlock;
 
 	zap_pte(mm, vma, addr, pte);
 


# vim: tw=80


--Boundary-00=_0tm8CxDNeJ5Qggx--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
