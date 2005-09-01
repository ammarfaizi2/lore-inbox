Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVIADTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVIADTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVIADTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:19:40 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:50520 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965055AbVIADTk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:19:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OgRm0QfhF6pRZJzIIz0gYLLjxgS+m0TSA79aedD+wBckroZUcI7onItSqvchVugnqGkAom/RmQZCwSBRUtN88erhKKlQwhH49bduXdLAMRcUBZ9pFZUl998CQ93cWN1YSUErUNJcTeDUxiTE1UqTx9BIgY5APtGOodfDsg6U268=
Message-ID: <67029b170508312019258cd244@mail.gmail.com>
Date: Thu, 1 Sep 2005 11:19:35 +0800
From: Zhou Yingchao <yingchao.zhou@gmail.com>
To: jmerkey@utah-nac.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <67029b1705083120142c0c1dea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EAd1J-0007Cw-00@calista.eckenfels.6bone.ka-ip.net>
	 <431651BC.9020108@utah-nac.org> <43165CE3.9080704@utah-nac.org>
	 <67029b1705083120142c0c1dea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/1, jmerkey <jmerkey@utah-nac.org>:
> Bernd,
>
> It might be helpful for someone to look at these sections of code I had
> to patch in 2.6.9.
> I discovered a case where the kernel scheduler will pass NULL for the
> array argument
> when I started hitting the extreme upper range > 200MB/S combined disk
> and lan
> throughput.  This was running with preemptible kernel and hyperthreading
> enabled.
>
> The wheels come off in the kernel somewhere.  I looked at later 2.6
> kernels and there's
> been some changes, but someone may get an ah ha from this fix, if there
> is an underlying
> problem in the kernel.
>
> Jeff
>
>
>  static void dequeue_task(struct task_struct *p, prio_array_t *array)
>  {
> -    array->nr_active--;
> -    list_del(&p->run_list);
> -    if (list_empty(array->queue + p->prio))
> -        __clear_bit(p->prio, array->bitmap);
> +        if (!array)
> +           printk("WARN:  prio_array was NULL in dequeue task %08X"
> +                  "pid-%d\n", (unsigned)p, (int)p->pid);
> +
> +        if (array)
> +        {
> +       array->nr_active--;
> +       list_del(&p->run_list);
> +       if (list_empty(array->queue + p->prio))
> +           __clear_bit(p->prio, array->bitmap);
> +        }
>  }
>
>
> static void deactivate_task(struct task_struct *p, runqueue_t *rq)
>  {
> -    rq->nr_running--;
> -    if (p->state == TASK_UNINTERRUPTIBLE)
> -        rq->nr_uninterruptible++;
> -    dequeue_task(p, p->array);
> -    p->array = NULL;
> +        if (!p->array)
> +           printk("WARN:  prio_array was NULL in deactivate task %08X"
> +                  "pid-%d\n", (unsigned)p, (int)p->pid);
> +
> +        if (p->array)
> +        {
> +       rq->nr_running--;
> +       if (p->state == TASK_UNINTERRUPTIBLE)
> +           rq->nr_uninterruptible++;
> +       dequeue_task(p, p->array);
> +       p->array = NULL;
> +        }
>  }
>

 I think a BUG_ON(!array) should be there to cache the call trace. I
think there are bugs on the call trace. The codes you add will only
resolve the problem in an exterior way.
