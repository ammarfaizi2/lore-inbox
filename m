Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWFJB4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWFJB4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWFJB4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:56:37 -0400
Received: from thunk.org ([69.25.196.29]:17568 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751446AbWFJB4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:56:37 -0400
Date: Fri, 9 Jun 2006 21:56:31 -0400
From: Theodore Tso <tytso@mit.edu>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060610015631.GA29805@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
References: <E1Foqjw-00010e-Ln@candygram.thunk.org> <20060610012757.GC27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610012757.GC27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 02:27:57AM +0100, Al Viro wrote:
> > 5) Nuke i_cindex.  This is only used by ieee1394's
> >    ieee_file_to_instance.  There must be another place where we can
> >    store this --- say, in a ieee1394-specific field in struct file?  Or
> >    maybe it can be derived some other way, but to chew up 4 bytes in
> >    i_cindex for all inodes just for ieee1394's benefit seems like the
> >    Wrong Thing(tm).
> 
> No, it's actually the right thing for _all_ char devices.  And it's used
> before we get a struct file.  If anything, ->i_rdev should go long-term...

i_cindex is set by fs/char_dev.h, and the only user of that field (I
grepped the entire sources) is ./drivers/ieee1394/ieee1394_core.h:

   /* return the index (within a minor number block) of a file */
   static inline unsigned char ieee1394_file_to_instance(struct file *file)
   {
	return file->f_dentry->d_inode->i_cindex;
   }


> > 6) Separate out those elements which are only used if the inode is open
> >    into a separate data structure (call it "struct inode_state" for
> >    the sake of argument):
> > 
> > 	i_flock, i_mapping, i_data, i_dnotify_mask, i_dnotify,
> > 	inotify_watches, inotify_sem, i_state, dirtied_when,
> > 	i_size_seqcount, i_mutex, i_alloc_sem
> > 
>
> It is not safe e.g. for ->i_mutex, since that puppy is used not only when
> there's an opened file over this inode (or, in fact, before any method
> had been called for this inode).
> 
> It is _certainly_ not safe for ->i_state (take a look at fs/inode.c).
> 
> It is not safe for ->i_data, unless you are willing to dispose of page
> cache on close (even leaving aside such things as directories).
> 
> No comments on idiotify fields - IIRC, they can also be used before any
> ->open() on the inode in question.

You're right, I added some fields which can't be moved out of struct
inode, but the basic point remains; it should be possible to shrink
struct inode by moving fields to an inode_state structure.

As far as i/dnotify fields are concerned, yes, they can be used on an
unopened inode, but we could also simply consider a file that is being
watched by i/dnotify as one that is "opened" from the point of view of
needing a inode_state structure to be allocated.  Depending on how
many files a typical GUI desktop is going to watch, this might or
might not be good idea.

Regards,

						- Ted
