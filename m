Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTLKXHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLKXHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:07:04 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:37278 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264401AbTLKXGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:06:34 -0500
Date: Thu, 11 Dec 2003 17:05:37 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: jh@sgi.com
Subject: kernel-2.4 delays during core dumping.
Message-ID: <20031211230537.GA21381@lnx-holt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the 2.4 kernel, large core dumps tie up some /proc/<pid> read
handlers for extended periods of time.  I have looked at the code and
see it is caused the core dump handler holding a down_write copy of
mm->mmap_sem.  This makes sense.  I also know that a rewrite for 2.4 is
unreasonable and have verified by both inspection and empirically that
the problem does not exist in 2.6.

That said, the problem does still exist in 2.4.  I have coded up a work
around for 2.4.  I will attach for illustration a diff that stands little
chance of applying cleanly against the bitkeeper source.  The gist of
the patch is have the core dump code predetermine the information that
will be needed later by the proc read handlers.  When the proc read
handler runs, if it cannot acquire the semaphore, it checks an new flag
in the mm and uses the other information instead if the flag indicates
the information is available.

I realize that some information will be a snapshot in time which is
no longer 100% correct.  That seems to be less of a concern to the
interested parties than not having their system appear to be locked up
for extremely long periods of time.

Am I on the right track with this?  I don't know if this is of interest
to others.  If so, please let me know.

Thanks,
Robin Holt

[holt@attica work]$ p_rdiff -u `p_list`

===========================================================================
linux/linux/fs/binfmt_elf.c
===========================================================================

--- /usr/tmp/TmpDir.24518-0/linux/linux/fs/binfmt_elf.c_1.42    Thu Dec 11 16:59:53 2003
+++ linux/linux/fs/binfmt_elf.c Thu Dec 11 16:59:40 2003
@@ -15,6 +15,7 @@
 #include <linux/stat.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/a.out.h>
 #include <linux/errno.h>
@@ -1082,8 +1083,106 @@
                *(struct pt_regs *)&prstatus.pr_reg = *regs;
 #endif
 
+       /* Temporary kludge to prevent core dumps from tying up /proc */
+       {
+               struct mm_struct *mm = current->mm;
+               char *cmdline, *environ;
+
+               cmdline = kmalloc(PAGE_SIZE,GFP_KERNEL);
+               environ = kmalloc(PAGE_SIZE,GFP_KERNEL);
+
+               if (cmdline != NULL) {
+                       int res = 0;
+                       int len = mm->arg_end - mm->arg_start;
+                       if (len > PAGE_SIZE)
+                               len = PAGE_SIZE;
+                       res = access_process_vm(current, mm->arg_start, cmdline, len, 0);
+                       // If the nul at the end of args has been overwritten, then
+                       // assume application is using setproctitle(3).
+                       if ( res > 0 && cmdline[res-1] != '\0' )
+                       {
+                               len = strnlen( cmdline, res );
+                               if ( len < res )
+                               {
+                                   res = len;
+                               }
+                               else
+                               {
+                                       len = mm->env_end - mm->env_start;
+                                       if (len > PAGE_SIZE - res)
+                                               len = PAGE_SIZE - res;
+                                       res += access_process_vm(current, mm->env_start,
+                                                       cmdline+res, len, 0);
+                               }
+                       }
+               }
+
+               if (environ != NULL) {
+                       int len = mm->env_end - mm->env_start;
+                       if (len > PAGE_SIZE)
+                               len = PAGE_SIZE;
+                       (void) access_process_vm(current, mm->env_start, environ, len, 0);
+               }
+               spin_lock(&mm->environ_lock);
+               mm->cmdline = cmdline;
+               mm->environ = environ;
+               spin_unlock(&mm->environ_lock);
+       }
+
        /* now stop all vm operations */
        down_write(&current->mm->mmap_sem);
