Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTJQNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTJQNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:50:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:385 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263470AbTJQNuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:50:02 -0400
Date: Fri, 17 Oct 2003 09:51:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Suresh Subramanian <Suresh.Subramanian@lntinfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: killing a kernel thread.
In-Reply-To: <OFE97AECC7.A7E1AF0C-ON65256DC2.0046781F@lntinfotech.com>
Message-ID: <Pine.LNX.4.53.0310170950290.3209@chaos>
References: <OFE97AECC7.A7E1AF0C-ON65256DC2.0046781F@lntinfotech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003, Suresh Subramanian wrote:

> Hello everybody
>
> How do i kill a kernel thread ?
>
> Thanks.
>

From:

Vladimir Kondratiev <vladimir.kondratiev@intel.com>

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

static int kt_proc_write(struct file *file, const char *buffer, unsigned
long count, void *data)
{
    char *buf;
    kt_priv_t* priv=(kt_priv_t*)data;
    int rc = count;
    if (count<1)
    {
        return -EINVAL;
    }
    buf = vmalloc(count+1);
    if (!buf) return -ENOMEM;
    buf[count]='\0';
    if (copy_from_user(buf,buffer,count))
    {
       rc=-EFAULT;
       goto out;
    }
    switch (buf[0])
    {
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
  struct proc_dir_entry *p;
  kt_priv_t* priv=&the_data;
  memset(priv,0,sizeof(*priv));
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



Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


