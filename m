Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTEMWkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTEMWkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:40:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18864
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263510AbTEMWjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:39:25 -0400
Date: Wed, 14 May 2003 00:52:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Fix for vma merging refcounting bug
Message-ID: <20030513225210.GK15316@dualathlon.random>
References: <1052483661.3642.16.camel@sisko.scot.redhat.com> <20030510163336.GB15010@dualathlon.random> <1052683446.4609.29.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052683446.4609.29.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 09:04:06PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Sat, 2003-05-10 at 17:33, Andrea Arcangeli wrote:
> > On Fri, May 09, 2003 at 01:34:21PM +0100, Stephen C. Tweedie wrote:
> > > When a new vma can be merged simultaneously with its two immediate
> > > neighbours in both directions, vma_merge() extends the predecessor vma
> > > and deletes the successor.  However, if the vma maps a file, it fails to
> > > fput() when doing the delete, leaving the file's refcount inconsistent.
> 
> > great catch! nobody could notice it in practice
> 
> Yep --- I only noticed it because I was running a quick-and-dirty vma
> merging test and wanted to test on a shmfs file, and noticed that the
> temporary shmfs filesystem became unmountable afterwards.  Test
> attached, in case anybody is interested (it's the third test, mapping a
> file page by page in two interleaved passes, which triggers this case.)
> 
> > I'm attaching for review what I'm applying to my -aa tree, to fix the
> > above and the other issue with the non-ram vma merging fixed in 2.5.
> 
> Looks OK.

actually I just noticed the fput is never been buggy in my tree:

	if (!file || !rb_parent || !vma_merge(mm, prev, rb_parent, addr, addr + len, vma->vm_flags, file, pgoff)) {
		vma_link(mm, vma, prev, rb_link, rb_parent);
		if (correct_wcount)
			atomic_inc(&file->f_dentry->d_inode->i_writecount);
	} else {
		if (file) {
			if (correct_wcount)
				atomic_inc(&file->f_dentry->d_inode->i_writecount);
			fput(file);
			^^^^^^^^^
		}
		kmem_cache_free(vm_area_cachep, vma);
	}

so this was a merging bug in 2.5

Andrea
