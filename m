Return-Path: <linux-kernel-owner+w=401wt.eu-S1753932AbXACCxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbXACCxY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbXACCxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:53:24 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:52953 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbXACCxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:53:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a75o/Bu4DTR/hK3Nugmwg9i8HWY5lZvqosGhdUikbj+r9Vxz+6UWP17YmtZFep3DJss0dw9ItGOiYSn2TQf0D1hIO2x1dT/An8je+FafwmX2bZVM21Whv7a1R+m67rsW7wIePfo+SsacvgDmtIP6GD6Yc3sOKXnd2JzkYtcQPFg=
Message-ID: <9e4733910701021853qa6830b5xd0bcc0746e43a218@mail.gmail.com>
Date: Tue, 2 Jan 2007 21:53:23 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
Subject: snd/core, freeing the device driver when an USB audio device is unplugged
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a basic problem in the way snd/core is handling the removal
of devices. If I unplug a USB audio device snd/core will end up in:
snd_card_free_when_closed. This isn't good because some desktop app
(don't know which one) keeps the sound device open until it exits.
This is not a good state to be in, the hardware is gone but the device
is still around.

Now if I plug the USB audio device back in, I get a sysfs error for
registering duplicate devices. Because snd_card_free_when_closed. is
waiting for the old device to be closed it is never freeing the sysfs
device. More looks to be messed up inside of snd/core when in this
state, but this is the obvious symptom.

Things do work properly if I restart gnome (killing whoever has the
card open) after I unplug the device and before I plug it back in
again.

I added a few printk to snd/core/init.c

-- I unplug my USB sound device
usb 2-1: USB disconnect, address 2
-- Inside sound core, I go into snd_card_free_when_closed
snd_card_free_when_closed

-- If I plug the snd device back in , the kernel will complain about a
device being registered twice. That because gnome (or something in the
desktop) is still holding the device open.

--- Now I restart gnome which closes whatever had the card open
snd_card_file_remove
snd_card_do_free
-- device finishes getting unregistered
unregistering device

using 2.6.20-rc3

-- 
Jon Smirl
jonsmirl@gmail.com
