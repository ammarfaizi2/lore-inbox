Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTJBMBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 08:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbTJBMBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 08:01:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263335AbTJBMBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 08:01:34 -0400
Date: Thu, 2 Oct 2003 13:01:33 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
Message-ID: <20031002120133.GC7665@parcelfarce.linux.theplanet.co.uk>
References: <1064936688.4222.14.camel@localhost.localdomain> <200309302006.32584.vitaly@namesys.com> <1065019441.4226.1.camel@localhost.localdomain> <16251.5348.570797.101912@laputa.namesys.com> <20031001184338.GW7665@parcelfarce.linux.theplanet.co.uk> <16251.63770.622805.143036@laputa.namesys.com> <20031002103550.GB7665@parcelfarce.linux.theplanet.co.uk> <16252.798.375208.261677@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16252.798.375208.261677@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Linus, please wait with applying the patch below until ACK from Nikita, OK?]

On Thu, Oct 02, 2003 at 02:51:10PM +0400, Nikita Danilov wrote:
> viro@parcelfarce.linux.theplanet.co.uk writes:
>  > On Thu, Oct 02, 2003 at 02:08:26PM +0400, Nikita Danilov wrote:
>  > > What about creating fake struct vfsmount for /proc/fs/reiserfs/<devname>
>  > > and attaching it to the super block of /<mountpoint>? After all
>  > > /proc/fs/reiserfs/<devname> is just a view into /<mountpoint>. This will
>  > > automatically guarantee that /<mountpoint> cannot be unmounted while
>  > > files in /proc/fs/reiserfs/<devname> are opened. Will this screw up
>  > > dcache?
>  > 
>  > I don't see what it would buy you - you get to revalidate the pointer to
>  > vfsmount instead of revalidating pointer to superblock, which is not easier.
> 
> I thought that opening procfs file would do mntget() that will pin super
> block of host file system. Wouldn't it?

That wouldn't help.  Look, the real problem here is that at some point
you need to decide that filesystem is getting shut down.  Doesn't really
matter how you do it - until some moment superblock is up and running,
after it we start shutting the things down.

Now, you want two places that would get access to superblock (directly or
not, again, it doesn't matter): mountpoint and file in procfs.  Mountpoint
is given up by explicit action - umount.  You want that action to trigger
removal of file in procfs.  I.e. you don't want simple presense of that
file to pin the thing down.  OTOH, you want IO on that file to hold
the filesystem until we are done.  Whether we do that in open() or in
read(), we still have a transition point somewhere.

And that transition is where the trouble is.  The object you want to access
is superblock.  So no matter what you do, you will need to get hold of it.
Which brings us back to revalidation of pointers to superblocks...

There *is* an alternative, and it might be worth considering, but it's much
more intrusive.  We might give these files a separate superblock and have
them mounted explicitly.  Then we are fine - this superblock would have
a pointer to vfsmount or reiserfs superblock directly and would pin it
down as long as it's mounted.  It would look like that:

mount -t reisermeta <pathname of reiserfs mountpoint> <some directory>

and we get these files under <some directory>.  That would avoid all problems
nicely and it's not hard to implement, but it's definitely more intrusive than
sget()-based revalidation and it creates a user-visible interface change.

It might be worth doing as an alternative interface (Jeff Garzik had played
with similar stuff for ext2 metadata/defragmenting/etc., so there's even
some existing code), but I would rather go for minimally intrusive correct
fix right now.


Speaking of seq_file...  It's not impossible to do if this context is kept
on stack of ->start()/->next()/->stop()/->show() callers, but I'm not sure
it buys us enough to be worth doing.


If you are OK with the patch below - please ACK it.  AFAICS it's the minimal
fix and combined with optimistic sget() patch it should address all objections.

diff -urN B6-rest/fs/reiserfs/procfs.c B6-current/fs/reiserfs/procfs.c
--- B6-rest/fs/reiserfs/procfs.c	Sat Sep 27 22:04:57 2003
+++ B6-current/fs/reiserfs/procfs.c	Thu Oct  2 07:57:31 2003
@@ -478,14 +478,15 @@
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	++*pos;
+	if (v)
+		deactivate_super(v);
 	return NULL;
 }
 
 static void r_stop(struct seq_file *m, void *v)
 {
-	struct proc_dir_entry *de = m->private;
-	struct super_block *s = de->data;
-	deactivate_super(s);
+	if (v)
+		deactivate_super(v);
 }
 
 static int r_show(struct seq_file *m, void *v)
