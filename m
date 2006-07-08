Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWGHQFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWGHQFA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWGHQFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:05:00 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:1446 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964879AbWGHQE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:04:59 -0400
Date: Sat, 8 Jul 2006 12:04:44 -0400
Message-Id: <200607081604.k68G4iev023286@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       "Steven M. French" <sfrench@us.ibm.com>, unionfs@filesystems.org,
       mm-commits@vger.kernel.org, jsipek@fsl.cs.sunysb.edu,
       "David J. Kleikamp" <shaggy@us.ibm.com>, fistgen@fsl.cs.sunysb.edu,
       ezk@cs.sunysb.edu, linux-kernel@vger.kernel.org
Subject: Re: [Unionfs] Re: + ecryptfs-dont-muck-with-the-existing-nameidata-structures.patch added to -mm tree 
In-reply-to: Your message of "Fri, 07 Jul 2006 18:24:32 CDT."
             <20060707232432.GA23350@us.ibm.com> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike, and everyone who wants to consider stacking:

If you want a stackable system to work well (instead of giving up and
"ripping it out" of your VFS), then you have to allow every major object
that is involved in the file system's implementation, to be stacked upon.
You have to think about a making things work not just for one-to-one stack,
but a stack of N levels (N > 2); or even fan-out stacks (ala Unionfs).

This means that, at the VERY least, every such object should have a way of
connecting it to its corresponding lower one(s).  More specifically, every
object needs to have some void* that is at the file system's control, into
which we can stuff info about lower objects, etc.

In all of the stackable file systems we've developed, we found it relatively
straightforward to handle struct inode, dentry, file, and superblock -- b/c
they have such a void* (or equivalent).

Things got more difficult when we had to deal w/ struct page, partly b/c
there's no easy way to have one page point to a lower page.  Struct page
also has the annoying problem that it back-refs *one* inode, via the
mapping->host (this is one major reason for the "double caching" problem).

When we ported the stackable file systems to 2.6, we noticed this new
nameidata structure being passed around to file systems.  Our initial desire
was to stack on it -- b/c that's the safest way avoid mixing objects b/t
layers.  But nameidata has no void* that one can use to stack on another.
So, instead, we looked at how precisely it was used by lower file systems.
We found out that, at least back when we did the 2.6 port, that it was ok to
just pass the nd we got from above to lower file systems, and that some file
systems didn't use it at all, so we could even just pass a null.  That
strategy may no longer work (b/c of nfsv4, it appears).

For years I've worked around similar VFS limitations, in my strong desire
not to require users to modify their kernel to use my stackable file
systems.  And this strategy was successful: stackable file systems had
become more and more popular (cf. Halcrow/IBM and www.unionfs.org :-)

But, if we we're now going to consider stacking seriously in linux, then I
think it would be best to do it cleanly.  This means that some changes to
the VFS are going to be unfortunately unavoidable.

Finally, note that just adding a void* to some structures won't
automatically make the code cleanly stackable.  Some VFS changes may be
needed, such as what Al did in 2.3: various VFS functions were split into
private VFS functions, and exported, reentrant vfs_* methods; these vfs_*
methods were very useful to us.

Sincerely,
Erez.
