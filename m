Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132700AbRDDOY1>; Wed, 4 Apr 2001 10:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132744AbRDDOYI>; Wed, 4 Apr 2001 10:24:08 -0400
Received: from mf1.lab.bredband.com ([195.54.122.119]:53647 "EHLO
	mf1.bredband.net") by vger.kernel.org with ESMTP id <S132734AbRDDOYB> convert rfc822-to-8bit;
	Wed, 4 Apr 2001 10:24:01 -0400
Message-Id: <5.0.2.1.0.20010404133937.00b59918@62.168.142.66>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 04 Apr 2001 15:21:49 +0200
To: linux-kernel@vger.kernel.org
From: Anders =?iso-8859-1?Q?Lind=E9n?= <anders.linden@perceptive.se>
Subject: gcc problem when compiling module?
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I had problems with compiling a piece of code with gcc.
It seems to produce asm output (for the gnu assembler) that it incorrect!

The reason that I post this in linux-kernel is that it _may_ be an error 
cause of a
header file in the linux-2.4.3 kernel. (I suspect asm/uaccess.h a lot).

The version of gcc I use:
gcc version 2.95.3 19991030 (prerelease)

The version of as (there is no gas on the system):
GNU assembler version 2.10.90 (i586-mandrake-linux) using BFD version 2.10.0.24

(I got the tools from the Mandrake 7.2 installation).

My kernel version:
2.4.3



When I am compiling it with make I get the following output:
gcc -c problem.c -D__KERNEL__ -DMODULE -DLINUX \
-I/usr/src/linux/include
/tmp/cc2zGHRK.s: Assembler messages:
/tmp/cc2zGHRK.s:147: Error: `%al' not allowed with `movl'
make: *** [all] Error 1


...which makes sence, al is an 8-bit register and cant be used with movl, or?


The problematic source code follows:


Makefile:
all:
         gcc -c problem.c -D__KERNEL__ -DMODULE -DLINUX \
         -I/usr/src/linux/include




problem.c:
#include <linux/kernel.h>
#include <linux/module.h>

#if CONFIG_MODVERSIONS==1
#define MODVERSIONS
#include <linux/modversions.h>
#endif

#include <linux/proc_fs.h>

#ifndef KERNEL_VERSION
#define KERNEL_VERSION(a,b,c) ((a)*65536+(b)*256+(c))
#endif

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
#include <asm/uaccess.h>
#endif

#define MESSAGE_LENGTH 80
static char Message[MESSAGE_LENGTH];

#define PROC_FILENAME "myuid"

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,0)
static int module_output(
     struct inode *inode, /* The inode read */
     struct file *file,   /* The file read */
     char *buf, /* The buffer to put data to (in the
                 * user segment) */
     int len)  /* The length of the buffer */
#else
static ssize_t module_output(
     struct file *file,   /* The file read */
     char *buf, /* The buffer to put data to (in the
                 * user segment) */
     size_t len,  /* The length of the buffer */
     loff_t *offset) /* Offset in the file - ignore */
#endif
{
   static int finished = 0;
   int i;
   char message[MESSAGE_LENGTH+30];

   if (finished)
   {
     finished = 0;
     return 0;
   }

   sprintf(message, "Last input:%s", Message);
   for(i=0; i<len && message[i]; i++)
     put_user(message[i], buf+i);

   finished = 1;

   return i;  /* Return the number of bytes "read" */
}

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
static ssize_t module_input(
     struct file *file,   /* The file itself */
     const char *buf,     /* The buffer with input */
     size_t length,       /* The buffer's length */
     loff_t *offset)      /* offset to file - ignore */
#else
static int module_input(
     struct inode *inode, /* The file's inode */
     struct file *file,   /* The file itself */
     const char *buf,     /* The buffer with the input */
     int length)          /* The buffer's length */
#endif
{
   int i;

   for(i=0; i<MESSAGE_LENGTH-1 && i<length; i++)
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
     get_user(Message[i], buf+i);
#else
     Message[i] = get_user(buf+i);
#endif
   Message[i] = '\0';  /* we want a standard, zero
                        * terminated string */

   return i;
}

static int module_permission(struct inode *inode, int op)
{
    /* Givetvis skall alla fa skriva till var fil! */
   if (op==4 || op==2)
     return 0;

   return -EACCES;
}

