Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbVF3VGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbVF3VGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVF3Ul5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:41:57 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:10150 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263033AbVF3UgS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:36:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i9eynvmI7jgvecl59Le1B9HvoBtVmcF9ROOkfsrYXUlIEID+vLm/w0E2JPYfANYrr2uZAyz6Gqq7qDZqLilimEmcWp+cdVk1IUUYl5UWNk5hVBSz/7Geg6C+xjZtI3lZc0mtBZ06FHKflNFQrE9yqodtE2V4u+DHxiPz7ABAEhc=
Message-ID: <d120d50005063013366a96cb99@mail.gmail.com>
Date: Thu, 30 Jun 2005 15:36:15 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: device_remove_file and disconnect
Cc: mat@mut38-1-82-67-62-65.fbx.proxad.net,
       matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050630170406.GA11334@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42C2D354.6060607@free.fr> <20050629184621.GA28447@kroah.com>
	 <42C301F7.4010309@free.fr> <20050629224235.GC18462@kroah.com>
	 <20050630072643.GA14703@mut38-1-82-67-62-65.fbx.proxad.net>
	 <20050630170406.GA11334@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/05, Greg KH <greg@kroah.com> wrote:
> On Thu, Jun 30, 2005 at 09:26:43AM +0200, mat@mut38-1-82-67-62-65.fbx.proxad.net wrote:
> 
> > > Again, any specific place in the kernel that you see not doing this?
> > I believe some drivers expected that sysfs read/write callback are always
> > called when the device is plugged so they don't check if
> > to_usb_interface/usb_get_intfdata return valid pointer.
> 
> Then they should be fixed.  Any specific examples?
> 

A lot of USB drivers implement sysfs attributes and then to something like this:

static ssize_t show_tabletProductId(struct device *dev, char *buf)
{
        struct aiptek *aiptek = dev_get_drvdata(dev);

        if (aiptek == NULL)
                return 0;

        return snprintf(buf, PAGE_SIZE, "0x%04x\n",
                        aiptek->inputdev->id.product);
}

aiptek structure is freed in aiptek_disconnect. It is possible that
CPU1 just passed that aiptek==NULL check and the task gets
rescheduled. Second CPU will do disconnect and kfree(aiptek).

You really need a semaphore in USB driver core to make sure that
device is not taken from you and that the driver that is bound to the
device is still the same.

-- 
Dmitry
