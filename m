Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267422AbUGNPwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267422AbUGNPwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUGNPwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:52:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50882 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267419AbUGNPv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:51:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Date: Wed, 14 Jul 2004 17:57:48 +0200
User-Agent: KMail/1.5.3
Cc: dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se>
In-Reply-To: <200407141216.i6ECGHxg008332@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407141757.48937.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wednesday 14 of July 2004 14:16, Mikael Pettersson wrote:
> gcc-3.4.1 errors out in 2.6.8-rc1-mm1 at drivers/scsi/sg.c:
>
> drivers/scsi/sg.c: In function `sg_ioctl':
> drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call to
> 'sg_jif_to_ms': function body not available drivers/scsi/sg.c:930: sorry,
> unimplemented: called from here
> make[2]: *** [drivers/scsi/sg.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
>
> sg_jif_to_ms() is marked inline but used defore its function
> body is available. Moving it nearer the top of sg.c (together
> with sg_ms_to_jif() for consistency) fixes the problem.

While your patch is perfectly fine I think we can do better.
I think that we may try converting sg.c to use jiffies_to_msecs()
and msecs_to_jiffies() from <linux/time.h>.

> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
>
> --- linux-2.6.8-rc1-mm1/drivers/scsi/sg.c.~1~	2004-07-14 12:58:34.000000000
> +0200 +++ linux-2.6.8-rc1-mm1/drivers/scsi/sg.c	2004-07-14
> 13:45:26.000000000 +0200 @@ -225,6 +225,30 @@
>  #define SZ_SG_REQ_INFO sizeof(sg_req_info_t)
>
>  static int
> +sg_ms_to_jif(unsigned int msecs)
> +{
> +	if ((UINT_MAX / 2U) < msecs)
> +		return INT_MAX;	/* special case, set largest possible */

I don't understand what for is this special case.

> +	else
> +		return ((int) msecs <
> +			(INT_MAX / 1000)) ? (((int) msecs * HZ) / 1000)
> +		    : (((int) msecs / 1000) * HZ);
> +}

jiffies are unsigned long, isn't this buggy on 64-bit archs?

> +static inline unsigned
> +sg_jif_to_ms(int jifs)
> +{

ditto

> +	if (jifs <= 0)
> +		return 0U;
> +	else {
> +		unsigned int j = (unsigned int) jifs;
> +		return (j <
> +			(UINT_MAX / 1000)) ? ((j * 1000) / HZ) : ((j / HZ) *
> +								  1000);
> +	}
> +}

also rounding up is missing (jiffies_to_msecs()/msecs_to_jiffies() does it)

Bartlomiej

