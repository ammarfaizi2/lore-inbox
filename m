Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVBROfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVBROfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVBROfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:35:41 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:48282 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261208AbVBROfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:35:25 -0500
Date: Fri, 18 Feb 2005 15:35:17 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gpio api
Message-ID: <20050218143517.GA5307@wohnheim.fh-wedel.de>
References: <4215F1A0.1030805@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4215F1A0.1030805@hp.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 February 2005 08:46:08 -0500, Jamey Hicks wrote:
> 
> GPIO Client Driver API
> 
> The first two calls are analogous to request_irq/free_irq, so that
> driver can ensure that they have exclusive access to a GPIO and can
> specify asynchronous or synchronous access.  I have run into problems
> due to out-of-date or misconfigured drivers that would be prevented by
> the use of these calls.
> 
>   #define GPIOF_SYNC      (1 << 0)
>   #define GPIOF_ASYNC     (1 << 1)
>   #define GPIOF_SYSFS     (1 << 2)
>   #define GPIOF_VALID     (1 << 3)
> 
>   int request_gpio(int gpio_num, const char *name,
>       void (*callback)(int gpionum, void *devid), int flags, void *devid);
>   void free_gpio(int gpio_num, void *devid);
> 
> It is a BUG to supply a NULL callback if GPIO is successfully
> requested with GPIOF_ASYNCH set.  [Alternatively, split into sync and
> async calls and consider it a BUG to use the synchronous calls on a
> GPIO requested with GPIOF_ASYNC set.]

Don't split the interface.  BUG_ON((flags&GPIOF_ASYNC) && !callback)
might be a good idea, but most likely there are valid reasons for NULL
callbacks as well.

Also, it's not unusual to request several pins at one.  If the
requester can simply provide a bitmask, the calling code is *much*
simpler.

>    int set_gpio_mode(int gpionum, int modeflags);
>    int set_gpio_value(int gpionum, int value);
>    int get_gpio_value(int gpionum);

These functions either lack a struct gpiochip argument or could be
omitted completely.

> GPIO Provider API
> 
>    struct gpiochip {
>       int (*set)(struct gpiochip *chip, void *context, int value);
>       int (*get)(struct gpiochip *chip void *context);
>       int (*mode)(struct gpiochip *chip, void *context, int modeflags);
>    };

A private structure is surely needed, no?


Overall, I like the idea.  Having a standard interface for gpio
drivers makes life somewhat easier when writing a driver, and a *lot*
easier when using one.  With every driver having their own custom
interface, some *will* end up broken and unusable.

Jörn

-- 
He that composes himself is wiser than he that composes a book.
-- B. Franklin
