Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSJTTIj>; Sun, 20 Oct 2002 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSJTTIj>; Sun, 20 Oct 2002 15:08:39 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:48282 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264620AbSJTTIh>; Sun, 20 Oct 2002 15:08:37 -0400
Message-ID: <001301c2786e$1303b160$eef13ccc@kamalnara317>
From: "Murali Therthala" <MuraliT@prodigy.net>
To: <linux-kernel@vger.kernel.org>
Subject: Compilation Error with a Dynamic Module
Date: Sun, 20 Oct 2002 15:22:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am trying to compile a dynamic module shown below that creates a readable
procs entry.
I invoke gcc as follows.

gcc -Wall -o2 -DMODULE -D_KERNEL_ -DLINUX -I
/lib/modules/`uname -r`\build/modules -c fMod3.c

and I get a whole bunch of errors with procfs.h.

/lib/modules/2.4.18-4GB/build/include/linux/proc_fs.h:47: parse error before
`off_t'
/lib/modules/2.4.18-4GB/build/include/linux/proc_fs.h:50: warning: `struct
file' declared inside parameter list
............................................................................
............................................................
............................................................................
............................................................

Could any of you offer me any hints to resolve this problem? I am using SUSE
with Kernel 2.4.18-4GB.
Thanks in advance for any feedback. Please see the source below.

Murali
----------------------------------------------------------------------------
---------------------------------

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <linux/sched.h>
#include <asm/uaccess.h>
#define MODULE_VERSION "1.0"
#define MODULE_NAME "My_procfs_example"
#define FOOBAR_LEN 8

struct fb_data_t
{
        char name[FOOBAR_LEN + 1];
        char value[FOOBAR_LEN + 1];
};

static struct proc_dir_entry  *example_dir,*foo_file;
struct fb_data_t   foo_data;

static int proc_read_foo(char *page,char **start,off_t off,int count,int
*eof,void *data)
{
        int len;
        struct fb_data_t *fb_data = (struct fb_data_t *)data;
        MOD_INC_USE_COUNT;
        len = sprintf(page, "%s = '%s'\n",fb_data->name, fb_data->value);
        MOD_DEC_USE_COUNT;
        return len;
}

static int __init init_procfs_example(void)
{
        int rv = 0;
        /* create directory */
        example_dir = proc_mkdir(MODULE_NAME, NULL);
        if(example_dir == NULL)
         {
                rv = -ENOMEM;
                goto out;
        }

        example_dir->owner = THIS_MODULE;

        foo_file = create_proc_entry("foo", 0644, example_dir);
        if(foo_file == NULL)
        {
                rv = -ENOMEM;
                goto no_foo;
        }
        strcpy(foo_data.name, "foo");
        strcpy(foo_data.value, "foo");
        foo_file->data = &foo_data;
        foo_file->read_proc = proc_read_foo;
        foo_file->write_proc = NULL;
        foo_file->owner = THIS_MODULE;

        printk(KERN_INFO "%s %s initialised\n",MODULE_NAME, MODULE_VERSION);
        return 0;

no_foo:
        remove_proc_entry("jiffies", example_dir);
out:
        return rv;
}

static void __exit cleanup_procfs_example(void)
{
        remove_proc_entry("foo", example_dir);
        remove_proc_entry(MODULE_NAME, NULL);
        printk(KERN_INFO "%s %s removed\n",MODULE_NAME, MODULE_VERSION);
}

module_init(init_procfs_example);
module_exit(cleanup_procfs_example);

MODULE_AUTHOR("XYZ");
MODULE_DESCRIPTION("A procfs example");

EXPORT_NO_SYMBOLS;

