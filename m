Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUI2Auo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUI2Auo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUI2Asi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:48:38 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5257 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268122AbUI2ArE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:47:04 -0400
Subject: Core scsi layer crashes in 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096401785.13936.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Sep 2004 21:03:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some stress testing for Fedora Core 3 and lets say the
SCSI layer came apart under stress. 

First problem was a device with 256 byte sector sizes. When it probes I
get a chain of errors. If I then try and mount it then it hangs the
mount forever. If you remove the USB scsi device to try and unjam it you
get errors logged about Invalid State 256 in USB reset and it doesn't
recover.

Second problem is with the scsi handling logic for errors. If you rmmod
a scsi driver while it is error handling you get a chain of errors
starting with

	Illegal transition Cancel->Offline
	Badness is scsi_device_set_state
	path:
	scsi_device_set_state
	scsi_unjam_host
	scsi_error_handler

This is followed by a series of further errors including kobject errors
and oopses. Then the machine dies.

The set up is fairly simple. Its a a disk and two scsi cd multichangers
configured so that I can also badly terminate them. In that situation
identify works but other commands tend to fail which allows good error
stressing.


