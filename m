Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313062AbSDOHiu>; Mon, 15 Apr 2002 03:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSDOHit>; Mon, 15 Apr 2002 03:38:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313062AbSDOHit>;
	Mon, 15 Apr 2002 03:38:49 -0400
Message-ID: <3CBA835D.484DB0B1@zip.com.au>
Date: Mon, 15 Apr 2002 00:38:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hugang <gang_hu@soul.com.cn>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] kmem_cache_grow.
In-Reply-To: <20020415144048.37318357.gang_hu@soul.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugang wrote:
> 
> Hell all:
> 
> Problem: first run "find /" , eject and insert pcmcia network's card, the kernel will crash.
> 
> Kernel oops: at
> linux/mm/slab.c->kmem_cache_grow.
>         if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
>                 BUG();          <-- here.

Known problem, I'm afraid.  The PCMCIA Card Services layer
in a number of places is doing stuff from inside a timer
handler which it should not be.

> Can I remove this check ?

It's best not to, really.  It'll probably appear to have
worked but your kernel could still fail in mysterious ways,
much later, very occasionally.

If you're using devfs, you could try disabling that.  Not
that this is a devfs bug, but disabling devfs reduces 
the number of functions which the buggy drivers call at
timer-interrupt time.

The bottom line is that we have a pcmcia_cs staffing shortage.
Somebody needs to go in, pull out the timers, use schedule_task().

-
