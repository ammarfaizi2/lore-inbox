Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423045AbWBOJmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423045AbWBOJmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBOJmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:42:25 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:30108 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932449AbWBOJmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:42:24 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] usbatm: use kthread_ API
Date: Wed, 15 Feb 2006 10:42:00 +0100
User-Agent: KMail/1.9.1
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
References: <20060214175152.GB19080@lst.de>
In-Reply-To: <20060214175152.GB19080@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151042.01267.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristoph,

On Tuesday 14 February 2006 18:51, Christoph Hellwig wrote:
> Use the kthread_ API instead of opencoding lots of hairy code for kernel
> thread creation and teardown.
> 
> Note: due to the short thread runtime we don't need a
> kthread_should_stop()

thanks for the patch.  Before writing the current code I first tried the
kthread API, but gave up on it - it seemed badly adapted to what I needed
(but maybe I misunderstood the API).  A workqueue is a better match.  I don't
remember all the issues that I had, but glancing through your patch and the API
documentation, a few things leap out.  Before listing them, let me first explain
what this per-device kernel thread is for.  When a USB device is plugged in, its probe
method is called by the khubd kernel thread.  This same thread is responsible for
all USB device connections and disconnections, so if a probe method takes a long
time (or forever) to exit, then new devices etc will be ignored as long as it is
running.  Summary: a probe method shouldn't take more than a few seconds to run.
The usbatm module manages and provides facilities for "minidrivers" like speedtch.
The speedtch module is the driver for the SpeedTouch ADSL modems made now by Thomson.
These modems need to have a great glob (about 750k) of firmware uploaded to them
before they can be used for anything.  The firmware needs to be loaded from userspace
(which can take an infinite amount of time, depending on the timeout value for the
firmware subsystem), then uploaded to the modem (this takes around 5 seconds).  It
would be natural to do the firmware loading from the USB probe method, but since it
can take forever to complete, this could potentially lock up the USB subsystem.  Thus
a one-off kernel thread (maybe a workqueue) is needed to do the uploading.  Since
several minidrivers have this same need, the thread logic is centralised in the
usbatm core.

Typically it goes like this:
(1) probe method is called, kernel thread is spawned.  probe method exits.
(2) kernel thread uploads firmware to modem.  kernel thread exits.  device now useable.

However, there is a complication, which comes in two flavours: (1) USB devices can be
removed at any time; (2) USB modules can be removed at any time.  Of course, (2) is
not essential, but it is a nice feature.  Typically it works by having the module
deregister itself from the USB subsystem in its exit method, which causes the USB
subsystem to logically disconnect all its devices, so this is a variant of (1).
Imagine that the kernel thread is busy running code inside the speedtch module when
the user tries to remove the module.  This is handled by having the device
disconnect logic shoot down the kernel thread if it is running (by sending it
a signal), and then waiting for it to complete before returning.  Summary: it
must be possible to shoot down the kernel thread and wait for it to finish.  This
requirement could be dropped, but then the module would not always be unloadable.

Finally, why have one thread per device, rather than a shared thread?  This is
because the usbatm core can manage an arbitrary number of independent modems,
so it seems logically correct to have their initialisations be independent, rather
than have them be serialised due to use of a common kernel thread.  You could fairly
consider this to be overengineering, since in practice 99.9% of users have only
one modem.  On the other hand, if there is one modem then having one thread per
modem is equivalent to having just one thread!  At least one person on the planet
has two modems (guess who, cough cough) and they both get "plugged in" at the
same time: at system boot, when the USB subsystem starts.  It seems a pity not
to have them upload firmware in parallel.

In short, in almost all cases the thread starts, runs, and exits by itself.
However it must also be possible to shoot it down and wait for it to finish.


Why the kthread API is not appropriate.  I said above that "a few things leap
out", but in fact only one thing leaps out.  But it's a fairly bad thing:

As far as I can see, the way to shoot down a kthread is by calling kthread_stop.
However, the documentation for kthread_stop says:

 * Sets kthread_should_stop() for @k to return true, wakes it, and
 * waits for it to exit.  Your threadfn() must not call do_exit()
 * itself if you use this function!  This can also be called after
 * kthread_create() instead of calling wake_up_process(): the thread
 * will exit without calling threadfn().

This is perfect, except for the fact that it explicitly says that the kthread
cannot exit by itself.  But in almost all cases our kthread wants to exit by
itself.  How to do this?  Clearly it can't call kthread_stop on itself.  It could
cause kthread_stop to be called from a workqueue (barf), but then there is the risk
that kthread_stop could be called twice, once from the workqueue, once from the
device disconnect method.  I'm not sure if that is a big no-no, but it looks like
it could be.  Maybe I've misunderstood the kthread API - please feel free to enlighten
me.

