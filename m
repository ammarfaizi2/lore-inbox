Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262941AbTCSHDe>; Wed, 19 Mar 2003 02:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262943AbTCSHDe>; Wed, 19 Mar 2003 02:03:34 -0500
Received: from [202.54.110.230] ([202.54.110.230]:45578 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id <S262941AbTCSHD0>; Wed, 19 Mar 2003 02:03:26 -0500
Message-ID: <E04CF3F88ACBD5119EFE00508BBB2121082D8201@exch-01.noida.hcltech.com>
From: "Hemanshu Kanji Bhadra, Noida" <hemanshub@noida.hcltech.com>
To: linux-kernel@vger.kernel.org
Subject: writting kernel modules on redhat 7.3 linux kernel 2.4.18-3
Date: Wed, 19 Mar 2003 12:37:08 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I want to write a simple kernel module, this is the following 2 files i used
when i try to compile 2nd file i get many errors in proc_fs.h 

any help will be appreciated,

thanks in advance.
- hemanshu



/*                                                     
 * $Id: hello.c,v 1.10 2001/07/17 10:30:02 rubini Exp $ 
 */                                                    
#define MODULE
#include <linux/module.h>

/*                                                        
 * These lines, although not shown in the book,           
 * are needed to make hello.c run properly even when      
 * your kernel has version support enabled                
 */                                                       
                                                          
int init_module(void)      { printk("<1>Hello, world\n"); return 0; }
void cleanup_module(void)  { printk("<1>Goodbye cruel world\n"); } 


however if i using the following code for writing /proc modules I get many
compile errors.

have a look at the code :-

/*
 * helloworld_proc_module v1.1 3/11/03
 * www.embeddedlinuxinterfacing.com
 *
 * The original location of this code is
 * http://www.embeddedlinuxinterfacing.com/chapters/07/
 * helloworld_proc_module.c
 *
 * Copyright (C) 2001 by Craig Hollabaugh
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Library General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/* v1.1 changed the variable name buffer to page in proc_write function, 
 * use of term buffer was confusing to students.
 */ 

/*
 * helloworld_proc_module.c is based on procfs_example.c by Erik Mouw.
 * For more information, please see The Linux Kernel Procfs Guide,
 * http://kernelnewbies.org/documents/kdoc/procfs-guide/lkprocfsguide.html
 */

/* helloworld_proc_module
 * helloworld_proc_module demonstrates the use of a /proc directory entry.
 * The init function, init_helloworld, creates /proc/helloworld and
 * populates its data, read_proc, write_proc and owner fields. The exit
 * function, cleanup_helloworld, removes the /proc/helloworld entry.
 * The proc_read function, proc_read_helloworld, is called whenever
 * a file read operation occurs on /proc/helloworld. The
 * proc_write function, proc_write_helloworld, is called whenever a file
 * file write operation occurs on /proc/helloworld.
 *
 * To demonstrate read and write operations, this module uses data
 * structure called helloworld_data containing a char field called value.
 * Read and write operations on /proc/helloworld manipulate
 * helloworld_data->value. The init function sets value = 'Default'.
 */


/*
gcc -O2 -D__KERNEL__ -DMODULE -I/usr/src/linux/include -c
helloworld_proc_module.c -o helloworld_proc_module.o

arm-linux-gcc -O2 -D__KERNEL__ -DMODULE -I/usr/src/arm-linux/include -c
helloworld_proc_module.c -o /tftpboot/arm-rootfs/helloworld_proc_module.o
*/


#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <asm/uaccess.h>

#define MODULE_VERSION "1.0"
#define MODULE_NAME "helloworld proc module"

/* this is how long our data->value char array can be */
#define HW_LEN 8

struct helloworld_data_t {
  char value[HW_LEN + 1];
};

static struct proc_dir_entry *helloworld_file;

struct helloworld_data_t helloworld_data;

/* proc_read - proc_read_helloworld
 * proc_read_helloworld is the callback function that the kernel calls when
 * there's a read file operation on the /proc file (for example,
 * cat /proc/helloworld). The file's data pointer (&helloworld_data) is
 * passed in the data parameter. You first cast it to the helloworld_data_t
 * structure. This proc_read function then uses the sprintf function to
 * create a string that is pointed to by the page pointer. The function then
 * returns the length of page. Because helloworld_data->value is set to
 * "Default", the command cat /proc/helloworld should return
 * helloworld Default
 */
static int proc_read_helloworld(char *page, char **start, off_t off,
                                int count, int *eof, void *data)
{
  int len;

/* cast the void pointer of data to helloworld_data_t*/
  struct helloworld_data_t *helloworld_data=(struct helloworld_data_t
*)data;

/* use sprintf to fill the page array with a string */
  len = sprintf(page, "helloworld %s\n", helloworld_data->value);

  return len;
}


/* proc_write - proc_write_helloworld
 * proc_write_helloworld is the callback function that the kernel calls 
 * when there's a write file operation on the /proc file, (for example,
 * echo test > /proc/helloworld). The file's data pointer
 * (&helloworld_data) is passed in the data parameter. You first cast it to
 * the helloworld_data_t structure. The page parameter points to the
 * incoming data. You use the copy_from_user function to copy the page 
 * contents to the data->value field. Before you do that, though, you check
 * the page length, which is stored in count to ensure that you don't
 * overrun the length of data->value. This function then returns the length
 * of the data copied.
 */
static int proc_write_helloworld(struct file *file, const char *page,
                                 unsigned long count, void *data)
{
  int len;

/* cast the void pointer of data to helloworld_data_t*/
  struct helloworld_data_t *helloworld_data=(struct helloworld_data_t
*)data;

/* do a range checking, don't overflow buffers in kernel modules */
  if(count > HW_LEN)
    len = HW_LEN;
  else
    len = count;

/* use the copy_from_user function to copy page data to
 * to our helloworld_data->value */
  if(copy_from_user(helloworld_data->value, page, len)) {
    return -EFAULT;
  }

/* zero terminate helloworld_data->value */
  helloworld_data->value[len] = '\0';

  return len;
}

/* init - init_helloworld
 * init_helloworld creates the /proc/helloworld entry file and obtains its
 * pointer called helloworld_file. The helloworld_file fields, data,
 * read_proc, write_proc and owner, are filled.  init_helloworld completes
 * by writing an entry to the system log using printk.
 */
static int __init init_helloworld(void)
{
  int rv = 0;

/* Create the proc entry and make it readable and writeable by all - 0666 */
  helloworld_file = create_proc_entry("helloworld", 0666, NULL);
  if(helloworld_file == NULL) {
    return -ENOMEM;
  }

/* set the default value of our data to Default. This way a read operation
on
 * /proc/helloworld will return something. */
  strcpy(helloworld_data.value, "Default");

/* Set helloworld_file fields */
  helloworld_file->data = &helloworld_data;
  helloworld_file->read_proc = &proc_read_helloworld;
  helloworld_file->write_proc = &proc_write_helloworld;
  helloworld_file->owner = THIS_MODULE;

/* everything initialized */
  printk(KERN_INFO "%s %s initialized\n",MODULE_NAME, MODULE_VERSION);
  return 0;
}

/* exit - cleanup_helloworld
 * cleanup_helloworld removes the /proc file entry helloworld and
 * prints a message to the system log.
 */
static void __exit cleanup_helloworld(void)
{
  remove_proc_entry("helloworld", NULL);

  printk(KERN_INFO "%s %s removed\n", MODULE_NAME, MODULE_VERSION);
}


/* here are the compiler macros for module operation */
module_init(init_helloworld);
module_exit(cleanup_helloworld);

MODULE_AUTHOR("Craig Hollabaugh");
MODULE_DESCRIPTION("helloworld proc module");
MODULE_LICENSE("GPL");

EXPORT_NO_SYMBOLS;

