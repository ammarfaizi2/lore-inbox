Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSKYX6M>; Mon, 25 Nov 2002 18:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266121AbSKYX6M>; Mon, 25 Nov 2002 18:58:12 -0500
Received: from fmr06.intel.com ([134.134.136.7]:33738 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266115AbSKYX6I>; Mon, 25 Nov 2002 18:58:08 -0500
Date: Mon, 25 Nov 2002 16:05:25 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
Message-Id: <200211260005.gAQ05Pn15843@linux.intel.com>
To: mochel@osdl.org
Subject: Re:[BUG] sysfs on 2.5.48 unable to remove files while in use
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

Sysfs (with the new subsystem_* function calls
that your previous patch added) will crash the 
kernel if a subsystem is unregistered with content 
inside it.

I stumbled across this while messing with the
noisy driver that you fixed up for proper sysfs
usage.  To make sure that I wasn't seeing some
side effects from kprobes, I distilled the 
essence of the sysfs operations to a new module
that I have attached to this email.

With sysfs mounted to /sys/, loading this module
will cause /sys/test/ and /sys/test/ctl to be
created.  

Test entries can be created by:
echo "add 1 test1" > /sys/test/ctl

this will cause /sys/1/message to be created
where message contains "test1".

This test entry can be removed by:
echo "del 1" > /sys/test/ctl

All is fine if I create a few entries, and
then remove them all before rmmod'ing the 
driver, but if I create an entry and then
attempt to rmmod the modules then my system
freezes with a partial oops message (not 
enough ksymoops to do anything with).

Here is the partial oops message ==>

Unable to handle kernel paging request at virtual address 5a5a5a5a
 printing eip:
c018a9c1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018a9c1>]    Not tainted
EFLAGS: 00010206
EIP is at sysfs_remove_dir+0x21/0x121
eax: 5a5a5a5a   ebx: da269f74   ecx: 00000000   edx: 00000002
esi: 00000800   edi: d9e72654   ebp: de4fdf14   esp: de4fdef8
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 1173, threadinfo=de4fc000 task=dce30ce0)
Stack: e08aa540 da269f74 de4fdf14 5a5a5a5a da269f74 00000800 da269f74 de4fdf30
       c01e9a2a da269f74 e08aa540 da269f74 00000800 e08a8000 de4fdf40 c01e9ad4
       da269f74 da269f88 de4fdf54 e08aa65b da269f74 00000003 c0371b94 de4fdfbc
Call Trace:
 [<e08aa540>] <1>Unable to handle kernel paging request at virtual address e08ad printing eip:
c0133e28
*pde = 015df067
*pte = 00000000

Here is the code for the test case described above:


/*
 * This is a simple module that performs basic sysfs file
 * operations. By installing this module, a new directory
 * called "test" is added to the sysfs root, with a control
 * file in that directory called "ctl"
 * 
 * To add a new test entry:
 * echo "add somename mytest" > $MYSYSFS/test/ctl
 *
 * As a result a new directory named "somename" will
 * be created in the test directory, with a file inside
 * that directory called "message".  Doing a cat on that
 * file will dump "mytest".
 * 
 * To remove the entry :
 * echo "del somename" > $MYSYSFS/test/ctl
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/kobject.h>

#define MAX_MSG_SIZE 128
#define to_mycont(entry) container_of(entry,struct mycont,kobj.entry);

static DECLARE_MUTEX(test_sem);
static struct subsystem test_subsys;

struct mycont {
	int id;
	char message[MAX_MSG_SIZE + 1];  
	struct kobject kobj;
};

/*
 * struct test_attribute - used for defining test attributes, with a 
 * typesafe show method.
 */
struct test_attribute {
	struct attribute attr;
	ssize_t (*show)(struct mycont *,char *,size_t,loff_t);
};


/**
 *	test_attr_show - forward sysfs read call to proper handler.
 *	@kobj:	kobject of test being acessed.
 *	@attr:	generic attribute portion of struct test_attribute.
 *	@page:	buffer to write into.
 *	@count:	number of bytes requested.
 *	@off:	offset into buffer.
 *
 *	This is called from sysfs and is necessary to convert the generic
 *	kobject into the right type, and to convert the attribute into the
 *	right attribute type.
 */

static ssize_t test_attr_show(struct kobject * kobj, struct attribute * attr,
			       char * page, size_t count, loff_t off)
{
	struct mycont * n = container_of(kobj,struct mycont,kobj);
	struct test_attribute * test_attr = container_of(attr,struct test_attribute,attr);
	return test_attr->show ? test_attr->show(n,page,count,off) : 0;
}