int module_open(struct inode *inode, struct file *file)
{
   MOD_INC_USE_COUNT;

   return 0;
}


#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
int module_close(struct inode *inode, struct file *file)
#else
void module_close(struct inode *inode, struct file *file)
#endif
{
   MOD_DEC_USE_COUNT;

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
   return 0;  /* success */
#endif
}

static struct file_operations File_Ops_4_Our_Proc_File =
{
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
   NULL,     /* struct module *owner; */
#endif
   NULL,  /* lseek/llseek */
   module_output,  /* "read" from the file */
   module_input,   /* "write" to the file */
   NULL,  /* readdir */
   NULL,  /* select/poll */
   NULL,  /* ioctl */
   NULL,  /* mmap */
   module_open,    /* Somebody opened the file */
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
   NULL,   /* flush, added here in version 2.2 */
#endif
   module_close,    /* Somebody closed the file */
   /* Some more will follow */
};

static struct inode_operations Inode_Ops_4_Our_Proc_File =
{
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
   &File_Ops_4_Our_Proc_File,
#endif
   NULL, /* create */
   NULL, /* lookup */
   NULL, /* link */
   NULL, /* unlink */
   NULL, /* symlink */
   NULL, /* mkdir */
   NULL, /* rmdir */
   NULL, /* mknod */
   NULL, /* rename */
   NULL, /* readlink */
   NULL, /* follow_link */
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
   NULL, /* readpage */
   NULL, /* writepage */
   NULL, /* bmap */
#endif
   NULL, /* truncate */
   module_permission /* check for permissions */
};

/* Directory entry */
static struct proc_dir_entry Our_Proc_File =
{
   0, /* Inode number - ignore, it will be filled by
       * proc_register[_dynamic] */
   sizeof(PROC_FILENAME)-1, /* Length of the file name */
   PROC_FILENAME, /* The file name */
   S_IFREG | S_IRUGO | S_IWUSR,
   /* File mode - this is a regular file which
    * can be read by its owner, its group, and everybody
    * else. Also, its owner can write to it.
    *
    * Actually, this field is just for reference, it's
    * module_permission that does the actual check. It
    * could use this field, but in our implementation it
    * doesn't, for simplicity. */
   1,  /* Number of links (directories where the
        * file is referenced) */
   0, 0,  /* The uid and gid for the file -
           * we give it to root */
   80, /* The size of the file reported by ls. */
   &Inode_Ops_4_Our_Proc_File,
   /* A pointer to the inode structure for
    * the file, if we need it. In our case we
    * do, because we need a write function. */
   NULL
   /* The read function for the file. Irrelevant,
    * because we put it in the inode structure above */
};

/* Initialize the module - register the proc file */
int init_module()
{
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,0)
   return proc_register_dynamic(&proc_root, &Our_Proc_File);
#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
   return proc_register(&proc_root, &Our_Proc_File);
#else
   struct proc_dir_entry *dirent;
   dirent=create_proc_entry(PROC_FILENAME,S_IFREG|S_IRUGO,&proc_root);
   if (dirent==NULL)
     return 1;
   memset((void *)dirent,0,sizeof(dirent));
   dirent->proc_iops=&Inode_Ops_4_Our_Proc_File;
   dirent->proc_fops=&File_Ops_4_Our_Proc_File;
   dirent->data=NULL;
   return 0;
#endif
}

/* Cleanup - unregister our file from /proc */
void cleanup_module()
{
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
   proc_unregister(&proc_root,Our_Proc_File.low_ino);
#else
   remove_proc_entry(PROC_FILENAME,&proc_root);
#endif
}





Maybe you recognize parts of the code from the linux kernel module 
programming guide. It is yet not completed, I was stuck in this error 
before I had finished it.
When I tried to only preprocess the code (to see if the error came from a 
header files inline asm) by using the -E switch to gcc I did not find 
anything special.

When I tried to do everything except assembling and linking (with the -S 
switch to gcc) I got a file problem.s which I inspected.

That file did contain a line like this (line 147):
movl %al,(%edx)

I am not sure this is correct assembly, but I have to admit that I am not 
yet very experienced on asm. Does this line really make sence? How do I 
move a long into al that is a 8-bit register?

I have only tried this version of gcc so far.

Best regards

/Anders Lindén

