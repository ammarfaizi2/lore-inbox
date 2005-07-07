Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVGGGKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVGGGKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVGGGKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:10:44 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:5286 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261160AbVGGGKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:10:42 -0400
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
            <courier.42BA3791.000006F9@courier.cs.helsinki.fi>
            <20050623044952.GA21017@alpha.home.local>
            <200507061411.57725.mgross@linux.intel.com>
In-Reply-To: <200507061411.57725.mgross@linux.intel.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Mark Gross <mgross@linux.intel.com>
Cc: Willy Tarreau <willy@w.ods.org>, Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Date: Thu, 07 Jul 2005 09:10:41 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CCC761.000020F0@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross writes:
> +static int
> +tlclk_open(struct inode *inode, struct file *filp)
> +{
> +	int result;
> +#ifdef MODULE
> +	if (!MOD_IN_USE) {
> +		MOD_INC_USE_COUNT;
> +#endif
> +		/* Make sure there is no interrupt pending will 
> +		   *  initialising interrupt handler */
> +		inb(TLCLK_REG6);
> +
> +		result = request_irq(telclk_interrupt, &tlclk_interrupt,
> +					SA_SHIRQ, "telclock", tlclk_interrupt);

Instead of playing the MOD_IN_USE games, please either (1) grab the irq in 
module init (it's a shared IRQ after all) or (2) do the following: 

static int tlclk_used; 

static int tlclk_open(struct inode *inode, struct file *filp) {
       if (tlclk_used++)
               return 0; 

       // request_irq goes here.
} 

For an example, see the file drivers/input/mouse/amimouse.c (appears in 
2.6.12 at least). 

                        Pekka 

