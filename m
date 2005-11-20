Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVKTMT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVKTMT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 07:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVKTMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 07:19:27 -0500
Received: from zorg.st.net.au ([203.16.233.9]:6604 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751222AbVKTMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 07:19:26 -0500
Message-ID: <43806A13.80706@torque.net>
Date: Sun, 20 Nov 2005 22:20:35 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marc@perkel.com
Subject: Re: Does Linux support powering down SATA drives?
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> Trying to save power consumption. I have a backup drive that is used
> only once a day to back up the main drive. So - why should I run it more
> that 10 minutes a day? What I'd like to do is keep it in an off state
> and then at night power it on, mount it up, do the backup, unmount it,
> and shut it down. Can I do that?

Yes, from lk 2.6.14 onwards.

An implementation (based on SAT:
http://www.t10.org/ftp/t10/drafts/sat/sat-r07.pdf) of
the START STOP UNIT SCSI command went into libata in
lk 2.6.14 . Hence you can use SCSI tools such as
sg_start (sg3_utils) or sdparm (sdparm) to place a
SATA disk in standby mode. For example:
"sg_start 0 /dev/sda" and "sdparm --command=stop /dev/sda"
are equivalent to "hdparm -y". The next command sent to that
disk will cause it to spin up again.

The power state machines of SCSI disks, ATA disks
and CD/DVD drives overlap but are not the same.
SATA and SAS transports add some wrinkles, see:
http://www.torque.net/sg/power.html
Spinning down disks with no mounted file systems makes
sense. However repeatedly spinning down a disk that is
periodically (e.g. 30 seconds later) accessed may shorten
its life.

In lk 2.6.15-rc1 implementations of the ATA COMMAND
PASS THROUGH (12 and 16 byte) SCSI commands went into
libata. These are defined in SAT (reference above).
libata also translates the HDIO_DRIVE_CMD and
HDIO_DRIVE_TASK ioctls into those pass through commands.
Recent versions of hdparm (I've tried 6.1 and 6.3) work as
expected. Hence "hdparm -y /dev/sda" puts the libata-connected
SATA disk /dev/sda into standby mode.
smartmontools also works for libata-connected SATA disks
in lk 2.6.15-rc1 .

The picture is not as bright for external USB and
1394 enclosures of ATA disks. They need to either
support the START STOP UNIT SCSI command or the
SAT pass through commands. I have not seen the
former and won't hold my breath waiting for the
latter.

Doug Gilbert

