Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbULPFIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbULPFIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 00:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbULPFH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 00:07:56 -0500
Received: from main.gmane.org ([80.91.229.2]:58809 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262582AbULPFFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 00:05:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: bug in sym53c8xx? [Was: RAID1 + LVM not detected during boot on 2.6.9]
Date: Thu, 16 Dec 2004 10:05:03 +0500
Message-ID: <cpr51c$gc4$1@sea.gmane.org>
References: <DBFABB80F7FD3143A911F9E6CFD477B0033AE3D6@hqemmail02.nvidia.com> <41C0935B.7060509@pbl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksandar Milivojevic wrote:

> The timeline (during normal boot) looks something like this:
> 
>   - sym53c8xx is loaded and starts detecting disks
>   - raid1 and dm-* modules are loaded
>   - raidautorun and lvm vgscan are executed
> 
> raid1 module doesn't find anything since sym53c8xx hasn't yet reported
> any disk drives.
> 
> If I insert sleep 30 (shorter value would probably work too) after
> "insmod sym53c8xx" line in init script, and than reboot, everything
> works.  sym53c8xx has enough time to find the disk drives, so when next
> steps are taken (loading of raid1 and dm-* modules, and execution of
> raidautorun and lvm vgscan) they are there.
> 
> I'm not sure if insmod was supposed to wait until driver initializes?
> 
> In the 2.4.x kernel days, I remember there was different driver used for
> this SCSI card (Symbios Logic 53c1010 Ultra3 SCSI Adapter).  It hasn't
> suffered from this problem (it detects disks fast enough so that
> subsequent loading/initialization of raid1 works).
> 
> The question is if this is:
> 
>    - bug in sym53c8xx driver?
>    - bug in insmod?
>    - bug in init script built by mkinitrd (missing sleep)?
>    - bug in design of initrd?
> 
> If this might be a bug in sym53c8xx, let me know, and I'll file the bug
> into bugzilla.

I am not sure how to classify this bug properly. 

First, the driver correctly follows the behaviour described by Greg KH: it
should load successfully even if there is no corresonding hardware. Then
(in already-loaded state) it should generate hotplug events when the
hardware says it's present (and that's slow). Greg KH says that in hotplug
world (i.e., in reality) nothing else is possible. From this viewpoint, the
bug is in the linuxrc script provided by RedHat. It should really either
poll and sleep and wait or use udev to get notification when the disk is
really accessible.

Second, a similar problem has been discussed on LKML in September, under the
title "udev is too slow creating devices". While originally concerned with
asynchronicity due to udev itself, this therad also touches the idea that
udev doesn't really add asynchronicity, since PCI devices are really
hot-pluggable and the bus is already asynchronous. The thread starts here:

http://lkml.org/lkml/2004/9/14/298

and continues here:

http://lkml.org/lkml/2004/9/18/89

In this thread, there were the following words by Benjamin Herrenschmidt:

> Nope, Greg is right. Drivers themselves won't necessarily provide
> you with the device interface in a synchronous way after they are
> loaded, and some will certainly never. It is all an asynchronous process
> and there is simply no way to ask for any kind of enforced synchronicity
> here without major bloatage.

However, we _do_ need this synchronicity, and therefore _have_ to live with
major bloatage either in the kernel (currently that's not there) or in the
userspace (your "sleep for a magic number of seconds" here and there in
linuxrc and bootscripts). My opinion is that the needed userspace bloatage
is not centralized, also it's hard to audit, and therefore the issue of
supporting the statement "This piece of hardware must be there, it's not
really hotpluggable" must be dealt with.

P.S.: FreeBSD explicitly sleeps 15 seconds for SCSI devices to settle.

-- 
Alexander E. Patrakov

