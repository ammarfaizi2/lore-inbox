Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWCMEis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWCMEis (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCMEis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:38:48 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:36759 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932098AbWCMEiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:38:46 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Mon, 13 Mar 2006 10:00:37 +0800."
             <3ACA40606221794F80A5670F0AF15F840B2DACA5@pdsmsx403> 
Date: Mon, 13 Mar 2006 04:38:27 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FIep9-0004nz-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need the acpi trace log before _PTS to see what kind of thermal
> related methods got called.

Alas, I've included all the dmesg's.  

Below is the script that I use to enter S3 sleep.  It unloads rid of
troublesome modules and stop services that don't sleep well.  Then
(for debugging) it sends the kernel version and boot parameters across
the serial console (the @@@@ SLEEP line), raises the debug level to
0x1F, does a sync (in case the sleep hangs, since this is my
production machine), and then enters mem sleep.

So nothing in it should trigger any thermal methods; except that I
usually have the THM2 trip point raised to 45C with a polling time of
100 seconds.  So once in a while a thermal poll will happen sleep is
being set up.  I am not sure whether it would be reported in the
dmesgs if it happened; but the S3 failure happens much more often than
such a thermal polling would happen, so I doubt the S3 failure
requires a thermal poll.

#!/bin/bash -x
# S3 (suspend to memory), with cleanups before and after
sync
ifdown eth0
remove='prism54 xircom_cb xircom_tulip_cb' 
remove2='snd_pcm_oss snd_cs46xx'
modprobe -rv $remove
modprobe -rv $remove2
/etc/init.d/chrony stop  > /dev/null

sleep 1

(echo "@@@@ SLEEP" ; date ; uname -a ; cat /proc/cmdline ) > /dev/tts/0
echo 0x0000001F > /proc/acpi/debug_level
sync
sleep 2
echo -n mem > /sys/power/state
[stuff for wakeup snipped]