/*
 * test_sysfs_ops - sysfs operations for struct myconts.
 */
static struct sysfs_ops test_sysfs_ops = {
	.show	= test_attr_show,
};


/* Default Attribute - the message to print out. */
static ssize_t test_message_read(struct mycont * n, char * page, size_t count, loff_t off)
{
	return off ? 0: snprintf(page,MAX_MSG_SIZE,"%s\n",n->message);

}

static struct test_attribute attr_message = {
	.attr	= { .name = "message", .mode = S_IRUGO },
	.show	= test_message_read,
};

/* Declare array of default attributes to be added when an mycont is added */
static struct attribute * default_attrs[] = {
	&attr_message.attr,
	NULL,
};


/* Declare test_subsys for addition to sysfs */
static struct subsystem test_subsys = {
	.kobj	= { .name = "test" },
	.default_attrs	= default_attrs,
	.sysfs_ops	= &test_sysfs_ops,
};


/*
 * test ctl attribute.
 * This is declared as an attribute of the subsystem, and added in 
 * test_init(). 
 * 
 * Reading this attribute dumps all the registered test messages.
 * Writing to it either adds or deletes a test message, as described at 
 * the beginning of the file.
 */
static ssize_t ctl_show(struct subsystem * s, char * page, size_t count, loff_t off)
{
	char * str = page;
	int ret = 0;

	down(&test_sem);
	if (!off) {
		struct list_head * entry, * next;
		list_for_each_safe(entry,next,&test_subsys.list) {
			struct mycont * n = to_mycont(entry);
			if ((ret + MAX_MSG_SIZE) > PAGE_SIZE)
				break;
			str += snprintf(str,PAGE_SIZE - ret,"%i: %s\n",
					n->id, n->message);
			ret = str - page;
		}
	}
	up(&test_sem);
	return ret;
}

static int add(int id, char * message)
{
	struct mycont * n;
	int error = 0;

	n = kmalloc(sizeof(struct mycont),GFP_KERNEL);
	if (!n)
		return -ENOMEM;
	memset(n,0,sizeof(struct mycont));

	strncpy(n->message,message,MAX_MSG_SIZE);
	n->id = id;

	/* Doing this manually will be unnecessary soon. */
	kobject_init(&n->kobj);
	n->kobj.subsys = &test_subsys;
	snprintf(n->kobj.name, KOBJ_NAME_LEN, "%i", id);
	if ((error = kobject_register(&n->kobj))) {
		goto Error;
	}
	goto Done;
 Error:
	kfree(n);
 Done:
	return error;
}

static int del(int id)
{
	struct list_head * entry;
	struct mycont * n;

	list_for_each(entry,&test_subsys.list) {
		n = to_mycont(entry);
		if ((int)(n->id) == id) {
			kobject_unregister(&n->kobj);
			return 0;
		}
	}
	return -EFAULT;
}

static ssize_t ctl_store(struct subsystem * s, const char * page, size_t count, loff_t off)
{
	char message[MAX_MSG_SIZE];
	char ctl[16];
	int id;
	int num;
	int error;
	int ret = 0;

	down(&test_sem);
	if (off)
		goto Done;
	num = sscanf(page,"%15s %i %128s",ctl,&id,message);
	if (!num) {
		error = -EINVAL;
		goto Done;
	}
	if (!strcmp(ctl,"add") && num == 3)
		error = add(id,message);
	else if (!strcmp(ctl,"del") && num == 2)
		error = del(id);
	else
		error = -EINVAL;
	ret = error ? error : count;
 Done:
	up(&test_sem);
	return ret;
}

static struct subsys_attribute subsys_attr_ctl = {
	.attr	= { .name = "ctl", .mode = 0644 },
	.show	= ctl_show,
	.store	= ctl_store,
};


static int __init test_init(void)
{
	subsystem_register(&test_subsys);
	subsys_create_file(&test_subsys,&subsys_attr_ctl);
	return 0;
}

static void __exit test_exit (void)
{
	subsys_remove_file(&test_subsys,&subsys_attr_ctl);
	subsystem_unregister(&test_subsys);
}

module_init(test_init);
module_exit(test_exit);

MODULE_AUTHOR("Rusty Lynch");
MODULE_LICENSE("GPL");
