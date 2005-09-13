Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVIMSl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVIMSl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVIMSl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:41:57 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:54443 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964977AbVIMSl4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:41:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HrPb5Xm1XxZZ6cZ4Hut/R6H3lMu76QwwkJMJhnt+ssSbf92uWIebjJltFP8ip6UtQek798i2qLRDQQb9c+VKcvQOO1FshCfT+KuqJ2LOWDdcDgwmblo6bF5qhiKD0G/FdmidICSz3oQPsjQXjBykmIh9yWgO/Uru4xPZQWrlkj0=
Message-ID: <d120d50005091311412f31c5cf@mail.gmail.com>
Date: Tue, 13 Sep 2005 13:41:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: roy.wood@gmail.com
Subject: Re: [PATCH] drivers/input/joystick/interact.c ; Linux 2.6.13-1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <e778aab0050913083656dc8c8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e778aab0050913083656dc8c8f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, roy wood <roy.wood@gmail.com> wrote:
> This patch to the Interact joystick driver adds support for the
> "RaiderPro Digital" model of joystick from Interact.  The patch is
> made against kernel version 2.6.13-1.

Cool, looks pretty nice.

> Also, apparently I need to send this directly to Linus to get this
> into the tree.  Anyone care to tell me the best email address to use
> to do that?  I promise not to foreward it to recruiters at MS.  :-)
> 

Actually that would be Vojtech Pavlik <vojtech@suse.cz> - input system
maintainer.

> + *
> + *  History:
> + *  --------
> + *  2005-09-12: rrwood - Add support for RaiderPro
>  */
> 

We prefer keeping changelogs in SCM, when possible

>  struct interact {
> -       struct gameport *gameport;
> -       struct input_dev dev;
> -       int bads;
> -       int reads;
> -       unsigned char type;
> -       unsigned char length;
> -       char phys[32];
> +       struct gameport *gameport; /* Kernel gameport struct ptr */
> +       struct input_dev dev;      /* Kernel input_dev struct ptr */

And I don't think we should add comments like these - they don't tell
you anything new. Especially when they wrong (dev is not a pointer
[yet])

> 
> -static short interact_abs_hhfx[] =
> +
> +/* I think the original purpose of setting up lists of controller
> + * axes/buttons was to provide a single location to maintain such
> + * information.  Although the table-based approach certainly makes
> + * the interact_connect() code below MUCH simpler and cleaner, the
> + * interact_poll() code ends up being very hard to read, unfortunately.
> + *
> + * I was tempted to either rewrite interact_poll() in a clearer fashion,
> + * or to implement a more comprehensive table-driven decoding approach
> + * (with values for offset, masking, shifting of each value).  I'm a
> + * bit leery of making such massive change though, since I don't have the
> + * controllers to test the result.  Instead, I'll just add support
> + * for the RaiderPro as clearly as I can.....
> + */

This is not a book, what one could have done but decided not to is not
very interesting unless the solution is outlined as a future TODO
item.

> 
>        if (interact_read_packet(interact->gameport, interact->length, data)
> < interact->length) {
> +               /* Couldn't read a full packet, so update the bad-count,
> +                * queue another read, and get out */

Yes, that is what that "if" statement said. Why also comment it?

> +       if (INTERACT_MAX_LENGTH - interact->length > 0) {
> +               /* If data packets are less than max length, shift them
> +                * for easier processing below (ProPad goofiness) */

This one is a decent comment tough (IMHO).

> +       /* Queue another read */
>        input_sync(dev);

??? input_sync signals that the input event packet is complete. What
is it about queueing another read stuff?

-- 
Dmitry
