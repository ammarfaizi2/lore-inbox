Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966444AbWKYLl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966444AbWKYLl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 06:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935153AbWKYLl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 06:41:57 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:11599 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S934045AbWKYLl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 06:41:56 -0500
Message-ID: <45682BFB.4030202@tls.msk.ru>
Date: Sat, 25 Nov 2006 14:41:47 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Q: sysfs usage of various devices/subsystems
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux has a variety of different devices and subsystems.
For example, tun/tap devices, bridge devices, ethernet
and ATM devices, routing, serial ports, printer ports,
floppies and so on.

And each such subsystem usually comes with its own control
program.  Like, tunctl, brctl, ethtool, miitool, slattach,
even ifconfig and route (or ip), setserial, tunelp etc.

The question is: can't it all be done from sysfs, so that
there's no need to have millions of tiny control programs
around but only shell will be sufficient?

For example, for tunctl, it's not at all difficult to have
something like this:

 # create new tun
 echo tap12 > /sys/class/misc/tun/new-tap
 # assign owner (uid)
 echo 1234 > /sys/class/net/tap12/owner

This is equivalent to tunctl -u 1234 tap12.  And

  echo y > /sys/class/net/tap12/delete

is equivalent to tunctl -d tap12.

Or, for tunelp:

  tunelp lp0 -i 10	echo 10 > /sys/class/printer/lp0/irq
  tunelp lp0 -t 10	echo 10 > /sys/class/printer/lp0/time
  tunelp lp0 -c 1000	echo 1000 > /sys/class/printer/lp0/chars
  tunelp lp0 -r         echo y > /sys/class/printer/lp0/reset

and so on.

Just to show an "idea".

The same is possible even for routing table manipulation and
as a complete replacement of ifconfig (modulo the name->ip
address resolution which kernel obviously should not do), but
those subsystems are more complex.

And currently, at least some devices/subsystems implements
exactly this way.  For example, SCSI subsystem, which has
  /sys/class/scsi_device/XXX/device/rescan
and
  /sys/block/sdX/device/delete

Also, some drivers uses this sysfs way for configuration and
management, like for QLogic iSCSI controllers.

What's the general consensus about all this?  Is it not being
done because of the lack of common agreement that this way is
THE way to go, or just because of the lack of the time or too
low priority of this task?

Thanks.

/mjt
