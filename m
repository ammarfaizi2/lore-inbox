Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269606AbUIRSnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269606AbUIRSnO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 14:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269609AbUIRSnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 14:43:14 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:50243 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269606AbUIRSnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 14:43:11 -0400
Message-ID: <9e47339104091811431fb44254@mail.gmail.com>
Date: Sat, 18 Sep 2004 14:43:06 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Design for setting video modes, ownership of sysfs attributes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original proposal.....
At OLS we talked about a system like this for setting video modes:

1) user owns graphics devices
2) user sets mode with string (or similar) format using ioctl common to
all drivers.
3) driver is locked to prevent multiple mode sets
4) common code takes this string and does a hotplug event with it.
5) hotplug event runs root context in user space 
6) mode is decoded and verified, this may involve a little process that
maintains the DDC database and reads a file of legal modes. Other
schemes are possible.
7a) mode is set using VBIOS and vm86, signal driver mode is set
7b) the register values needed to set the mode are passed into a root
priv ioctl.
8) driver is unlocked.

In this model all of the verification happens in user space. If you
want to set modes other than the ones from DDC you have to add them to
the config file. There is no need for DDC support and mode verification
in the kernel.

To give credit this is Alan Cox's design.

---------------------------------------------------------------------------------

I'm now starting to implement this design. Would it be better to set
the mode via sysfs attributes? This would allow mode settting with
something like: "echo 'my mode string' /sys/class/drm/card0/mode" A
list of available modes could be in /sys/class/drm/card0/modes

Can PAM change the ownership of a sysfs attribute/directory on login?
For this to work logging in needs to assign you ownership of the
attribute since you want to be able to change it but not anyone else.
DRM may need to assign the ownership of multiple attributes, is this
easy to do?

How are errors going to be communicated in this scheme? I can cat the
sysfs mode variable to get a status. Is there a good way to do this
without polling?

If the sysfs scheme doesn't work mode setting will need to be an IOCTL
with a small program since PAM can change the ownership of the DRM
device. The sysfs scheme has the major advantage of avoiding the need
for the small program.

If we go the sysfs route what is BSD going to do, will we have to
build parallel implementations?

-- 
Jon Smirl
jonsmirl@gmail.com
