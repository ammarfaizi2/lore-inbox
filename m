Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUD1AR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUD1AR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUD1AOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:14:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17280 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264531AbUD1AMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:12:50 -0400
Date: Tue, 27 Apr 2004 20:13:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Ken Ashcraft <ken@coverity.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] Implementation inconsistencies in 2.6.3
In-Reply-To: <20040427230520.GB2662@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.53.0404272006390.1280@chaos>
References: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com>
 <20040427221446.GA2662@one-eyed-alien.net> <4609.171.64.70.113.1083106713.spork@webmail.coverity.com>
 <20040427230520.GB2662@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Matthew Dharm wrote:

> On Tue, Apr 27, 2004 at 03:58:33PM -0700, Ken Ashcraft wrote:
> > > On Tue, Apr 27, 2004 at 02:47:22PM -0700, Ken Ashcraft wrote:
> > >
> > >> ---------------------------------------------------------
> > >> [BUG] (mdharm-usb@one-eyed-alien.net) looks like it should return count
> > >> instead of strlen(buf), but this is in scsiglue.c, so is it special
> > >> code?
> > >>
> > >> example:
> > >> /home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/scsi_sysfs.c:274:store_rescan_field:
> > >> NOTE:READ: Checking arg count [EXAMPLE=device_attribute.store-2]
> > >>
> > >> /home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/storage/scsiglue.c:321:store_max_sectors:
> > >> ERROR:READ: Not checking arg [COUNTER=device_attribute.store-2]  [fit=1]
> > >> [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=233] [counter=1] [z >
> > >> 3.20943839741638] [fn-z = -4.35889894354067]
> > >>
> > >> 	return sprintf(buf, "%u\n", sdev->request_queue->max_sectors);
> > >> }
> > >>
> > >> /* Input routine for the sysfs max_sectors file */
> > >>
> > >> Error --->
> > >> static ssize_t store_max_sectors(struct device *dev, const char *buf,
> > >> 		size_t count)
> > >> {
> > >> 	struct scsi_device *sdev = to_scsi_device(dev);
> > >
> > > My understanding was that I was supposed to return the number of bytes in
> > > the buffer that I actually used.  I thought 'count' was the maximum size I
> > > could use.
> > >
> >
> > That sounds feasible.  I can't find any documentation on the interface, so
> > I can't tell.  However, there are ~233 functions that at least reference
> > count.  Many of them are almost identical: they call sscanf or strtol to
> > get a length out of buf, pass that length to some subroutine, and then
> > unconditionally return count.  This is a more representative example than
> > the one listed above.
> >
> > static ssize_t set_pwm_enable1(struct device *dev, const char *buf,
> >                                 size_t count)
> > {
> >         struct i2c_client *client = to_i2c_client(dev);
> >         struct asb100_data *data = i2c_get_clientdata(client);
> >         unsigned long val = simple_strtoul(buf, NULL, 10);
> >         data->pwm &= 0x0f; /* keep the duty cycle bits */
> >         data->pwm |= (val ? 0x80 : 0x00);
> >         asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
> >         return count;
> > }
>
> It seems pretty shady to me to have a function which is passed a value, the
> entire purpose of which is to return it to the caller unchanged.
>
> Perhaps someone on l-k can comment...
>
> Matt

There are many funtions that are called for their effect (like printf),
and many functions that return the same value that they were passed,
like memcpy(), memmove(), strcpy(), strncpy(), etc.

In the subject code, the effect of the function was to condition
some parameters and call another function, returning the same
value it was passed. Sounds good to me.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


