Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132811AbRDDPaB>; Wed, 4 Apr 2001 11:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132840AbRDDP3n>; Wed, 4 Apr 2001 11:29:43 -0400
Received: from t2.redhat.com ([199.183.24.243]:39162 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132839AbRDDP32>; Wed, 4 Apr 2001 11:29:28 -0400
To: linux-kernel@vger.kernel.org
Subject: rw_semaphore bug
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <23243.986398031.0@warthog.cambridge.redhat.com>
Date: Wed, 04 Apr 2001 16:28:46 +0100
Message-ID: <23245.986398126@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23243.986398031.1@warthog.cambridge.redhat.com>

I've found a bug in the write path of the read/write semaphore stuff (at least
for the i386 arch). The attached kernel module (rwsem.c) and driver program
(driver.c) demonstrate it.

What happens is that once the driver finishes, you end up with a whole load of
processes forked off of driver that are stuck in the D state and are waiting
in down_write_failed(), even though the semaphore is in the unlocked state.

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="rwsem.c"; charset="us-ascii"
Content-ID: <23243.986398031.2@warthog.cambridge.redhat.com>
Content-Description: rwsem.c

#define __NO_VERSION__
#include <linux/config.h>
#include <linux/module.h>
#include <linux/poll.h>
#include <linux/proc_fs.h>
#include <linux/stat.h>
#include <linux/init.h>
#include <linux/personality.h>
#include <linux/smp_lock.h>
#include <linux/delay.h>

struct proc_dir_entry *rwsem_proc;

struct rw_semaphore rwsem_sem;

static int rwsem_write_proc(struct file *file, const char *buffer, unsigned long count, void *data)
{
	printk("[%05d %08x]: downing\n",current->pid,rwsem_sem.count);
	down_write(&rwsem_sem);
	printk("[%05d %08x]: downed\n",current->pid,rwsem_sem.count);
	mdelay(1);
	printk("[%05d %08x]: upping\n",current->pid,rwsem_sem.count);
	up_write(&rwsem_sem);
	printk("[%05d %08x]: upped\n",current->pid,rwsem_sem.count);

	mdelay(100);

	printk("[%05d %08x]: downing\n",current->pid,rwsem_sem.count);
	down_write(&rwsem_sem);
	printk("[%05d %08x]: downed\n",current->pid,rwsem_sem.count);
	mdelay(1);
	printk("[%05d %08x]: upping\n",current->pid,rwsem_sem.count);
	up_write(&rwsem_sem);
	printk("[%05d %08x]: upped\n",current->pid,rwsem_sem.count);

	return -ENOENT;
}

static int __init rwsem_init_module(void)
{
	printk(KERN_INFO "rwsem loading...\n");

	init_rwsem(&rwsem_sem);

	/* try and create the access point */
	rwsem_proc = create_proc_entry("rwsem",S_IRUGO|S_IWUGO,NULL);
	if (!rwsem_proc)
		return -EEXIST;

	rwsem_proc->write_proc = &rwsem_write_proc;
	return 0;
}

static void __exit rwsem_cleanup_module(void)
{
	printk(KERN_INFO "rwsem unloading\n");

	remove_proc_entry("rwsem",NULL);

}

module_init(rwsem_init_module);
module_exit(rwsem_cleanup_module);

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="driver.c"; charset="us-ascii"
Content-ID: <23243.986398031.3@warthog.cambridge.redhat.com>
Content-Description: driver.c

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
	int loop, fd, tmp;

	fd = open("/proc/rwsem",O_RDWR);
	if (fd<0) {
		perror("open");
		return 1;
	}

	for (loop=0; loop<50; loop++) {
		switch (fork()) {
		case -1:
			perror("fork");
			return 1;
		case 0:
			write(fd," ",1);
			exit(1);
		default:
			break;
		}
	}

	for (loop=0; loop<5; loop++) {
		if (wait(&tmp)<0) {
			perror("wait");
			return 1;
		}
	}

	return 0;
}

------- =_aaaaaaaaaa0--
