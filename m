Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVLCB3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVLCB3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVLCB3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:29:45 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:102 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750770AbVLCB3o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:29:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WB7lKqztKli3Rq209eQcCvLUF3Joahs/BsxnV+Tltm0DtlcXk/4h2MYybPgp04KYMdQqVerSgtvToFXQbcqN8LXaGWmkE65R8skb6CDEBHSLFryd8zSQMkckuM6en3mjcg7A6FFCe1/cE3P/zaXbQfoLBKH83ZVPfYxLpkoB1lw=
Message-ID: <9a8748490512021729t145291c0h8ba5b8bdb0513d9e@mail.gmail.com>
Date: Sat, 3 Dec 2005 02:29:43 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] touch softlockup watchdog in ide_wait_not_busy
In-Reply-To: <200511291555.27202.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511291555.27202.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Now that Alexander confirmed this patch fixed his problem, any reason
it couldn't go into -mm ?

He gave this feedback :
On 11/30/05, Alexander V. Inyukhin <shurick@sectorb.msk.ru> wrote:
...
> It seems to work.
> I have no BUG messages during boot with this patch.


/Jesper


On 11/29/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Hi,
>
> This is a resend of a patch I proposed in the
> "[BUG] 2.6.15-rc1, soft lockup detected while probing IDE devices on AMD7441"
> thread.
> I recieved no ACK/NACK or other feedback on the patch, so I'm resending it in
> the hope of getting some comments :)
>
>
> From: Jesper Juhl <jesper.juhl@gmail.com>
>
> Make sure we touch the softlockup watchdog in
> ide_wait_not_busy() since it may cause the watchdog to trigger, but
> there's really no point in that since the loop will eventually return, and
> triggering the watchdog won't do us any good anyway.
>
> The  if (!(timeout % 128))  bit is a guess that since
> touch_softlockup_watchdog() is a per_cpu thing it will be cheaper to do the
> modulo calculation than calling the function every time through the loop,
> especially as the nr of CPU's go up. But it's purely a guess, so I may very
> well be wrong - also, 128 is an arbitrarily chosen value, it's just a nice
> number that'll give us <10 function calls pr second.
>
> Since I have no IDE devices in my box I'm unable to test this beyond making
> sure it compiles without warnings or errors (which it does).
>
> Let me know what you think.
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  drivers/ide/ide-iops.c |    8 ++++++++
>  1 files changed, 8 insertions(+)
>
> diff -up linux-2.6.15-rc3-orig/drivers/ide/ide-iops.c linux-2.6.15-rc3/drivers/ide/ide-iops.c
> --- linux-2.6.15-rc3-orig/drivers/ide/ide-iops.c        2005-11-29 15:30:32.000000000 +0100
> +++ linux-2.6.15-rc3/drivers/ide/ide-iops.c     2005-11-29 15:44:23.000000000 +0100
> @@ -24,6 +24,7 @@
>  #include <linux/hdreg.h>
>  #include <linux/ide.h>
>  #include <linux/bitops.h>
> +#include <linux/sched.h>
>
>  #include <asm/byteorder.h>
>  #include <asm/irq.h>
> @@ -1243,6 +1244,13 @@ int ide_wait_not_busy(ide_hwif_t *hwif,
>                  */
>                 if (stat == 0xff)
>                         return -ENODEV;
> +
> +               /*
> +                * We risk triggering the soft lockup detector, but we don't
> +                * want that, so better poke it a bit once in a while.
> +                */
> +               if (!(timeout % 128))
> +                       touch_softlockup_watchdog();
>         }
>         return -EBUSY;
>  }
>
>
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
