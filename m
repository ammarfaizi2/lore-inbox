Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWBNVhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWBNVhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWBNVhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:37:06 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:44758 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1422800AbWBNVhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:37:04 -0500
Date: Wed, 15 Feb 2006 00:36:38 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: use kthread_ API
Message-ID: <20060214213638.GB13885@2ka.mipt.ru>
References: <20060214174825.GD18919@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214174825.GD18919@lst.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 15 Feb 2006 00:36:39 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 06:48:25PM +0100, Christoph Hellwig (hch@lst.de) wrote:
> Use the kthread_ API instead of opencoding lots of hairy code for kernel
> thread creation and teardown.

Your patch looks good, I will test it and if everything is ok push
upstream.

Thank you, Christoph.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/drivers/w1/w1.c
> ===================================================================
> --- linux-2.6.orig/drivers/w1/w1.c	2006-01-05 16:43:19.000000000 +0100
> +++ linux-2.6/drivers/w1/w1.c	2006-02-14 18:01:58.000000000 +0100
> @@ -30,6 +30,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> +#include <linux/kthread.h>
>  
>  #include <asm/atomic.h>
>  
> @@ -57,9 +58,7 @@
>  DEFINE_SPINLOCK(w1_mlock);
>  LIST_HEAD(w1_masters);
>  
> -static pid_t control_thread;
> -static int control_needs_exit;
> -static DECLARE_COMPLETION(w1_control_complete);
> +static struct task_struct *w1_control_thread;
>  
>  static int w1_master_match(struct device *dev, struct device_driver *drv)
>  {
> @@ -712,22 +711,16 @@
>  {
>  	struct w1_slave *sl, *sln;
>  	struct w1_master *dev, *n;
> -	int err, have_to_wait = 0;
> +	int have_to_wait = 0;
>  
> -	daemonize("w1_control");
> -	allow_signal(SIGTERM);
> -
> -	while (!control_needs_exit || have_to_wait) {
> +	while (!kthread_should_stop() || have_to_wait) {
>  		have_to_wait = 0;
>  
>  		try_to_freeze();
>  		msleep_interruptible(w1_control_timeout * 1000);
>  
> -		if (signal_pending(current))
> -			flush_signals(current);
> -
>  		list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry) {
> -			if (!control_needs_exit && !dev->flags)
> +			if (!kthread_should_stop() && !dev->flags)
>  				continue;
>  			/*
>  			 * Little race: we can create thread but not set the flag.
> @@ -738,18 +731,9 @@
>  				continue;
>  			}
>  
> -			if (control_needs_exit) {
> -				set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
> +			if (kthread_should_stop()) {
> +				kthread_stop(dev->thread);
>  
> -				err = kill_proc(dev->kpid, SIGTERM, 1);
> -				if (err)
> -					dev_err(&dev->dev,
> -						 "Failed to send signal to w1 kernel thread %d.\n",
> -						 dev->kpid);
> -			}
> -
> -			if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
> -				wait_for_completion(&dev->dev_exited);
>  				spin_lock_bh(&w1_mlock);
>  				list_del(&dev->w1_master_entry);
>  				spin_unlock_bh(&w1_mlock);
> @@ -784,7 +768,7 @@
>  		}
>  	}
>  
> -	complete_and_exit(&w1_control_complete, 0);
> +	return 0;
>  }
>  
>  int w1_process(void *data)
> @@ -792,17 +776,11 @@
>  	struct w1_master *dev = (struct w1_master *) data;
>  	struct w1_slave *sl, *sln;
>  
> -	daemonize("%s", dev->name);
> -	allow_signal(SIGTERM);
> -
> -	while (!test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
> +	while (!kthread_should_stop()) {
>  		try_to_freeze();
>  		msleep_interruptible(w1_timeout * 1000);
>  
> -		if (signal_pending(current))
> -			flush_signals(current);
> -
> -		if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags))
> +		if (kthread_should_stop())
>  			break;
>  
>  		if (!dev->initialized)
> @@ -835,8 +813,6 @@
>  	}
>  
>  	atomic_dec(&dev->refcnt);
> -	complete_and_exit(&dev->dev_exited, 0);
> -
>  	return 0;
>  }
>  
> @@ -868,11 +844,11 @@
>  		goto err_out_master_unregister;
>  	}
>  
> -	control_thread = kernel_thread(&w1_control, NULL, 0);
> -	if (control_thread < 0) {
> +	w1_control_thread = kthread_run(w1_control, NULL, "w1_control");
> +	if (IS_ERR(w1_control_thread)) {
> +		retval = PTR_ERR(w1_control_thread);
>  		printk(KERN_ERR "Failed to create control thread. err=%d\n",
> -			control_thread);
> -		retval = control_thread;
> +			retval);
>  		goto err_out_slave_unregister;
>  	}
>  
> @@ -898,8 +874,7 @@
>  	list_for_each_entry(dev, &w1_masters, w1_master_entry)
>  		__w1_remove_master_device(dev);
>  
> -	control_needs_exit = 1;
> -	wait_for_completion(&w1_control_complete);
> +	kthread_stop(w1_control_thread);
>  
>  	driver_unregister(&w1_slave_driver);
>  	driver_unregister(&w1_master_driver);
> Index: linux-2.6/drivers/w1/w1.h
> ===================================================================
> --- linux-2.6.orig/drivers/w1/w1.h	2005-12-27 18:30:31.000000000 +0100
> +++ linux-2.6/drivers/w1/w1.h	2006-02-14 18:01:34.000000000 +0100
> @@ -149,7 +149,6 @@
>  	void		(*search)(unsigned long, w1_slave_found_callback);
>  };
>  
> -#define W1_MASTER_NEED_EXIT		0
>  #define W1_MASTER_NEED_RECONNECT	1
>  
>  struct w1_master
> @@ -172,12 +171,11 @@
>  
>  	long			flags;
>  
> -	pid_t			kpid;
> +	struct task_struct	*thread;
>  	struct semaphore	mutex;
>  
>  	struct device_driver	*driver;
>  	struct device		dev;
> -	struct completion	dev_exited;
>  
>  	struct w1_bus_master	*bus_master;
>  
> Index: linux-2.6/drivers/w1/w1_int.c
> ===================================================================
> --- linux-2.6.orig/drivers/w1/w1_int.c	2005-12-27 18:30:31.000000000 +0100
> +++ linux-2.6/drivers/w1/w1_int.c	2006-02-14 18:02:26.000000000 +0100
> @@ -22,6 +22,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/delay.h>
> +#include <linux/kthread.h>
>  
>  #include "w1.h"
>  #include "w1_log.h"
> @@ -65,7 +66,6 @@
>  	dev->max_slave_count	= slave_count;
>  	dev->slave_count	= 0;
>  	dev->attempts		= 0;
> -	dev->kpid		= -1;
>  	dev->initialized	= 0;
>  	dev->id			= id;
>  	dev->slave_ttl		= slave_ttl;
> @@ -76,8 +76,6 @@
>  	INIT_LIST_HEAD(&dev->slist);
>  	init_MUTEX(&dev->mutex);
>  
> -	init_completion(&dev->dev_exited);
> -
>  	memcpy(&dev->dev, device, sizeof(struct device));
>  	snprintf(dev->dev.bus_id, sizeof(dev->dev.bus_id),
>  		  "w1_bus_master%u", dev->id);
> @@ -125,12 +123,12 @@
>  	if (!dev)
>  		return -ENOMEM;
>  
> -	dev->kpid = kernel_thread(&w1_process, dev, 0);
> -	if (dev->kpid < 0) {
> +	dev->thread = kthread_run(&w1_process, dev, "%s", dev->name);
> +	if (IS_ERR(dev->thread)) {
> +		retval = PTR_ERR(dev->thread);
>  		dev_err(&dev->dev,
>  			 "Failed to create new kernel thread. err=%d\n",
> -			 dev->kpid);
> -		retval = dev->kpid;
> +			 retval);
>  		goto err_out_free_dev;
>  	}
>  
> @@ -147,20 +145,14 @@
>  	spin_unlock(&w1_mlock);
>  
>  	msg.id.mst.id = dev->id;
> -	msg.id.mst.pid = dev->kpid;
> +	msg.id.mst.pid = dev->thread->pid;
>  	msg.type = W1_MASTER_ADD;
>  	w1_netlink_send(dev, &msg);
>  
>  	return 0;
>  
>  err_out_kill_thread:
> -	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
> -	if (kill_proc(dev->kpid, SIGTERM, 1))
> -		dev_err(&dev->dev,
> -			 "Failed to send signal to w1 kernel thread %d.\n",
> -			 dev->kpid);
> -	wait_for_completion(&dev->dev_exited);
> -
> +	kthread_stop(dev->thread);
>  err_out_free_dev:
>  	w1_free_dev(dev);
>  
> @@ -169,15 +161,10 @@
>  
>  void __w1_remove_master_device(struct w1_master *dev)
>  {
> -	int err;
>  	struct w1_netlink_msg msg;
> +	pid_t pid = dev->thread->pid;
>  
> -	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
> -	err = kill_proc(dev->kpid, SIGTERM, 1);
> -	if (err)
> -		dev_err(&dev->dev,
> -			 "%s: Failed to send signal to w1 kernel thread %d.\n",
> -			 __func__, dev->kpid);
> +	kthread_stop(dev->thread);
>  
>  	while (atomic_read(&dev->refcnt)) {
>  		dev_dbg(&dev->dev, "Waiting for %s to become free: refcnt=%d.\n",
> @@ -188,7 +175,7 @@
>  	}
>  
>  	msg.id.mst.id = dev->id;
> -	msg.id.mst.pid = dev->kpid;
> +	msg.id.mst.pid = pid;
>  	msg.type = W1_MASTER_REMOVE;
>  	w1_netlink_send(dev, &msg);
>  

-- 
	Evgeniy Polyakov
