Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUHKNhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUHKNhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 09:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUHKNhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 09:37:54 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:15756 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268054AbUHKNhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 09:37:47 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <411A1B72.1010302@optonline.net>
References: <4119611D.60401@optonline.net>
	<20040811080935.GA26098@elf.ucw.cz>  <411A1B72.1010302@optonline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Aug 2004 08:37:41 -0500
Message-Id: <1092231462.2087.3.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 08:13, Nathan Bryant wrote:
> No. Remember that DMA works differently under SCSI than it does under 
> IDE. SCSI DMA is a host controller feature, whereas under IDE it is 
> enabled/disabled at the drive level and the drives have special 
> knowledge of DMA. Since generic_scsi_suspend() is the device level 
> suspend routine, it is called before the host controller's suspend 
> routine, (due to depth first traversal of device tree), which is 
> responsible for disabling the PCI slot. Only after the host controller 
> is suspended will there be no DMA, but if your real question is "can I 
> generically control a SCSI disk with PIO for software suspend" then the 
> answer is NO. For purposes of not suspending the drivers, I haven't 
> looked into how swsusp would see which host adapter owns which drive, 
> but some of the required information seems to be present in sysfs.

Actually, the answer is to most intents and purposes "yes".  You are
technically correct: there's no way to disable DMA in SCSI.  However,
once a device is quiesced, it has no outstanding commands, so there will
be no outstanding DMA to that device.  When all devices on a host have
been quiesced, then there will be no DMA at all going on *except* if the
user initiates any via another interface (like sending a device probe or
doing a unit scan).  The guarantee should be strong enough for swsusp to
proceed, but we can look at quiescing a host properly (however, we'd
need to move to a better host state model than we currently possess).

James


