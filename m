Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312901AbSCZA7A>; Mon, 25 Mar 2002 19:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312900AbSCZA6v>; Mon, 25 Mar 2002 19:58:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312899AbSCZA6m>;
	Mon, 25 Mar 2002 19:58:42 -0500
Message-ID: <3C9FC76F.6050900@mandrakesoft.com>
Date: Mon, 25 Mar 2002 19:57:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?ISO-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 3c59x and resume
In-Reply-To: <20020323161647.GA11471@ufies.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:

>Here is a small patch tested with 2.4.18 and 2.4.19-pre4.
>It was proposed by Andrew but not integrated in pre4.
>
>The problem is when using the vortex driver and suspend/resuming the
>machine. Without this patch the card id is each time greater. To resume
>correctly this driver need the option enable_wol=1 but as-is it will
>only be true for the first ID. You can enable it for the first 8 IDs
>with enable_wol=1,1,1,1,1,1,1,1 but you can't do it for all IDs.
>Said another way without this patch you can't suspend/resume more than
>eight times your machine.
>
>This is a fix for the most common use. The proper fix would be IMO to
>keep a bitmap of used IDs but I don't know if it worsts it.
>Also a fix would be to separate the suspend/resume functionality from
>the wol functionality (wake up on lan).
>
>Thanks,
>Christophe
>
>--- linux/drivers/net/3c59x.c	Sat Mar 23 10:24:56 2002
>+++ linux/drivers/net/3c59x.c	Sat Mar 23 10:57:00 2002
>@@ -2891,6 +2891,9 @@
> 
> 	vp = dev->priv;
> 
>+	if (vp->card_idx == vortex_cards_found - 1)
>+         vortex_cards_found--;
>+
> 	/* AKPM: FIXME: we should have
> 	 *	if (vp->cb_fn_base) iounmap(vp->cb_fn_base);
> 	 * here
>

This patch causes module defaults to be reused -- potentially incorrectly.

This is a personal solution, that might live on temporary as an 
outside-the-tree patch... but we cannot apply this to the stable kernel.

I agree the card idx is wrong on remove.  Insert and remove a 3c59x 
cardbus card several times, and you will lose your module options too. 
 However... take note that this problem cannot be solved "the easy way" 
-- because one solution people may desire will potentially result in 
module options getting re-used incorrectly.  The above is one such solution.

If you want WOL options to "stick" or vary per-interface, we already 
have an API for that -- ethtool.  Check out drivers/net/natsemi.c for an 
example implementation.  _Tested_ patches to 3c59x that add WOL ethtool 
support are welcome, pending Andrew's approval.  Do not remove 
enable_wol for now in a stable series, but we will deprecate its use 
once ethtool support appears.

    Jeff





