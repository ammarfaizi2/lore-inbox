Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbTEIEYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 00:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTEIEYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 00:24:35 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:52383 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262293AbTEIEYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 00:24:34 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Date: Fri, 9 May 2003 14:36:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16059.12369.932394.482644@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - Don't remove inode from hash until filesystem has deleted it.
In-Reply-To: message from Jan Harkes on Thursday May 8
References: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
	<20030508204334.GA8577@delft.aura.cs.cmu.edu>
X-Mailer: VM 7.14 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 8, jaharkes@cs.cmu.edu wrote:
> On Thu, May 08, 2003 at 11:44:32AM +1000, Neil Brown wrote:
> > ------------------------------------------------------
> > Don't remove inode from hash until filesystem has deleted it.
> >
> > With this patch, the inode being deleted is left on the hash table,
> > and if a lookup find an inode being freed in the hashtable, it waits
> > in the inode waitqueue for the inode to be fully deleted.
> 
> I could be wrong, but won't that break the following sequence of
> operations,
> 
>     mkdir("foo", 0755);
>     fd = creat("foo/bar", 0644);
>     unlink("foo/bar");
>     rmdir("foo"); /* this should succeed, but if the file is hashed
> 		     we get EBUSY here */
>     close(fd);
> 
> Or have potential deadlock effects when rmdir is replaced with some
> operation that tries to perform a lookup for the inode, f.i. a
> stat("foo/bar", &statbuf);
> 
> Jan

Thankyou for your feedback.

However I don't think this is a problem.

The patch keeps the *inode* in the *inode hash table* slightly longer
than normal, but it does nothing to any dentry that might be connected
to the inode and might be hashed in a dentry table.
So when you unlink("foo/bar") the dentry is treated just as it always
is and is unhashed.

It is just the inode that instead of being unhash before the
filesystem it told that it is to be delete (this is different from
telling it that a filename is to be deleted), it is now unhash after
the filesystem has completed it's deletion process.

NeilBrown