+
+       { /* Temporary kludge to prevent core dumps from tying up /proc */
+               struct vm_area_struct *vma;
+               unsigned long area_size;
+               struct mm_struct *mm = current->mm;
+
+               mm->vsize = 0;
+
+               mm->resident = mm->rss;
+               mm->share = mm->trs = mm->drs = 0;
+               mm->data = mm->stack = mm->exec = mm->lib = 0;
+
+               vma = mm->mmap;
+               while (vma) {
+                       area_size = vma->vm_end - vma->vm_start;
+
+                       mm->vsize += area_size;
+
+                       if (!vma->vm_file) {
+                               mm->data += area_size;
+                               if (vma->vm_flags & VM_GROWSDOWN)
+                                       mm->stack += area_size;
+                       } else if (!vma->vm_flags & VM_WRITE) {
+                               if (vma->vm_flags & VM_EXEC) {
+                                       mm->exec += area_size;
+                                       if (!vma->vm_flags & VM_EXECUTABLE)
+                                               mm->lib += area_size;
+                               }
+                       }
+                       if (is_vm_hugetlb_page(vma)) {
+                               if (!(vma->vm_flags & VM_DONTCOPY))
+                                       mm->share += area_size;
+                               continue;
+                       }
+                       if (vma->vm_flags & VM_SHARED || vma->vm_next_share)
+                               mm->share += area_size;
+                       if (vma->vm_flags & VM_EXECUTABLE) {
+                               mm->trs += area_size;   /* text */
+                               if ((mm->exe_mnt == NULL) && (vma->vm_file)) {
+                                       mm->exe_mnt = mntget(vma->vm_file->f_vfsmnt);
+                                       mm->exe_dentry = dget(vma->vm_file->f_dentry);
+                               }
+                       } else
+                               mm->drs += area_size;
+
+                       vma = vma->vm_next;
+               }
+               mm->eip = KSTK_EIP(current);
+               mm->esp = KSTK_ESP(current);
+               atomic_inc(&mm->vsize_valid);
+       } /* end kludge */
+
        segs = current->mm->map_count;
 
 #ifdef DEBUG
@@ -1279,6 +1378,18 @@
 
  end_coredump:
        set_fs(fs);
+       spin_lock(&current->mm->environ_lock);
+       if (current->mm->cmdline != NULL) {
+               kfree(current->mm->cmdline);
+               current->mm->cmdline = NULL;
+       }
+       if (current->mm->environ != NULL) {
+               kfree(current->mm->environ);
+               current->mm->environ = NULL;
+       }
+       spin_unlock(&current->mm->environ_lock);
+       atomic_dec(&current->mm->vsize_valid);
+       current->mm->exe_mnt = NULL;
        up_write(&current->mm->mmap_sem);
        return has_dumped;
 }

===========================================================================
linux/linux/fs/proc/array.c
===========================================================================

--- /usr/tmp/TmpDir.24518-0/linux/linux/fs/proc/array.c_1.38    Thu Dec 11 16:59:53 2003
+++ linux/linux/fs/proc/array.c Thu Dec 11 16:08:19 2003
@@ -183,24 +183,35 @@
        struct vm_area_struct * vma;
        unsigned long data = 0, stack = 0;
        unsigned long exec = 0, lib = 0;
+       int got_lock;
 
