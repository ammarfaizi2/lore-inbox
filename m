Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318661AbSIKKmy>; Wed, 11 Sep 2002 06:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSIKKmy>; Wed, 11 Sep 2002 06:42:54 -0400
Received: from angband.namesys.com ([212.16.7.85]:2432 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318661AbSIKKmx>; Wed, 11 Sep 2002 06:42:53 -0400
Date: Wed, 11 Sep 2002 14:47:40 +0400
From: Oleg Drokin <green@namesys.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911144740.A911@namesys.com>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain> <20020911120551.A937@namesys.com> <20020911102507.GA1364@suse.de> <20020911102926.GB1364@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020911102926.GB1364@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 12:29:26PM +0200, Jens Axboe wrote:

> > ok I see the bug. it's due to the imbalanced nature of ide_map_buffer()
> > vs ide_unmap_buffer(). i'll cook up a fix right away.
> Does this make it work?

No. It fails exactly like without the patch.

> --- include/linux/ide.h~	2002-09-11 12:27:14.000000000 +0200
> +++ include/linux/ide.h	2002-09-11 12:27:29.000000000 +0200
> @@ -597,9 +597,10 @@
>  	return rq->buffer + task_rq_offset(rq);
>  }
>  
> -extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
> +extern inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
>  {
> -	bio_kunmap_irq(buffer, flags);
> +	if (rq->bio)
> +		bio_kunmap_irq(buffer, flags);
>  }
>  
>  /*

Perhaps you forgot to make sure rq->bio is zeroed on unmapping/freeing?

Bye,
    Oleg
