Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVCaLy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVCaLy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVCaLy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:54:58 -0500
Received: from ytmexo03.mgw.ibps.net ([202.221.197.115]:9155 "EHLO
	ytmexo03.mgw.ibps.net") by vger.kernel.org with ESMTP
	id S261376AbVCaLyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:54:14 -0500
Message-ID: <424BE4D8.7050902@slc01.tohoku.grp.ricoh.co.jp>
Date: Thu, 31 Mar 2005 20:54:00 +0900
From: Piotr Muszynski <piotr@slc01.tohoku.grp.ricoh.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: module for controlling kprobes with /proc
Content-Type: multipart/mixed;
 boundary="------------080202010908030601080102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080202010908030601080102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have programmed a universal module to register/remove kprobes handlers
by interacting with /proc with simple commands.

The handlers must be in kernel and can be executed before or after
the function at which the breakpoints are placed. It works with 2.6.11.
No kernel tree modifications needed. No sanity checks performed.

It is miserable, perhaps useful...

http://sourceforge.net/projects/kprobmod/

Regards,

Piotr Muszynski




--------------080202010908030601080102
Content-Type: text/plain;
 name="kprobemod.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kprobemod.c"

/*
 * kprobemod.c -- Control Kprobes by /proc
 
 * Copyright (C) 2005 Piotr Muszynski, Tohoku Ricoh Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *
 *     +-------------------+
 *     | Debugged module   |
 *     | - - - - - - - - - |
 *     |                   |
 *     |                   |
 *     | x --> breakpoint  | --+
 *     |                   |   |
 *     |                   |   |
 * +-->| display_my_data() |   |
 * |   +-------------------+   |
 * |                           |
 * |                           |
 * |   +-------------------+   |
 * |   | kprobe module     |   |
 * |   | - - - - - - - - - |   |
 * |   |                   |   |
 * |   |                   |   |
 * OR--| kprobe_callback() |<--+
 * |   |                   |
 * |   | - - - - - - - - - |
 * |   | breakpoint table  |
 * |   | - - - - - - - - - |
 * |   | /proc interface   |
 * |   +-------------------+
 * |
 * |
 * |   +-------------------+
 * |   | other part of     |
 * |   | kernel            |
 * |   | - - - - - - - - - |
 * +-->| do_whatever()     |
 *     +-------------------+
 *
 *
 * kprobemod is commanded from user space by writing
 * to /proc file
 *
 * command format:
 *     1  character     insert:1, delete:0
 *     1  character     SEPARATOR
 *     10 characters    0x12345678 action (handler function address)
 *     1 character      SEPARATOR
 *     10 characters    0x12345678 where (breakpoint address)
 *     1 character      SEPARATOR
 *     1 character      post:1, pre:0
 *
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <linux/kernel.h>
#include <asm/uaccess.h>

#if CONFIG_MODVERSIONS==1
#define MODVERSIONS
#include </usr/src/linux/include/config/modversions.h>
#endif

#include <linux/kallsyms.h>
#include <linux/kprobes.h>

static struct proc_dir_entry *proc_kprobe_file;

static void insert_probe(
	unsigned long action,
	unsigned long where,
	int when
);
static void remove_probe (unsigned long where);
static void remove_all_probes (void);
static int kprobe_init (void);
static void kprobe_exit (void);
int proc_read (
	char *page, char **startp, off_t offset,
	int buffer_length, int *eof, void *zero
);
int proc_write (
	struct file *file, const char *buffer,
	unsigned long count, void *data
);
void call_handle(struct kprobe *kp);
int kp_dummy_pre(struct kprobe *, struct pt_regs *);
int kp_pre(struct kprobe *kp, struct pt_regs *regs);
void kp_dummy_post(struct kprobe *, struct pt_regs *, unsigned long);
void kp_post(
	struct kprobe *kp, struct pt_regs *ptregs,
	unsigned long flags
);
int kp_fault (struct kprobe *kp, struct pt_regs *regs, int trapnr);

//command string:
	// [0]		insert:1, delete:0
	// [1]		SEPARATOR
	// [2-11]	0x12345678 action
	// [12]		SEPARATOR
	// [13-22]	0x12345678 where
	// [23]		SEPARATOR
	// [24]		post:1, pre:0
struct kprobe_command {
	void (*action) (void);	// address of handler function to insert
	unsigned long where;	// address to place the probe at
	int when;				// 0:pre,1:post
	struct kprobe kp;
};

#define MAXPOINTS 20
static struct kprobe_command kpcmd[MAXPOINTS];

//
// Register a probe given address, action handler, pre/post parameter
//
static void insert_probe(
	unsigned long action,
	unsigned long where,
	int when)
{
	int loop;
	for (loop = 0; loop < MAXPOINTS; loop++)
		if ((kpcmd[loop].where == 0) || (kpcmd[loop].where == where))
			break;
	if (loop == MAXPOINTS) {
		printk(KERN_ALERT "kprobe: table full\n");
		return;
	}
	// refuse multiple probes at one address
	if (kpcmd[loop].where == where) {
		printk(KERN_ALERT "kprobe: address taken on NULL\n");
		return;
	}
	struct kprobe_command *pkpc = &kpcmd[loop];
	pkpc->action = (void (*) (void))action;
	pkpc->where  = where;
	pkpc->when   = when;
	pkpc->kp.fault_handler = kp_fault;
	pkpc->kp.addr = (kprobe_opcode_t *)where;
	if(0 == when) {
		pkpc->kp.pre_handler  = kp_pre;
		pkpc->kp.post_handler = kp_dummy_post;
	} else {
		pkpc->kp.post_handler = kp_post;
		pkpc->kp.pre_handler  = kp_dummy_pre;
	}
	int result = register_kprobe(&pkpc->kp);
	printk(KERN_ALERT "kprobe: register_kprobe() returned %d\n", result);
	printk(KERN_ALERT "kprobe: inserted # %04d\n", loop);
}

//
// Remove single probe
//
static void remove_probe (unsigned long where)
{
	if (where == 0) {
		printk(KERN_ALERT "kprobe: NULL address\n");
		return;
	}
	int loop;
	// find probe for given address
	// assume one probe per address
	for (loop = 0; loop < MAXPOINTS; loop++)
		if (kpcmd[loop].where == where)
			break;
	if (loop == MAXPOINTS) {
		printk(KERN_ALERT "kprobe: entry not found\n");
		return;
	}
	struct kprobe_command *pkpc = &kpcmd[loop];

	unregister_kprobe(&pkpc->kp);
	memset(pkpc, 0, sizeof(struct kprobe_command));
	printk(KERN_ALERT "kprobe: removed # %04d\n", loop);
}

//
// Remove all probes
//
static void remove_all_probes (void)
{
	int loop;
	for (loop = 0; loop < MAXPOINTS; loop++) {
		if (kpcmd[loop].where != 0) {
			struct kprobe_command *pkpc = &kpcmd[loop];
			unregister_kprobe(&pkpc->kp);
			memset(pkpc, 0, sizeof(struct kprobe_command));
			printk(KERN_ALERT "kprobe: removed # %04d\n", loop);
		}
	}
}

static int kprobe_init (void)
{
	printk(KERN_ALERT "kprobe: insmod()\n");

	// access us by writing commands to /proc
	proc_kprobe_file = create_proc_entry(
		"kprobe", S_IFREG | S_IRUGO | S_IWUSR, &proc_root
	);
	if (NULL == proc_kprobe_file)
		return 1;
	proc_kprobe_file->read_proc  = proc_read;
	proc_kprobe_file->write_proc = proc_write;
	proc_kprobe_file->owner      = THIS_MODULE;
	proc_kprobe_file->mode       |= S_IWUSR | S_IRUSR | S_IRGRP | S_IROTH;
	proc_kprobe_file->uid        = 0;
	proc_kprobe_file->gid        = 100;

	memset(kpcmd, 0, sizeof(kpcmd));

///	kp.addr = (kprobe_opcode_t *)kallsyms_lookup_name("do_fork");

	return 0;
}

static void kprobe_exit (void)
{
	remove_all_probes();
	remove_proc_entry("kprobe", proc_kprobe_file);
	printk(KERN_ALERT "kprobe: exit()\n");
}

//
// Show registered probes
//
int proc_read (
	char   *page,
	char  **startp,
	off_t   offset,
	int     buffer_length,
	int    *eof,
	void   *zero)
{
	int len = 0;

	if(offset > 0)
		return 0;
	int loop;
	for (loop = 0; loop < MAXPOINTS; loop++) {
		struct kprobe_command *pkpc = &kpcmd[loop];
		if (pkpc->where != 0) {
			len += sprintf(
				page + len, "%04d: %s->0x%08lx at 0x%08lx\n",
				loop,
				(pkpc->when) ? "POST":"PRE ",
				(unsigned long)pkpc->action,
				pkpc->where
			);
		}
	}

	return len;
}


//
// Read user's commands
//
int proc_write (
	struct file   *file, 
	const char    *buffer,
	unsigned long  count, 
	void          *data)
{
	char command[30];
	if (count < 28) {
		copy_from_user(command, buffer, count);
		command[count] = 0;
	} else {
		printk(KERN_ALERT "kprobe count: 0x%08lx\n", count);
		goto error;
	}

	printk(KERN_ALERT "kprobe command: %s\n", command);

	if ((':' == command[1]) && (':' == command[12]) && (':' == command[23]))
	{
		printk(KERN_ALERT "kprobe command %s OK\n", command);
		int when = 0;
		unsigned long where = 0, action = 0;
		if (command[24] == '1')
			when = 1;
		char *tmp;
		action = simple_strtoul(&command[2],  &tmp, 16);
		if (tmp - &command[2] < 10)
			goto error;
		where  = simple_strtoul(&command[13], &tmp, 16);
		if (tmp - &command[13] < 10)
			goto error;
		printk(KERN_ALERT "kprobe: good command\n");
		printk(KERN_ALERT "kprobe: %d when\n", when);
		printk(KERN_ALERT "kprobe: 0x%08lx where\n", where);
		printk(KERN_ALERT "kprobe: 0x%08lx action\n", action);

		if (command[0] == '1')
			insert_probe(action, where, when);
		else
			remove_probe(where);

		return count;
	}

error: printk(KERN_ALERT "kprobe: bad command\n");
	return -1;
}

//
// Magic occurs here
// We call the other module's debugging function by pointer
// Actually, it can be anything, so be careful
//
void call_handle(struct kprobe *kp)
{
	printk(KERN_ALERT "kprobe call_handle()\n");
	int loop;
	// find the handler
	for (loop = 0; loop < MAXPOINTS; loop++) {
		struct kprobe_command *pkpc = &kpcmd[loop];
		if (kp->addr == (void *)pkpc->where) {
			// and call it
			(*pkpc->action)();
		}
	}
}

///
/// Collection of callbacks
/// These are called by kernel when it stumbles upon kprobed address
///	All data we need is in struct kprobe
///
int kp_dummy_pre(struct kprobe *kp, struct pt_regs *regs)
{
	return 0;
}

int kp_pre(struct kprobe *kp, struct pt_regs *regs)
{
	call_handle(kp);
	return 0;
}

void kp_dummy_post(struct kprobe *kp, struct pt_regs *ptregs, unsigned long flags)
{
	return;
}

void kp_post(struct kprobe *kp, struct pt_regs *ptregs, unsigned long flags)
{
	call_handle(kp);
	return;
}

int kp_fault (struct kprobe *kp, struct pt_regs *regs, int trapnr)
{
	printk(KERN_ALERT "kp_fault()\n");
	return 0;
}

module_init(kprobe_init);
module_exit(kprobe_exit);

MODULE_LICENSE("Dual BSD/GPL");




--------------080202010908030601080102--
