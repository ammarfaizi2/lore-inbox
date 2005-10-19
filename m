Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVJSRe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVJSRe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVJSRe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:34:56 -0400
Received: from smtpout.mac.com ([17.250.248.84]:64980 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751182AbVJSRe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:34:56 -0400
In-Reply-To: <1129741246.25383.23.camel@gnupooh.mitre.org>
References: <1129741246.25383.23.camel@gnupooh.mitre.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4C7CA605-435C-4B16-A3A1-44EF247BF5B0@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 26 ways to set a device driver variable from userland
Date: Wed, 19 Oct 2005 13:34:49 -0400
To: Rick Niles <fniles@mitre.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2005, at 13:00:45, Rick Niles wrote:
> There are so many ways to set a configuration value in a device  
> driver. I'm wondering which are "recommended" methods. I'm looking  
> for some sort of guidance when writing a new driver.  I kinda  
> assume this is a FAQ, but I didn't see it anyway, maybe it should  
> be added to the FAQ.
>
> OK there might not be 26 ways, but there's a few major ones. I'm  
> thinking in term of char devices so some of these might not apply  
> to block and network drivers.

I'm going to kind of try to summarize a lot of the comments I see on  
this list in general here; I may get some of the fine points wrong,  
but you should be able to get the gist of things.

> (1) ioctl, probably the oldest.

New ioctls are frowed upon, mainly because they tend to involve  
fragile binary structures that aren't very 64-bit compatible.  It's  
possible to avoid those issues, but sufficiently difficult that I  
would recommend against ioctls.

> (2) use read/write to a special configuration-only /dev file (e.g. / 
> dev/dvb)

This is similar to the above with ioctls, except using read() and  
write() instead of ioctl() on the device.  I don't recommend it for  
similar reasons.

> (3) /proc filesystem

/proc is for processes, not hardware.  There is some stuff in there  
that shouldn't be (/proc/bus/usb), but it's slowly being moved out,  
so don't introduce new stuff.

> (4) sysfs

This is ideal for almost all device driver purposes.  It's really  
easy, integrates well into the device model, trivial to configure  
from hotplug scripts which already have sysfs path info associated  
with them, etc.  The idea behind sysfs is to have small single values  
broken up into human-readable and human-useable pseudo-files.  Some  
random PCI device would have various little configuration values and  
strings, dma mode configuration, useful human-readable numbers and  
text pulled from the PCI ROM, a binary dump of PCI config space and/ 
or firmware for debugging, etc.

> (5) module load-time command line options.

These are nice and relatively easy to use, but cannot be changed at  
runtime on their own (If they have a corresponding sysfs file, then  
they can, however).  Sometimes that's appropriate, but usually you  
want a more flexible solution.

> Should EVERY variable that can be modified by say sysfs also be  
> settable by insmod command line?

I wouldn't recommend it.  Frequently such sysfs files are device- 
specific.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



