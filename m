Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTKQJmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTKQJmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:42:10 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:7300 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263424AbTKQJl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:41:57 -0500
Date: Mon, 17 Nov 2003 09:42:09 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: William Lee Irwin III <wli@holomorphy.com>
cc: viro@parcelfarce.linux.theplanet.co.uk, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031117090339.GC22764@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0311170937550.748-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two files: simple.c kernel module and user.c user test program.  
If you (or anyone) believe it is possible to return more than a single
page on a read(2) please change them accordingly and let me know.

simple.c
=======================

/*
 *   simple.c --- Provide access to process data via /proc/scan
 */

#include <linux/init.h>
#include <linux/sched.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/spinlock.h>
#include <linux/mm.h>
#include <linux/file.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>

#include <asm/uaccess.h>

/* Red Hat Linux 2.4.20-8 has its own next_task() macro */
#ifndef next_task
	#define next_task(p)	(p)->next_task
#endif

struct proc {
	int pid;                 /* process id */
	int uid;                 /* real user id */
	char comm[17];		 /* process name */
	char wasted[200];	 /* wasted space, filled with 'A' */
};

#define PROCLEN		(sizeof(struct proc))

MODULE_DESCRIPTION("Simple module for testing seq_file");
MODULE_AUTHOR("Tigran Aivazian <tigran@veritas.com>");
MODULE_LICENSE("GPL");
EXPORT_NO_SYMBOLS;

static int simple_show(struct seq_file *m, void *v)
{
	struct task_struct *p = (struct task_struct *)v;
	struct proc proc;

	proc.pid = p->pid;
	proc.uid = p->uid;
	strncpy(proc.comm, p->comm, 16);
	memset(proc.wasted, 'A', 200);

	if (m->count + PROCLEN < m->size) {
		memcpy(m->buf + m->count, &proc, PROCLEN);
		m->count += PROCLEN;
		return 0;
	} else {
		m->count = m->size;
		return -1;
	}
}

static void *c_start(struct seq_file *m, loff_t *ppos)
{
	struct task_struct *p = &init_task;
	int n = *ppos;

	read_lock(&tasklist_lock);

	if (n == 0)
		return (void *)p;
	
	while (n--)
		p = next_task(p);

	return (void *)p;
}

static void *c_next(struct seq_file *m, void *v, loff_t *ppos)
{
	struct task_struct *p= (struct task_struct *)v;

	p = next_task(p);
	if (p == &init_task)
		p = NULL;
	else
		++*ppos;

	return (void *)p;
}

static void c_stop(struct seq_file *m, void *v)
{
	read_unlock(&tasklist_lock);
}

struct seq_operations seqops = {
	.start		= c_start,
	.next		= c_next,
	.stop		= c_stop,
	.show		= simple_show,
};

static int simple_open(struct inode *inode, struct file *file)
{
	return seq_open(file, &seqops);
}


static struct file_operations fileops = {
	.owner		= THIS_MODULE,
	.open		= simple_open,
	.read		= seq_read,
	.llseek		= seq_lseek,
	.release	= seq_release,
};


static int  __init simple_init(void)
{
	struct proc_dir_entry *entry = create_proc_entry("scan", 0, NULL);

	if (entry) {
		entry->proc_fops = &fileops;
		printk(KERN_INFO "simple: /proc/scan created\n");
		return 0;
	} else {
		printk(KERN_ERR "simple: failed to create /proc/scan\n");
		return -1;
	}
}

static void __exit simple_exit(void)
{
	remove_proc_entry("scan", 0);
}

module_init(simple_init)
module_exit(simple_exit)

user.c
=============================

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>

struct proc {
	int pid;                 /* process id */
	int uid;                 /* real user id */
	char comm[17];		 /* process name */
	char wasted[200];	 /* wasted space, filled with 'A' */
};


#define PROCLEN		(sizeof(struct proc))
#define MAXPROCS 100
struct proc procs[MAXPROCS];

int main(int argc, char *argv[])
{
	int fd, len, nproc, i, j, count = 0;
	static int first_scan = 1;

	fd = open("/proc/scan", O_RDONLY);
	if (fd == -1) {
		fprintf(stderr, "%s: open(\"/proc/scan\"), errno=%d (%s)\n",
			argv[0], errno, strerror(errno));
		exit(1);
	}

	while (1) {
		len = read(fd, procs, MAXPROCS*PROCLEN);
		nproc = len/PROCLEN;

		if ((procs[0].pid == 0) && !first_scan) {
			printf("Total: count=%d procs\n\n", count);
			count = 0;
			break;
		}
		printf("\tnproc=%d\n", nproc);

		if (first_scan)
			first_scan = 0;

		count += nproc;

		printf("%d bytes (%d procs)\n", len, nproc);
		for (i=0; i<nproc; i++) {
			printf("proc[%d]: pid=%d, uid=%d, comm=<%s>\n",
					i, procs[i].pid, procs[i].uid, procs[i].comm);
			for (j=0; j<200; j++)
				if (procs[i].wasted[j] != 'A') {
					fprintf(stderr, "Corruption i=%d, j=%d\n", i, j);
					exit(1);
				}
		}
	}
	return 0;
}

