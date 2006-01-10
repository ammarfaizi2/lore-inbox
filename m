Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWAJXVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWAJXVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030682AbWAJXVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:21:45 -0500
Received: from zorg.st.net.au ([203.16.233.9]:6352 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751291AbWAJXVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:21:43 -0500
Message-ID: <43C441A5.6000205@torque.net>
Date: Wed, 11 Jan 2006 09:22:13 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Treubig <jtreubig@hotmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Error handling in LibATA
References: <BAY101-F102837A76FADACF6F37DBBDF250@phx.gbl>
In-Reply-To: <BAY101-F102837A76FADACF6F37DBBDF250@phx.gbl>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Treubig wrote:
> I've been working on a problem with Promise 20269 PATA adapter under
> LibATA that if the drive has a write error or time-out, the application
> that is accessing the drive using SG should see some sort of error.  My
> first problem was my system hung.  After patching the IDE-IO.C, with a
> recognized patch, I have been able to keep my system from hanging.  Now
> the only problem is the application gets no notification that the drive
> has been rendered inaccessible.  (Test case is to run a system with my
> app going, and then pull the power from the drive.  System log shows the
> errors, but nothing gets back to the app).  The app does get
> notifications if I perform the same type of test on a drive attached to
> the motherboard secondary IDE adapter, so we know the app is correctly
> implemented.
> 
> I've traced the errors down to the fact that the errors are caught in
> libata-core.c (ata_qc_timeout).  I'd like to put a call in libata-core.c
> that would cause an error to be reflected back to the application.  Can
> you suggest the function or method that would do this?

John,
SG_IO ioctl users would normally expect to see DRIVER_TIMEOUT
(plus a suggest mask) in sg_io_hdr::driver_status when a
mid level timeout goes off. So that needs to be "wired"
in libata (along with some other transport errors I suspect).

Here is an example of a timeout using the scsi_debug driver:
# modprobe scsi_debug ptype=9 delay=200000
# lsscsi -g
[0:0:0:0]    comms   Linux    scsi_debug       0004  -         /dev/sg0
# sg_start /dev/sg0
start stop unit: transport: Driver_status=0x06 [DRIVER_TIMEOUT, SUGGEST_OK]
START STOP UNIT command failed


Doug Gilbert
