Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVASN46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVASN46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVASN46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:56:58 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:18354 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261723AbVASNz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:55:58 -0500
Subject: [RFC] Relay fork module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: guillaume.thouvenin@bull.net, efocht@hpce.nec.com
Date: Wed, 19 Jan 2005 14:55:47 +0100
Message-Id: <1106142947.10947.35.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/01/2005 15:04:04,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/01/2005 15:04:08,
	Serialize complete at 19/01/2005 15:04:08
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    Here is the relay fork module. It sends a signal to one or several
processes when a fork occurs in the kernel. It relays information about
all forks and not only for a parent from its child like "ptrace" does.
This module is used by the Enhanced Linux System Accounting
(http://elsa.sf.net). In order to work, you need to apply the small
patch (relay_fork.patch) that I posted earlier.

   The relay fork module is configured by using the sysfs. The main
directory is called "/sys/relayfork" and it contains to file. one
keeps the number of the signal that is send when a fork occurred and
the other is a list of processes that are registered. Those files
are writable. The tree structure is as follow:
         sys/
           |
           --> relayfork/
                  |
                  ---> processes
                  ---> signal

   If you want to register a process, just "echoing" its PID in the
file "processes". Example:
        - Register process 123
          echo 123 > /sys/relayfork/processes
        - Un-Register process 123
          echo -123 > /sys/relayfork/processes

   You must be root to add a process in the list and you can register
several processes.

   By default the module send the RT signal "33". We use a RT signal
because if a signal occurs when a another one is still in the queue he
is added. If it's not a RT signal, the signal is lost. The administrator
is free to change it.
        echo XX > /sys/relayfork/signal

Any comments are welcome,

Guillaume.

Reminder:  This module used a hook in the kernel tree. Thus you need to
apply the corresponding patch in order to use it.

------------ relay_fork.c -----------------

/*
 * Relay fork interface
 *
 * Author: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
 *
 * This module is a relay for fork monitoring. You use the 
 * /sys/relayfork/processes to register your process or to 
 * display registered processes. 
 * The interface send a signal (default is a the RT signal 33)
 * to all registered processes when a fork occurs in the kernel. 
 * The signal can be change by using /sys/relayfork/signal. 
 *
 * Conventions:
 * 	structures are prefixed by rfork_
 * 	functions  are prefixed by rfd_
 * 	variable  are prefixed by relayf_
 */

#include <linux/module.h>	/* for all modules      */
#include <linux/kernel.h>	/* for KERN_ALERT       */
#include <linux/init.h>		/* for the macros       */

#include <linux/spinlock.h>	/* for spinlock         */
#include <linux/sched.h>	/* for task_struct      */
#include <linux/kobject.h>

#define RELAY_FORK_SIGNAL	33

MODULE_AUTHOR("Guillaume Thouvenin <guillaume.thouvenin@bull.net>");
MODULE_DESCRIPTION("sysfs interface to relay fork device");
MODULE_LICENSE("GPL");

/* available if the relay-fork patch is applied */
extern int trace_fork(void (*func) (int, int));

/*******************
 * local definition 
 *******************/


struct rfork_device {
	struct kobject kobj;
	struct list_head proclist;	/* registered processes  */
	unsigned long signal;	/* signal to send to processes */
};

struct rfork_attribute {
	struct attribute attr;
	 ssize_t(*show) (struct rfork_device * dev, char *buf);
	 ssize_t(*store) (struct rfork_device * dev, const char *buf,
			  size_t count);
};

struct rfork_proclist {
	struct list_head list;
	unsigned long pid;

};

/*****************************
 * header for local functions
 *****************************/


ssize_t rfd_attr_show(struct kobject *kobj, struct attribute *attr,
		      char *buf);
ssize_t rfd_attr_store(struct kobject *kobj, struct attribute *attr,
		       const char *buf, size_t size);

ssize_t rfd_proclist_show(struct rfork_device *dev, char *buf);
ssize_t rfd_proclist_store(struct rfork_device *dev, const char *buf,
			   size_t size);
ssize_t rfd_signal_show(struct rfork_device *dev, char *buf);
ssize_t rfd_signal_store(struct rfork_device *dev, const char *buf,
			 size_t size);


/*****************
 * local variable 
 *****************/


static spinlock_t relayf_lock = SPIN_LOCK_UNLOCKED;	/* protect relayf */

struct sysfs_ops relayf_sysfs_ops = {
	.show = rfd_attr_show,
	.store = rfd_attr_store,
};

struct kobj_type relayf_kobj_type = {
	.sysfs_ops = &relayf_sysfs_ops,
};

static struct rfork_device relayf;

#define RELAYF_ATTR(_name,_mode,_show,_store)    			\
struct rfork_attribute relayf_attr_##_name = {            		\
        .attr = {.name  = __stringify(_name) , .mode   = _mode },
\
        .show   = _show,                                		\
        .store  = _store,                               		\
};
/* give write access only to root, otherwise it's a security hole */
static RELAYF_ATTR(processes, 0644, rfd_proclist_show,
rfd_proclist_store);
static RELAYF_ATTR(signal, 0644, rfd_signal_show, rfd_signal_store);


