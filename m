Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVC0VWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVC0VWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVC0VWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:22:22 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:40454 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261587AbVC0VWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:22:03 -0500
Date: Sun, 27 Mar 2005 23:21:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a
 check after use)
Message-Id: <20050327232158.46146243.khali@linux-fr.org>
In-Reply-To: <20050327205014.GD4285@stusta.de>
References: <20050327205014.GD4285@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch fixes a check after use found by the Coverity checker.
> (...)
>  static void amp_hercules(struct cs_card *card, int change)
>  {
> -	int old=card->amplifier;
> +	int old;
>  	if(!card)
>  	{
>  		CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO 
>  			"cs46xx: amp_hercules() called before initialized.\n"));
>  		return;
>  	}
> +	old = card->amplifier;

I see that you are fixing many bugs like this one today, all reported by
Coverity. In all cases (as far as I could see at least) you are moving
the dereference after the check. Of course it prevents any NULL pointer
dereference, and will make Coverity happy. However, I doubt that this is
always the correct solution.

Think about it. If the pointer could be NULL, then it's unlikely that
the bug would have gone unnoticed so far (unless the code is very
recent). Coverity found 3 such bugs in one i2c driver [1], and the
correct solution was to NOT check for NULL because it just couldn't
happen. Could be the case for all the bugs you are fixing right now too.

[1] http://linux.bkbits.net:8080/linux-2.5/cset@1.1982.139.27

Coverity and similar tools are a true opportunity for us to find out and
study suspect parts of our code. Please do not misuse these tools! The
goal is NOT to make the tools happy next time you run them, but to
actually fix the problems, once and for all. If you focus too much on
fixing the problems quickly rather than fixing them cleanly, then we
forever lose the opportunity to clean our code, because the problems
will then be hidden. If you look at case [1] above, you'll see that we
were able to fix more than just what Coverity had reported.

Considering the very important flow of patches you are sending these
days, I have to admit I am quite suspicious that you don't really
investigate all issues individually as you should, but merely want to
fix as many bugs as possible in a short amount of time. This is not,
IMVHO, what needs to be done. Of course, if you actually investigated
all these bugs and are certain that none of these checks can be removed
because pointers can actually be NULL in regular cases, then please
accept my humble apologizes and keep up with the good work.

Thanks,
-- 
Jean Delvare
