Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbUKDRTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbUKDRTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUKDRNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:13:42 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:40029 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262299AbUKDRFh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:05:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 4/4] driver-model: attach/detach sysfs node implemented
Date: Thu, 4 Nov 2004 12:05:31 -0500
User-Agent: KMail/1.6.2
Cc: Tejun Heo <tj@home-tj.org>, rusty@rustcorp.com.au, mochel@osdl.org,
       greg@kroah.com
References: <20041104074330.GG25567@home-tj.org> <20041104074628.GK25567@home-tj.org>
In-Reply-To: <20041104074628.GK25567@home-tj.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411041205.32028.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 02:46 am, Tejun Heo wrote:
>  ma_04_manual_attach.patch
> 
>  This patch implements device interface nodes attach and detach.
> Reading attach node shows the name of applicable drivers.  Writing a
> driver name attaches the device to the driver.  Writing anything to
> the write-only detach node detaches the driver from the currently
> associated driver.
> 
...
> +/**
> + *   detach - manually detaches the device from its associated driver.
> + *
> + *   This is a write-only node.  When any value is written, it detaches
> + *   the device from its associated driver.
> + */
> +static ssize_t detach_store(struct device * dev, const char * buf, size_t
> n)
> +{
> +     down_write(&dev->bus->subsys.rwsem);
> +     device_release_driver(dev);
> +     up_write(&dev->bus->subsys.rwsem);
> +     return n;
> +}

This will not work for pretty much any bus but PCI because only PCI
allows to detach a driver leaving children devices on the bus. The
rest of buses remove children devices when disconnecting parent.

Also, there usually much more going on with regard to locking and
other bus-specific actions besides taking bus's rwsem when binding
devices. Serio bus will definitely get upset if you try to disconnect
even a leaf device in the manner presented above and I think USB
will get upset as well.

I have tried the naïve approach as well but in the end we need bus
-specific helper to do manual connect/disconnect. Please take a look
at these:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109908274124446&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109912528510337&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109912553831130&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109912553827412&w=2

-- 
Dmitry