/**************************
 * body of local functions 
 **************************/


/**
 * rfd_strtoi - convert a string to an unsigned long
 * @name: the string to convert
 *
 * Convert a string to an unsigned long. When we found 
 * a character that is not a number, we return immediatly.
 * The first character can be '-' but if it is, we just 
 * ignore it and return the positive value.
 */
static unsigned long rfd_strtoi(const char *name)
{
	unsigned long val = 0;

	/* If it's a negative value we just forgot the '-' */
	if (*name == '-')
		name++;

	for (;; name++) {
		switch (*name) {
		case '0'...'9':
			val = 10 * val + (*name - '0');
			break;
		default:
			return val;
		}
	}
}

/**
 * rfd_nbdigits - return the number of digits of an integer
 * @i: the integer
 *
 * example:  For "0" it returns 1
 *           For "324" it returns 3
 *           For "-324" it returns 3
 */

static inline int rfd_nbdigits(int i)
{
	int res = 0;

	if (i < 0)
		i *= -1;

	do {
		i = i / 10;
		res++;
	} while (i != 0);

	return res;
}

#define KOBJ_TO_RFORK(obj) container_of(obj, struct rfork_device, kobj)
#define ATTR_TO_RFORK(obj) container_of(obj, struct rfork_attribute,
attr)

/**
 * rfd_attr_show - method called when a file is read
 * @kobj: the kobject
 * @attr: the attribute
 * @buf:  the buffer
 *
 * Translate the generic struct kobject and struct attribute 
 * pointers to the appropriate pointer types, and calls the 
 * associated methods.
 */
ssize_t rfd_attr_show(struct kobject * kobj, struct attribute * attr,
		      char *buf)
{
	struct rfork_device *rf_dev = KOBJ_TO_RFORK(kobj);
	struct rfork_attribute *rf_attr = ATTR_TO_RFORK(attr);
	ssize_t ret = 0;

	if (rf_attr->show)
		ret = rf_attr->show(rf_dev, buf);

	return ret;
}

/**
 * rfd_attr_store - method called when a file is written
 * @kobj: the kobject
 * @attr: the attribute
 * @buf:  the buffer
 *
 * Translate the generic struct kobject and struct attribute 
 * pointers to the appropriate pointer types, and calls the 
 * associated methods.
 */
ssize_t rfd_attr_store(struct kobject * kobj, struct attribute * attr,
		       const char *buf, size_t size)
{
	struct rfork_device *rf_dev = KOBJ_TO_RFORK(kobj);
	struct rfork_attribute *rf_attr = ATTR_TO_RFORK(attr);
	ssize_t ret = 0;

	if (rf_attr->store)
		ret = rf_attr->store(rf_dev, buf, size);

	return ret;
}

