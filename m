Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275383AbTHNTPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275385AbTHNTPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:15:20 -0400
Received: from fmr03.intel.com ([143.183.121.5]:11205 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S275383AbTHNTOz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:14:55 -0400
Message-ID: <3F3BDF1C.9080500@intel.com>
Date: Thu, 14 Aug 2003 22:12:28 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: resource leak in kernel_thread()
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to spawn and terminate kernel thread from the module quite often. 
At any given time, only one thread is alive. There are events that 
triggers thread creation and termination.
I found that, if I create/terminate thread many times (3000 - 4000 
times), system get to the stage when it can't create new process. I 
checked that, if I terminate one (already running) process after getting 
to this stage, I can create one more kernel thread, then system return 
to the state when no more processes can be created.

I use vanilla 2.4.20 kernel.

kernel_thread() start returning -11, which is -EAGAIN.

I must be doing something stupid, but I looked at kernel thread usage in 
the kernel code and found it is the same as in my example (to extent I 
can understand :-) ).

I will appreciate any help WRT proper kernel_thread usage. Please, CC me 
(vladimir.kondratiev@intel.com) in your reply since I am not subscribed 
to the list.

To simulate this situation, I created simple example. Following code is 
module that creates/terminates thread. To model external event that will 
trigger creation/termination, I use "/proc/kthread" file. The same file 
used to get some statistics. To create thread, one need to write "+" to 
the file, to terminate - "-". I run it on single CPU, so I removed all 
kernel_lock() related code.

To execute the test, run the following script. After some 3000-4000 
threads your system will be unable to create processes.

---kthread.sh begin---
#!/bin/sh
f="/proc/kthread"

function start () {
  echo "+" > $f
}

function stop () {
  echo "-" > $f
}

function display () {
  clear
  cat $f
}

sudo /sbin/insmod kthread.o
while true; do start; display; stop; done
---kthread.sh end---
---Makefile begin---
ifneq ($(KERNELRELEASE),)

obj-m := kthread.o

kthread-objs := kthread-main.o

include $(TOPDIR)/Rules.make

$(obj-m) : $($(obj-m:.o=-objs)) $(lib)
    $(LD) -r -o $@ $($(obj-m:.o=-objs)) $(lib)

else

KDIR    := /lib/modules/$(shell uname -r)/build
PWD        := $(shell pwd)

default:
    $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

endif
---Makefile end---
---kthread-main.c begin---
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/proc_fs.h>
#include <linux/vmalloc.h>
#include <asm/uaccess.h>

typedef struct kt_priv_struct {
  int nthreads; /**< let's count how many times kernel_thread succeeded */
  int pid;
  wait_queue_head_t wq;      /**< kthread sleep here */
  struct completion exited;
  __u32 volatile status;
} kt_priv_t;

static kt_priv_t the_data;

static int kt_thread(void* arg)
{
  kt_priv_t* priv=(kt_priv_t*)arg;
  daemonize();
  reparent_to_init();
  snprintf(current->comm,sizeof(current->comm),"kth_%d",priv->nthreads);
  ++priv->nthreads;
  while (!test_bit(0,&priv->status)) {
    /* framework for periodical execution */
    unsigned long to=HZ; /* timeout for periodical maintenance */
    do {
      to=interruptible_sleep_on_timeout(&priv->wq,to);
    } while ( !signal_pending(current) && to>0 );
    if (signal_pending(current)) {
      spin_lock_irq(&current->sigmask_lock);
      flush_signals(current);
      spin_unlock_irq(&current->sigmask_lock);
    }
    /* thread body - for this simple example do nothing */
  }
  complete_and_exit(&priv->exited,0);
}

static void kt_start(kt_priv_t* priv)
{
  if (priv->pid>0) return;
  init_completion(&priv->exited);
  init_waitqueue_head(&priv->wq);
  priv->status=0;
  priv->pid=kernel_thread(kt_thread,priv,0);
}

static void kt_stop(kt_priv_t* priv)
{
  if (priv->pid>0 && (0==test_and_set_bit(0,&priv->status))) {
    kill_proc(priv->pid,SIGHUP,1);
    wait_for_completion(&priv->exited);
    priv->pid=0;
  }
}

static int kt_proc_read(char* buf,char** start,off_t offset,int 
count,int* eof,void* data)
{
  kt_priv_t* priv=(kt_priv_t*)data;
  int len=0;
  len+=sprintf(buf+len,"nthreads = %d\n",priv->nthreads);
  len+=sprintf(buf+len,"pid      = %d\n",priv->pid);
  *eof=1;
  return len;
}

static int kt_proc_write(struct file *file, const char *buffer,unsigned 
long count, void *data)
{
  kt_priv_t* priv=(kt_priv_t*)data;
  int rc=count;
  if (count<1) {
    return -EINVAL;
  }
  char* buf=vmalloc(count+1);
  if (!buf) return -ENOMEM;
  buf[count]='\0';
  if (copy_from_user(buf,buffer,count)) {
    rc=-EFAULT;
    goto out;
  }
  switch (buf[0]) {
  case '+':
    kt_start(priv);
    break;
  case '-':
    kt_stop(priv);
    break;
  }
  out:
  vfree(buf);
  return rc;
}

static char* kt_proc_name="kthread";

static int kt_mod_init(void)
{
  kt_priv_t* priv=&the_data;
  memset(priv,0,sizeof(*priv));
  struct proc_dir_entry* 
p=create_proc_read_entry(kt_proc_name,0666,NULL,kt_proc_read,priv);
  if (p) {
    SET_MODULE_OWNER(p);
    p->write_proc=kt_proc_write;
  }
  return 0;
}

static void kt_mod_exit(void)
{
  kt_stop(&the_data);
  remove_proc_entry(kt_proc_name,NULL);
}

module_init(kt_mod_init);
module_exit(kt_mod_exit);

MODULE_AUTHOR("Vladimir Kondratiev <vladimir.kondratiev@intel.com>");
MODULE_DESCRIPTION("Kernel thread example");
MODULE_LICENSE("GPL");
---kthread-main.c end---


