Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283558AbRLDWRd>; Tue, 4 Dec 2001 17:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283559AbRLDWRZ>; Tue, 4 Dec 2001 17:17:25 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:47257 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S283558AbRLDWRP> convert rfc822-to-8bit; Tue, 4 Dec 2001 17:17:15 -0500
Date: Tue, 4 Dec 2001 20:23:49 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make ncr53c8xx work with bio.
In-Reply-To: <20011204133520.A3760@suse.de>
Message-ID: <20011204195646.H3044-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

Indeed the patch does make the ncr53c8xx driver compile and work again.
If Linus accepts to apply your patch, this will be just fine.

However, the question about still having ncr53c8xx and may-be sym53c8xx
version 1 in linux-2.5, given that sym-2 can, at least in theory, replaces
both, is not yet answered.

Anyway, at minimal, these drivers should get made conformant to eh
expectations and also modified as follows:

- Remove the double spin_locking.

- Remove the batching of completions prior to give them back to upper
  layer. This is useless given that no recursive call can happen and
  such batching is done by scsi layer thanks to forced new eh.

Such changes are easy to make, at least by me, and I will propose them if
it gets proven that these drivers versions are still useful for linux-2.5.
This depends obviously on the actual reliability of sym-2 compared to the
bundle ncr53c8xx/sym53c8xx. Only practice can give the right answer.

In the meantime, maintaining these drivers at minimal compilable and
working is certainly a good thing.

  Gérard.

On Tue, 4 Dec 2001, Dave Jones wrote:

> Hi folks,
>  Patch below makes ncr53c8xx driver compile again in 2.5.1pre5.
>  Seems to have survived yesterdays torture tests.
>
> regards,
> Dave.
>
> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/scsi/ncr53c8xx.c linux-dj/drivers/scsi/ncr53c8xx.c
> --- linux/drivers/scsi/ncr53c8xx.c	Sun Sep 30 20:26:07 2001
> +++ linux-dj/drivers/scsi/ncr53c8xx.c	Mon Dec  3 16:44:11 2001
> @@ -8625,9 +8625,9 @@
>       if (DEBUG_FLAGS & DEBUG_TINY) printk ("]\n");
>
>       if (done_list) {
> -          NCR_LOCK_SCSI_DONE(np, flags);
> +          NCR_LOCK_SCSI_DONE(done_list->host, flags);
>            ncr_flush_done_cmds(done_list);
> -          NCR_UNLOCK_SCSI_DONE(np, flags);
> +          NCR_UNLOCK_SCSI_DONE(done_list->host, flags);
>       }
>  }
>
> @@ -8648,9 +8648,9 @@
>       NCR_UNLOCK_NCB(np, flags);
>
>       if (done_list) {
> -          NCR_LOCK_SCSI_DONE(np, flags);
> +          NCR_LOCK_SCSI_DONE(done_list->host, flags);
>            ncr_flush_done_cmds(done_list);
> -          NCR_UNLOCK_SCSI_DONE(np, flags);
> +          NCR_UNLOCK_SCSI_DONE(done_list->host, flags);
>       }
>  }
>
> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/scsi/sym53c8xx_comm.h linux-dj/drivers/scsi/sym53c8xx_comm.h
> --- linux/drivers/scsi/sym53c8xx_comm.h	Fri Oct 12 23:35:54 2001
> +++ linux-dj/drivers/scsi/sym53c8xx_comm.h	Mon Dec  3 16:43:38 2001
> @@ -438,10 +438,10 @@
>  #define	NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
>  #define	NCR_UNLOCK_NCB(np, flags)  spin_unlock_irqrestore(&np->smp_lock, flags)
>
> -#define	NCR_LOCK_SCSI_DONE(np, flags) \
> -		spin_lock_irqsave(&io_request_lock, flags)
> -#define	NCR_UNLOCK_SCSI_DONE(np, flags) \
> -		spin_unlock_irqrestore(&io_request_lock, flags)
> +#define	NCR_LOCK_SCSI_DONE(host, flags) \
> +		spin_lock_irqsave(&(host)->host_lock, flags)
> +#define	NCR_UNLOCK_SCSI_DONE(host, flags) \
> +		spin_unlock_irqrestore(&((host)->host_lock), flags)
>
>  #else
>
> @@ -452,8 +452,8 @@
>  #define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
>  #define	NCR_UNLOCK_NCB(np, flags)  do { restore_flags(flags); } while (0)
>
> -#define	NCR_LOCK_SCSI_DONE(np, flags)    do {;} while (0)
> -#define	NCR_UNLOCK_SCSI_DONE(np, flags)  do {;} while (0)
> +#define	NCR_LOCK_SCSI_DONE(host, flags)    do {;} while (0)
> +#define	NCR_UNLOCK_SCSI_DONE(host, flags)  do {;} while (0)
>
>  #endif
>
>
> --
> | Dave Jones.                    http://www.codemonkey.org.uk
> | SuSE Labs .
>
>