/**
 * rfd_proclist_show - method called when processes attribute is read
 * @dev: the relay fork device
 * @buf: the buffer
 * 
 * The buffer is a buffer of size PAGE_SIZE (due to sysfs
implementation).
 * As the method is called only once for a read, the show() method
should 
 * fill the entire buffer. Buffer is filled with a list of processes
that
 * are registered. As the size of the buffer is limited, we also limit 
 * how many processes are displayed.
 * Method returns the number of bytes printed into the buffer. If a bad 
 * value comes through, it returns an  error.
 */
ssize_t rfd_proclist_show(struct rfork_device * dev, char *buf)
{
	struct rfork_proclist *p;
	struct list_head *pos;
	struct list_head *next;
	int char_print;
	char tmp[PAGE_SIZE];

	char_print = 0;

	spin_lock_irq(&relayf_lock);
	list_for_each_safe(pos, next, &dev->proclist) {
		p = container_of(pos, struct rfork_proclist, list);
		if (char_print + rfd_nbdigits(p->pid) + 1 < PAGE_SIZE - 1) {
			memset(tmp, 0, PAGE_SIZE);
			char_print += sprintf(tmp, "%lu ", p->pid);
			strcat(buf, tmp);
		} else
			/* 
			 * buf is full enough, we don't need to go through
			 * the list
			 */
			break;
	}
	spin_unlock_irq(&relayf_lock);
	strncat(buf, "\n", 1);
	char_print++;
	return char_print;
}

/**
 * rfd_proclist_store - method called when processes attribute is
written
 * @dev: the relay fork device
 * @buf: the buffer
 * @size:
 * 
 * As the method is called only once for a write, the store() method
should 
 * fill the entire buffer. Methods should return the number of bytes
used 
 * from the buffer. If a bad value comes through, we return an error.
 */
ssize_t rfd_proclist_store(struct rfork_device * dev, const char *buf,
			   size_t size)
{
	struct rfork_proclist *p;
	struct list_head *pos;	/* use as a loop counter */
	struct list_head *next;	/* temporary storage */
	int pid;		/* process to add or remove */

	pid = rfd_strtoi(buf);
	if (pid == 0)
		/* nothing to do */
		return strlen(buf);

	switch (*buf) {
	case '-':
		/* remove the process */
		spin_lock_irq(&relayf_lock);
		list_for_each_safe(pos, next, &dev->proclist) {
			p = container_of(pos, struct rfork_proclist, list);
			if (p->pid == pid) {
				list_del(&p->list);
				spin_unlock_irq(&relayf_lock);
				kfree(p);
				return strlen(buf);
			}
		}
		spin_unlock_irq(&relayf_lock);
		break;
	default:
		/* add the process. We check if it is already in the list */
		spin_lock_irq(&relayf_lock);
		list_for_each_safe(pos, next, &dev->proclist) {
			p = container_of(pos, struct rfork_proclist, list);
			if (p->pid == pid) {
				spin_unlock_irq(&relayf_lock);
				return strlen(buf);
			}
		}

		/* check if it is a valid pid */
		read_lock(&tasklist_lock);
		if (!find_task_by_pid(pid)) {
			read_unlock(&tasklist_lock);
			spin_unlock_irq(&relayf_lock);
			return strlen(buf);
		}
		read_unlock(&tasklist_lock);
		spin_unlock_irq(&relayf_lock);

		p = kmalloc(sizeof(struct rfork_proclist), GFP_KERNEL);
		if (!p)
			return -ENOMEM;

		INIT_LIST_HEAD(&p->list);
		p->pid = rfd_strtoi(buf);
		spin_lock_irq(&relayf_lock);
		list_add(&p->list, &dev->proclist);
		spin_unlock_irq(&relayf_lock);
	}

	return strlen(buf);
}

/**
 * rfd_signal_show - method called when signal attribute is read
 * @dev: the relay fork device
 * @buf: the buffer
 *
 * Buffer is filled by an integer which is the RT signal used by
 * the relay fork interface to relay fork information to processes.
 */
ssize_t rfd_signal_show(struct rfork_device * dev, char *buf)
{
	return sprintf(buf, "%lu\n", dev->signal);
}

