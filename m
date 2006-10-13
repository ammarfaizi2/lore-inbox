Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWJMKGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWJMKGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWJMKGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:06:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:49693 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751099AbWJMKGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:06:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GzK7vLoGQJnCk+w45p0fgmu5xcmxPlR8R/O78DctDlpFy/0oRLL/7iQBRkOATaXh6caB9EtdEqv/5XMmdNDS+e9NDAWoXTNIQWkg2OyOHRt+jwn7hpTR+NAiKK/Ce1zKoxHS7s0CNEU9/XUcTfh0CnPvERaVlabbWOm81uZmf6Y=
Message-ID: <9a8748490610130306v3bfe13b4j135cc474ff718657@mail.gmail.com>
Date: Fri, 13 Oct 2006 12:06:40 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Burman Yan" <yan_952@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HP mobile data protection system driver
Cc: "Andrey Panin" <pazke@donpac.ru>
In-Reply-To: <20061013092603.GA26306@pazke.donpac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY20-F7ACD05600A29690DC3CCED80A0@phx.gbl>
	 <20061013092603.GA26306@pazke.donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/06, Andrey Panin <pazke@donpac.ru> wrote:
> On 286, 10 13, 2006 at 10:47:15 +0200, Burman Yan wrote:
> > Hi, all.
> >
> > I'm new to the list so forgive me in advance for any netiquette mistakes I
> > make.
> >
> > I wrote a driver for the accelerometer chip on HP nc6400 laptop (I think
> > the same chip is present on
> > other NCxxxx models). This driver uses ACPI interface present in the bios
> > and behaves pretty much like
> > hdaps. This is a fully functional version - tested on 2.6.17 and 2.6.18
> > (not 2.6.19-rc1 since I have a
> > problem with that kernel on my laptop). It applies on 2.6.19-rc1 as well
> > though. I would like your
> > remarks and suggestions on this. Also, should I mail this patch to a kernel
> > maintainer? I could not find a maintainer that looks like the address for
> > this patch. The closest one is the lm_sensors maintainer, but
> > that's probably wrong.
>
> Some comments:
>
> 1. Use hard tabs instead of 8 spaces;
> 2. C++ comments are tolerated, but not welcomed;
> 3. You missed Signed-off-by: line.
>
Agree with those points. Some additional ones below.


> +          accelerometer data is readable via /proc/drivers/mdps.

I believe it would be better to use sysfs. Procfs is cluttered enough
as it is and there's not much will to clutter it further.


> +static int mdps_get_xy(acpi_handle handle, int* x, int* y)
> +{
> +        unsigned long x_lo, x_hi, y_lo, y_hi;
> +
> +        mdps_ALRD(mdps.device->handle, MDPS_OUTX_L, &x_lo);
> +        mdps_ALRD(mdps.device->handle, MDPS_OUTX_H, &x_hi);
> +        mdps_ALRD(mdps.device->handle, MDPS_OUTY_L, &y_lo);
> +        mdps_ALRD(mdps.device->handle, MDPS_OUTY_H, &y_hi);
> +
> +        *x = mdps_glue_bytes(x_hi, x_lo);
> +        *y = mdps_glue_bytes(y_hi, y_lo);
> +
> +        return 0;
> +}
> +

You never return anything but 0 here, so why not just make the
function return void instead?


> +static int mdps_mouse_kthread(void *data)
> +{
> +        int x, y;
> +
> +        while (!kthread_should_stop()) {
> +                mdps_get_xy(mdps.device->handle, &x, &y);
> +
> +                // need to invert the X axis for this to look natural
> +                input_report_abs(mdps.idev, ABS_X, -(x - mdps.xcalib));
> +                input_report_abs(mdps.idev, ABS_Y, y - mdps.ycalib);
> +
> +                input_sync(mdps.idev);
> +
> +                msleep_interruptible(MDPS_POLL_INTERVAL);
> +        }
> +
> +        return 0;
> +}

void return ??   Other functions could probably return void as well,
not pointing out any more.


> +
> +static inline int mdps_poweroff(acpi_handle handle)
> +{
> +        unsigned long ret;
> +        mdps.is_on = 0;
> +        return (mdps_ALWR(handle, MDPS_CTRL_REG1, 0x00, &ret) == AE_OK);


> +int mdps_suspend(struct acpi_device * device, int state)
>

Accepted CodingStyle is :
    int mdps_suspend(struct acpi_device *device, int state)

> +                if (!ent)
> +                {
> +                        return;
> +                }

We don't use braces when the body is just a single statement. It
should be written like so:
    if (!ent)
        return;

And when there is more than a single statement in the body, the
opening brace should be placed on the same line as the 'if' :
    if (some_condition) {
        foo();
        bar();
    } else {
        foobar();
        snafu();
    }




> +static void __exit mdps_exit_module(void)
> +{
> +        mdps_remove(mdps.device, 1);
> +
             ^^^^ superfluous blank line...
> +        acpi_bus_unregister_driver(&mdps_driver);
> +}


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
