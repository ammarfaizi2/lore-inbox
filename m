Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWIDG5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWIDG5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 02:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWIDG5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 02:57:39 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:30175 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932384AbWIDG5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 02:57:37 -0400
Date: Mon, 4 Sep 2006 08:52:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
In-Reply-To: <1157031183.3384.793.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr>
References: <1157031183.3384.793.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+struct file gfs2_internal_file_sentinal = {
>+	.f_flags = O_NOATIME|O_RDONLY,
>+};
>+
>+static int gfs2_read_actor(read_descriptor_t *desc, struct page *page,
>+			   unsigned long offset, unsigned long size)
>+{
>+	char *kaddr;
>+	unsigned long count = desc->count;
>+
>+	if (size > count)
>+		size = count;
>+
>+	kaddr = kmap(page);
>+	memcpy(desc->arg.buf, kaddr + offset, size);
>+        kunmap(page);
>+
>+        desc->count = count - size;
>+        desc->written += size;
>+        desc->arg.buf += size;
>+        return size;
>+}

Indent mismatch.

>+static int gfs2_readdir(struct file *file, void *dirent, filldir_t filldir)
>+{
>+	int error;
>+
>+	if (strcmp(current->comm, "nfsd") != 0)

Is not there a better way to do this? Note that there is also a "nfsd4" process
running. Do you really want to do a 'costly'

  strcmp(current->comm, "nfsd") != 0 && strcmp(current->comm, "nfsd4") != 0

every time someone does a readdir? What if I run a userspace nfs daemon?
What if that userspace daemon is called differently?

jengelh@linux01:7 08:28:14 ~ > ps -e | grep nfs
 5580 ?        00:00:08 rpc.nfsd
jengelh@linux01:7 08:28:30 ~ > rpm -qf /usr/sbin/rpc.nfsd 
nfs-server-2.2beta51-209.2 (a userspace nfsd)

>+static int do_flock(struct file *file, int cmd, struct file_lock *fl)
>+{
>+	struct gfs2_file *fp = file->private_data;
>+	struct gfs2_holder *fl_gh = &fp->f_fl_gh;
>+	struct gfs2_inode *ip = GFS2_I(file->f_dentry->d_inode);
>+	struct gfs2_glock *gl;
>+	unsigned int state;
>+	int flags;
>+	int error = 0;
>+
>+	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
>+	flags = ((IS_SETLKW(cmd)) ? 0 : LM_FLAG_TRY) | GL_EXACT | GL_NOCACHE;
                 ^              ^

>+const struct file_operations gfs2_dir_fops = {
>+	.readdir = gfs2_readdir,
>+	.unlocked_ioctl = gfs2_ioctl,
>+	.open = gfs2_open,
>+	.release = gfs2_close,
>+	.fsync = gfs2_fsync,
>+	.lock = gfs2_lock,
>+	.flock = gfs2_flock,
>+};

Maybe have the structs' members lined up.

>+/*
>+ * These values are provided for use as indices of an array
>+ * for use with the iflags_cvt function below
>+ */
>+enum {
>+	iflag_SecureRm		= 0,	/* Secure deletion */

If these values are not used on-disk or on-network, the =N parts could go away.

>+ fail_sys:
>+	gfs2_sys_fs_del(sdp);

Some labels in your code have a leading space, others do not. Make it
consistent.

>+static int gfs2_get_sb(struct file_system_type *fs_type, int flags,
>+		const char *dev_name, void *data, struct vfsmount *mnt)
>+{
>+	struct super_block *sb;
>+	struct gfs2_sbd *sdp;
>+	int error = get_sb_bdev(fs_type, flags, dev_name, data, fill_super, mnt);
>+	if (error)
>+		goto out;
>+	sb = mnt->mnt_sb;
>+	sdp = (struct gfs2_sbd*)sb->s_fs_info;

Nocast.

>+static int test_bdev_super(struct super_block *s, void *data)
>+{
>+	return (void *)s->s_bdev == data;
>+}

Nocast.

>+static int gfs2_get_sb_meta(struct file_system_type *fs_type, int flags,
>+			    const char *dev_name, void *data, struct vfsmount *mnt)
>+{
>+	sdp = (struct gfs2_sbd*) sb->s_fs_info;

Nocast.

>+	error = gfs2_change_nlink(dip, +1);

Interesting annotation of direction (+1) :-)

>+	/* Make sure we aren't trying to move a dirctory into it's subdir */

Should not the VFS handle this? (Or at least, the VFS should have some
generic_*_check_move_subdir() or so, in case a fs does not have its own.)

>+/**
>+ * gfs2_getattr - Read out an inode's attributes
>+ * @mnt: ?

Might complete the doc.

>+	struct gfs2_ea_request er;

Just for info, EA stands for what?




Jan Engelhardt
-- 

-- 
VGER BF report: U 0.5
