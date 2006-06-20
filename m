Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWFTHOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWFTHOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWFTHOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:14:51 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:47296 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964918AbWFTHOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:14:51 -0400
Message-ID: <44979F99.1090807@aitel.hist.no>
Date: Tue, 20 Jun 2006 09:11:21 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jeff Gold <jgold@mazunetworks.com>
CC: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Serial Console and Slow SCSI Disk Access?
References: <448DDC7F.4030308@mazunetworks.com> <448DDF1D.5020108@rtr.ca> <448DE4F1.9000407@mazunetworks.com> <4496492A.1030907@aitel.hist.no> <4496BF65.30108@mazunetworks.com>
In-Reply-To: <4496BF65.30108@mazunetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Gold wrote:
> Helge Hafting wrote:
>> With nothing attached, any write to the serial device might go
>> through a lengthy timeout because of flow control.  [...] But I can't
>> see why it'd make scsi disks slower. The scsi host adapter 
>> initialization writes some messages of course, but there should be no
>> more console accesses during a hdparm test run.
>
> This makes sense to me.  When I attach a serial cable and use that to 
> login (I've got agetty running), hdparm produces no console messages 
> that I can see using minicom.  Still, the disk throughput is around 
> 1.5 MB/sec for some reason.  When I disable the serial console in 
> grub.conf and reboot I get over 70 MB/sec again.
>
> A combination of out-of-tree patches (mainly network related but also 
> one to disable PM_TIMERS) seem to eliminate the issue even with the 
> serial console enabled, at least for the moment.  That means I no 
> longer have a problem, but the whole thing is mysterious to me.
I can see one possibility, that I didn't think of yesterday.
Do the scsi host adapter share its interrupt with the serial line?
(Boot a kernel that has the problem, and when scsi is slow, do a
cat /proc/interrupts
If the scsi and the serial driver share an interrupt, then that is the 
source
of the problem.

Linux can share interrupts without big performance problems - IF both of
the hardware drivers are written with interrupt sharing in mind.  Many
linux drivers are, but some are not.  So check if interrupt sharing is 
happening,
and if so, contact the maintainers of your scsi driver and your serial
port driver.  Ask them if such sharing is ok or not.  If you don't
understand the /proc/interrupt listing, just send it to the
maintainers so they can have a look.

Shared interrupts are to some extent set up by the bios, and to some
extent by linux.  So different kernel versions (or booting with a different
set of drivers loaded, or a different distribution) may make a difference.

You can often get a pci device to use a different interrupt by moving it
to another slot.  That tends to solve interrupt sharing problems. I assume
your scsi adapter is pci.

Helge Hafting
