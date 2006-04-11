Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWDKUmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWDKUmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWDKUmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:42:24 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:64912 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751389AbWDKUmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:42:24 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] tpm: update to use wait_event calls
Date: Tue, 11 Apr 2006 22:40:19 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
References: <1144679848.4917.15.camel@localhost.localdomain> <20060410150324.4dd55994.akpm@osdl.org> <1144786559.12054.15.camel@localhost.localdomain>
In-Reply-To: <1144786559.12054.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112240.20155.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kylene,

On Tuesday, 11. April 2006 22:15, Kylene Jo Hall wrote:
> Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-11 12:18:35.573996500 -0500
> +++ linux-2.6.16-44/drivers/char/tpm/tpm_tis.c	2006-04-11 14:00:04.341229250 -0500
> @@ -95,10 +95,10 @@ static int request_locality(struct tpm_c
>  		 chip->vendor.iobase + TPM_ACCESS(l));
>  
>  	if (chip->vendor.irq) {
> -		interruptible_sleep_on_timeout(&chip->vendor.int_queue,
> -					       HZ *
> -					       chip->vendor.timeout_a /
> -					       1000);
> +		wait_event_interruptible_timeout(chip->vendor.int_queue,
> +						 (check_locality(chip, l) >= 0),
> +						 HZ * chip->vendor.timeout_a /
> +						 1000);
>  		if (check_locality(chip, l) >= 0)
>  			return l;

what about using msecs_to_jiffies(chip->vendor.timeout_a) for this?

>  
> @@ -150,7 +150,7 @@ static int get_burstcount(struct tpm_chi
>  }
>  
>  static int wait_for_stat(struct tpm_chip *chip, u8 mask, u32 timeout,
> -			 wait_queue_head_t * queue)
> +			 wait_queue_head_t *queue)
>  {
>  	unsigned long stop;
>  	u8 status;
> @@ -161,7 +161,10 @@ static int wait_for_stat(struct tpm_chip
>  		return 0;
>  
>  	if (chip->vendor.irq) {
> -		interruptible_sleep_on_timeout(queue, HZ * timeout / 1000);
> +		wait_event_interruptible_timeout(*queue,
> +						 ((tpm_tis_status(chip) &
> +						   mask) == mask),
> +						 HZ * timeout / 1000);
>  		status = tpm_tis_status(chip);
>  		if ((status & mask) == mask)
>  			return 0;

msecs_to_jiffies(timeout)?


Regards

Ingo Oeser