/**
 * rfd_signal_store - method called when signal attribute is written
 * @dev: the relay fork device
 * @buf: the buffer
 * @size:
 *
 * Read the string in the buffer and convert it to an unsigned long
 * integer. This value is used to set the new RT signal. A RT signal 
 * must be between SIGRTMIN and SIGRTMAX.
 */
ssize_t rfd_signal_store(struct rfork_device * dev, const char *buf,
			 size_t size)
{
	unsigned long rtsignal = rfd_strtoi(buf);

	spin_lock_irq(&relayf_lock);
	if ((rtsignal > SIGRTMIN) && (rtsignal < SIGRTMAX))
		dev->signal = rfd_strtoi(buf);
	spin_unlock_irq(&relayf_lock);

	return strlen(buf);
}

/**
 * rfd_relay_fork_info - send information to all registered processes
 * @parent: PID of the parent 
 * @child: PID of the child
 *
 * Send information to all registered processes when a fork 
 * occurs in the kernel. 
 */
void rfd_relay_fork_info(int parent, int child)
{
	struct list_head *pos;
	struct list_head *next;
	struct siginfo sinfo;

	/*pr_info("FORK: parent = %d, child = %d\n", parent, child); */

	spin_lock_irq(&relayf_lock);
	list_for_each_safe(pos, next, &relayf.proclist) {
		struct task_struct *taskp;
		struct rfork_proclist *p =
		    container_of(pos, struct rfork_proclist, list);

		read_lock(&tasklist_lock);
		taskp = find_task_by_pid(p->pid);
		if (taskp) {
			sinfo.si_signo = relayf.signal;
			sinfo.si_errno = 0;
			sinfo.si_code = SI_ASYNCIO;
			/*
			 * should be the sender ID but in our case, it is set
			 * to the pid of the process that initiates the fork.
			 */
			sinfo.si_pid = parent;
			/*
			 * process created during the fork. This information
			 *  is needed to keep jobs coherent.
			 */
			sinfo.si_value.sival_int = child;

			send_sig_info(relayf.signal, &sinfo, taskp);
		} else {
			/* we can remove it from proclist */
			list_del(&p->list);
			kfree(p);
		}
		read_unlock(&tasklist_lock);
	}
	spin_unlock_irq(&relayf_lock);
}

/**
 * Modules start and stop
 **/

/**
 * rfd_init -
 */
static int __init rfd_init(void)
{
	int retval;

	retval = trace_fork(&rfd_relay_fork_info);
	if (retval < 0)
		return retval;

	/* Initialization of relayf */
	kobject_set_name(&relayf.kobj, "relayfork");
	relayf.kobj.ktype = &relayf_kobj_type;
	INIT_LIST_HEAD(&relayf.proclist);
	relayf.signal = RELAY_FORK_SIGNAL;

	/* 
	 * Register the kobject. As our object doesn't have a parent
	 * or a dominant kset, a directory is created at the top-level
	 * of the sysfs partition.
	 */
	retval = kobject_register(&relayf.kobj);
	sysfs_create_file(&relayf.kobj, &relayf_attr_processes.attr);
	sysfs_create_file(&relayf.kobj, &relayf_attr_signal.attr);

	return retval;
}

/**
 * rfd_cleanup - 
 */
static void __exit rfd_cleanup(void)
{
	struct list_head *pos;	/* use as a loop counter */
	struct list_head *next;	/* temporary storage */

	/* don't forget to release the fork hook */
	trace_fork(NULL);

	/* release entry that was dynamically allocated */
	list_for_each_safe(pos, next, &relayf.proclist) {
		struct rfork_proclist *p =
		    container_of(pos, struct rfork_proclist, list);
		list_del(&p->list);
		kfree(p);
	}

	sysfs_remove_file(&relayf.kobj, &relayf_attr_processes.attr);
	sysfs_remove_file(&relayf.kobj, &relayf_attr_signal.attr);
	kobject_unregister(&relayf.kobj);
}


module_init(rfd_init);
module_exit(rfd_cleanup);


