Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWIDOp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWIDOp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWIDOp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:45:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39873 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751420AbWIDOp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:45:27 -0400
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr>
References: <1157031183.3384.793.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Sep 2006 15:50:40 +0100
Message-Id: <1157381440.3384.941.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 08:52 +0200, Jan Engelhardt wrote:
> >+struct file gfs2_internal_file_sentinal = {
> >+	.f_flags = O_NOATIME|O_RDONLY,
> >+};
> >+
> >+static int gfs2_read_actor(read_descriptor_t *desc, struct page *page,
> >+			   unsigned long offset, unsigned long size)
> >+{
> >+	char *kaddr;
> >+	unsigned long count = desc->count;
> >+
> >+	if (size > count)
> >+		size = count;
> >+
> >+	kaddr = kmap(page);
> >+	memcpy(desc->arg.buf, kaddr + offset, size);
> >+        kunmap(page);
> >+
> >+        desc->count = count - size;
> >+        desc->written += size;
> >+        desc->arg.buf += size;
> >+        return size;
> >+}
> 
> Indent mismatch.
> 
Now fixed.

> >+static int gfs2_readdir(struct file *file, void *dirent, filldir_t filldir)
> >+{
> >+	int error;
> >+
> >+	if (strcmp(current->comm, "nfsd") != 0)
> 
> Is not there a better way to do this? Note that there is also a "nfsd4" process
> running. Do you really want to do a 'costly'
> 
>   strcmp(current->comm, "nfsd") != 0 && strcmp(current->comm, "nfsd4") != 0
> 
> every time someone does a readdir? What if I run a userspace nfs daemon?
> What if that userspace daemon is called differently?
> 
> jengelh@linux01:7 08:28:14 ~ > ps -e | grep nfs
>  5580 ?        00:00:08 rpc.nfsd
> jengelh@linux01:7 08:28:30 ~ > rpm -qf /usr/sbin/rpc.nfsd 
> nfs-server-2.2beta51-209.2 (a userspace nfsd)
> 
Ah, now this is a very tricky one to solve. Its on my todo list to look
at this area again. You are right that the test is bogus in that it
should only respond to the in kernel NFS server and the reason for its
existence is due to locking issues with the way that NFS calls through
the VFS layer.

It means the in the NFS case we have to constantly check that the file
position within the directory hasn't changed. This is, of course rather
slow and hence has been special cased.

The test you've mentioned here is (aside from slow) also bogus for the
reason that any userspace NFS daemon will also get caught by this code
despite the fact that it could perfectly well use the "normal" readdir
function which is much faster.

It may be that the correct place to make the change is in NFS rather
than GFS2, but I haven't had a chance to look at this in detail yet.

Red Hat bugzilla #201015 is tracking this issue - I just realised that
it wasn't publicly viewable, so I've fixed that.

> >+static int do_flock(struct file *file, int cmd, struct file_lock *fl)
> >+{
[function lines snipped]
> >+	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
> >+	flags = ((IS_SETLKW(cmd)) ? 0 : LM_FLAG_TRY) | GL_EXACT | GL_NOCACHE;
>                  ^              ^
> 
ok.

> >+const struct file_operations gfs2_dir_fops = {
> >+	.readdir = gfs2_readdir,
> >+	.unlocked_ioctl = gfs2_ioctl,
> >+	.open = gfs2_open,
> >+	.release = gfs2_close,
> >+	.fsync = gfs2_fsync,
> >+	.lock = gfs2_lock,
> >+	.flock = gfs2_flock,
> >+};
> 
> Maybe have the structs' members lined up.
> 
now done.

> >+/*
> >+ * These values are provided for use as indices of an array
> >+ * for use with the iflags_cvt function below
> >+ */
> >+enum {
> >+	iflag_SecureRm		= 0,	/* Secure deletion */
> 
> If these values are not used on-disk or on-network, the =N parts could go away.
> 
These have to be equal to the values of the constants as originally
defined by ext2/3 and also used/extended by other fs. This is generic
infrastructure originally requested by Christoph. I didn't want to carry
patches to all the other filesystems in the GFS2 git tree, but they can
all use this as well and I'll send some patches once this has hit Linus
kernel tree.

> >+ fail_sys:
> >+	gfs2_sys_fs_del(sdp);
> 
> Some labels in your code have a leading space, others do not. Make it
> consistent.
> 
Fixed in an earlier commit.

> >+static int gfs2_get_sb(struct file_system_type *fs_type, int flags,
[lines snipped]
> 	sb = mnt->mnt_sb;
> >+	sdp = (struct gfs2_sbd*)sb->s_fs_info;
> 
> Nocast.
> 
ok.

> >+static int test_bdev_super(struct super_block *s, void *data)
> >+{
> >+	return (void *)s->s_bdev == data;
> >+}
> 
> Nocast.
> 
ok

> >+static int gfs2_get_sb_meta(struct file_system_type *fs_type, int flags,
> >+			    const char *dev_name, void *data, struct vfsmount *mnt)
> >+{
> >+	sdp = (struct gfs2_sbd*) sb->s_fs_info;
> 
> Nocast.
> 
ok.

> >+	error = gfs2_change_nlink(dip, +1);
> 
> Interesting annotation of direction (+1) :-)
> 
Well it seemed to make sense here, so I left it alone.

> >+	/* Make sure we aren't trying to move a dirctory into it's subdir */
> 
> Should not the VFS handle this? (Or at least, the VFS should have some
> generic_*_check_move_subdir() or so, in case a fs does not have its own.)
> 
It can't handle this since the VFS doesn't know about locking across the
cluster. GFS2 has to redo the checks which the VFS does once it has the
glocks required for the operation.

> >+/**
> >+ * gfs2_getattr - Read out an inode's attributes
> >+ * @mnt: ?
> 
> Might complete the doc.
> 
fixed.

> >+	struct gfs2_ea_request er;
> 
> Just for info, EA stands for what?
> 
Extended Attribute. I don't see anywhere convenient to add a note to the
code though... I guessed that it was reasonably obvious since it
occurred in a function relating to extended attributes. The patch for
this email is:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=26c1a57412b59a2284a521c711d9e9105bb6ad23


Steve.


