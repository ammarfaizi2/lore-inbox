Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUJLTNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUJLTNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUJLTL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:11:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:63116 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267625AbUJLTKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:10:43 -0400
Date: Tue, 12 Oct 2004 21:08:02 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@digeo.com
Subject: Re: 4level page tables for Linux II
Message-ID: <20041012190802.GA14821@wotan.suse.de>
References: <20041012135919.GB20992@wotan.suse.de> <1097606902.10652.203.camel@localhost> <20041012190346.GA705@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012190346.GA705@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 09:03:46PM +0200, Andi Kleen wrote:
> On Tue, Oct 12, 2004 at 11:48:22AM -0700, Dave Hansen wrote:
> > @@ -110,13 +115,18 @@ int install_file_pte(struct mm_struct *m
> >                 unsigned long addr, unsigned long pgoff, pgprot_t prot)
> >  {
> > ...
> > +       pml4 = pml4_offset(mm, addr);
> > +
> > +       spin_lock(&mm->page_table_lock);
> > +       pgd = pgd_alloc(mm, pml4, addr);
> > +       if (!pgd)
> > +               goto err_unlock;
> > 
> > Locking isn't needed for access to the pml4?  This is a wee bit
> > different from pgd's and I didn't see any documentation about it
> > anywhere.  Could be confusing.
> 
> No, the lock is still needed. Thanks for catching this, that was indeed
> wrong.

Actually on second though - the code was actually ok. The reason is 
that the highest page table level never goes away while the process
exists, and holding a pointer into it is always valid. 

Only referencing it needs a lock, but pml4_offset doesn't reference
anything yet.

The same used to hold for pgds, but the 4level page tables change that. 
However there was at least one bug in the patchkit in this area 
which I now fixed.

-Andi
