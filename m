Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTEYH3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTEYH3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 03:29:50 -0400
Received: from moraine.clusterfs.com ([216.138.243.178]:62339 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261422AbTEYH3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 03:29:43 -0400
Date: Sun, 25 May 2003 01:42:43 -0600
From: Peter Braam <braam@clusterfs.com>
To: viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@transmeta.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>, lustre-devel@lists.sf.net
Subject: intent patches
Message-ID: <20030525074243.GF18405@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al, Linus, Trond,

The Lustre intent patch has much in common with Trond's approach, but
is a bit more comprehensive and slightly differently implemented.

We'd very happy if we could try to integrate this, with Trond for 2.5
but we also understanding if it's deemed to be too disruptive.  

We _do_ have resources to sort it all out very agressively in the next
few weeks.

Intents
-------

We currently use intents for two methods: 
 - getattr
 - open
For other methods, we would like the intents also, but they did not
solve all our woes.  We may have overlooked one or two, like
permission. 

[a very preliminary patch, done partly wrongly]
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/iopen-jdike-2.5.69.patch?rev=1.1.2.1&content-type=text/vnd.viewcvs-markup

We embed into nameidata the following struct lookup_intent:

struct lookup_intent {
       int it_op;
       int it_mode;
       int it_flags;
       /* private data for FS and used to pass in second dentry for rename */
       void *it_data;  
       /* for setattr */
       struct iattr *it_attr;

       /* arguably the following are Lustre specific */
       int it_disposition;
       int it_status;
       __u64 it_lock_handle[2];
       int it_lock_mode;
};

We introduced lookup2 and d_revalidate2 to avoid changing all file
systems and in 2.5 we give them a namei data parameter.

The intents are used to indicate to the file system what is the
purpose of lookup of the last component of the pathname.  It allows
the file system to execute things atomically on the server and to
avoid taking locks for lookup separately from other locks for
operations that follow. 

We added a dentry method called intent_release. It's purpose is to
drop locks associated with the intent. It is principally called from
path_release (we are working around some issued in descending and
ascending mount points and following symbolic links).

We would like to pass a pointer to nameidata to: 

 - open (file method)
 - create directory (inode method)
 - lookup (inode method)
 - revalidate (dentry method)
 - revalidate (inode method)

and perhaps also to mkdir, rmdir, unlink, rename, mknod, setattr.  We
have not done so yet, and can work aroud this by adding a field 
     struct lookup_intent *d_it
in a dentry. This is not elegant, and the protection of this field is
delicate, but avoids large scale api changes.

Differences with Trond's patch.
-------------------------------

Trond changes all callers instead of adding lookup2 (better long term,
very invasive for pre-2.6),  he has vfsintent point to nameidata and
inside "opendata" and we have the exact opposite...  We do all
methods.

End of intent discussion.

Other  Lustre VFS issues
===================================================================

Other calls
-----------

We found it simpler to use a new method for mkdir, rmdir, mknod,
unlink, rename.  These methods execute entirely on the server and do
not instantiate a client dentry for the new or removed objects on the
client.  The client will get that from the server on the next lookup.

When we presented the intent proposal this approach was the
alternative.  We knew about and defended by by Bryan Henderson and
Bruce Walker.

We found we were best off having both alternatives.

If a file system uses fine grained locking, e.g. uses a different lock
to protect a dentry, the inode's (directory) content, and the inode's
attributes, there is no need for this approach, but with coarser
locks, like one lock per inode, an intent approach to some functions,
in particular rename, leads to a wild chase of locks and revocations
which the new methods avoid altogether.

But for the case of open and getattr, it was equally intractible to
use a server based operation, because following mountpoints and
symbolic links outside of the file system is somewhat client oriented,
see below.

Other issues raised by Lustre
-----------------------------

Lustre passed POSIX just as well as ext3 from one client.  In
distributed tests we found some new issues needed to be resolved and
we have not yet run a distributed POSIX test (see
http://marc.theaimsgroup.com/?l=lustre-devel&m=102719870303114&w=2)

Lustre has one single file system namespace across all clients, no
exceptions, keep that in mind for the following.

a. mount points

POSIX specifies mount points cannot be unlinked from the namespace.
We found it necessary for the VFS to let the covered file system know
when it is pinning a dentry for mounting.  The file system can then
take a lock or let the server know otherwise that other clients should
also not remove the mount point from the namespace.

b. current working directories

Several contraints exist on directories pinned by processes, e.g. you
can unlink but not destroy an unlinked directory into which a process
is cd'd.  Again, other nodes do not know about this unless chdir
notifies the FS that a dentry is pinned.

c. file handle cache

Lustre improved the NFS file handle lookups and Ted T'so's iopen patch
to make it possible to dcache file handles in an invisible directory
and provide dcached lookups, by carefully eliminating double dentries,
particularly for directories.

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/iopen-jdike-2.5.69.patch?rev=1.1.2.1&content-type=text/vnd.viewcvs-markup

d. distributed revalidation of dentries

In two cases we found the dcache was too harsh in rejecting a lookup.
These are the cases where d_revalidate and d_invalidate both return
0.  We did not understand the significance of everything, and could
not return -ENOENT. So we added a retry loop here.  Lookin fs/namei.c,
real_lookup, after the Uhhuh comment: we do not return -ENOENT, but
try again.  Similarly in filp_open/open_namei.

We also maintain a list of alienated dentries.  We forcefully unhash
busy, dcached dentries and put them on the list when lock revocations
come in that invalidate the dentry.  [This is done in Lustre, but we
added a d_flag to force d_invalidate to return 0.]  Lustre's lookup
puts them back in the hash if they are still on the list.

I discussed c & d with Al a few times and as he predicted it was
fairly hellish to sort out the races, but we prevailed, I think.

---------------------------------

With this we believe we are getting quite close to total POSIX
semantics for Lustre.  On 2.4 all except a. and b. is solid, we are
now finally focussing on 2.5 where more stabilization work is needed.

I hope this is useful.

- Peter -
