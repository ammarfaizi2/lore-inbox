Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbSKFWen>; Wed, 6 Nov 2002 17:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266176AbSKFWem>; Wed, 6 Nov 2002 17:34:42 -0500
Received: from thunk.org ([140.239.227.29]:55714 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266175AbSKFWel>;
	Wed, 6 Nov 2002 17:34:41 -0500
Date: Wed, 6 Nov 2002 17:41:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christopher Li <chrisl@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name, leaves ino with bad nlink
Message-ID: <20021106224112.GA10130@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christopher Li <chrisl@vmware.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Ext2 devel <ext2-devel@lists.sourceforge.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <1036471670.21855.15.camel@ixodes.goop.org> <20021105212415.GB1472@vmware.com> <20021106082500.GA3680@vmware.com> <20021106214027.GA9711@think.thunk.org> <20021106172455.A7778@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106172455.A7778@vmware.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 05:24:55PM -0800, Christopher Li wrote:
> > Simply retrying the ext3_delete_entry() isn't sufficient, since
> > another ext3_add_entry() could move the directory entry again while
> > you're reading in the blocks as part of ext3_find_entry().  OK, that
> > would be pretty rare, since enough other directory adds would have
> > to fill up enough that another split could happen, but *is* possible.
> > (Surely our scheduler isn't that unfair....)
> 
> I think we have the lock on ext3_rename. I might be wrong.
> If other process can change the dir between the add new entry
> and delete old entry. We should also need to check the entry have
> been delete from other process in case fall into dead loop? 

We take the BKL, yes; but if we need to sleep waiting for a block to
be read in, that's when another process can run.  Yes, that means
another process could end up deleting the entry out from under us ---
or make some other change to the directory.  I was actually quite
nervous about this, so I spent some time auditing the code paths of
when do_split() might sleep, to make sure it would never leave the
directory in an unstable condition.

Things will actually get easier once we fine-grain lock ext3 (and
remove the BKL), since we'll very likely end up locking the directory
during an insert, rename, or delete, and so we don't have to worry
about things happening in an interleaved fashion.

> Do you have time to look at the missing "." and ".." entry patch?

Yup, that's going to Linus as well.

> Can you please change my email address in source file to vmware
> if you submit it?

I wasn't able to find your e-mail address in the source file.... 
grep -i chrisl fs/ext3/*.c didn't turn up anything?

						- Ted
