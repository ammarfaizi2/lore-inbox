Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSHNMyg>; Wed, 14 Aug 2002 08:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSHNMyg>; Wed, 14 Aug 2002 08:54:36 -0400
Received: from richardson.uni2.net ([130.227.52.104]:44510 "EHLO
	richardson.uni2.net") by vger.kernel.org with ESMTP
	id <S317793AbSHNMyf> convert rfc822-to-8bit; Wed, 14 Aug 2002 08:54:35 -0400
Message-ID: <D0B43857843DD41185DE0060979AC20C2FD38E@intermail.pallas.dk>
From: Agust Karlsson <Gusti@pallas.dk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Semaphore block in fs/super.c mount_root
Date: Wed, 14 Aug 2002 14:58:21 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to get a jffs2 file system to mount as root with kernel
2.4.18.
If I mount it as a "normal" mount point everything is OK, but if I use it as
a root device it blocks forever.
I have traced it down to the function mount_root in fs/super.c where I can
see that there is an up_read(&sb->s_umount) (line 1061) when we get the
super block directly just before the goto mount_it.
But where my jffs2 superblock gets read (line 1073) there is no such
up_read() and by tracing the calls from blkdev_put() (line 1077) I'll find
an down_read(&s->s_umount) in the function get_super() (line 518 same file).

By putting in an up_read(&sb->s_umount) just before blkdev_put() solves my
problem.
Do I need to increase the sb->s_active as well ???

Just wantet to point this out in case this is a bug.
BTW the down_write() just before the goto mount_it; has no effect as the
first statement after the label is up_write() on the same semapohre

Hereis a list of the relevant part of super.c with my alteration:
from line 1056:
	sb = get_super(ROOT_DEV);
	if (sb) {
		/* FIXME */
		p = (char *)sb->s_type->name;
		atomic_inc(&sb->s_active);
		up_read(&sb->s_umount);
		down_write(&sb->s_umount);
		goto mount_it;
	}
	for (p = fs_names; *p; p += strlen(p)+1) { 
		struct file_system_type * fs_type = get_fs_type(p);
		if (!fs_type)
  			continue;
		atomic_inc(&bdev->bd_count);
		retval = blkdev_get(bdev, mode, 0, BDEV_FS);
		if (retval)
			goto Eio;
  		sb = read_super(ROOT_DEV, bdev, fs_type,
				root_mountflags, root_mount_data);
		put_filesystem(fs_type);
		if (sb) {
                                    up_read(&sb->s_umount);  //This works
for jffs2
			blkdev_put(bdev, BDEV_FS);
			goto mount_it;
		}
	}

Best regards
Gusti
--
Agust Karlsson            mailto:gusti@pallas.dk
Pallas Informatik A/S     http://www.pallas.dk
Allerød Stationsvej 2D    Tel.: +45 48 10 24 10
DK-3450 Allerød           Fax.: +45 48 10 24 01


