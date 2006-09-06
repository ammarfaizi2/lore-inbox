Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWIFJpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWIFJpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIFJpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:45:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56769 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750736AbWIFJpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:45:06 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060904225419.GA4367@us.ibm.com> 
References: <20060904225419.GA4367@us.ibm.com>  <20060830211203.GA12953@us.ibm.com> <20060825221615.GA11613@us.ibm.com> <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com> <27154.1156546746@warthog.cambridge.redhat.com> <10689.1157020231@warthog.cambridge.redhat.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Sep 2006 10:44:45 +0100
Message-ID: <8777.1157535885@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> Is it safe to assume that a pointer will always be equal to or smaller
> than an unsigned long for all architectures?

I presume you're talking about the sizes of the types.  Inside the Linux
kernel:

	sizeof(void *) == sizeof(unsigned long)

must always hold true.  There are too many things that depend on it to do
otherwise.

> Casting a pointer to an unsigned long, in general, makes me a bit
> uncomfortable.

Pointers are just numbers that are used in a particular way.  Go and look in
linux/err.h:-)

> Dave Chinner told me that XFS uses 32-bit inode numbers on 32-bit
> machines, so I imagine that this patch really is only helpful for NFS.

At the moment, maybe, but they could always change it.  And what about Reiser4?

> +int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode)
> +{
> +	if (ecryptfs_inode_to_private(inode) && 

Is this part of the condition actually necessary?  Can you not guarantee that
this will always be true?

> +	ecryptfs_set_inode_lower(inode, igrab((struct inode *)lower_inode));

igrab() might fail.  I would recommend doing it before calling iget5_unlocked()
and drop the extraneous reference to lower_inode afterwards if the eCryptFS
inode returned is already set up.

You're also casting lower_inode twice.  Whilst there's nothing actually wrong
with that, it might look better if you assigned it to its own variable at the
top of the function and only do the cast once.

> +static void ecryptfs_read_inode(struct inode *inode) { }
> +

You shouldn't need that any more.  Just leave the read_inode op pointer unset.
The NULL pointer exception handler will let you know if anyone tries to access
it (which they shouldn't - only *you* should call iget*() on your own inodes).


Looks good otherwise.  Just the igrab() thing is a real problem.

David
