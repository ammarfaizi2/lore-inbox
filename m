Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032316AbWLGPvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032316AbWLGPvC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937997AbWLGPvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:51:01 -0500
Received: from mail.exanet.com ([212.143.73.109]:60004 "EHLO mr.exanet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937986AbWLGPvA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:51:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 8BIT
Subject: Simple OOM kill protection interface
Date: Thu, 7 Dec 2006 17:50:55 +0200
Message-ID: <A6FDE6B975803043804A49F12F49028E0F5588@hawk.exanet-il.co.il>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Simple OOM kill protection interface
Thread-Index: AccaF3tQn+qkaVsvTJGZOc6YQxao/A==
From: "Menny Hamburger" <menny@exanet.com>
To: "Linux kernel (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following is a rather simple module implementation that adds an interface for protecting against the oom_killer by setting the oomkilladj in the task struct.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/capability.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <linux/swap.h>
#include <linux/sysrq.h>
#include <asm/uaccess.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/jiffies.h>
#include <linux/slab.h>
#include <linux/errno.h>
#include <linux/fs.h>
#include <linux/file.h>
#include <linux/ioctl.h>
#include <linux/sched.h>

#define OOM_KILL_CTL_VERSION    "1.0"
#define OOM_KILL_CTL_DESC       "OOM kill protection interface"

static struct proc_dir_entry *proc_oom_kill = NULL;
static struct proc_dir_entry *proc_oom_kill_ctl = NULL;
static struct proc_dir_entry *proc_oom_kill_usage = NULL;
static struct proc_dir_entry *proc_oom_kill_status = NULL;

static int get_task_oom_protection(struct task_struct *p)
{
	return (p->oomkilladj == OOM_DISABLE);
}

/*
 * Protecting a process does not protect all existing children - only future children 
 */
static void update_process_oom_protection(struct task_struct *tsk, int protect)
{
	struct mm_struct *mm = NULL;

            mm = tsk->mm;
            if (!mm) {
                return;
            }

	if (protect)
	    tsk->oomkilladj = OOM_DISABLE;
	else
	    tsk->oomkilladj = 0;
}

static int set_oom_protection_state(int pid, int protect)
{
	struct task_struct *p;
	int rc = 1;

	read_lock(&tasklist_lock);
	p = find_task_by_pid(pid);
	if (p) {
		update_process_oom_protection(p, protect);
		rc = 0;
	}

	read_unlock(&tasklist_lock);

	return rc;
}

static int set_task_oom_protection(struct task_struct *p, int protect)
{
	read_lock(&tasklist_lock);
	update_process_oom_protection(p, protect);
	read_unlock(&tasklist_lock);

	return 0;
}

void unprotect_all(void)
{
	struct task_struct *p, *g;

	read_lock(&tasklist_lock);
	do_each_thread(g, p) {
		update_process_oom_protection(p, 0);
	} while_each_thread(g, p);
	read_unlock(&tasklist_lock);
}

int print_protected(char *buffer, int len)
{
	struct task_struct *g, *p;
	int pos = 0, protected;

	pos = snprintf(buffer, len,
				   "%-10s %-16s\n"
				   "%-10s %-16s\n",
				   "PID", "NAME",
				   "---", "----");

	read_lock(&tasklist_lock);

	do_each_thread(g, p)
		if (p->pid) {
			protected = get_task_oom_protection(p);
			if (protected) {
				pos += snprintf(buffer + pos, len - pos, "%-10d %-16s\n",
							   p->pid,
							   p->comm);
			}
		}
	while_each_thread(g, p);

	read_unlock(&tasklist_lock);

	return pos;
	
}

static int oom_kill_ctl(struct file * file, const char * buf,
						      unsigned long length, void *data)
{
	int pid, err, protect;
	char *buffer, *p;

	if (!buf || length > PAGE_SIZE)
		return -EINVAL;

	buffer = (char *)__get_free_page(GFP_KERNEL);
	if (!buffer)
		return -ENOMEM;

	err = -EFAULT;
	if (copy_from_user(buffer, buf, length))
		goto out;

	err = -EINVAL;
	if (length < PAGE_SIZE)
		buffer[length] = '\0';
	else if (buffer[PAGE_SIZE-1])
		goto out;

	if (!strncmp("setprotection", buffer, 13)) {
		p = buffer + 14;
		pid = simple_strtoul(p, &p, 0);
		if (!pid) {
			printk (KERN_WARNING "OOMKill: no pid was supplied\n");
		} else {
			protect = simple_strtoul(p + 1, &p, 0);
			set_oom_protection_state(pid, protect);
		}	
		err = length;
	}

out:
	free_page((unsigned long)buffer);
	return err;
}


static int oom_kill_usage(char *buffer, char **start, off_t offset, int length)
{
	char *temp;

	temp = buffer;
	temp += snprintf(temp, length, "Usage:\n"
					 "cat /proc/oom_kill_protection/stat\n"
					 "echo \"setprotection <pid> [0/1]\" > /proc/oom_kill_protection/ctl\n");

	return temp-buffer;
}

static int oom_kill_proc_info(char *buffer, char **start, off_t offset, int length)
{
	int size, len = 0;
	off_t begin = 0;
	off_t pos = 0;

	size = snprintf(buffer, length, "OOM protected processes:\n");
	len += size;
	pos = begin + len;

	size = print_protected(buffer + len, length - len);
	len += size;
	pos = begin + len;
	if (pos < offset) {
		len = 0;
		begin = pos;
	}

	*start = buffer + (offset - begin); /* Start of wanted data */
	len -= (offset - begin);    /* Start slop */
	if (len > length)
		len = length;

	return len;
}

static void remove_proc_entries(void)
{
	if (proc_oom_kill_ctl) {
		remove_proc_entry("ctl", proc_oom_kill);
		proc_oom_kill_ctl = NULL;
	}

	if (proc_oom_kill_status) {
		remove_proc_entry("status", proc_oom_kill);
		proc_oom_kill_status = NULL;
	}

	if (proc_oom_kill_usage) {
		remove_proc_entry("usage", proc_oom_kill);
		proc_oom_kill_usage = NULL;
	}

	if (proc_oom_kill) {
		remove_proc_entry("oom_kill_protection", 0);
		proc_oom_kill = NULL;
	}
}


static int oom_protect_major = 0;

#define OOM_SET_PROTECT_MAGIC 'O'
#define OOM_GET_PROTECT_MAGIC 'o'

#define NAME "oom_protect"
#define OOMSETPROTECTCMD   _IOWR(OOM_SET_PROTECT_MAGIC, 1, int)
#define OOMGETPROTECTCMD   _IOR(OOM_GET_PROTECT_MAGIC, 2, int)

static int oom_kill_ioctl(struct inode *inode,
		          struct file *file,
		          unsigned int cmd,
		          unsigned long arg)
{
    switch (cmd) {
    case OOMSETPROTECTCMD: {
		  int mode;

		  printk(KERN_DEBUG "Received OOMSETPROTECTCMD from task %d\n", current->pid);

		  if (copy_from_user(&mode, (void *) arg, sizeof(int)))
		  	return -EFAULT;

		  printk(KERN_DEBUG "[%d] Protection mode was set to %d\n", current->pid, mode);

		  if (set_task_oom_protection(current, mode))
		  	return -EINVAL;

		  break;
    }
    case OOMGETPROTECTCMD: {
		  int mode;

		  printk(KERN_DEBUG "Received OOMGETPROTECTCMD from task %d\n", current->pid);

		  mode = get_task_oom_protection(current);
		  copy_to_user((void *) arg, &mode, sizeof(int));

		  break;
    }
    default:
		  return -EINVAL;
    }

    return 0;
}

static struct file_operations oom_kill_fops =
{
    .owner      = THIS_MODULE,
    .open       = nonseekable_open,
    .ioctl      = oom_kill_ioctl,
};

static void register_device(void)
{
    int r;

    r = register_chrdev(oom_protect_major, NAME, &oom_kill_fops);
    if (r < 0) {
		printk(KERN_ERR NAME ": unable to register character device\n");
		return;
    }
    if (!oom_protect_major) {
	  	oom_protect_major = r;
	  	printk(KERN_DEBUG NAME ": got dynamic major %d\n", oom_protect_major);
    }

    return;
}

static void unregister_device(void)
{
    unregister_chrdev(oom_protect_major, NAME);
}

static int __init oom_kill_ctl_init(void)
{
	proc_oom_kill = proc_mkdir("oom_kill_protection", 0);
	if (!proc_oom_kill) {
		printk (KERN_ERR "cannot init /proc/oom_kill_protection\n");
		remove_proc_entries();
		return -ENOMEM;
	}

	proc_oom_kill_ctl = create_proc_entry ("ctl", S_IFREG|S_IRUGO|S_IWUSR, proc_oom_kill);
	if (!proc_oom_kill_ctl) {
		printk (KERN_ERR "cannot init /proc/oom_kill_protection/ctl\n");
		remove_proc_entries();
		return -ENOMEM;
	}

	proc_oom_kill_status = create_proc_info_entry("status", 0, proc_oom_kill, oom_kill_proc_info);
	if (!proc_oom_kill_status) {
		printk (KERN_ERR "cannot init /proc/oom_kill_protection/status\n");
		remove_proc_entries();
		return -ENOMEM;
	}

	proc_oom_kill_usage = create_proc_info_entry("usage", 0, proc_oom_kill, oom_kill_usage);
	if (!proc_oom_kill_usage) {
		printk (KERN_ERR "cannot init /proc/oom_kill_protection/usage\n");
		remove_proc_entries();
		return -ENOMEM;
	}

	proc_oom_kill_ctl->write_proc = oom_kill_ctl;
	register_device();
	printk(KERN_INFO OOM_KILL_CTL_DESC  " was initialized\n");
	return 0;
}

static void __exit oom_kill_ctl_cleanup(void)
{
	unprotect_all();
	remove_proc_entries();
	unregister_device();
	printk(KERN_INFO OOM_KILL_CTL_DESC  " was cleaned-up\n");
}

module_init(oom_kill_ctl_init);
module_exit(oom_kill_ctl_cleanup);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION(OOM_KILL_CTL_DESC ", v" OOM_KILL_CTL_VERSION);
MODULE_AUTHOR("Menny Hamburger., <mennyt@exanet.com>");


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

There are two interfaces:
1) /proc interface (/proc/oom_kill_protection) that can be used inside scripts
2) A device that registers an ioctl, which can be issued via a calling c program.

To create the device after the module is loaded do the following from a script:
major_name=$(dmesg | grep oom_protect |  grep dynamic | tail -n 1 | awk '{print $5}' | xargs)
if [ -n "$major_name" ]; then
      mknod /dev/oom_protect c $major_name 1
fi
if [ ! -r /dev/oom_protect ]; then
     logger -p error "Unable to create /dev/oom_protect"
else
     logger -p notice "Created device /dev/oom_protect"
fi

Usage via a script:
echo "setprotection $$ 1 > /proc/oom_kill_protection/ctl"

Usage via a c prog:
#include <sys/ioctl.h>

........

#define OOMSETPROTECTCMD   _IOWR('O', 1, int)

int oom_protection = 1, oom_protected = 1, fd;

if ((fd = open("/dev/oom_protect", 0)) >= 0) {
    if (ioctl(fd, OOMSETPROTECTCMD, &oom_protection) == 0)
        oom_protected = 1;

        close(fd);
}
....


Menny

