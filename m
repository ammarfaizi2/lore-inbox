Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVC2G1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVC2G1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVC2G1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:27:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:21391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262445AbVC2G1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:27:23 -0500
Date: Mon, 28 Mar 2005 22:23:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a
 check after use)
Message-Id: <20050328222348.4c05e85c.akpm@osdl.org>
In-Reply-To: <20050327232158.46146243.khali@linux-fr.org>
References: <20050327205014.GD4285@stusta.de>
	<20050327232158.46146243.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> > This patch fixes a check after use found by the Coverity checker.
>  > (...)
>  >  static void amp_hercules(struct cs_card *card, int change)
>  >  {
>  > -	int old=card->amplifier;
>  > +	int old;
>  >  	if(!card)
>  >  	{
>  >  		CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO 
>  >  			"cs46xx: amp_hercules() called before initialized.\n"));
>  >  		return;
>  >  	}
>  > +	old = card->amplifier;
> 
>  I see that you are fixing many bugs like this one today, all reported by
>  Coverity. In all cases (as far as I could see at least) you are moving
>  the dereference after the check. Of course it prevents any NULL pointer
>  dereference, and will make Coverity happy. However, I doubt that this is
>  always the correct solution.
> 
>  Think about it. If the pointer could be NULL, then it's unlikely that
>  the bug would have gone unnoticed so far (unless the code is very
>  recent). Coverity found 3 such bugs in one i2c driver [1], and the
>  correct solution was to NOT check for NULL because it just couldn't
>  happen.

No, there is a third case: the pointer can be NULL, but the compiler
happened to move the dereference down to after the check.

If the optimiser is later changed, or if someone tries to compile the code
with -O0, it will oops.

