Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWBRUXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWBRUXc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 15:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWBRUXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 15:23:32 -0500
Received: from 69-172-25-214.clvdoh.adelphia.net ([69.172.25.214]:64210 "EHLO
	ever.mine.nu") by vger.kernel.org with ESMTP id S932136AbWBRUXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 15:23:31 -0500
Date: Sat, 18 Feb 2006 15:23:23 -0500
Message-Id: <200602182023.k1IKNNuI012372@rhodes.mine.nu>
To: linux-kernel@vger.kernel.org
From: linuxer@ever.mine.nu
Subject: pktcdvd DVD+RW always writes at max drive speed (not media speed)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/block/pktcdvd.c it appears that in the case of DVD
rewriting, pkt_open_write always sets the write speed to pkt_get_max_speed
(the maximum writing speed reported by the drive). 

In my case, I have a new drive capable of 8x re-writing. However, all of
my existing media is rated for only 4x rewrite speed. 

When attempting to rw mount these disks, pktcdvd reports:

Feb 18 00:09:52 ever kernel: pktcdvd: write speed 11080kB/s
Feb 18 00:09:54 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 -
sense 00.54.9c (No sense)
Feb 18 00:09:54 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed

And then of course a huge heap of I/O errors on the disk. 


pktcdvd.c only calls pkt_media_speed for CD drives, not DVD
drives. dvd+rw-tools has a program, dvd+rw-mediainfo, that is able to derive
the information of the rated media speed successfully. Code from this should
be integrated into the pktcdvd driver so as to avoid this pitfall. 

However, as I don't necessarily expect someone to do this for me right
away, I have a second question:

Although migrating sensing code from dvd+rw-mediatype would be by far the
more elegant solution, it occurs to me that an easier hack would be to add
a new case to pkt_ctl_ioctl, something along the lines of
PKT_CTRL_CMD_FORCESPEED or similar, and patch pktsetup.c (simple user mode
pktcdvd setup/teardown utility, a component provided in udftools) likewise
to allow the user to specify the write speed. I would also have to add an
additional member to struct pktcdvd_device in order to store this setting
on a per device context, however. Would this work, or am I too naive about
kernel programming?

Also, would this be a welcome or useful addition anyways (regardless of
possible future media-speed autodetection), to allow the user to override
and write faster/slower than drive reports media speed, to allow the user
more flexibility in overspeed/underspeed writing based on individual media
performance? 

Thank you for taking the time to read this, and I would appreciate any of
your thoughts.

PS: Please CC me, as I am not currently subscribed to the list. 

