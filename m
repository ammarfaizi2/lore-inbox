Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbUKIXjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbUKIXjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUKIXjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:39:16 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:40550 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261768AbUKIXgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:36:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SYxCJtnlm8Tc+heEV2JrfI8y4HeNIJ3PQs9DpIzUiES2zxynA2P4hq3PwrwTT9M7vuwvPpZMt3lqXBYt5oyInUWNrgWOizTyMsdHghlN4/riDn/u/H4TxbQko/+PkYs03tRmAPEgosxa70qPu6BujqGN17EH48v72YHxJ9ibOO8=
Message-ID: <d120d5000411091536115ac91b@mail.gmail.com>
Date: Tue, 9 Nov 2004 18:36:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Cc: Tejun Heo <tj@home-tj.org>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041109223729.GB7416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041109223729.GB7416@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, 9 Nov 2004 14:37:29 -0800, Greg KH <greg@kroah.com> wrote:
> Ok, everone's been back and forth about the whole bind/unbind stuff
> lately, so let's just do this a step at a time.
> 
> How about the following patch.  It adds a "unbind" file to any device
> that is bound to a driver.  Writing any value to that file disconnects
> the device from the driver associated with it.
> 
> It's small, simple, and it works.
> 
> It also can cause bad things to happen if you aren't careful about what
> type of device you are unbinding (some i2c chip devices don't really
> unbind from the driver fully, but that's an i2c issue, and I'm working
> on it.)
> 
> Also, unbinding a device from a driver can cause the children devices to
> disappear, depending on the type of driver that is bound to the device.

With the present implementation it is pretty much impossible to do
since unbind grabs bus's rwsem. That means that any driver attempting
to remove children will deadlock. Driver core is not aware of evry bus's
topology issues that's why you need a bus method to do proper locking
and children removal.

> 
> As an example, a usb-storage device, that has a scsi-host, and scsi
> devices as children.  If you unbind the usb-storage device, the
> scsi-host and devices are all removed from the system (as they should
> be.)
> 

What about unbinding USB hub driver? It will hang because you can not
remove children on the same bus. In serio the core takes care of removing
any children before unbinding the driver, but again, this is bus-specific
implementation. The bus knows how to handle this.

I also have issue with doing it in steps - it will cause every device have
3 or 4 method-attributes - unbind, bind, rescan, [reconnect]. They all
implement very similar action - control link between device and driver.
I do not see the reason for splitting them apart and it will be a waste
of resources to have all of them as well.

-- 
Dmitry
