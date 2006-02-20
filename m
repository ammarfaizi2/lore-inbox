Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWBTRo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWBTRo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWBTRo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:44:28 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:55131 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161127AbWBTRo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:44:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Gn/sYg+kv80Dew88YUTdY8LcAwSa21KdfIu357z3IGFp+0BvteVBL3Z1CkY0wg+Aj3mXQuvMhJ7mrbPYixKKg1T42QZ2x+HdBzAU7pOe1uEOPdAqJEtXZ/jwTAz68O6om5AF6ni1hV0bCD7bGU1RxS9KJi3ktWDELoLa4pIeitw=
Date: Mon, 20 Feb 2006 20:44:02 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Brian Marete <bgmarete@gmail.com>
Cc: Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko
Message-ID: <20060220174402.GA14327@mipter.zuzino.mipt.ru>
References: <6dd519ae0602200504n7d89dcb9j4685f1f0939f9c53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd519ae0602200504n7d89dcb9j4685f1f0939f9c53@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:04:24PM +0000, Brian Marete wrote:
> Modprobe(8)ing saa7134.ko causes an oops. This
> is repeatable and happens every time I try to load saa7134.ko. My
> saa7134 compatible TV card is not known by the driver, but TV has worked
> in pervious kernel versions with the insmod option `card=3'. The FM
> radio has never worked.:) I use the following insmod options for
> saa7134.ko:
>
> `options saa7134 card=3 disable_ir=1'
			  ^^^^^^^^^^^^

This prevents saa7134_input_init1() from initializing ->remote which is
needed by

   657	static int saa7134_hwinit2(struct saa7134_dev *dev)
   658	{
   659		unsigned int irq2_mask;
   660		dprintk("hwinit2\n");
   661
   662		saa7134_video_init2(dev);
   663		saa7134_tvaudio_init2(dev);
   664
   665		/* enable IRQ's */
   666		irq2_mask =
   667			SAA7134_IRQ2_INTE_DEC3    |
   668			SAA7134_IRQ2_INTE_DEC2    |
   669			SAA7134_IRQ2_INTE_DEC1    |
   670			SAA7134_IRQ2_INTE_DEC0    |
   671			SAA7134_IRQ2_INTE_PE      |
   672			SAA7134_IRQ2_INTE_AR;
   673
   674		if (dev->has_remote == SAA7134_REMOTE_GPIO) {
   675	===>		if (dev->remote->mask_keydown & 0x10000)	<===
   676				irq2_mask |= SAA7134_IRQ2_INTE_GPIO16;
   677			else if (dev->remote->mask_keydown & 0x40000)
   678				irq2_mask |= SAA7134_IRQ2_INTE_GPIO18;
   679			else if (dev->remote->mask_keyup & 0x40000)
   680				irq2_mask |= SAA7134_IRQ2_INTE_GPIO18A;
   681		}


Brian, please, try without this module parameter.

