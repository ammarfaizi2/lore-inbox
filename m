Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUJTSN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUJTSN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUJTSIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:08:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13762 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268919AbUJTSH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:07:58 -0400
Date: Wed, 20 Oct 2004 11:07:45 -0700
Message-Id: <200410201807.i9KI7j6G007197@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include all vmas with unbacked pages in ELF core dumps
In-Reply-To: Linus Torvalds's message of  Wednesday, 20 October 2004 10:19:41 -0700 <Pine.LNX.4.58.0410201003192.2317@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: you'll understand when you're older, dear.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Augh. Not all filesystems support holes, 

We could represent the holes in ELF format instead.  When a hole is at the
tail end of a vma, just reducing p_memsz does the trick.  For holes in the
middle, we can make more ELF phdrs rather than one per vma.

> and I think VM_SHARED should trump VM_WRITE.

If VM_SHARED is never set when COW could have happened, then fine.

> But any non-dumped section _will_ show up in the ELF headers, so things
> like guard pages have nothing to do with "maydump()", imho. 

Guard pages are indeed not truly an interesting case, since they are always
zero anyway.  But in the general case, PROT_NONE is no guarantee that there
isn't worthwhile data there.  e.g., some GC schemes use page protections
temporarily on parts of their heap--if it crashes in the middle of that,
you want that heap page's contents dumped even though at that instant the
page was not readable.

> In general, I'd much prefer just adding a VM_DIRTY flag, and making the
> COW logic set it. That should guarantee that we write out the minimal 
> required sections.

I got the impression that vma->anon_vma being set when vma->vm_file is also
set means that COW happened.  Would VM_DIRTY not be set in the same set of
cases?


Thanks,
Roland
