Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRCMV1R>; Tue, 13 Mar 2001 16:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbRCMV1H>; Tue, 13 Mar 2001 16:27:07 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:51343 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S131157AbRCMV0y>; Tue, 13 Mar 2001 16:26:54 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC] fbdev & power management
Date: Tue, 13 Mar 2001 22:25:29 +0100
Message-Id: <20010313212529.16206@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on improving some aspects of Power Management on the
PowerBooks, and among other things, I have a problem with fbdevs.

Currently, each fbdev registers a power management callback to sleep/
wakeup the device. We handle HW related things (shutting the backlight
off, putting the chip to sleep when possible, backing up the frame buffer
content, etc...) from there.

We do call the video sleep last during the sleep process, and wake it up
first, to avoid any problem if something is beeing printed to the console
while the chip is suspended.

However, this is not very safe. First, there's the cursor timer, which
can screw us up. I have a hack in my tree where the fbdev driver calls a
new routine in fbcon.c that stops/starts the cursor timer.

But I'm looking toward a more generic solution. By having a way to
"suspend" the entire fbcon, maybe we can have all console output blocked
& buffered until the fbcon is woken up. Also, a question is should we
call that fbcon_suspend()/fbcon_resume() (currently only the cursor timer
stuff) from the fbdev's or should the fbcon itself register as a power
management client, and then call fbdev's suspend/resume routines ? I
prefer the second solution as the fbdev's are often PCI devices (and so
already have the ability of having PCI suspend/resume hooks).

Another solution would be to have all fbdev's have it's own suspend/
resume hook (and maintain a "suspend" state that would tell fbdev to stop
calling them or start working on a memory based backup image), and
separately, fbdev's own suspend/resume (for the cursor, as it's not head-
dependant but rather global to all fbdev's).

Any comment ?

Ben.


