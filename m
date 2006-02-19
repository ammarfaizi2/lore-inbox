Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWBSJbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWBSJbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 04:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWBSJbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 04:31:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25866 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932381AbWBSJbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 04:31:24 -0500
Date: Sun, 19 Feb 2006 09:31:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: don't bother users with unimportant messages.
Message-ID: <20060219093106.GA10010@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060219010910.GA18841@redhat.com> <20060219081523.GA9668@flint.arm.linux.org.uk> <20060219082916.GA19903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219082916.GA19903@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 03:29:16AM -0500, Dave Jones wrote:
> On Sun, Feb 19, 2006 at 08:15:23AM +0000, Russell King wrote:
>  > On Sat, Feb 18, 2006 at 08:09:10PM -0500, Dave Jones wrote:
>  > > When users see these printed to the console, they think
>  > > something is wrong.  As it's just informational and something
>  > > that only developers care about, lower the printk level.
>  > 
>  > If you're getting complaints about this, wouldn't it be better to
>  > forward them here so that they can be fixed up?
> 
> w83627hf, and probably other drivers from drivers/hwmon/

I don't see it - w83627hf registers w83627hf_driver via i2c_isa_add_driver,
which does not have any probe, remove or shutdown methods.  Moreover,
i2c_isa_add_driver doesn't set any of these methods.  So how can:

        if ((drv->bus->probe && drv->probe) ||
            (drv->bus->remove && drv->remove) ||
            (drv->bus->shutdown && drv->shutdown)) {

be true?  Local distro modifications maybe?

> 
>  > The thing about this particular message is that if you see it, the
>  > driver will _not_ work properly, so it's actually more than a
>  > "debugging" message.  It's telling you why driver FOO doesn't work.
> 
> I'm pretty certain this driver _was_ working fine before this change.

If driver->bus->{probe,remove,shutdown} are set, the driver model will
_not_ call driver->{probe,remove,shutdown} itself.  Hence, if both
contain pointers then it's highly likely the driver will not work.
Not reporting these instances will lead to users complaining "my
driver doesn't work" and then a headache for someone to work out
why - since nothing obvious will have changed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
