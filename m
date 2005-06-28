Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVF1OkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVF1OkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVF1Ojn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:39:43 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:52149 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261675AbVF1Oib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:38:31 -0400
Date: Tue, 28 Jun 2005 16:38:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: [Patch] Hotfix for Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628143800.GB18116@wohnheim.fh-wedel.de>
References: <20050628134316.GS5044@implementation.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628134316.GS5044@implementation.labri.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 June 2005 15:43:16 +0200, Samuel Thibault wrote:
> 
> There is something wrong with the current madvise(MADV_DONTNEED)
> implementation. Both the manpage and the source code says that
> MADV_DONTNEED means that the application does not care about the data,
> so it might be thrown away by the kernel. But that's not what posix
> says:
> 
> http://www.opengroup.org/onlinepubs/009695399/functions/posix_madvise.html
> 
> It says that "The posix_madvise() function shall have no effect on the
> semantics of access to memory in the specified range". I.e. the data
> that was recorded shall be saved!
> 
> The current linux implementation of MADV_DONTNEED is rather an
> implementation of solaris' MADV_FREE, see its manpage:
> http://docs.sun.com/app/docs/doc/816-5168/6mbb3hrde?a=view
> 
> Hence the current madvise_dontneed() implementation could be renamed
> into madvise_free() and the appropriate MADV_FREE case be added, while
> a new implementation of madvise_dontneed() _needs_ be written. It may
> for instance go through the range so as to zap clean pages (since it is
> safe), and set dirty pages as being least recently used so that they
> will be considered as good candidates for eviction.

Agreed.  Unless someone else comes up with something better soon, you
can use below patch.

Akpm, would you merge this?

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 mm/madvise.c |    4 ++++
 1 files changed, 4 insertions(+)

--- linux-2.6.12-rc4logfs/mm/madvise.c~madvice_bug	2005-03-04 11:40:50.000000000 +0100
+++ linux-2.6.12-rc4logfs/mm/madvise.c	2005-06-28 16:34:54.000000000 +0200
@@ -97,6 +97,10 @@ static long madvise_willneed(struct vm_a
 static long madvise_dontneed(struct vm_area_struct * vma,
 			     unsigned long start, unsigned long end)
 {
+	return 0;
+	/* Really ugly bugfix - madvice may never change anything
+	 * beyond performance.  Dropping dirty pages is right out.
+	 */
 	if ((vma->vm_flags & VM_LOCKED) || is_vm_hugetlb_page(vma))
 		return -EINVAL;
 
