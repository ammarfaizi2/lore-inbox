Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTDXWuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTDXWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:50:20 -0400
Received: from lakemtao06.cox.net ([68.1.17.115]:62639 "EHLO
	lakemtao06.cox.net") by vger.kernel.org with ESMTP id S264443AbTDXWuP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:50:15 -0400
Subject: Re: 2.5.68-mm2 bttv oops
From: steven roemen <sdroemen1@cox.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030423213119.26c74759.akpm@digeo.com>
References: <1051153462.997.159.camel@lws04.home.net>
	 <20030423213119.26c74759.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051225182.976.7.camel@lws04.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 17:59:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay, that patch worked.

the only problem i see now is, migration/0, migration/1 are both in D
state(via top) or DX (via ps aux), and bringing the load up to ~2.00.
i have KDE 3.1.1, evolution 1.2.4, konsole, gkrellm running; and these
never give a load like this before.

Steve

On Wed, 2003-04-23 at 23:31, Andrew Morton wrote:
> steven roemen <sdroemen1@cox.net> wrote:
> >
> > here's what is in the syslog after booting the 2.5.68-mm2 kernel:
> > bttv is built into the kernel.
> 
> This'll fix it up
> 
>  25-akpm/drivers/media/video/bttv-driver.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff -puN drivers/media/video/bttv-driver.c~irqreturn-bttv drivers/media/video/bttv-driver.c
> --- 25/drivers/media/video/bttv-driver.c~irqreturn-bttv	Wed Apr 23 18:00:18 2003
> +++ 25-akpm/drivers/media/video/bttv-driver.c	Wed Apr 23 18:02:52 2003
> @@ -1279,7 +1279,7 @@ static int bttv_prepare_buffer(struct bt
>  }
>  
>  static int
> -buffer_setup(struct file *file, int *count, int *size)
> +buffer_setup(struct file *file, unsigned int *count, unsigned int *size)
>  {
>  	struct bttv_fh *fh = file->private_data;
>  	
> @@ -3156,22 +3156,23 @@ bttv_irq_switch_fields(struct bttv *btv)
>  	spin_unlock(&btv->s_lock);
>  }
>  
> -static void bttv_irq(int irq, void *dev_id, struct pt_regs * regs)
> +static irqreturn_t bttv_irq(int irq, void *dev_id, struct pt_regs * regs)
>  {
>  	u32 stat,astat;
>  	u32 dstat;
>  	int count;
>  	struct bttv *btv;
> +	int handled = 0;
>  
>  	btv=(struct bttv *)dev_id;
>  	count=0;
> -	while (1) 
> -	{
> +	while (1) {
>  		/* get/clear interrupt status bits */
>  		stat=btread(BT848_INT_STAT);
>  		astat=stat&btread(BT848_INT_MASK);
>  		if (!astat)
> -			return;
> +			break;
> +		handled = 1;
>  		btwrite(stat,BT848_INT_STAT);
>  
>  		/* get device status bits */
> @@ -3231,6 +3232,7 @@ static void bttv_irq(int irq, void *dev_
>  			       "bttv%d: IRQ lockup, cleared int mask\n", btv->nr);
>  		}
>  	}
> +	return IRQ_RETVAL(handled);
>  }
>  
> 
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

