Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbTIMXfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTIMXfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:35:43 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17675
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262249AbTIMXfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:35:33 -0400
Date: Sat, 13 Sep 2003 16:17:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <Pine.LNX.4.10.10309131209520.16744-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10309131614250.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


more examples of SYMBOL rip offs.

2.6.0-test5

./kernel/exit.c

static inline void __exit_fs(struct task_struct *tsk)
{
        struct fs_struct * fs = tsk->fs;

        if (fs) {
                task_lock(tsk);
                tsk->fs = NULL;
                task_unlock(tsk);
                __put_fs_struct(fs);
        }
}

void exit_fs(struct task_struct *tsk)
{
        __exit_fs(tsk);
}

./kernel/fork.c

static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
{
        struct fs_struct *fs = kmem_cache_alloc(fs_cachep, GFP_KERNEL);
        /* We don't need to lock fs - think why ;-) */
        if (fs) {
                atomic_set(&fs->count, 1);
                fs->lock = RW_LOCK_UNLOCKED;
                fs->umask = old->umask;
                read_lock(&old->lock);
                fs->rootmnt = mntget(old->rootmnt);
                fs->root = dget(old->root);
                fs->pwdmnt = mntget(old->pwdmnt);
                fs->pwd = dget(old->pwd);
                if (old->altroot) {
                        fs->altrootmnt = mntget(old->altrootmnt);
                        fs->altroot = dget(old->altroot);
                } else {
                        fs->altrootmnt = NULL;
                        fs->altroot = NULL;
                }
                read_unlock(&old->lock);
        }
        return fs;
}

struct fs_struct *copy_fs_struct(struct fs_struct *old)
{
        return __copy_fs_struct(old);
}

EXPORT_SYMBOL_GPL(exit_fs);
EXPORT_SYMBOL_GPL(copy_fs_struct);

This is what the issue is about!
Taking away the functionality of the API.

So much for choice anymore.



Andre Hedrick
LAD Storage Consulting Group


