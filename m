Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSBUWkC>; Thu, 21 Feb 2002 17:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbSBUWjz>; Thu, 21 Feb 2002 17:39:55 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:20613 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286161AbSBUWjl>; Thu, 21 Feb 2002 17:39:41 -0500
Subject: Large Amount of Kernel Memory on 2.4.16 Consumed by Kiobufs
To: linux-kernel@vger.kernel.org
Cc: "Badari Pulavarty" <badari@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF4A92A5AE.4F21EAEC-ON85256B67.00793208@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Thu, 21 Feb 2002 16:39:37 -0600
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/21/2002 05:39:39 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a system hang while running a complex database query on a
2.4.16 4GB kernel using raw I/O. Bill Hartner and I examined
/proc/meminfo, and saw the LowFree value gradually going down to 2MB.
And the system did not have much response from that point on. By examining
/proc/slabinfo, it was apparent that the number of buffer heads allocated
was significant.

Since we did not experience this memory problem on 2.4.6, I built two
kernels, namely 2.4.6-Test and 2.4.16-Test, for comparison purposes.
Both kernels had Ingo Molnar's scalable timer patch.

Meminfo and slabinfo provided the following data for the first three
queries of a database workload:

                    2.4.6-Test           |        2.4.16-Test
                                         |
               LowFree    buffer_head    |    LowFree   buffer_head
                  (KB)  (total count)    |       (KB) (total_count)
                                         |
Start          247,688         20,084    |   288,640         20,720
After Query 1  214,680        118,760    |   124,644      1,414,880
After Query 2  208,080        147,880    |    55,680      2,078,120
After Query 3  184,984        147,880    |   Too Low


The annotated call graph gave a similar picture and pointed to the
routines that triggered the allocation of buffer heads.

2.4.6-Test:

   dentry_open               1045
     chrdev_open               1045
       raw_open                  1042
         alloc_kiovec              46
            alloc_kiobuf_bhs         46
              kmem_cache_alloc         47,104 for buffer heads

2.4.16-Test:

   dentry_open               1310
     chrdev_open               1306
       raw_open                  1306
         alloc_kiovec              1306
           alloc_kiobuf_bhs          1306
             kmem_cache_alloc          1,337,344 for buffer heads

I then studied a number of files and data structures on 2.4.16,
namely, /include/linux/fs.h, /fs/file_table.c, /fs/open.c,
and /drivers/char/raw.c, and came to the following understanding.
(Some annotations on these files are given at the end of the note.)

     Based upon this set of files, we can see that for each dentry open,
a file object is assigned. For each raw open, a kiobuf is created,
which in turn creates buffer heads. Whenever a file object is returned
to the free list, its kiobuf memory should be released by free_kiovec
in fput (file_table.c). This heavy consumption of kernel memory was not
due to memory leak, it had to do with attaching a kiobuf with each file
object. On the other hand, on 2.4.6, a kiobuf object is only associated
with a device, not every file. In database applications, having a large
number of file objects is pretty common due to the use of many I/O
prefetching agents, many logical drives and many tables.

     Based upon the analysis, solutions had been proposed. I evaluated
two proposals. The first one was basically used to prove the concept.

  (1) Proposed by Badari Pulavarty and Bill Hartner:
      Reduce KIO_MAX_ATOMIC_IO from 512 to 256, which cut down
      the number of buffer heads by one half. Let's call it
      2.4.16-BH1.

  (2) Proposed by Badari Pulavarty:
      Combined with his earlier patch to allocate one buffer head
      per 4KB page, it can significantly reduce the allocation
      of buffer heads. Let's call it 2.4.16-BH2.

After a long sequence of complex queries, I have the following
observations:

                   2.4.6-Best     2.4.16-BH1    2.4.16-BH2

LowFree (MB)             ~170             ~8          ~250

Number of            ~163,000     ~1,485,000      ~385,000
buffer_head
allocated

And they achieved similar level of performance.

     I think Badari has a good start on this problem.

Regards,
Peter

------------------------------------------------------------------------
Some annotations (<<***) on the files:

In /include/linux/fs.h:

struct file {
        struct list_head        f_list;
        struct dentry           *f_dentry;
        struct vfsmount         *f_vfsmnt;
        struct file_operations  *f_op;
        atomic_t                f_count;
        unsigned int            f_flags;
        mode_t                  f_mode;
        loff_t                  f_pos;
        unsigned long           f_reada, f_ramax, f_raend,
                                f_ralen, f_rawin;
        struct fown_struct      f_owner;
        unsigned int            f_uid, f_gid;
        int                     f_error;

