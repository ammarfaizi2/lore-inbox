Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285481AbRLNTlH>; Fri, 14 Dec 2001 14:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285475AbRLNTks>; Fri, 14 Dec 2001 14:40:48 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:23841 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S285481AbRLNTkm> convert rfc822-to-8bit; Fri, 14 Dec 2001 14:40:42 -0500
Date: Fri, 14 Dec 2001 17:46:37 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: =?iso-8859-1?q?Kirk=20Alexander?= <kirkalx@yahoo.co.nz>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20011214041151.91557.qmail@web14904.mail.yahoo.com>
Message-ID: <20011214172419.Q1591-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Dec 2001, Kirk Alexander wrote:

> [cc'ed to lkml and Gerard Roudier]
>
> Hi Jens,
>
> You asked people to send in reports of which drivers
> were broken by the removal of io_request_lock.
>
> My system is a clunky old Digital Pentium Pro with a
> NCR53c810 rev 2 scsi controller, so it can't use the
> sym driver.

Use sym53c8xx_2 instead. This one uses 2 different firmwares,

- one based on sym53c8xx driver scripts called
  'LOAD/STORE based' firmware,
- and another one that only uses generic scripts instructions
  and called 'GENERIC' firmware.

The GENERIC firmware has worked for me witn a 810 rev. 2.

I haven't this controller installed at the moment, but I can test the
driver by forcing the driver to use the GENERIC scripts instead for any
symbios chip.

You may let me know if sym53c8xx_2 still works with 810 rev 2.

> I fixed the problem by seeing what the sym
> driver did i.e. the patch below
> This may not be right at all, and I haven't had a
> chance to boot the kernel - but it did build OK.

The ncr53c8xx and sym53c8xx version 1 use the obsolete scsi eh handling.
Moving the eh code from sym53c8xx_2 (version 2) to ncr53c8xx/sym53c8xx is
quite feasible, but may-be it is just useless given sym53c8xx_2. For now,
it seems that sym53c8xx_2 replaces both ncr/sym53c8xx without any loss of
reliability and performance.

  Gérard.

> Cheers,
> Kirk Alexander
>
> P.S.
> Please excuse me if this has already been fixed or
> posted, or if I've broken some lkml etiquette - first
> post I think after lurking off and on for ages. Also
> first time I've compiled a kernel that has only been
> out a few days!

You are welcome and you didn't break any etiquette. The lkml is a very
open mailing list but it gets more than 200 postings a day. Thus the
linux-scsi@vger.kernel.org list should be preferred for topics that
address scsi specifically.


> --- linux/drivers/scsi/sym53c8xx_comm.h	Fri Dec 14
> 16:46:45 2001
> +++ linux/drivers/scsi/sym53c8xx_comm.h	Fri Dec 14
> 16:49:19 2001
> @@ -438,11 +438,20 @@
>  #define	NCR_LOCK_NCB(np, flags)
> spin_lock_irqsave(&np->smp_lock, flags)
>  #define	NCR_UNLOCK_NCB(np, flags)
> spin_unlock_irqrestore(&np->smp_lock, flags)
>
> +#if LINUX_VERSION_CODE >= LinuxVersionCode(2,5,0)
> +
> +#define	NCR_LOCK_SCSI_DONE(np, flags) \
> +		spin_lock_irqsave((np)->done_list->host, flags)
> +#define	NCR_UNLOCK_SCSI_DONE(np, flags) \
> +		spin_unlock_irqrestore((np)->done_list->host,
> flags)
> +#else
> +
>  #define	NCR_LOCK_SCSI_DONE(np, flags) \
>  		spin_lock_irqsave(&io_request_lock, flags)
>  #define	NCR_UNLOCK_SCSI_DONE(np, flags) \
>  		spin_unlock_irqrestore(&io_request_lock, flags)
>
> +#endif
>  #else
>
>  #define	NCR_LOCK_DRIVER(flags)     do {
> save_flags(flags); cli(); } while (0)

