Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWHDKjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWHDKjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 06:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWHDKjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 06:39:52 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:28635
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751414AbWHDKjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 06:39:51 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer CPUs
Date: Fri, 4 Aug 2006 12:39:12 +0200
User-Agent: KMail/1.9.1
References: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com> <1154627776.23655.106.camel@localhost.localdomain> <20060804065623.GA24404@1wt.eu>
In-Reply-To: <20060804065623.GA24404@1wt.eu>
Cc: Jukka Partanen <jspartanen@gmail.com>, kkeil@suse.de,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041239.13260.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 August 2006 08:56, Willy Tarreau wrote:
> On Thu, Aug 03, 2006 at 06:56:15PM +0100, Alan Cox wrote:
> > Ar Iau, 2006-08-03 am 19:53 +0300, ysgrifennodd Jukka Partanen:
> > > AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
> > > (they are there in 2.6.17.7 too), to fix module initialization
> > > problems appearing with at least some newer Celerons and
> > > Pentium III.
> > 
> > Should be using cpu_relax() I think. Its a polled busy loop so you want
> > other CPU threads to run if possible.
> 
> You mean like this ? Here's the patch for 2.6, I'll queue the same for 2.4
> if it's alright.
> 
> > Alan
> 
> Regards,
> Willy
> 
> From 512d12bd7ce9c0a15dfd91a6f7c2970c92b3abdd Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Fri, 4 Aug 2006 08:50:10 +0200
> Subject: [PATCH] AVM C4 ISDN card : use cpu_relax() in busy loops
> 
> As suggested by Alan, use cpu_relax() in 3 busy loops : "It's a
> polled busy loop so you want other CPU threads to run if possible".
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/isdn/hardware/avm/c4.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/isdn/hardware/avm/c4.c b/drivers/isdn/hardware/avm/c4.c
> index f7253b2..aee278e 100644
> --- a/drivers/isdn/hardware/avm/c4.c
> +++ b/drivers/isdn/hardware/avm/c4.c
> @@ -22,6 +22,7 @@ #include <linux/capi.h>
>  #include <linux/kernelcapi.h>
>  #include <linux/init.h>
>  #include <asm/io.h>
> +#include <asm/processor.h>
>  #include <asm/uaccess.h>
>  #include <linux/netdevice.h>
>  #include <linux/isdn/capicmd.h>
> @@ -150,6 +151,7 @@ static inline int wait_for_doorbell(avmc
>  		if (!time_before(jiffies, stop))
>  			return -1;
>  		mb();
> +		cpu_relax();

cpu_relax() implies a memory barrier.

-- 
Greetings Michael.
