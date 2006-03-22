Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWCVXWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWCVXWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWCVXWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:22:51 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:21877 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932487AbWCVXWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:22:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nBz0LwM54KBN/2MXv0cJAuN8hYhS61gnugerTi/rD/d4KT8DjVnHEagHHUEXgKgLrpIKQ97q90fHxB0C3IewXg3KTp/MgVNBenJ4+AMg0VzI4RfwUYgIgLDE1wzPtMOPIC0OUOwXjJe5pKo5rfjBwoN546I5RUpx/GaIinRlelw=
Date: Thu, 23 Mar 2006 02:22:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Pointer dereference in net/irda/ircomm/ircomm_tty.c
Message-ID: <20060322232247.GD7790@mipter.zuzino.mipt.ru>
References: <1143067566.26895.8.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143067566.26895.8.camel@alice>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 11:46:05PM +0100, Eric Sesterhenn wrote:
> this fixes coverity bugs #855 and #854. In both cases tty
> is dereferenced before getting checked for NULL.

Before Al will flame you,

IMO, what should be done is removing asserts checking for "self",
because ->driver_data is filled in ircomm_tty_open() with valid pointer.

> --- linux-2.6.16/net/irda/ircomm/ircomm_tty.c.orig
> +++ linux-2.6.16/net/irda/ircomm/ircomm_tty.c
> @@ -493,7 +493,7 @@ static int ircomm_tty_open(struct tty_st
>   */
>  static void ircomm_tty_close(struct tty_struct *tty, struct file *filp)
>  {
> -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
> +	struct ircomm_tty_cb *self;
>  	unsigned long flags;
>
>  	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
> @@ -501,6 +501,8 @@ static void ircomm_tty_close(struct tty_
>  	if (!tty)
>  		return;
>
> +	self = (struct ircomm_tty_cb *) tty->driver_data;
> +
>  	IRDA_ASSERT(self != NULL, return;);
>  	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
>
> @@ -1006,17 +1008,19 @@ static void ircomm_tty_shutdown(struct i
>   */
>  static void ircomm_tty_hangup(struct tty_struct *tty)
>  {
> -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
> +	struct ircomm_tty_cb *self;
>  	unsigned long	flags;
>
>  	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
>
> -	IRDA_ASSERT(self != NULL, return;);
> -	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
> -
>  	if (!tty)
>  		return;
>
> +	self = (struct ircomm_tty_cb *) tty->driver_data;
> +
> +	IRDA_ASSERT(self != NULL, return;);
> +	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
> +
>  	/* ircomm_tty_flush_buffer(tty); */
>  	ircomm_tty_shutdown(self);

