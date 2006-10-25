Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWJYU4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWJYU4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWJYU4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:56:35 -0400
Received: from shells.gnugeneration.com ([207.44.156.13]:17358 "HELO
	shells.gnugeneration.com") by vger.kernel.org with SMTP
	id S1422781AbWJYU4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:56:34 -0400
Date: Wed, 25 Oct 2006 15:56:34 -0500
From: lkml@pengaru.com
To: linux-kernel@vger.kernel.org
Subject: rename() contention (BUG?)
Message-ID: <20061025205634.GB9100@shells.gnugeneration.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have seen some scalability problems with Maildir-based mail systems running on
Linux (debian sarge, 2.6.8), and after much investigation I found a large part
of the problem was rename() contention.

Under periods of high concurrency (multi-process or multi-threaded parallel POP
or IMAP servers), the server load would begin to skyrocket with most of the
processes in D state.  

Though the WCHAN of the processes was always "-" in these delays, I found via
strace that the delays were occuring in the rename() system call.

However, the storage was not being stressed, it was an EMC NAS being accessed
over NFS with plenty of spindles to go around and the NAS head had little load
on it.

After looking through the kernel sources I found in the VFS layer (fs/namei.c):

/*
 * p1 and p2 should be directories on the same fs.
 */
struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
{
        struct dentry *p;

        if (p1 == p2) {
                down(&p1->d_inode->i_sem);
                return NULL;
        }

        down(&p1->d_inode->i_sb->s_vfs_rename_sem);

        for (p = p1; p->d_parent != p; p = p->d_parent) {
                if (p->d_parent == p2) {
                        down(&p2->d_inode->i_sem);
                        down(&p1->d_inode->i_sem);
                        return p;
                }
        }

        for (p = p2; p->d_parent != p; p = p->d_parent) {
                if (p->d_parent == p1) {
                        down(&p1->d_inode->i_sem);
                        down(&p2->d_inode->i_sem);
                        return p;
                }
        }

        down(&p1->d_inode->i_sem);
        down(&p2->d_inode->i_sem);
        return NULL;
}


void unlock_rename(struct dentry *p1, struct dentry *p2)
{
        up(&p1->d_inode->i_sem);
        if (p1 != p2) {
                up(&p2->d_inode->i_sem);
                up(&p1->d_inode->i_sb->s_vfs_rename_sem);
        }
}
 

I also found this documented in Documentation/filesystems/directory-locking, the
problem became clear.  Though these servers were implemented using parallel
programming techniques, they were being serialized at the cross-directory
renames occuring on the same filesystem.

I was able to eliminate the symptoms by splitting what was one large
"filesystem" into 256 filesystems, which worked well enough for me not to care
so much about it.  This was done by simply mounting the subdirectories
explicitly, no changes were done to the NAS.  (mail was layed out as something
like /mail/[0-9a-f]/[0-9a-f]/[0-9a-f]/Maildir already, so it was trivial to add
more mounts).

However, after thinking more about this rename locking scheme, I must ask you
guys & gals:

What exactly is the purpose of the s_vfs_rename_sem?
Must that lock be held for the duration of the rename operation?  
Couldnt we release it after acquiring the locks on the relevant
directories?

To me, it looks like the s_vfs_rename_sem is for making the acquisition
of the multiple directory locks atomic to prevent deadlock.  But once you hold
the locks, couldnt you release the s_vfs_rename_sem?

For example:


/*
 * p1 and p2 should be directories on the same fs.
 */
struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
{
        struct dentry *p;

        if (p1 == p2) {
                down(&p1->d_inode->i_sem);
                return NULL;
        }

        down(&p1->d_inode->i_sb->s_vfs_rename_sem);

        for (p = p1; p->d_parent != p; p = p->d_parent) {
                if (p->d_parent == p2) {
                        down(&p2->d_inode->i_sem);
                        down(&p1->d_inode->i_sem);
			up(&p1->d_inode->i_sb->s_vfs_rename_sem);
                        return p;
                }
        }

        for (p = p2; p->d_parent != p; p = p->d_parent) {
                if (p->d_parent == p1) {
                        down(&p1->d_inode->i_sem);
                        down(&p2->d_inode->i_sem);
			up(&p1->d_inode->i_sb->s_vfs_rename_sem);
                        return p;
                }
        }

        down(&p1->d_inode->i_sem);
        down(&p2->d_inode->i_sem);
	up(&p1->d_inode->i_sb->s_vfs_rename_sem);

        return NULL;
}


void unlock_rename(struct dentry *p1, struct dentry *p2)
{
        up(&p1->d_inode->i_sem);
        if (p1 != p2) {
                up(&p2->d_inode->i_sem);
        }
}



If we could avoid holding the lock during the (potentially lengthy, depending on
the filesystem & storage) rename operation, it would help especially these
Maildir-based mail servers.

So, am I totally off my rocker here?

Regards,
Vito Caputo
