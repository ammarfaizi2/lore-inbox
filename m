Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWIEQJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWIEQJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWIEQJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:09:47 -0400
Received: from xenotime.net ([66.160.160.81]:13715 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965146AbWIEQJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:09:45 -0400
Date: Tue, 5 Sep 2006 09:13:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [RFC] USB device persistence across
 suspend-to-disk
Message-Id: <20060905091318.42c273d2.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.44L0.0609051104260.14667-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0609051104260.14667-100000@iolanthe.rowland.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2006 11:26:48 -0400 (EDT) Alan Stern wrote:

> Index: mm/Documentation/usb/persist.txt
> ===================================================================
> --- /dev/null
> +++ mm/Documentation/usb/persist.txt
> @@ -0,0 +1,154 @@
> +
> +	What is the solution?
> +
> +Setting the "persist=y" module parameter for usbcore will cause the

                persist=1 ??

> +kernel to work around these issues.  If usbcore is build into the

s/build/built/

> +main kernel instead of as a separate module, you can put
> +"usbcore.persist=1" on the boot command line.  You can also change the
> +kernel's behavior on the fly using sysfs: Type
> +
> +	echo y >/sys/module/usbcore/parameters/persist

Does sysfs treat 'y' as '1'?
Anyway, it would be Good to be consistent.

> +to turn the option on, and replace the 'y' with an 'n' to turn it off.
> +
> +The "persist" option enables a mode in which the core USB device data
> +structures are allowed to persist across a power-session disruption.
> +It works like this.  If the kernel sees that a USB host controller is
> +not in the expected state during resume (i.e., if the controller was
> +reset or otherwise had lost power) then it applies a persistence check
> +to each of the USB devices below that controller.  It doesn't try to
> +resume the device; that can't work once the power session is gone.
> +Instead it issues a USB port reset followed by a re-enumeration.
> +(This is exactly the same thing that happens whenever a USB device is
> +reset.)  If the re-enumeration shows that the device now attached to
> +that port has the same descriptors as before, including the Vendor and
> +Product IDs, then the kernel continues to use the same device
> +structure.  In effect, the kernel treats the device as though it had
> +merely been reset instead of unplugged.

so does the USB device also retain its same USB address?


> Index: mm/drivers/usb/core/message.c
> ===================================================================
> --- mm.orig/drivers/usb/core/message.c
> +++ mm/drivers/usb/core/message.c
> @@ -764,7 +764,7 @@ int usb_string(struct usb_device *dev, i
>  			err = -EINVAL;
>  			goto errout;
>  		} else {
> -			dev->have_langid = -1;
> +			dev->have_langid = 1;
>  			dev->string_langid = tbuf[2] | (tbuf[3]<< 8);
>  				/* always use the first langid listed */
>  			dev_dbg (&dev->dev, "default language 0x%04x\n",

Different patch (?).

---
~Randy
