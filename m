Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVKWSBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVKWSBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVKWSBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:01:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:10404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932118AbVKWSBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:01:46 -0500
Date: Wed, 23 Nov 2005 10:00:05 -0800
From: Greg KH <gregkh@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm@osdl.org, ehabkost@mandriva.com
Subject: Re: [PATCH 2/2] - usbserial: race-condition fix.
Message-ID: <20051123180005.GA26433@suse.de>
References: <20051122195926.18c3221c.lcapitulino@mandriva.com.br> <20051122221353.GA10311@suse.de> <20051123093655.5555f23e.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123093655.5555f23e.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:36:55AM -0200, Luiz Fernando Capitulino wrote:
> On Tue, 22 Nov 2005 14:13:53 -0800
> Greg KH <gregkh@suse.de> wrote:
> 
> | On Tue, Nov 22, 2005 at 07:59:26PM -0200, Luiz Fernando Capitulino wrote:
> | > @@ -60,6 +61,7 @@ struct usb_serial_port {
> | >  	struct usb_serial *	serial;
> | >  	struct tty_struct *	tty;
> | >  	spinlock_t		lock;
> | > +	struct semaphore        sem;
> | 
> | You forgot to document what this semaphore is used for.
> 
>  Okay.
> 
> | Hm, can we just use the spinlock already present in the port structure
> | for this?  Well, drop the spinlock and use the semaphore?  Yeah, that
> | means grabbing a semaphore for ever write for some devices, but USB data
> | rates are slow enough it wouldn't matter :)
> 
>  As far as I read the code, I found that spinlock is only used by the
> generic driver, in the
> drivers/usb/serial/generic.c:usb_serial_generic_write() function.

No, lots of other usb-serial drivers use it.  Increase your grep a bit
wider :)

>  Can we drop the spinlock there and use our new semaphore? Or should we
> create a new spinlock just to use there?

Create a new one for where?

>  I ask it because the semaphore will be used to serialize open()/close()
> operations in the usb-serial driver, is a bit weird to use the same
> semaphore in a write() function of other driver.

I agree, but yet-another-lock isn't the best either.

thanks,

greg k-h
