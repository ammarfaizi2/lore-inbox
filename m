Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVHZLpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVHZLpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 07:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVHZLpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 07:45:11 -0400
Received: from verein.lst.de ([213.95.11.210]:50657 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965024AbVHZLpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 07:45:09 -0400
Date: Fri, 26 Aug 2005 13:44:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Howard <ghoward@sgi.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] Standardize shutdown of the system from enviroment control modules
Message-ID: <20050826114453.GA28115@lst.de>
References: <20050809211003.GA29361@lst.de> <20050811173717.GA10420@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811173717.GA10420@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 07:37:17PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 09, 2005 at 11:10:03PM +0200, Christoph Hellwig wrote:
> > Currently snsc_event for Altix systems sends SIGPWR to init (and abuses
> > tasklist_lock..) while the sbus drivers call execve for /sbin/shutdown
> > (which is also ugly, it should at least use call_usermodehelper)
> > With normal sysvinit both will end up the same, but I suspect the
> > shutdown variant, maybe with a sysctl to chose the exact path to call
> > would be cleaner.  What do you guys think about adding a common function
> > to do this.  Could you test such a patch for me?
> 
> Okay, here's such a patch, I've also switched the SN and the two sbus
> drivers over.

ping?

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/drivers/char/snsc_event.c
> ===================================================================
> --- linux-2.6.orig/drivers/char/snsc_event.c	2005-08-11 16:45:55.000000000 +0200
> +++ linux-2.6/drivers/char/snsc_event.c	2005-08-11 19:03:59.000000000 +0200
> @@ -195,24 +195,7 @@
>  	severity = scdrv_event_severity(code);
>  
>  	if ((code & EV_CLASS_MASK) == EV_CLASS_PWRD_NOTIFY) {
> -		struct task_struct *p;
> -
> -		/* give a SIGPWR signal to init proc */
> -
> -		/* first find init's task */
> -		read_lock(&tasklist_lock);
> -		for_each_process(p) {
> -			if (p->pid == 1)
> -				break;
> -		}
> -		if (p) { /* we found init's task */
> -			printk(KERN_EMERG "Power off indication received. Initiating power fail sequence...\n");
> -			force_sig(SIGPWR, p);
> -		} else { /* failed to find init's task - just give message(s) */
> -			printk(KERN_WARNING "Failed to find init proc to handle power off!\n");
> -			printk("%s|$(0x%x)%s\n", severity, esp_code, desc);
> -		}
> -		read_unlock(&tasklist_lock);
> +		envctrl_do_shutdown();
>  	} else {
>  		/* print to system log */
>  		printk("%s|$(0x%x)%s\n", severity, esp_code, desc);
> Index: linux-2.6/drivers/sbus/char/bbc_envctrl.c
> ===================================================================
> --- linux-2.6.orig/drivers/sbus/char/bbc_envctrl.c	2005-08-11 16:45:59.000000000 +0200
> +++ linux-2.6/drivers/sbus/char/bbc_envctrl.c	2005-08-11 19:01:44.000000000 +0200
> @@ -4,13 +4,12 @@
>   * Copyright (C) 2001 David S. Miller (davem@redhat.com)
>   */
>  
> -#define __KERNEL_SYSCALLS__
> -
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/envctrl.h>
>  #include <asm/oplib.h>
>  #include <asm/ebus.h>
>  static int errno;
> @@ -176,8 +175,6 @@
>  static void do_envctrl_shutdown(struct bbc_cpu_temperature *tp)
>  {
>  	static int shutting_down = 0;
> -	static char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> -	char *argv[] = { "/sbin/shutdown", "-h", "now", NULL };
>  	char *type = "???";
>  	s8 val = -1;
>  
> @@ -201,8 +198,8 @@
>  	printk(KERN_CRIT "kenvctrld: Shutting down the system now.\n");
>  
>  	shutting_down = 1;
> -	if (execve("/sbin/shutdown", argv, envp) < 0)
> -		printk(KERN_CRIT "envctrl: shutdown execution failed\n");
> +
> +	envctrl_do_shutdown();
>  }
>  
>  #define WARN_INTERVAL	(30 * HZ)
> Index: linux-2.6/drivers/sbus/char/envctrl.c
> ===================================================================
> --- linux-2.6.orig/drivers/sbus/char/envctrl.c	2005-08-11 16:45:59.000000000 +0200
> +++ linux-2.6/drivers/sbus/char/envctrl.c	2005-08-11 19:01:57.000000000 +0200
> @@ -19,8 +19,6 @@
>   *              Daniele Bellucci <bellucda@tiscali.it>
>   */
>  
> -#define __KERNEL_SYSCALLS__
> -
>  #include <linux/config.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
> @@ -33,6 +31,7 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> +#include <linux/envctrl.h>
>  
>  #include <asm/ebus.h>
>  #include <asm/uaccess.h>
> @@ -975,25 +974,6 @@
>  	return NULL;
>  }
>  
> -static void envctrl_do_shutdown(void)
> -{
> -	static int inprog = 0;
> -	static char *envp[] = {	
> -		"HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> -	char *argv[] = { 
> -		"/sbin/shutdown", "-h", "now", NULL };	
> -
> -	if (inprog != 0)
> -		return;
> -
> -	inprog = 1;
> -	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
> -	if (0 > execve("/sbin/shutdown", argv, envp)) {
> -		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
> -		inprog = 0;  /* unlikely to succeed, but we could try again */
> -	}
> -}
> -
>  static struct task_struct *kenvctrld_task;
>  
>  static int kenvctrld(void *__unused)
> Index: linux-2.6/include/linux/envctrl.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/include/linux/envctrl.h	2005-08-11 18:58:41.000000000 +0200
> @@ -0,0 +1,6 @@
> +#ifndef _LINUX_ENVCTRL_H
> +#define _LINUX_ENVCTRL_H
> +
> +extern int envctrl_do_shutdown(void);
> +
> +#endif /* _LINUX_ENVCTRL_H */
> Index: linux-2.6/kernel/Makefile
> ===================================================================
> --- linux-2.6.orig/kernel/Makefile	2005-08-11 16:46:07.000000000 +0200
> +++ linux-2.6/kernel/Makefile	2005-08-11 18:57:57.000000000 +0200
> @@ -7,7 +7,7 @@
>  	    sysctl.o capability.o ptrace.o timer.o user.o \
>  	    signal.o sys.o kmod.o workqueue.o pid.o \
>  	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
> -	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
> +	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o envctrl.o
>  
>  obj-$(CONFIG_FUTEX) += futex.o
>  obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
> Index: linux-2.6/kernel/envctrl.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/kernel/envctrl.c	2005-08-11 19:04:19.000000000 +0200
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (C) 2001 David S. Miller.
> + * Copyright (C) 2005 Christoph Hellwig.
> + *	Released under GPL v2.
> + *
> + * Common code to shutdown the system when overheating.
> + */
> +
> +#include <linux/envctrl.h>
> +#include <linux/kernel.h>
> +#include <linux/kmod.h>
> +
> +static char *envp[] = {
> +	"HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL
> +};
> +
> +static char *argv[] = {
> +	"/sbin/shutdown", "-h", "now", NULL
> +};
> +
> +/*
> + * envctrl_do_shutdown  -  shut the system down when overheating
> + *
> + * Common routine to be called from all enviromental monitoring
> + * drivers when a fatal overheating is detected.
> + *
> + * Returns 0 if /sbin/shutdown has been called sucessfully, 1 if
> + * this routine has been called already but the kernel is still
> + * running or a negative error value if executing the shutdown
> + * command failed.
> + */
> +int envctrl_do_shutdown(void)
> +{
> +	static int shutting_down = 0;
> +	int error;
> +
> +	if (shutting_down)
> +		return 1;
> +	shutting_down = 1;
> +
> +	printk(KERN_CRIT "envctrl: WARNING: Shutting down the system now.\n");
> +	error = call_usermodehelper("/sbin/shutdown", argv, envp, 0);
> +	if (error)
> +		printk(KERN_CRIT "envctrl: WARNING: system shutdown failed!\n");
> +	return error;
> +}
---end quoted text---
