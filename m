Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVCIPx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVCIPx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCIPxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:53:25 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:53402 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261581AbVCIPv7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:51:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Michal Januszewski <spock@gentoo.org>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 16:40:09 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <20050308021706.GH26249@spock.one.pl> <200503090117.12755.arnd@arndb.de> <20050309020527.GA20294@spock.one.pl>
In-Reply-To: <20050309020527.GA20294@spock.one.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503091640.10421.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 09 März 2005 03:05, Michal Januszewski wrote:
> On Wed, Mar 09, 2005 at 01:17:11AM +0100, Arnd Bergmann wrote:
> change_console()
> complete_change_console()
> switch_screen() == redraw_screen()
> con_switch() == fbcon_switch()
> 
> From inside fbcon_switch(), we need to call the splash helper to get a
> new picture for the theme 'bar' which is used on tty2. The splash helper
> does an ioctl and we're back in the kernel.. with the console semaphore
> already held.

Ok, I now saw that you call call_usermodehelper with wait==1. Why is that
necessary? If you don't wait there, you don't need any hacks around the
console semaphore, because the helper will simply wait for change_console
to finish.
 
> What are the alternatives to the ioctl? A relatively clean way of
> feeding the data back to the kernel would be using sysfs. However, to
> make it sane we would have to export the various components of struct
> vc_splash in /sys/class/tty/tty<x> (otherwise, we would probabky have
> to pass aggreaget data types through a sysfs entry -- something that is
> IMO much worse than an ioctl). That however could be a little
> problematic -- tty_class is currently defined as a class_simple.
> To add entries other than the standard 'dev' we would have to define a
> completely new class, right? That sounds like a rather intrusive
> change..

Right. I don't think that sysfs is the right interface for this problem.
For a short moment I had the idea that you could write an escape sequence
to the tty device, but that would race against the regular output.
An ioctl on the tty device is probably the best you can do here, but
if that's not possible, creating a misc device in order to do ioctl on it
is a rather ugly hack.

 Arnd <><
