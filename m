Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbUDEFuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 01:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUDEFuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 01:50:22 -0400
Received: from mail.inter-page.com ([12.5.23.93]:9481 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S263136AbUDEFuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 01:50:00 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Pete Zaitcev'" <zaitcev@redhat.com>
Cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [linux-usb-devel] [PATCH] (linux 2.4.25) hangup on disconnect for usbserial module
Date: Sun, 4 Apr 2004 22:49:40 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA9BOg2suQOk2BJuklNeZkhAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040404221432.1a10c85a.zaitcev@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasting the whole program is impractical, so here is the psudocode

Open /dev/usb/ttyUSB0
Build Poll structure with events = POLLIN for this descriptor
Call poll(&structure,1,-1)

(Without the patch) If you pull the usb cable out of the computer, the program above
will never return from the poll.  I was quite surprised, especially since this didn't
match the behavior of the ACM device that we alternately use in our box.  The hang is
semi-terminal too, as nothing can reattach to the file descriptor from below.

If you use /dev/usb/ttyACM0 in the identical program (obviously also against a
different device 8-) when you pull the plug poll returns immediately and revents has
the (I think) POLLHUP bit set.  (I am not certain this is the value, the actual
program considers all three of POLLHUP, POLLNVAL and POLLERR equally terminal in this
case and doesn't emit the actual value, but it is at least one of those. 8-)

The hangup semantic with all its ramifications (sighup if the device is a controlling
terminal etc.) is "good for me", and matches other kinds of (USB and non-USB)
devices, but I have no opinion on particular apps.  I considered adding an IOCTL and
flag to control this but decided against for the following reasons:

The poll management happens at the far side of the tty layer, and this was the only
non-intrusive and portable way I could figure out to pass the disconnect event
through the that layer.

The CLOCAL flag already acts as a means to enable/disable tty_hangup()'s effects and
is mature and well documented as an interface feature.

There was no clear way to propagate this event that wasn't either far more delicate,
far reaching, or disruptive.


Rob.


-----Original Message-----
From: Pete Zaitcev [mailto:zaitcev@redhat.com] 
Sent: Sunday, April 04, 2004 10:15 PM
To: Robert White
Cc: linux-usb-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] (linux 2.4.25) hangup on disconnect for
usbserial module

On Sun, 4 Apr 2004 21:46:52 -0700
"Robert White" <rwhite@casabyte.com> wrote:

> This is "reasonably well tested" on the x86 platform.
> 
> This patch fixes a problem where the usbserial code would not notify
> connected programs that the serial port was going away.

> @@ -1404,9 +1408,11 @@ static void usb_serial_disconnect(struct
>                 for (i = 0; i < serial->num_ports; ++i) {
>                         port = &serial->port[i];
>                         down (&port->sem);
> -                       if (port->tty != NULL)
> +                       if (port->tty != NULL) {
> +                               tty_hangup(port->tty);
>                                 while (port->open_count > 0)
>                                         __serial_close(port, NULL);
> +                       }

I'll think about it.

If Greg approves and takes, it's fine, too.

What is the actual symptom? Did you expect a SIGHUP?

-- Pete



