Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVC0O5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVC0O5A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVC0O4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:56:21 -0500
Received: from isilmar.linta.de ([213.239.214.66]:30907 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261758AbVC0OlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:41:15 -0500
Date: Sun, 27 Mar 2005 16:42:47 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>, mochel@digitalimplant.org
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050327144246.GA9800@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, mochel@digitalimplant.org,
	dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <d120d500050315094724938ffc@mail.gmail.com> <20050315193415.GA26299@kroah.com> <20050315201503.GA3591@isilmar.linta.de> <20050315221431.GC28880@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315221431.GC28880@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 02:14:31PM -0800, Greg KH wrote:
> It will not make the reference counting logic easier to get wrong, or
> easier to get right.  It totally takes it away from the user, and makes
> them implement it themselves if they so wish (like the USB HCD patch
> does.)

Hi,

While looking more closely at your patches, I noticed the following race:

A) attribute is opened -> class_device's reference count is increased

B) usb/host/ohci-dbg.c::remove_debug_files() -- succeeds, as it doesn't check
   class_device's reference count()
B) usb/core/hcd.c::usb_deregister_count() -- class_device_unregister doesn't
   wait until class_device's reference count reaches zero, so 
   struct class_device still has "struct usb_bus *bus" saved as class_data
   and continues to exist.

B) possibly the kref count of struct usb_bus reaches zero, and struct usb_bus *
   is kfreed.

A) attribute is read -> e.g. usb/host/ohci-dbg.c::show_periodic()
        bus = class_get_devdata(class_dev);
        hcd = bus->hcpriv;
  --> accessing kfree'd structure. Ooops.

A) ... [if it hadn't oopsed] attribute is closed, reference count reaches zero,
   class_device is removed.


If both reference counts were kept unified (as with previous struct 
class{,_device} design) this couldn't happen. The proper reference counting
for dynamically allocated objects and their "attributes" is _the_ advantage 
of sysfs/driver model in favour of procfs.

Or am I missing something?

Thanks and Happy Easter,
	Dominik
