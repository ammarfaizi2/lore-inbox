Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVCIOp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVCIOp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVCIOpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:45:06 -0500
Received: from [202.125.86.130] ([202.125.86.130]:39898 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261850AbVCIOlq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:41:46 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: badness in interruptible_sleep_on_timeout FC-3 (source code and Makefile attached)
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Wed, 9 Mar 2005 20:12:28 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348113A48C2@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: badness in interruptible_sleep_on_timeout FC-3 (source code and Makefile attached)
Thread-Index: AcUktJGEv6XfIHC9RuGx9114gepojAAAZO4w
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I have developed a small module in Fedora Core 3 with 2.6.9-1.667 kernel
version. This module uses the interruptible_sleep_on_timeout call and
one proc entry in it. After inserting the module when I try to cat the
/proc entry I got the following messages on the screen.

<jit_init> invoked!
Badness in interruptible_sleep_on_timeout at kernel/sched.c:3005
 [<02302989>] interruptible_sleep_on_timeout+0x5d/0x23a
 [<0211b919>] default_wake_function+0x0/0xc
 [<0aa120f9>] jit_read_queue+0x48/0x60 [badness_test]
 [<021a515f>] proc_file_read+0xd1/0x1ee
 [<0216554f>] vfs_read+0xb6/0xe2
 [<02165762>] sys_read+0x3c/0x62
Badness in interruptible_sleep_on_timeout at kernel/sched.c:3005
 [<02302989>] interruptible_sleep_on_timeout+0x5d/0x23a
 [<0211b919>] default_wake_function+0x0/0xc
 [<0aa120f9>] jit_read_queue+0x48/0x60 [badness_test]
 [<021a515f>] proc_file_read+0xd1/0x1ee
 [<0216554f>] vfs_read+0xb6/0xe2
 [<02165762>] sys_read+0x3c/0x62

I tried with spinlocks also. Even though, I got the same messages.
Here is the source code for the *.c file and Makefile.

badness_test.c file 
-------------------
#include <linux/config.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/kernel.h> 	/* printk() */
#include <linux/fs.h>     	/* everything... */
#include <linux/proc_fs.h>
#include <linux/errno.h> 	/* error codes */
#include <linux/types.h>  	/* size_t */

/*
 * This module is a silly one: it only embeds short code fragments
 * that show how time delays can be handled in the kernel.
 */

int jit_delay = 1; /* the default delay in read() */
char *jit_spoke = "Sample string to test various delay options.\n";

MODULE_PARM(jit_delay, "i");
MODULE_PARM(jit_spoke, "s");
MODULE_LICENSE("GPL");

#define LIMIT (PAGE_SIZE-128) /* don't print any more after this size */

static int jit_print(char *buf)
{
    int len = 0;
    len = sprintf(buf+len,"%s",jit_spoke);
    return len;
}

int jit_read_queue(char *buf, char **start, off_t offset,
                   int len, int *eof, void *data)
{
    wait_queue_head_t wait;

    init_waitqueue_head (&wait);
    interruptible_sleep_on_timeout(&wait, jit_delay*HZ);

    *eof = 1;
    return jit_print(buf);
}

int jit_init(void)
{
    printk("<%s> invoked!\n",__FUNCTION__);

    create_proc_read_entry("jitqueue", 0, NULL, jit_read_queue, NULL);

    return 0; /* succeed */
}

void jit_cleanup(void)
{
    printk("<%s> invoked!\n",__FUNCTION__);
    
    remove_proc_entry ("jitqueue", 0);
}

module_init(jit_init);
module_exit(jit_cleanup);

-----------------------------------------------------------------------

Makefile 
--------
#
# Makefile for badness_test.c file
#
KDIR:=/lib/modules/$(shell uname -r)/build
TRGT:=badness_testing
OBJS:=badness_test.o

obj-m += $(TRGT).o
$(TRGT)-objs := $(OBJS)

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
clean:
	$(RM) .*.cmd *.mod.c *.ko *.o -r .tmp*

------------------------------------------------------------------------
---

Please give some advices on this issue. 

Thanks and Regards,
Srinivas G
