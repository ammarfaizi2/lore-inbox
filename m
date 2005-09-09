Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVIILC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVIILC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVIILC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:02:26 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:5344 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030236AbVIILC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:02:26 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc() in
	ntfs_malloc_nofs() and add _nofail() version.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <84144f0205090903366454da6@mail.gmail.com>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
	 <84144f0205090903366454da6@mail.gmail.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 09 Sep 2005 12:02:20 +0100
Message-Id: <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 13:36 +0300, Pekka Enberg wrote:
> On 9/9/05, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > -static inline void *ntfs_malloc_nofs(unsigned long size)
> > +static inline void *__ntfs_malloc(unsigned long size,
> > +               unsigned int __nocast gfp_mask)
> >  {
> >         if (likely(size <= PAGE_SIZE)) {
> >                 BUG_ON(!size);
> >                 /* kmalloc() has per-CPU caches so is faster for now. */
> > -               return kmalloc(PAGE_SIZE, GFP_NOFS);
> > -               /* return (void *)__get_free_page(GFP_NOFS | __GFP_HIGHMEM); */
> > +               return kmalloc(PAGE_SIZE, gfp_mask);
> > +               /* return (void *)__get_free_page(gfp_mask); */
> >         }
> >         if (likely(size >> PAGE_SHIFT < num_physpages))
> > -               return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
> > +               return __vmalloc(size, gfp_mask, PAGE_KERNEL);
> 
> Unrelated to this patch but why do you have this wrapper instead of
> using kmalloc() where you can and__vmalloc() where you really have to?

Very easy.  Allocations are variable sized.  Without the wrapper I would
have to copy and paste the wrapped code all over the ntfs driver as
there is no way to tell which one I would need in advance.

I used to simply use vmalloc() but that caused loads of people's
machines to run out of vmalloc space in a matter of hours and also
vmalloc is much slower so I added the kmalloc if a page and vmalloc
otherwise.

Note just using kmalloc is no good as it doesn't go high enough in size
(again this problem was being hit by people which is why I had switched
to vmalloc in the first place).

Also kmalloc with size > PAGE_SIZE used to cause machines to run OOM and
give page order > 1 allocation failures, hence why I never use kmalloc
for more than one page any more.

Also note I only use the ntfs_malloc_nofs() wrapper if I have to.  If I
know how much I am allocating or at least know that the maximum is quite
small, I use kmalloc() directly.  It is pretty much only for the runlist
allocations that I use the wrapper as the runlist is typically small but
for fragmented files it can grow huge.  I have seen runlists consuming
over 256kiB of ram, without vmalloc that would be a real problem...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

