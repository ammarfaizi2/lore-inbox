Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937117AbWLFS4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937117AbWLFS4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937108AbWLFS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:56:17 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:49464 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937117AbWLFS4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:56:16 -0500
Date: Wed, 6 Dec 2006 19:46:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
In-Reply-To: <20061206173245.GA23405@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235471170-git-send-email-jsipek@cs.sunysb.edu>
 <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr>
 <20061205195013.GE2240@filer.fsl.cs.sunysb.edu> <20061206173245.GA23405@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 6 2006 12:32, Josef Sipek wrote:
>> > >+int __init init_sioq(void)
>> > 
>> > Although it's just me, I'd prefer sioq_init(), sioq_exit(),
>> > sioq_run(), etc. to go in hand with what most drivers use as naming
>> > (i.e. <modulename> "_" <function>).
>> 
>> That makes sense.
> 
>Hrm. Looking at the code, I noticed that the opposite is true:
>
>destroy_filldir_cache();
>destroy_inode_cache();
>destroy_dentry_cache();
>unregister_filesystem(&unionfs_fs_type);
>
>The last one in particular...

I smell a big conspiracy! So yet again it's mixed mixed

fs$ grep __init */*.c | grep -v ' init_'
sysfs/mount.c:int __init sysfs_init(void)
sysv/inode.c:int __init sysv_init_icache(void)
proc/vmcore.c:static int __init vmcore_init(void)
proc/nommu.c:static int __init proc_nommu_init(void)
proc/proc_misc.c:void __init proc_misc_init(void)
proc/proc_tty.c:void __init proc_tty_init(void)
proc/root.c:void __init proc_root_init(void)


> 
>> > >+void __unionfs_mknod(void *data)
>> > >+{
>> > >+	struct sioq_args *args = data;
>> > >+	struct mknod_args *m = &args->mknod;
>> > 
>> > Care to make that: const struct mknod_args *m = &args->mknod;?
>> > (Same for other places)
>>  
>> Right.
> 
>If I make the *args = data line const, then gcc (4.1) yells about modifying
>a const variable 3 lines down..
>
>args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
>
>Sure, I could cast, but that seems like adding cruft for no good reason.

No I despise casts more than missing consts. Why would gcc throw a warning?
Let's take this super simple program

<<<
struct inode;
struct dentry;

struct mknod_args {
    struct inode *parent;
    struct dentry *dentry;
    int mode;
    int dev;
};

extern int vfs_mknod(struct inode *, struct dentry *, int, int /*dev_t*/);

int main(void) {
    const struct mknod_args *m;
    vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
    return 0;
}
>>>

As undefined-behavior as it looks, it's got the const and vfs_mknod, as well as
an approximation of dev_t. It throws no warnings when compiled with `gcc -Wall
-c test.c`. Did I miss something?



	-`J'
-- 
