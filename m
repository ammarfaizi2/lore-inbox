Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbULOTl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbULOTl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbULOTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:41:26 -0500
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:21205
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S262452AbULOTlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:41:18 -0500
Message-ID: <41C0935B.7060509@pbl.ca>
Date: Wed, 15 Dec 2004 13:41:15 -0600
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bug in sym53c8xx? [Was: RAID1 + LVM not detected during boot on 2.6.9]
References: <DBFABB80F7FD3143A911F9E6CFD477B0033AE3D6@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0033AE3D6@hqemmail02.nvidia.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Warren wrote:
> From: linux-kernel-owner@vger.kernel.org 
> 
>>I've installed one machine (Fedora Core 3 distro) with /boot 
>>on  RAID1 device (md0) and all other filesystems on LVM
>>volumes located on another  RAID1 device (md1).  There was
>>only one volume group, with couple of volumes for file
>>systems (one of them was root file system).
> 
> You do have the correct partition types setup, right? The underlying
> RAID partitions should be type 0xfd (Linux raid autodetect). Also, where
> are your disks attached - are you really sure that the kernel has
> drivers for your host controller in the initrd

I've did a bit of troubleshooting and found where the problem was.

The problem seems to be that sym53c8xx is "slow" in detecting disks 
connected to the SCSI controller.

The timeline (during normal boot) looks something like this:

  - sym53c8xx is loaded and starts detecting disks
  - raid1 and dm-* modules are loaded
  - raidautorun and lvm vgscan are executed

raid1 module doesn't find anything since sym53c8xx hasn't yet reported 
any disk drives.

If I insert sleep 30 (shorter value would probably work too) after 
"insmod sym53c8xx" line in init script, and than reboot, everything 
works.  sym53c8xx has enough time to find the disk drives, so when next 
steps are taken (loading of raid1 and dm-* modules, and execution of 
raidautorun and lvm vgscan) they are there.

I'm not sure if insmod was supposed to wait until driver initializes?

In the 2.4.x kernel days, I remember there was different driver used for 
this SCSI card (Symbios Logic 53c1010 Ultra3 SCSI Adapter).  It hasn't 
suffered from this problem (it detects disks fast enough so that 
subsequent loading/initialization of raid1 works).

The question is if this is:

   - bug in sym53c8xx driver?
   - bug in insmod?
   - bug in init script built by mkinitrd (missing sleep)?
   - bug in design of initrd?

If this might be a bug in sym53c8xx, let me know, and I'll file the bug 
into bugzilla.

Note about hardware (if somebody attempts to reproduce the problem):

The SCSI controller in question is integrated onto dual P-III 
motherboard (Asus CUV4X-DLS, only one CPU installed currently, runing 
single processor kernel).  There are two of them on the motherboard. 
First SCSI controller doesn't function properly, so two disk drives are 
connected to the second SCSI controller.  First SCSI controller is 
disabled in Symbios BIOS (but it seems that Linux doesn't care about 
that).  All other BIOS settings are set to default values.  Yeah, I know 
there's some faulty hardware involed, but I can't rip it out from the 
motherboard, Linux ignores the fact it is disabled, and there's nothing 
connected to it.  Plus, the old 2.4.x driver was able to handle it 
without any problems.

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
