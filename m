Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280596AbRKFVQp>; Tue, 6 Nov 2001 16:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280594AbRKFVQZ>; Tue, 6 Nov 2001 16:16:25 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34809 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280587AbRKFVQR>;
	Tue, 6 Nov 2001 16:16:17 -0500
Date: Tue, 6 Nov 2001 14:15:21 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Philip.Blundell@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lp.c, eexpress.c jiffies cleanup
Message-ID: <20011106141521.R3957@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	Philip.Blundell@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111062039440.23693-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0111062039440.23693-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Tue, Nov 06, 2001 at 09:04:51PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2001  21:04 +0100, Tim Schmielau wrote:
> In eexpress.c I also turned absolute jiffies number into multiples of HZ,
> yet the resulting timeout values still do not always seem reasonable to
> me.

I agree.  It seems very ugly.  I looked at a few drivers which loop 1 or 2
jiffies, but to busy-loop for 1/10th of a second, or even 20 seconds
is terribly bad.  I took a look at the functions scb_rdcmd() and
scb_status() and they are only reading from an I/O port, so no chance
of sleeping/blocking, just busy waiting.

> -	unsigned long int oldtime = jiffies;
> -	while (scb_rdcmd(dev) && ((jiffies-oldtime)<10));
> +	unsigned long timeout = jiffies + HZ/10;
> +	while (scb_rdcmd(dev) && (time_before(jiffies, timeout)));
>  	if (scb_rdcmd(dev)) {
>  		printk("%s: command didn't clear\n", dev->name);
>  	}
> @@ -1598,16 +1598,16 @@
>  #endif
> -                oj = jiffies;
> +                timeout = jiffies + 20*HZ;
>                  while ((SCB_CUstat(scb_status(dev)) == 2) &&
> -                       ((jiffies-oj) < 2000));
> +                       time_before(jiffies, timeout));
>  		if (SCB_CUstat(scb_status(dev)) == 2)
>  			printk("%s: warning, CU didn't stop\n", dev->name);
>                  lp->started &= ~(STARTED_CU);

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

