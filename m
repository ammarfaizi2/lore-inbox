Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbTCOUHK>; Sat, 15 Mar 2003 15:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTCOUHI>; Sat, 15 Mar 2003 15:07:08 -0500
Received: from comtv.ru ([217.10.32.4]:49067 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261532AbTCOUHB>;
	Sat, 15 Mar 2003 15:07:01 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove BKL from ext2's readdir
References: <m3vfyluedb.fsf@lexa.home.net>
	<20030315023614.3e28e67b.akpm@digeo.com>
	<20030315030322.792fa598.akpm@digeo.com>
	<m3wuj0fvls.fsf@lexa.home.net>
	<20030315121125.48294975.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 15 Mar 2003 23:09:42 +0300
In-Reply-To: <20030315121125.48294975.akpm@digeo.com>
Message-ID: <m3smto4cjd.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:


 AM> grep again.

 AM> I've made the change to ext2 and ext3.  Other filesystems will
 AM> require some thought to verify that the lock_kernel()s are not
 AM> protecting against some other random codepath.


hmm:

[root@proto edited]# head Makefile 
VERSION = 2
PATCHLEVEL = 5
SUBLEVEL = 64
EXTRAVERSION =


fs/ext2/dir.c:

struct file_operations ext2_dir_operations = {
        .read           = generic_read_dir,
        .readdir        = ext2_readdir,
        .ioctl          = ext2_ioctl,
        .fsync          = ext2_sync_file,
};



fs/read_write.c:

static inline loff_t llseek(struct file *file, loff_t offset, int origin)
{
        loff_t (*fn)(struct file *, loff_t, int);

        fn = default_llseek;
        if (file->f_op && file->f_op->llseek)
                fn = file->f_op->llseek;
        return fn(file, offset, origin);
}

