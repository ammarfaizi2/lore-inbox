Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264130AbUD0Qq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbUD0Qq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUD0Qq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:46:26 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:33176 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264130AbUD0QqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:46:18 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Tue, 27 Apr 2004 18:46:03 +0200
From: stefan.eletzhofer@eletztrick.de
To: Greg KH <greg@kroah.com>
Cc: stefan.eletzhofer@eletztrick.de, linux-kernel@vger.kernel.org
Subject: Re: i2c_get_client() missing?
Message-ID: <20040427164603.GB2517@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20040427150144.GA2517@gonzo.local> <20040427153512.GA19633@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427153512.GA19633@kroah.com>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:35:12AM -0700, Greg KH wrote:
> On Tue, Apr 27, 2004 at 05:01:44PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> > Hi,
> > I'm in the process of porting my Epson 8564 RTC chip from 2.4 to
> > 2.6.6-rc2. This is a RTC chip sitting on a I2C bus.
> > 
> > The code is here:
> > http://213.239.196.168/~seletz/patches/2.6.6-rc2/i2c-rtc8564.patch
> > http://213.239.196.168/~seletz/patches/2.6.6-rc2/machine-raalpha-rtc.patch
> > 
> > In order to split up functionality (I2C bus access and RTC misc device
> > stuff) I wrote two separate modules. In the rtc code module I did a i2c_get_client()
> > with the ID of my RTC chip to get a struct i2c_client which I think I need to
> > talk to the chip. I've implemented the command callback in my I2C module, which
> > I want to call from my RTC module.
> > 
> > Now I find that in 2.6.6-rc2 the i2c_get_client() implementation is missing (the prototype
> > is still in linux/i2c.h). Even the docs for i2c_use_client() refer to that function.
> 
> It was removed as there were no users of it from what I remember.  I
> should go and delete that prototype too...
> 
> > Most probably I'm missing something, but how is one supposed to access a i2c-client's
> > command function when i2c_get_client() is missing?
> 
> Where do you need to access it from?  Why do all of the current drivers
> not need it?

Well, in my RTC module I want to access the chip driver's command function, because I
encapsulated all I2C and low-level RTC chip access there.

Basically I want to do something like:
------------------------------------------------
  struct i2c_client client = NULL;

  client = i2c_get_client( I2C_DRIVERID_RTC8564, 0, NULL );

  ...

  ret = client->driver->command(client, cmd, data);
------------------------------------------------

Where cmd, data are commands and data for the RTC chip driver. The above code
is in my rtc driver module, which does all the misc /dev/rtc driver stuff.

I don't know why all other drivers don't need them. It may well be that most of the drivers
in drives/i2c/chips are sensors-like drivers, which have sysfs/proc userspace interfaces and are
never called/used by other modules.

The drivers/media/video tree contains some cards which apparently have their own I2C bus on it,
and they do som nasty (?) stuff to get similar functionality. They have implicit access to their i2c adapters,
and thus can walk the adapter's client list. 

In my case I haven't access to the i2c adapter, and I dont want to be dependent on the
I2C adapter my chip sits on. Therefore I think i2c_get_client() is needed.

> 
> > Of course I could just merge these two drivers and forget about
> > separating i2c chip access and rtc stuff, but ...
> 
> If you always need both drivers to get the system to work, and there's
> no real reason to split them up...

Well, I thought that maybe not everyone wants to implement a full-blown /dev/rtc style
interface, for example some ppl might implement a sensors-like /sysfs userspace interface
for that RTC chip. On embedded systems (where I do all this) some ppl might not be interested
in the RTC functionality of that chip but may be interested to use it as low-power counting
device, which even sends IRQs using a separate IRQ line.

> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
