Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267874AbTGOOE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbTGOOE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:04:29 -0400
Received: from leviathan.ele.uri.edu ([131.128.51.64]:33424 "EHLO
	leviathan.ele.uri.edu") by vger.kernel.org with ESMTP
	id S267874AbTGOOEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:04:25 -0400
From: mingz <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: linux-kernel@vger.kernel.org
Subject: defunc thread?
Date: Tue, 15 Jul 2003 09:54:42 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307150954.42253.mingz@ele.uri.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I code a smal example about kernel thread. But when I 
insmod thrtest.o &
more /proc/testthread
ps aux

then i can see my thread become defunc. if i 
insmod (and wait till it return, )
more /proc/testthread, 
ps aux, 

the thread status is correct. can anybody tell me why? thx

ming
---------------------------------------------------------------------------------
#include <linux/errno.h>    /* Miscellaneous error codes */
#include <linux/stddef.h>   /* NULL */
#include <linux/slab.h>     /* kmalloc() */
#include <linux/module.h>   /* EXPORT_SYMBOL */
#include <linux/pci.h>
#include <linux/smp_lock.h>
#include <linux/proc_fs.h>
#include <asm/uaccess.h>
#include <linux/interrupt.h>

DECLARE_WAIT_QUEUE_HEAD(test_wait);

int t_thread(void *startup)
{
	int i = 0;
	
	lock_kernel();
	daemonize();
	current->tty = NULL;
	strcpy(current->comm, "testthread");
	unlock_kernel();

	spin_lock_irq(&current->sigmask_lock);
	sigfillset(&current->blocked);
	recalc_sigpending(current);
	spin_unlock_irq(&current->sigmask_lock);

	complete((struct completion *)startup);

	printk("test thread up and call complete\n");
	interruptible_sleep_on(&test_wait);
	printk("thread wake up %d times\n", ++i);

	printk("test thread do cleanup work\n");

	return 0;
}

int test_read_procmem(char *buf, char **start, off_t offset, int count, int 
*eof, void *data)
{
        int len = 0;

        len += sprintf(buf+len,"test v0.1 Dragonfly, ELE, URI\n");
        *eof = 1;

	wake_up_interruptible(&test_wait);
        return len;
}

static struct completion startup = COMPLETION_INITIALIZER(startup);

int test_init(void)
{
	kernel_thread(t_thread, &startup, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
	wait_for_completion(&startup);

	create_proc_read_entry("testthread", 0, NULL, test_read_procmem, NULL);
	
	set_current_state (TASK_INTERRUPTIBLE);
	schedule_timeout (30*HZ);
	__set_current_state (TASK_RUNNING);

	return 0;
}

void test_clean(void)
{
	remove_proc_entry("helpm", NULL);
}

module_init(test_init);
module_exit(test_clean);

MODULE_DESCRIPTION("Test Thread");
MODULE_LICENSE("GPL");



