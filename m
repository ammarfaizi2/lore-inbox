Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTEPXpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbTEPXps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:45:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42713 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264638AbTEPXpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:45:47 -0400
Date: Fri, 16 May 2003 16:59:58 -0700
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516235958.GA17439@kroah.com>
References: <20030515200324.GB12949@ranty.ddts.net> <20030516223624.GA16759@kroah.com> <20030516233751.GA2045@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516233751.GA2045@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 01:37:52AM +0200, Manuel Estrada Sainz wrote:
> > > 	- Driver calls request_firmware()
> > 
> > Yeah, I agree with your comment in the code, I think a struct device *
> > should be passed here.  Or at least somewhere...
> 
>  To make compatibility with 2.4 kernel easier, I think that I'll add a
>  new 'struct device *' parameter to request_firmware(). On 2.4 kernels
>  it can be an unused 'void *'. Does that sound too ugly?

Yeah, don't use void * if you can ever help it.  As there will be two
different versions for two different kernels, just don't have that
paramater, or make it a char * like you have now for 2.4.  That seems to
make sense for 2.4 where you don't have a struct device.

> > > 	- 'hotplug firmware' gets called with ACCTION=add
> > 
> > I don't see why you need to add a new environment variable in your
> > firmware_class_hotplug() call.  What is the FIRMWARE variable for, if we
> > already have a device symlink back to the device that is asking for the
> > firmware?  Oh, you don't have that :)
> 
>  The same device can ask for different firmware images.

Ah, that makes more sense now.  Ok, I have no problem with it.

> > > 	- The call to request_firmware() returns with the firmware in a
> > > 	  memory buffer and the driver can finish loading.
> > 
> > request_firmware() can't use a static struct class_device, like you have
> > it, in order to work properly for multiple calls to request_firmware()
> > at the same time by different drivers.  Just create a new struct
> > class_device, and put it on a list, like I had to do for the tty class
> > code (and i2c_dev class code, but that isn't in the kernel to look at
> > yet...)
> 
>  Sorry, I don't know how that 'static' got there, I just wanted to
>  allocate it on the stack. But I guess that it should be dynamically
>  allocated anyway. Do I really need to put it on a list?

If you want to delete it later, you have to have some way to find it
again.  If you are just adding it and then removing it in the same
function, just allocate it dynamically, register it, sleep, and then
free it.  So then you would not need a list.

thanks,

greg k-h