        unsigned long           f_version;

        /* needed for tty driver, and maybe others */
        void                    *private_data;

        /* preallocated helper kiobuf to speedup O_DIRECT */
        struct kiobuf           *f_iobuf;
                                       <<*** new field
        long                    f_iobuf_lock;
                                       <<*** new field
};

In /fs/file_table.c:

struct file * get_empty_filp(void)
{
        static int old_max = 0;
        struct file * f;

        file_list_lock();
        if (files_stat.nr_free_files > NR_RESERVED_FILES) {

         <<*** files_stat.nr_free_files indicates the number of
               "file" objects on the free list, where NR_RESERVED_FILES
               is set to 10. If the number of file objects on the free
               list is fewer than NR_RESERVED_FILES, the system creates
               new file objects. Indeed, it consumes kernel memory. It
               consumes even more when kiobuf is also allocated.

        used_one:
                f = list_entry(free_list.next, struct file, f_list);
                list_del(&f->f_list);
                files_stat.nr_free_files--;
        new_one:
                memset(f, 0, sizeof(*f));

                  <<*** f_iobuf is set to null.

                atomic_set(&f->f_count,1);
                f->f_version = ++event;
                f->f_uid = current->fsuid;
                f->f_gid = current->fsgid;
                list_add(&f->f_list, &anon_list);
                file_list_unlock();
                return f;
        }
        /*
         * Use a reserved one if we're the superuser
         */
        if (files_stat.nr_free_files && !current->euid)
                goto used_one;
        /*
         * Allocate a new one if we're below the limit.
         */
        if (files_stat.nr_files < files_stat.max_files) {
                file_list_unlock();
                f = kmem_cache_alloc(filp_cachep, SLAB_KERNEL);
                file_list_lock();
                if (f) {
                        files_stat.nr_files++;

                           <<*** Create a new file object.

                        goto new_one;
                }
        . . .
}

In /fs/open.c:

struct file *dentry_open(struct dentry *dentry,
                         struct vfsmount *mnt, int flags)
{
        struct file * f;
        struct inode *inode;
        static LIST_HEAD(kill_list);
        int error;

        . . .
        f = get_empty_filp();   <<*** Get the file object.
        . . .

        f->f_dentry = dentry;
        f->f_vfsmnt = mnt;
        f->f_pos = 0;
        f->f_reada = 0;
        f->f_op = fops_get(inode->i_fop);
        file_move(f, &inode->i_sb->s_files);

        /* preallocate kiobuf for O_DIRECT */
        f->f_iobuf = NULL;
          <<*** Set f_iobuf to NULL.

        if (f->f_op && f->f_op->open) {
                error = f->f_op->open(inode,f); <<*** Call raw_open.
                if (error)
                        goto cleanup_all;
        }
        . . .
}

In /drivers/char/raw.c:

int raw_open(struct inode *inode, struct file *filp)
{
        int minor;
        struct block_device * bdev;

        . . .
        if (!filp->f_iobuf) {   <<*** It must be true.
                err = alloc_kiovec(1, &filp->f_iobuf);
                         <<*** Allocate kiobuf here.

                if (err)
                        return err;
        }
        . . .
}

In /fs/file_table.c:

void fput(struct file * file)
{
        struct dentry * dentry = file->f_dentry;
        struct vfsmount * mnt = file->f_vfsmnt;
        struct inode * inode = dentry->d_inode;



        if (atomic_dec_and_test(&file->f_count)) {

            <<*** If f_count is 1, it is decremented to 0 and the
                  object is returned to the free list.

                locks_remove_flock(file);

                if (file->f_iobuf)
                        free_kiovec(1, &file->f_iobuf);
                          <<*** This should free up the
                                memory of kiobuf.

                if (file->f_op && file->f_op->release)
                        file->f_op->release(inode, file);
                fops_put(file->f_op);
                if (file->f_mode & FMODE_WRITE)
                        put_write_access(inode);
                file_list_lock();
                file->f_dentry = NULL;
                file->f_vfsmnt = NULL;
                list_del(&file->f_list);
                list_add(&file->f_list, &free_list);
                files_stat.nr_free_files++;

                  <<*** Add the file object back to the free list.

                file_list_unlock();
                dput(dentry);
                mntput(mnt);
        }
}

Wai Yee Peter Wong
IBM Linux Technology and Solutions Center, Performance Analysis
email: wpeter@us.ibm.com

