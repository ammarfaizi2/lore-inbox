Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWDGVlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWDGVlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWDGVlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:41:03 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:18644 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964972AbWDGVlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:41:01 -0400
Message-ID: <4436DC4A.1060604@t-online.de>
Date: Fri, 07 Apr 2006 23:40:26 +0200
From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: stable@kernel.org, Brian Marete <bgmarete@gmail.com>,
       David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [2.6.16] saa7134 disable_ir oops
References: <44246C0E.3080306@cogweb.net>	<20060406202016.05db1eca.vsu@altlinux.ru>	<1144415771.28307.13.camel@praia> <20060407133628.GG10864@master.mivlgu.local>
In-Reply-To: <20060407133628.GG10864@master.mivlgu.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: r11+BiZZZeRQB9HSvQRVtdIs9IS6nKziOdk1RafuNw+ETpnjbUTg6s
X-TOI-MSGID: eb82bb64-0543-4890-81db-40cd722adac8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Sergey Vlasov wrote:
> On Fri, Apr 07, 2006 at 10:16:10AM -0300, Mauro Carvalho Chehab wrote:
> 
>>Em Qui, 2006-04-06 ?s 20:20 +0400, Sergey Vlasov escreveu:
>>
>>>On Fri, 24 Mar 2006 14:00:46 -0800 David Liontooth wrote:
>>
>>>Does the following patch fix things?
>>>
>>
>>Applied at v4l-dvb tree. Thanks.
> 
> 
> IMHO this patch should also be added to 2.6.16-stable - it fixes oops in
> configurations which worked fine with older kernels.
> 
> -----------------------------------------------------------------------
> 
> saa7134: Fix oops with disable_ir=1
> 
> When disable_ir=1 parameter is used, or when saa7134_input_init1()
> fails for any other reason, dev->remote will remain NULL, and the
> driver will oops in saa7134_hwinit2().  Therefore dev->remote must be
> checked before dereferencing.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> 
> --- linux-2.6.16.orig/drivers/media/video/saa7134/saa7134-core.c	2006-03-20 08:53:29 +0300
> +++ linux-2.6.16/drivers/media/video/saa7134/saa7134-core.c	2006-04-06 20:00:56 +0400
> @@ -543,6 +543,8 @@ static irqreturn_t saa7134_irq(int irq, 
>  		if (report & SAA7134_IRQ_REPORT_GPIO16) {
>  			switch (dev->has_remote) {
>  				case SAA7134_REMOTE_GPIO:
> +					if (!dev->remote)
> +						break;
>  					if  (dev->remote->mask_keydown & 0x10000) {
>  						saa7134_input_irq(dev);
>  					}
> @@ -559,6 +561,8 @@ static irqreturn_t saa7134_irq(int irq, 
>  		if (report & SAA7134_IRQ_REPORT_GPIO18) {
>  			switch (dev->has_remote) {
>  				case SAA7134_REMOTE_GPIO:
> +					if (!dev->remote)
> +						break;
>  					if ((dev->remote->mask_keydown & 0x40000) ||
>  					    (dev->remote->mask_keyup & 0x40000)) {
>  						saa7134_input_irq(dev);
> @@ -671,7 +675,7 @@ static int saa7134_hwinit2(struct saa713
>  		SAA7134_IRQ2_INTE_PE      |
>  		SAA7134_IRQ2_INTE_AR;
>  
> -	if (dev->has_remote == SAA7134_REMOTE_GPIO) {
> +	if (dev->has_remote == SAA7134_REMOTE_GPIO && dev->remote) {
>  		if (dev->remote->mask_keydown & 0x10000)
>  			irq2_mask |= SAA7134_IRQ2_INTE_GPIO16;
>  		else if (dev->remote->mask_keydown & 0x40000)
> 

Let's think this over, please.
1) The problem originally was that a card type with remote control was
    forced for a card that doesn't have one.
2) On the other hand you are right, this situation should not cause an oops.
The code should be that GPIO irqs should be completely ignored unless a handler
has been installed, so the
  if (dev->has_remote)
is completely wrong and should be repaced by something explictly initialized,
maybe the dev->remote pointer does the trick better.
I never worked seriously on this fraction of the driver, so there might be a
better solution.

Comments?
    Hartmut
