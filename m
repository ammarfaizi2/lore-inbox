Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752075AbWJNFK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWJNFK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWJNFK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:10:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:26074 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752075AbWJNFKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:10:25 -0400
Date: Sat, 14 Oct 2006 07:10:19 +0200
From: Nick Piggin <npiggin@suse.de>
To: Robin Holt <holt@sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_user_pages(..., write==1, ...) may return with readable pte.
Message-ID: <20061014051019.GC23740@wotan.suse.de>
References: <20061013203342.GA21610@lnx-holt.americas.sgi.com> <20061014045305.GA23740@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014045305.GA23740@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 06:53:06AM +0200, Nick Piggin wrote:
> On Fri, Oct 13, 2006 at 03:33:42PM -0500, Robin Holt wrote:
> > Handle the case in get_user_pages() when a call to __handle_mm_fault()
> > inserts a writable pte, and a process doing dup_mmap converts it
> > to readable before get_user_pages() does the subsequent request to
> > follow_page().
> > 
> > 
> > Signed-off-by: Robin Holt <holt@sgi.com>
> > 
> > ---
> > 
> > Hugh, Nick, and Linus,
> > 
> > I think I have tripped over another flavor of a get_user_pages bug
> > we addressed back in 2005.  I do not have a test case to prove it is
> > the issue I am trying to address, but I have done as thorough a code
> > walk-through as I can.
> > 
> > Assume a pte is currently empty.  A first pthread is in the kernel on
> > a call path which is leading to get_user_pages.  A second pthread is
> > in the process of doing a fork.  The process doing get_user_pages()
> > gets into __handle_mm_fault() and grabs ptl just before the process
> > doing a fork attempts to grab the ptl to convert the pages to COW.
> > __handle_mm_fault() will insert the writable pte and unlock ptl then
> > return with VM_FAULT_WRITE set.  The process doing a fork then gets
> > the lock and starts converting the pte to RO/COW.  The get_user_pages()
> > process then clears FOLL_WRITE from foll_flags and calls follow_page()
> > without write, adds to the map count for the page, but does not have a
> > writable mapping.
> 
> Hi Robin,
> 
> dup_mmap holds mmap_sem for write. get_user_pages caller must hold it
> for read.
> 
> So it think it is OK? But if not, then you can't just get rid of this
> FOLL_WRITE bit, because then we get infinite loops when a 'force'
> write access (eg. ptrace setting a breakpoint in text).

What problem are you seeing, BTW?

