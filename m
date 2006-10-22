Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWJVLqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWJVLqz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 07:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWJVLqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 07:46:55 -0400
Received: from as3.cineca.com ([130.186.84.211]:55184 "EHLO as3.cineca.com")
	by vger.kernel.org with ESMTP id S1751776AbWJVLqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 07:46:55 -0400
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sn9c10x list corruption in 2.6.18.1
Date: Sun, 22 Oct 2006 13:46:52 +0200
User-Agent: KMail/1.9.1
References: <20061022031145.GA24855@redhat.com>
In-Reply-To: <20061022031145.GA24855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221346.53038.luca.risolia@studio.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave.

> I found one area in the driver where we do list manipulation without any locking,
> but I'm not entirely convinced that this is the source of the bug yet.

Spinlocks are not necessary there, becouse that piece of code is already
isolated when running, to prevent concurrent accesses to the list from within 
the irq handler. The bug should be elsewhere (probably not in the driver).

Best regards
Luca


> > --- linux-2.6.18.noarch/drivers/media/video/sn9c102/sn9c102_core.c~	2006-10-21 22:57:32.000000000 -0400
> +++ linux-2.6.18.noarch/drivers/media/video/sn9c102/sn9c102_core.c	2006-10-21 22:58:43.000000000 -0400
> @@ -197,13 +197,16 @@ static void sn9c102_empty_framequeues(st
>  static void sn9c102_requeue_outqueue(struct sn9c102_device* cam)
>  {
>  	struct sn9c102_frame_t *i;
> +	unsigned long lock_flags;
>  
> +	spin_lock_irqsave(&cam->queue_lock, lock_flags);
>  	list_for_each_entry(i, &cam->outqueue, frame) {
>  		i->state = F_QUEUED;
>  		list_add(&i->frame, &cam->inqueue);
>  	}
>  
>  	INIT_LIST_HEAD(&cam->outqueue);
> +	spin_unlock_irqrestore(&cam->queue_lock, lock_flags);
>  }
