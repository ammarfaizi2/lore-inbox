Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285151AbRLMURn>; Thu, 13 Dec 2001 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285154AbRLMURe>; Thu, 13 Dec 2001 15:17:34 -0500
Received: from fw.pdx.polyserve.com ([65.209.250.242]:11527 "HELO
	mail.pdx.polyserve.com") by vger.kernel.org with SMTP
	id <S285151AbRLMURV>; Thu, 13 Dec 2001 15:17:21 -0500
Message-ID: <3C190C34.50008@polyserve.com>
Date: Thu, 13 Dec 2001 12:14:44 -0800
From: Michael Gaughen <mgaughen@polyserve.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: mgaughen@polyserve.com
Subject: SMP race in VFS.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I have a question about a potential race, on SMP machines,
between the creat(2) and rename(2) operations.  Rename has the
semantic that if the "newpath" exists, then it will be atomically
replaced.  Now I have two processes: one is renaming a directory
"a" to directory "b" (which _is_ empty), while the second is
trying to create a file "c" within directory "b."  In that test, the
directory "b" should _always_ exist, therefore, the create should
always succeed.  However, there exists a window of opportunity
in which the create can return ENOENT.

  Upon further investigation of the VFS code, I found:

     do_rename():
        ...
        lock_kernel();
        error = vfs_rename(old_dir->d_inode, old_dentry,
                                   new_dir->d_inode, new_dentry);
        unlock_kernel();
        ...

  that eventually calls down to:

      vfs_rename_dir():
        if (target) { /* Hastur! Hastur! Hastur! */
                triple_down(&old_dir->i_zombie,
                            &new_dir->i_zombie,
                            &target->i_zombie);
                d_unhash(new_dentry);
        } else
                double_down(&old_dir->i_zombie,
                            &new_dir->i_zombie);
        ...
        if (target) {
                if (!error)
                        target->i_flags |= S_DEAD;
                triple_up(&old_dir->i_zombie,
                          &new_dir->i_zombie,
                          &target->i_zombie);
                if (d_unhashed(new_dentry))
                        d_rehash(new_dentry);
                dput(new_dentry);
        } else
                double_up(&old_dir->i_zombie,
                          &new_dir->i_zombie);

        if (!error)
                d_move(old_dentry,new_dentry);
         ...

     vfs_create():
         ...
        down(&dir->i_zombie);
        error = may_create(dir, dentry);
        if (error)
                goto exit_locks;
        ...
        lock_kernel();
        error = dir->i_op->create(dir, dentry, mode);
        unlock_kernel();
        ...

Now, in this case, both processes have performed their
path walks, and are now referencing the same dentry/inode
corresponding to the directory "b."  The rename process is
able to acquire the BKL, and the necessary i_zombies first.
The create process must then block, within vfs_create,
waiting for directory "b's" i_zombie.  The rename operation
completes, sets S_DEAD within the target inode (in this case
the target inode is the directory "b"), and releases all of its
i_zombies.  At this point, before vfs_rename_dir is able to
call d_move, the process blocked in vfs_create is able to
acquire the i_zombie, and call may_create - which finds that
the directory "b's" inode is now dead and returns ENOENT.

The problem boils down to the fact that the d_move was not
called before the may_create.  I am not sure of the appropriate
fix for this race, but I see at least two options.  One is to move
the call to may_create within the lock_kernel() - however, that
may not be a good long term solution if the BKL is going away.  
Another possibility is to move the call to d_move within the
protection of the i_zombie (within vfs_rename_dir).

The test was run on an SMP machine running Linux kernel2.4.7.  
Upon inspection, I found that the race still exists in the latest stable
release: 2.4.16.  And this race _only_ exists_ on SMP machines.

Comments?  Ideas?  Flames?

Thanks,
-Mike Gaughen

ps.  Please CC me on any replies, as I am not subscribed to the list.

