Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318313AbSIBPz2>; Mon, 2 Sep 2002 11:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318314AbSIBPz2>; Mon, 2 Sep 2002 11:55:28 -0400
Received: from [80.120.128.82] ([80.120.128.82]:64528 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id <S318313AbSIBPz1>;
	Mon, 2 Sep 2002 11:55:27 -0400
From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200209021503.g82F3F430394@hofr.at>
Subject: kthread execve question
To: linux-kernel@vger.kernel.org
Date: Mon, 2 Sep 2002 17:03:15 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI !

 starting out at kernel/kmod.c as an example I tried to execve a simple command
 from a kernel thread using the exec_usermodehelper from kmod (kmod enabled in
 the kernel). It all seems to be fine - the printk appears but the command is
 not executed...

 any hint whats wrong ? any pointers to using kernel threads dosc/examples in 
 general and how to execute user space apps would be appreciated.

thx !
hofrat

--- broken hello world kthread ---
#define __KERNEL_SYSCALLS__

#include <linux/config.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/unistd.h>
#include <linux/kmod.h>
#include <linux/smp_lock.h>

#include <asm/uaccess.h>

char cmd_path[256] = "/bin/echo";

static int exec_cmd(void * kthread_arg)
{
	static char * envp[] = { "HOME=/", 
		"TERM=linux", 
		"PATH=/:/bin:/usr/bin:/usr/bin", 
		NULL };
	char *argv[] = { kthread_arg,
		">>",
		"/tmp/kthread_echo", 
		NULL };
	int ret;

	printk("calling usermodehelper for %s \n",cmd_path); 
	ret = exec_usermodehelper(cmd_path, argv, envp);

	printk(KERN_ERR "failed to exec %s, ret = %d\n", cmd_path,ret);
	return ret;
}

int init_module(void) {
	pid_t pid;
	char kthread_arg[]="Hello World";

	pid = kernel_thread(exec_cmd, (void*) kthread_arg, 0);
	if (pid < 0) {
		printk(KERN_ERR "fork failed, errno %d\n", -pid);
		return pid;
	}
	printk("fork ok, pid %d\n",pid);
	return 0;
}

void cleanup_module(void) {
	printk("module exit\n");
}
