Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268489AbTCFWhf>; Thu, 6 Mar 2003 17:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268492AbTCFWhf>; Thu, 6 Mar 2003 17:37:35 -0500
Received: from webmail17.rediffmail.com ([203.199.83.27]:61582 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S268489AbTCFWhb>;
	Thu, 6 Mar 2003 17:37:31 -0500
Date: 6 Mar 2003 22:46:08 -0000
Message-ID: <20030306224608.29991.qmail@webmail17.rediffmail.com>
MIME-Version: 1.0
From: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
Reply-To: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
To: linux-kernel@vger.kernel.org
Cc: svijayar@cisco.com, narendiran_srinivasan@satyam.com
Subject: fd_install question ??
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We modified the existing /usr/src/linux/fs/pipe.c such that we 
need more than 2 file descriptors where one of the descriptors 
will be writer and others should be readers.

However while doing an fd_install on the third descriptor we 
encounter an "OOPS" .

The peculair thing is we are able to successfully read using the 
third descriptor , while our program exits we encounter the 
"OOPS".

We modified the code as follows :

I have highlighted modifications using arrows ( --> ):
------------------------------------------------------

We made fd[0] as write end and fd[1],fd[2] as read ends.
We also successfully received three file descriptors namely 3,4,5 
 from each of the three get_unused_fd() calls respectively.

As specified earlier we were able to successfully read using the 
third file descriptor.

Please spare time to go through the modifications we made in the 
code and help us to sort out this issue.

Thanks in advance,
Sudharsan.

++++++++++++++++++++++++++++++++++++++++++++++++++++++

     int do_pipe(int *fd)
  {
          struct qstr this;

          char name[32];

          struct dentry *dentry;

          struct inode * inode;

          //struct file *f1, *f2;
-->        struct file *f1, *f2, *f3;

          int error;

          //int i,j;
-->        int i,j,k;

          error = -ENFILE;

          f1 = get_empty_filp();
          if (!f1)
                  goto no_files;

          f2 = get_empty_filp();
          if (!f2)
                  goto close_f1;

-->      if (!f3)
-->             goto close_f12

          inode = get_pipe_inode();

          if (!inode)
         //         goto close_f12;
-->                goto close_f123

          error = get_unused_fd();

          if (error < 0)
                  goto close_f12_inode;
          i = error;

          error = get_unused_fd();
          if (error < 0)
                  goto close_f12_inode_i;
          j = error;

-->      error = get_unused_fd();
-->      if (error < 0)
-->              goto close_f12_inode_i_j;
-->      k=error;

         error = -ENOMEM;

          sprintf(name, "[%lu]", inode->i_ino);
          this.name = name;
          this.len = strlen(name);
          this.hash = inode->i_ino; /* will go */

          dentry = d_alloc(pipe_mnt->mnt_sb->s_root, &this);

          if (!dentry)
          //        goto close_f12_inode_i_j;
-->                goto close_f12_inode_i_j_k;

          dentry->d_op = &pipefs_dentry_operations;

          d_add(dentry, inode);

         // f1->f_vfsmnt = f2->f_vfsmnt = 
mntget(mntget(pipe_mnt));
-->        f1->f_vfsmnt = f2->f_vfsmnt = f3->f_vfsmnt = 
mntget(mntget(pipe_mnt));
         // f1->f_dentry = f2->f_dentry = dget(dentry);
-->        f1->f_dentry = f2->f_dentry = f3->f_dentry = 
dget(dentry);
          /* read file */

          f1->f_pos = f2->f_pos = 0;
         // f1->f_flags = O_RDONLY;
-->        f1->f_flags = O_WRONLY;
          //f1->f_op = &read_pipe_fops;
-->        f1->f_op = &write_pipe_fops;
            f1->f_mode = 1;
            f1->f_version = 0;

          /* write file */
         // f2->f_flags = O_WRONLY;
-->        f2->f_flags = O_RDONLY;
         // f2->f_op = &write_pipe_fops;
-->        f2->f_op = &read_pipe_fops;
            f2->f_mode = 2;
            f2->f_version = 0;

-->        f3->f_flags = O_RDONLY;
-->        f3->f_op = &read_pipe_fops;
            f3->f_mode = 2;
            f3->f_version = 0;

          fd_install(i, f1);
          fd_install(j, f2);
-->      fd_install(k, f3);

          fd[0] = i;
          fd[1] = j;
-->      fd[2] = k;

          return 0;

-->  close_f12_inode_i_j_k :
-->       put_unused_fd(k);

      close_f12_inode_i_j:
          put_unused_fd(j);

      close_f12_inode_i:
          put_unused_fd(i);

      close_f12_inode:
          free_page((unsigned long) PIPE_BASE(*inode));
          kfree(inode->i_pipe);
          inode->i_pipe = NULL;
          iput(inode);

-->   close_f123:
-->         put_filp(f3);

  close_f12:
          put_filp(f2);

  close_f1:
          put_filp(f1);

  no_files:
          return error;
  }

++++++++++++++++++++++++++++++++++++++++++++++++

