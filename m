Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTEMWwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTEMWwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:52:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28592
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263643AbTEMWwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:52:15 -0400
Date: Wed, 14 May 2003 01:05:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Fix for vma merging refcounting bug
Message-ID: <20030513230500.GA29246@dualathlon.random>
References: <1052483661.3642.16.camel@sisko.scot.redhat.com> <20030510163336.GB15010@dualathlon.random> <1052683446.4609.29.camel@sisko.scot.redhat.com> <20030513225210.GK15316@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513225210.GK15316@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 12:52:10AM +0200, Andrea Arcangeli wrote:
> On Sun, May 11, 2003 at 09:04:06PM +0100, Stephen C. Tweedie wrote:
> > Hi,
> > 
> > On Sat, 2003-05-10 at 17:33, Andrea Arcangeli wrote:
> > > On Fri, May 09, 2003 at 01:34:21PM +0100, Stephen C. Tweedie wrote:
> > > > When a new vma can be merged simultaneously with its two immediate
> > > > neighbours in both directions, vma_merge() extends the predecessor vma
> > > > and deletes the successor.  However, if the vma maps a file, it fails to
> > > > fput() when doing the delete, leaving the file's refcount inconsistent.
> > 
> > > great catch! nobody could notice it in practice
> > 
> > Yep --- I only noticed it because I was running a quick-and-dirty vma
> > merging test and wanted to test on a shmfs file, and noticed that the
> > temporary shmfs filesystem became unmountable afterwards.  Test
> > attached, in case anybody is interested (it's the third test, mapping a
> > file page by page in two interleaved passes, which triggers this case.)
> > 
> > > I'm attaching for review what I'm applying to my -aa tree, to fix the
> > > above and the other issue with the non-ram vma merging fixed in 2.5.
> > 
> > Looks OK.
> 
> actually I just noticed the fput is never been buggy in my tree:
> 
> 	if (!file || !rb_parent || !vma_merge(mm, prev, rb_parent, addr, addr + len, vma->vm_flags, file, pgoff)) {
> 		vma_link(mm, vma, prev, rb_link, rb_parent);
> 		if (correct_wcount)
> 			atomic_inc(&file->f_dentry->d_inode->i_writecount);
> 	} else {
> 		if (file) {
> 			if (correct_wcount)
> 				atomic_inc(&file->f_dentry->d_inode->i_writecount);
> 			fput(file);
> 			^^^^^^^^^
> 		}
> 		kmem_cache_free(vm_area_cachep, vma);
> 	}
> 
> so this was a merging bug in 2.5

Apologies, I was on the laptop reading that code wrong and I sent the
email too early, the patch I posted was correct for my tree too indeed.

Andrea