Perhaps there were some other issues, but I don't recall what they were.


Maybe a workqueue is the right solution.  I did consider this, but rejected it
for some reason which I can't remember.  I've just been rummaging through the
workqueue code and I can't see any immediate problem.  Hmmm, how do you send a
signal to the workqueue thread?

All the best,

Duncan.

> Note2: all this is a bit odd and I don't have hardware, Duncan or David,
> could you give it a try?
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/drivers/usb/atm/usbatm.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/atm/usbatm.c	2006-02-04 13:35:01.000000000 +0100
> +++ linux-2.6/drivers/usb/atm/usbatm.c	2006-02-14 18:08:04.000000000 +0100
> @@ -75,6 +75,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/proc_fs.h>
>  #include <linux/sched.h>
> +#include <linux/kthread.h>
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/smp_lock.h>
> @@ -999,38 +1000,24 @@
>  	struct usbatm_data *instance = arg;
>  	int ret;
>  
> -	daemonize(instance->driver->driver_name);
> -	allow_signal(SIGTERM);
> -
> -	complete(&instance->thread_started);
> -
>  	ret = instance->driver->heavy_init(instance, instance->usb_intf);
> -
>  	if (!ret)
>  		ret = usbatm_atm_init(instance);
> -
> -	mutex_lock(&instance->serialize);
> -	instance->thread_pid = -1;
> -	mutex_unlock(&instance->serialize);
> -
> -	complete_and_exit(&instance->thread_exited, ret);
> +	return 0;
>  }
>  
>  static int usbatm_heavy_init(struct usbatm_data *instance)
>  {
> -	int ret = kernel_thread(usbatm_do_heavy_init, instance, CLONE_KERNEL);
> +	int ret;
>  
> -	if (ret < 0) {
> -		usb_err(instance, "%s: failed to create kernel_thread (%d)!\n", __func__, ret);
> +	instance->thread = kthread_run(usbatm_do_heavy_init, instance, "%s",
> +			instance->driver->driver_name);
> +	if (IS_ERR(instance->thread)) {
> +		ret = PTR_ERR(instance->thread);
> +		usb_err(instance, "%s: failed to create kernel thread (%d)!\n", __func__, ret);
>  		return ret;
>  	}
>  
> -	mutex_lock(&instance->serialize);
> -	instance->thread_pid = ret;
> -	mutex_unlock(&instance->serialize);
> -
> -	wait_for_completion(&instance->thread_started);
> -
>  	return 0;
>  }
>  
> @@ -1112,10 +1099,6 @@
>  	kref_init(&instance->refcount);		/* dropped in usbatm_usb_disconnect */
>  	mutex_init(&instance->serialize);
>  
> -	instance->thread_pid = -1;
> -	init_completion(&instance->thread_started);
> -	init_completion(&instance->thread_exited);
> -
>  	INIT_LIST_HEAD(&instance->vcc_list);
>  	skb_queue_head_init(&instance->sndqueue);
>  
> @@ -1227,7 +1210,6 @@
>  	if (!(instance->flags & UDSL_SKIP_HEAVY_INIT) && driver->heavy_init) {
>  		error = usbatm_heavy_init(instance);
>  	} else {
> -		complete(&instance->thread_exited);	/* pretend that heavy_init was run */
>  		error = usbatm_atm_init(instance);
>  	}
>  
> @@ -1275,12 +1257,10 @@
>  
>  	mutex_lock(&instance->serialize);
>  	instance->disconnected = 1;
> -	if (instance->thread_pid >= 0)
> -		kill_proc(instance->thread_pid, SIGTERM, 1);
> +	if (instance->thread);
> +		kthread_stop(instance->thread);
>  	mutex_unlock(&instance->serialize);
>  
> -	wait_for_completion(&instance->thread_exited);
> -
>  	mutex_lock(&instance->serialize);
>  	list_for_each_entry(vcc_data, &instance->vcc_list, list)
>  		vcc_release_async(vcc_data->vcc, -EPIPE);
> Index: linux-2.6/drivers/usb/atm/usbatm.h
> ===================================================================
> --- linux-2.6.orig/drivers/usb/atm/usbatm.h	2006-02-04 13:35:01.000000000 +0100
> +++ linux-2.6/drivers/usb/atm/usbatm.h	2006-02-14 18:07:11.000000000 +0100
> @@ -176,9 +176,7 @@
>  	int disconnected;
>  
>  	/* heavy init */
> -	int thread_pid;
> -	struct completion thread_started;
> -	struct completion thread_exited;
> +	struct task_struct *thread;
>  
>  	/* ATM device */
>  	struct list_head vcc_list;
> 
> 
