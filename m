Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUA1DKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbUA1DKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:10:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265826AbUA1DKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:10:02 -0500
Date: Wed, 28 Jan 2004 03:09:58 +0000
From: Matthew Wilcox <willy@debian.org>
To: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-ID: <20040128030958.GH11844@parcelfarce.linux.theplanet.co.uk>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:54:37AM +0900, Hironobu Ishii wrote:
> This is a readX_check() prototype patch to evaluate
> the performance disadvantage.

I think you've just demonstrated why this type of interface is unacceptable:

> + #ifdef CONFIG_PCI_RECOVERY
> +   {
> +    int read_fail;
> +    read_fail = CHIPREG_READ32(&pa, &ioc->chip->ReplyFifo);
> +    if (read_fail) {
> +     printk("PCI PIO read error:%d\n", read_fail);
> +     /* recovery code */
> +    }
> +    if (pa == 0xFFFFFFFF)
> +     return IRQ_HANDLED;
> +   }
> + #else
>     if ((pa = CHIPREG_READ32(&ioc->chip->ReplyFifo)) == 0xFFFFFFFF)
>      return IRQ_HANDLED;
> ! #endif

We go from two easily understood lines to ten plus the recovery code.
If indeed recovery is even possible.  An exception framework is clearly
the way to do this.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