-       down_read(&mm->mmap_sem);
-       for (vma = mm->mmap; vma; vma = vma->vm_next) {
-               unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
-               if (!vma->vm_file) {
-                       data += len;
-                       if (vma->vm_flags & VM_GROWSDOWN)
-                               stack += len;
-                       continue;
-               }
-               if (vma->vm_flags & VM_WRITE)
-                       continue;
-               if (vma->vm_flags & VM_EXEC) {
-                       exec += len;
-                       if (vma->vm_flags & VM_EXECUTABLE)
+       while (((got_lock = down_read_trylock(&mm->mmap_sem)) == 0) &&
+               (atomic_read(&mm->vsize_valid) == 0)) {
+       };
+       if (got_lock != 0) {
+               for (vma = mm->mmap; vma; vma = vma->vm_next) {
+                       unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
+                       if (!vma->vm_file) {
+                               data += len;
+                               if (vma->vm_flags & VM_GROWSDOWN)
+                                       stack += len;
+                               continue;
+                       }
+                       if (vma->vm_flags & VM_WRITE)
                                continue;
-                       lib += len;
+                       if (vma->vm_flags & VM_EXEC) {
+                               exec += len;
+                               if (vma->vm_flags & VM_EXECUTABLE)
+                                       continue;
+                               lib += len;
+                       }
                }
+               up_read(&mm->mmap_sem);
+       } else {
+               data = mm->vsize >> 10;
+               stack = mm->stack >> 10;
+               exec = mm->exec >> 10;
+               lib = mm->lib >> 10;
        }
        buffer += sprintf(buffer,
                "VmSize:\t%8lu kB\n"
@@ -215,7 +226,6 @@
                mm->rss << (PAGE_SHIFT-10),
                data - stack, stack,
                exec - lib, lib);
-       up_read(&mm->mmap_sem);
        return buffer;
 }
 
@@ -309,6 +319,7 @@
        int res;
        pid_t ppid;
        struct mm_struct *mm;
+       int got_lock;
 
        state = *get_task_state(task);
        vsize = eip = esp = 0;
@@ -323,15 +334,23 @@
        task_unlock(task);
        if (mm) {
                struct vm_area_struct *vma;
-               down_read(&mm->mmap_sem);
-               vma = mm->mmap;
-               while (vma) {
-                       vsize += vma->vm_end - vma->vm_start;
-                       vma = vma->vm_next;
+               while (((got_lock = down_read_trylock(&mm->mmap_sem)) == 0) &&
+                       (atomic_read(&mm->vsize_valid) == 0)) {
+               };
+               if (got_lock != 0) {
+                       vma = mm->mmap;
+                       while (vma) {
+                               vsize += vma->vm_end - vma->vm_start;
+                               vma = vma->vm_next;
+                       }
+                       eip = KSTK_EIP(task);
+                       esp = KSTK_ESP(task);
+                       up_read(&mm->mmap_sem);
+               } else {
+                       vsize = mm->vsize;
+                       eip = mm->eip;
+                       esp = mm->esp;
                }
-               eip = KSTK_EIP(task);
-               esp = KSTK_ESP(task);
-               up_read(&mm->mmap_sem);
        }
 
        wchan = get_wchan(task);
@@ -409,27 +428,38 @@
        task_unlock(task);
        if (mm) {
                struct vm_area_struct * vma;
+               int got_lock;
 
-               down_read(&mm->mmap_sem);
-               resident = mm->rss;
-
-               for (vma = mm->mmap; vma; vma = vma->vm_next) {
-                       int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-
-                       size += pages;
-                       if (is_vm_hugetlb_page(vma)) {
-                               if (!(vma->vm_flags & VM_DONTCOPY))
+               while (((got_lock = down_read_trylock(&mm->mmap_sem)) == 0) &&
+                       (atomic_read(&mm->vsize_valid) == 0)) {
+               };
+               if (got_lock != 0) {
+                       resident = mm->rss;
+
+                       for (vma = mm->mmap; vma; vma = vma->vm_next) {
+                               int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+                               size += pages;
+                               if (is_vm_hugetlb_page(vma)) {
+                                       if (!(vma->vm_flags & VM_DONTCOPY))
+                                               share += pages;
+                                       continue;
+                               }
+                               if (vma->vm_flags & VM_SHARED || vma->vm_next_share)
                                        share += pages;
-                               continue;
+                               if (vma->vm_flags & VM_EXECUTABLE)
+                                       trs += pages;   /* text */
+                               else
+                                       drs += pages;
                        }
-                       if (vma->vm_flags & VM_SHARED || vma->vm_next_share)
-                               share += pages;
-                       if (vma->vm_flags & VM_EXECUTABLE)
-                               trs += pages;   /* text */
-                       else
-                               drs += pages;
+                       up_read(&mm->mmap_sem);
+               } else {
+                       resident = mm->resident;
+                       size = mm->vsize >> 16;
+                       share = mm->share >> 16;
+                       trs = mm->trs >> 16;
+                       drs = mm->drs >> 16;
                }
-               up_read(&mm->mmap_sem);
                mmput(mm);
        }
        return sprintf(buffer,"%d %d %d %d %d %d %d\n",

===========================================================================
linux/linux/fs/proc/base.c
===========================================================================

--- /usr/tmp/TmpDir.24518-0/linux/linux/fs/proc/base.c_1.32     Thu Dec 11 16:59:53 2003
+++ linux/linux/fs/proc/base.c  Thu Dec 11 16:08:19 2003
@@ -58,6 +58,7 @@
        struct vm_area_struct * vma;
        int result = -ENOENT;
        struct task_struct *task = inode->u.proc_i.task;
+       int got_lock;
 
        task_lock(task);
        mm = task->mm;
@@ -66,19 +67,29 @@
        task_unlock(task);
        if (!mm)
                goto out;
-       down_read(&mm->mmap_sem);
-       vma = mm->mmap;
-       while (vma) {
-               if ((vma->vm_flags & VM_EXECUTABLE) && 
-                   vma->vm_file) {
-                       *mnt = mntget(vma->vm_file->f_vfsmnt);
-                       *dentry = dget(vma->vm_file->f_dentry);
+       while (((got_lock = down_read_trylock(&mm->mmap_sem)) == 0) &&
+               (atomic_read(&mm->vsize_valid) == 0)) {
+       };
+       if (got_lock != 0) {
+               vma = mm->mmap;
+               while (vma) {
+                       if ((vma->vm_flags & VM_EXECUTABLE) && 
+                           vma->vm_file) {
+                               *mnt = mntget(vma->vm_file->f_vfsmnt);
+                               *dentry = dget(vma->vm_file->f_dentry);
+                               result = 0;
+                               break;
+                       }
+                       vma = vma->vm_next;
+               }
+               up_read(&mm->mmap_sem);
+       } else {
+               if (mm->exe_mnt != NULL) {
+                       *mnt = mm->exe_mnt;
+                       *dentry = mm->exe_dentry;
                        result = 0;
-                       break;
                }
-               vma = vma->vm_next;
        }
-       up_read(&mm->mmap_sem);
        mmput(mm);
 out:
        return result;
@@ -168,12 +179,20 @@
                atomic_inc(&mm->mm_users);
        task_unlock(task);
        if (mm) {
-               int len = mm->env_end - mm->env_start;
-               if (len > PAGE_SIZE)
-                       len = PAGE_SIZE;
-               res = access_process_vm(task, mm->env_start, buffer, len, 0);
-               if (!may_ptrace_attach(task))
-                       res = -ESRCH;
+               spin_lock(&mm->environ_lock);
+               if (mm->environ != NULL) {
+                       res = strnlen(mm->environ, PAGE_SIZE);
+                       memcpy(buffer, mm->environ, res);
+                       spin_unlock(&mm->environ_lock);
+               } else {
+                       int len = mm->env_end - mm->env_start;
+                       spin_unlock(&mm->environ_lock);
+                       if (len > PAGE_SIZE)
+                               len = PAGE_SIZE;
+                       res = access_process_vm(task, mm->env_start, buffer, len, 0);
+                       if (!may_ptrace_attach(task))
+                               res = -ESRCH;
+               }
                mmput(mm);
        }
        return res;
@@ -189,26 +208,34 @@
                atomic_inc(&mm->mm_users);
        task_unlock(task);
        if (mm) {
-               int len = mm->arg_end - mm->arg_start;
-               if (len > PAGE_SIZE)
-                       len = PAGE_SIZE;
-               res = access_process_vm(task, mm->arg_start, buffer, len, 0);
-               // If the nul at the end of args has been overwritten, then
-               // assume application is using setproctitle(3).
-               if ( res > 0 && buffer[res-1] != '\0' )
-               {
-                       len = strnlen( buffer, res );
-                       if ( len < res )
-                       {
-                           res = len;
-                       }
-                       else
+               spin_lock(&mm->environ_lock);
+               if (mm->cmdline != NULL) {
+                       res = strnlen(mm->cmdline, PAGE_SIZE);
+                       memcpy(buffer, mm->cmdline, res);
+                       spin_unlock(&mm->environ_lock);
+               } else {
+                       int len = mm->arg_end - mm->arg_start;
+                       spin_unlock(&mm->environ_lock);
+                       if (len > PAGE_SIZE)
+                               len = PAGE_SIZE;
+                       res = access_process_vm(task, mm->arg_start, buffer, len, 0);
+                       // If the nul at the end of args has been overwritten, then
+                       // assume application is using setproctitle(3).
+                       if ( res > 0 && buffer[res-1] != '\0' )
                        {
-                               len = mm->env_end - mm->env_start;
-                               if (len > PAGE_SIZE - res)
-                                       len = PAGE_SIZE - res;
-                               res += access_process_vm(task, mm->env_start, buffer+res, len, 0);
-                               res = strnlen( buffer, res );
+                               len = strnlen( buffer, res );
+                               if ( len < res )
+                               {
+                                   res = len;
+                               }
+                               else
+                               {
+                                       len = mm->env_end - mm->env_start;
+                                       if (len > PAGE_SIZE - res)
+                                               len = PAGE_SIZE - res;
+                                       res += access_process_vm(task, mm->env_start, buffer+res, len, 0);
+                                       res = strnlen( buffer, res );
+                               }
                        }
                }
                mmput(mm);

===========================================================================
linux/linux/include/linux/sched.h
===========================================================================

--- /usr/tmp/TmpDir.24518-0/linux/linux/include/linux/sched.h_1.79      Thu Dec 11 16:59:53 2003
+++ linux/linux/include/linux/sched.h   Wed Dec 10 09:39:32 2003
@@ -223,6 +223,15 @@
        atomic_t mm_count;                      /* How many references to "struct mm_struct" (users count as 1) */
        int map_count;                          /* number of VMAs */
        struct rw_semaphore mmap_sem;
+       atomic_t vsize_valid;                   /* following 5 are valid */
+        unsigned long vsize, eip, esp;
+       unsigned long resident, share, trs, drs;
+       unsigned long data, stack, exec, lib;
+       struct vfsmount *exe_mnt;
+       struct dentry *exe_dentry;
+       spinlock_t environ_lock;                /* protect environ and cmdline */
+       char *environ;
+       char *cmdline;
        spinlock_t page_table_lock;             /* Protects task page tables and mm->rss */
 
        struct list_head mmlist;                /* List of all active mm's.  These are globally strung
@@ -257,6 +266,11 @@
        mm_users:       ATOMIC_INIT(2),                 \
        mm_count:       ATOMIC_INIT(1),                 \
        mmap_sem:       __RWSEM_INITIALIZER(name.mmap_sem), \
+       vsize_valid:    ATOMIC_INIT(0),                 \
+       environ_lock:   SPIN_LOCK_UNLOCKED,             \
+       exe_mnt:        NULL,                           \
+       environ:        NULL,                           \
+       cmdline:        NULL,                           \
        page_table_lock: SPIN_LOCK_UNLOCKED,            \
        mmlist:         LIST_HEAD_INIT(name.mmlist),    \
 }

