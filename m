Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTHTTN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTHTTNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:13:25 -0400
Received: from main.gmane.org ([80.91.224.249]:991 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262156AbTHTTNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:13:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Wuertele <dave-gnus@bfnet.com>
Subject: 2.4.18 usb-storage hotplug implementation question
Date: Wed, 20 Aug 2003 12:13:20 -0700
Organization: Berkeley Fluent Network
Message-ID: <m3d6f0xhv3.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:9HbN7xpNYrmbbOIU1uao/dQpADs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to augment the 2.4.18 SCSI/USB code (usb-storage) code
to be able to hot-plug and detect usb-memory cards when
plugged in. I have things working, except when I pull
out a card when a lot of I/O is happening.

The general strategy that I am using is:

1. a task polls (READ_CAPACITY) for the 3 LUNs that i have
   (using a Phison chip).
2. When it succeeds, it mounts the device

-- user process does file i/o --

3. When the card is pulled, ideally, a READ_CAPACITY fails
   and the processes with open files are sent a kill signal (SIGHUP)
   and the device unmounted.

PROBLEM
When a process is reading from the card, if the card is pulled
the Phison chip sometimes locks up, so I:
	1. reset the hub port
	2. Fail the pending read

However there is times when the usb (submit) does not come back
fast enough, so the READ_10 times out (seems to take over 10 seconds).
The abort handler is called (by scsi), which unlinks the urb
and says ok (to abort). I then return a DID_ERROR to the
SCSI-CMD. However the bottom half handler of this command
says that since the timer went off, it returns doing nothing.
In the meanwhile the user-process is stuck inside the file/io
routines (waiting on the buffer completion - in TASK_UNINTERRUPTIBLE
state). So I cannot unmount the device (or handle new mounts).

Questions:

1. Is there a better strategy than the above for dectecting
   plug-unplug?

2. How do i handle the failure?

3. What am i supposed to do in abort handler, so that the SCSI
   subsystem can continue working?

Thanks,
Dave

