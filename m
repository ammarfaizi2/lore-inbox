Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272249AbTHDUr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272266AbTHDUr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:47:28 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:32927 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S272249AbTHDUrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:47:21 -0400
Date: Mon, 4 Aug 2003 16:47:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804204720.GA18059@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804155604.2cdb96e7.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 03:56:04PM +0200, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 15:44:15 +0200 Andries Brouwer <aebr@win.tue.nl> wrote:
> > 
> > Quite a lot of software thinks that the file hierarchy is a tree,
> > if you wish a forest.
> > 
> > Things would break badly if the hierarchy became an arbitrary graph.
> 
> Care to name one? What exactly is the rule you see broken? Sure you can build
> loops, but you cannot prevent people from doing braindamaged things to their
> data anyway. You would not ban dd either for being able to flatten your
> harddisk only because of one mistyping char...

Only root can 'dd' to my disks, but anyone can do 'mkdir a; ln a a/a'
and get even the simple things really messed up. You can't even rm -rf
it anymore.

Currently rm doesn't need to concern itself about loops. If something
doesn't go away, it is a non-empty directory that needs to be traversed,
and suddenly it has to track inodes and device numbers to identify
potential cycles in the path. Hundreds of simple application suddenly
become more complex. Can you imagine 'rm' running your machine out of
memory on a reasonably sized tree.

Also all 'hardlinked name entries' point at the same object. However,
'..' could be the parent directory of any one of the name entries, but
clearly not more than one at any time. So we actually have two (or more)
objects that do not have the identical contents but share the same
supposedly unique object identifier (inode number).

Should we be allowed to 'unlink' a directory that is non-empty? But then
the rmdir has to check all children, count the number of directories
(i.e. fetch the attributes of all children) to compensate for the
additional linkcounts added by the '..' entries. And to avoid a race
with another unlink, or changes to the directory while we are traversing
it this has to happen while all access to the directory is locked out.
Not very scalable, especially when your directories do contain
tens-of-thousands of users and gigabytes of data.

Now if we don't allow the unlink for non-empty directories it is
possible to create a loop that can never be removed. ln / /tmp/foo

Typical optimizations for directory traversal make use of the fact that
the child directories increase the link count. When reading directory
entries and (linkcount - 2) directories have been seen we know all other
entries are files. The additional references make this optimization
useless.

NFS exporting a filesystem is another good example. NFS is stateless and
currently identifies files with a cookie that contains the (device/ino)
pair. But because inode numbers are no longer unique because we need to
know who the parent is, but the parent ino number also isn't unique
anymore, so we need to pass a list of device/[list of all parents]/ino.

As a result we're no better of compared to sending fixed pathnames over
to the NFS server, and anyone who moves a directory from a to b breaks
all other clients that happen to have a reference to a file or directory
anywhere in the tree below the recently moved directory.

Did you want any more reasons why hardlinked directories are bad?

Jan
