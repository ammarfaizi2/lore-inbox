Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVC0Vnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVC0Vnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVC0Vnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:43:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60944 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261594AbVC0VnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:43:24 -0500
Date: Sun, 27 Mar 2005 23:43:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a check after use)
Message-ID: <20050327214323.GH4285@stusta.de>
References: <20050327205014.GD4285@stusta.de> <20050327232158.46146243.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327232158.46146243.khali@linux-fr.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 11:21:58PM +0200, Jean Delvare wrote:
> Hi Adrian,
> 
> > This patch fixes a check after use found by the Coverity checker.
> > (...)
> >  static void amp_hercules(struct cs_card *card, int change)
> >  {
> > -	int old=card->amplifier;
> > +	int old;
> >  	if(!card)
> >  	{
> >  		CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO 
> >  			"cs46xx: amp_hercules() called before initialized.\n"));
> >  		return;
> >  	}
> > +	old = card->amplifier;
> 
> I see that you are fixing many bugs like this one today, all reported by
> Coverity. In all cases (as far as I could see at least) you are moving
> the dereference after the check. Of course it prevents any NULL pointer
> dereference, and will make Coverity happy. However, I doubt that this is
> always the correct solution.
> 
> Think about it. If the pointer could be NULL, then it's unlikely that
> the bug would have gone unnoticed so far (unless the code is very
> recent). Coverity found 3 such bugs in one i2c driver [1], and the
> correct solution was to NOT check for NULL because it just couldn't
> happen. Could be the case for all the bugs you are fixing right now too.
> 
> [1] http://linux.bkbits.net:8080/linux-2.5/cset@1.1982.139.27
> 
> Coverity and similar tools are a true opportunity for us to find out and
> study suspect parts of our code. Please do not misuse these tools! The
> goal is NOT to make the tools happy next time you run them, but to
> actually fix the problems, once and for all. If you focus too much on
> fixing the problems quickly rather than fixing them cleanly, then we
> forever lose the opportunity to clean our code, because the problems
> will then be hidden. If you look at case [1] above, you'll see that we
> were able to fix more than just what Coverity had reported.
>...

There are two cases:
1. NULL is impossible, the check is superfluous
2. this was an actual bug

In the first case, my patch doesn't do any harm (a superfluous isn't a 
real bug).

In the second case, it fixed a bug.
It might be a bug not many people hit because it might be in some error 
path of some esoteric driver.

If a maintainer of a well-maintained subsystem like i2c says
"The check is superfluous." that's the perfect solution.

But in less maintained parts of the kernel, even a low possibility that 
it fixes a possible bug is IMHO worth making such a riskless patch.

> Thanks,
> Jean Delvare

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

