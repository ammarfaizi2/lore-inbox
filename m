Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSHHMDp>; Thu, 8 Aug 2002 08:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSHHMDo>; Thu, 8 Aug 2002 08:03:44 -0400
Received: from [212.18.235.100] ([212.18.235.100]:37007 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S317498AbSHHMDm>; Thu, 8 Aug 2002 08:03:42 -0400
From: kernel@street-vision.com
Message-Id: <200208081206.g78C6j402355@tench.street-vision.com>
Subject: Re: [PATCH] [2.4.20-pre1] Watchdog Stuff (1/4)
To: Joel.Becker@oracle.com (Joel Becker)
Date: Thu, 8 Aug 2002 12:06:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020808001238.GB1038@nic1-pc.us.oracle.com> from "Joel Becker" at Aug 07, 2002 05:12:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might cc the driver author...

> 
>         Here are four patches for the watchdog drivers.  These patches
> are an update to 2.4.20-pre1 of the original set against 2.4.19-pre9.
> The first patch (this one) adds WDIOC_SETTIMEOUT support to
> wafer5823wdt.c.  The second patch adds Matt Domsch's 'nowayout' module
> option to the drivers that currently don't have it.  The third patch
> fixes a bug where most of the "magic close character" capable drivers
> don't use get_user().  The fourth patch adds "magic close character"
> support to almost all of the remaining drivers.  It also adds
> WDIOF_MAGICCLOSE to the driver info flags.                                 
> 
> Joel

> +
> +	case WDIOC_SETTIMEOUT:
> +		if (get_user(new_margin, (int *)arg))
> +			return -EFAULT;
> +		if ((new_margin < 1) || (new_margin > 255))
> +			return -EINVAL;
> +		wd_margin = new_margin;
> +		wafwdt_stop();
> +		wafwdt_start();
> +		/* Fall */
> +	case WDIOC_GETTIMEOUT:
> +		return put_user(wd_margin, (int *)arg);

I really wouldnt do wafwdt_stop(); wafwdt_start(); here. The new timeout
will be set on the next watchdog ping anyway, and you need to spin_lock
and unlock round this too. Much cleaner just to drop it.

Justin
