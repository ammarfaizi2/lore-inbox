Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422714AbWBNThX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWBNThX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWBNThX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:37:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10771 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422714AbWBNThW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:37:22 -0500
Date: Tue, 14 Feb 2006 19:37:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: use kthread_ API
Message-ID: <20060214193713.GA9435@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20060214175016.GA19080@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214175016.GA19080@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 06:50:16PM +0100, Christoph Hellwig wrote:
> Use the kthread_ API instead of opencoding lots of hairy code for kernel
> thread creation and teardown.
> 
> Also use wake_up_process instead of an additional per-socket waitqueue.

Nack.  This breaks an error path - look at what happens when we fail to
register a socket - we set socket->thread to NULL and exit.   That is
then picked up by the "socket thread for socket %p did not start" code
which you decided to remove.

IOW, this introduces bugs into what was bug free code.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Index: linux-2.6/drivers/pcmcia/cs.c
> ===================================================================
> --- linux-2.6.orig/drivers/pcmcia/cs.c	2006-01-06 10:44:16.000000000 +0100
> +++ linux-2.6/drivers/pcmcia/cs.c	2006-02-14 18:34:14.000000000 +0100
> @@ -29,6 +29,7 @@
>  #include <linux/pm.h>
>  #include <linux/pci.h>
>  #include <linux/device.h>
> +#include <linux/kthread.h>
>  #include <asm/system.h>
>  #include <asm/irq.h>
>  
> @@ -235,22 +236,16 @@
>  	INIT_LIST_HEAD(&socket->cis_cache);
>  
>  	init_completion(&socket->socket_released);
> -	init_completion(&socket->thread_done);
> -	init_waitqueue_head(&socket->thread_wait);
>  	init_MUTEX(&socket->skt_sem);
>  	spin_lock_init(&socket->thread_lock);
>  
> -	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
> -	if (ret < 0)
> +	socket->thread = kthread_run(pccardd, socket, "pccardd");
> +	if (IS_ERR(socket->thread)) {
> +		ret = PTR_ERR(socket->thread);
>  		goto err;
> -
> -	wait_for_completion(&socket->thread_done);
> -	if(!socket->thread) {
> -		printk(KERN_WARNING "PCMCIA: warning: socket thread for socket %p did not start\n", socket);
> -		return -EIO;
>  	}
> -	pcmcia_parse_events(socket, SS_DETECT);
>  
> +	pcmcia_parse_events(socket, SS_DETECT);
>  	return 0;
>  
>   err:
> @@ -273,10 +268,8 @@
>  	cs_dbg(socket, 0, "pcmcia_unregister_socket(0x%p)\n", socket->ops);
>  
>  	if (socket->thread) {
> -		init_completion(&socket->thread_done);
> +		kthread_stop(socket->thread);
>  		socket->thread = NULL;
> -		wake_up(&socket->thread_wait);
> -		wait_for_completion(&socket->thread_done);
>  	}
>  	release_cis_mem(socket);
>  
> @@ -630,12 +623,8 @@
>  static int pccardd(void *__skt)
>  {
>  	struct pcmcia_socket *skt = __skt;
> -	DECLARE_WAITQUEUE(wait, current);
>  	int ret;
>  
> -	daemonize("pccardd");
> -
> -	skt->thread = current;
>  	skt->socket = dead_socket;
>  	skt->ops->init(skt);
>  	skt->ops->set_socket(skt, &skt->socket);
> @@ -645,13 +634,9 @@
>  	if (ret) {
>  		printk(KERN_WARNING "PCMCIA: unable to register socket 0x%p\n",
>  			skt);
> -		skt->thread = NULL;
> -		complete_and_exit(&skt->thread_done, 0);
> +		return 0;
>  	}
>  
> -	add_wait_queue(&skt->thread_wait, &wait);
> -	complete(&skt->thread_done);
> -
>  	for (;;) {
>  		unsigned long flags;
>  		unsigned int events;
> @@ -677,7 +662,7 @@
>  			continue;
>  		}
>  
> -		if (!skt->thread)
> +		if (!kthread_should_stop())
>  			break;
>  
>  		schedule();
> @@ -686,12 +671,10 @@
>  	/* make sure we are running before we exit */
>  	set_current_state(TASK_RUNNING);
>  
> -	remove_wait_queue(&skt->thread_wait, &wait);
> -
>  	/* remove from the device core */
>  	class_device_unregister(&skt->dev);
>  
> -	complete_and_exit(&skt->thread_done, 0);
> +	return 0;
>  }
>  
>  /*
> @@ -706,7 +689,7 @@
>  		s->thread_events |= events;
>  		spin_unlock(&s->thread_lock);
>  
> -		wake_up(&s->thread_wait);
> +		wake_up_process(s->thread);
>  	}
>  } /* pcmcia_parse_events */
>  EXPORT_SYMBOL(pcmcia_parse_events);
> Index: linux-2.6/include/pcmcia/ss.h
> ===================================================================
> --- linux-2.6.orig/include/pcmcia/ss.h	2006-01-06 10:44:17.000000000 +0100
> +++ linux-2.6/include/pcmcia/ss.h	2006-02-14 18:32:41.000000000 +0100
> @@ -244,8 +244,6 @@
>  	struct semaphore		skt_sem;	/* protects socket h/w state */
>  
>  	struct task_struct		*thread;
> -	struct completion		thread_done;
> -	wait_queue_head_t		thread_wait;
>  	spinlock_t			thread_lock;	/* protects thread_events */
>  	unsigned int			thread_events;
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
