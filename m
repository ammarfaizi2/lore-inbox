Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318541AbSICFQO>; Tue, 3 Sep 2002 01:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSICFQO>; Tue, 3 Sep 2002 01:16:14 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:42465 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318541AbSICFQN>; Tue, 3 Sep 2002 01:16:13 -0400
Date: Tue, 3 Sep 2002 06:20:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function
In-Reply-To: <20020903035745.GG29452@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.SOL.3.96.1020903055423.13331A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002, Jan Harkes wrote:
> On Sat, Aug 31, 2002 at 07:00:04PM +0100, Anton Altaparmakov wrote:
> > Without such icache lookup functionality it is impossible to write inodes
> > via the VM page dirty code paths AFAICS. - The only alternative I can see
> > is to duplicate the whole icache private to NTFS so that I can perform the
> > lookup internally but I think that is silly considering the VFS already
> > keeps the inode cache...
> 
> Wouldn't you be able to use something like the following code to do ilookup?
> 
> Jan
> 
> 
> static int dont_set(struct inode *inode, void *data)
> {
> 	return -1;
> }
> 
> struct inode *ilookup(struct super_block *sb, struct list_head *head,
> 		      int (*test)(struct inode *, void *), void *data)
> {
> 	return iget5_locked(sb, head, test, dont_set, data);
> }

Sure! But that makes me want to throw up. Before I use that I would
implement my own ntfs inode cache alongside the VFS...

1) The iget5_locked + failing set() approach incurs an
alloc_inode()/destroy_inode() + a second find_inode() + second taking of
inode_lock, i.e. it is very expensive operation. 

2) It will return inodes that are I_FREEING or I_CLEAR. I will have to
test for these in NTFS and then iput() to wash my hands clean of such
garbage. And if I am not mistaken, the iput() actually will BUG().

3) My proposed ilookup() is fast and small so I would prefer that. And it
would seem quite a few other FS would be only too happy to see something
along those lines appear.

4) If anything, as Christoph Hellwig suggested to me on #kernel,
iget{,5}_locked() should be reimplemented in terms of my ilookup()
implementation and not vice versa. (-:

I suspect that point 2) may actually be an existing race condition in the
VFS. If someone does iget() or iget_locked(), whatever, at just the right
time, they could end up with a very weird struct inode which would BUG() 
on iput() if the code actually survives that long... - I haven't looked
into this closely so I may be missing something which doesn't allow these
BUG() scenarios to happen but from a cursory look around when I was
looking for a way to do the equivalent of ilookup() it would seem there
isn't... 

Thanks for your comments. It is interesting to read everyone's
suggestions...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

