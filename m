Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWF2MEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWF2MEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWF2MEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:04:14 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:54794 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751871AbWF2MEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:04:13 -0400
Date: Thu, 29 Jun 2006 14:04:19 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Regression in -git / [PATCH] i2c-i801.c: don't
 pci_disable_device() after it was just enabled
Message-Id: <20060629140419.23822395.khali@linux-fr.org>
In-Reply-To: <200606271840.56044.daniel.ritz-ml@swissonline.ch>
References: <200606271840.56044.daniel.ritz-ml@swissonline.ch>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I see that your patch was already merged, but I would like to reply
anyway.

> [PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled
> 
> Commit 02dd7ae2892e5ceff111d032769c78d3377df970:
> 	[PATCH] i2c-i801: Merge setup function
> has a missing return 0 in the _probe() function. this means the error
> path is always executed and pci_disable_device() is called even when
> the device just got successfully enabled.

Oops, good catch, thanks. I'm quite ashamed for letting this go
through :(

> having the SMBus device disabled makes some systems (eg. Fujitsu-Siemens
> Lifebook E8010) hang hard during power-off.
> 
> Intead of reverting the whole commit this patch fixes it up:
> - don't ever call pci_disable_device(), also not in the _remove() function
>   to avoid hangs

This is weird, and would certainly deserve additional investigation.
Disabling the PCI device when we no more need it is the right thing to
do and almost all pci drivers do that by now - except I2C bus drivers,
this is the first one I was attempting to convert.

Do you have any idea why disabling the SMBus causes the problem you
observe? Could be that your BIOS attempts to use the SMBus at power
down time, but I wonder what for. Do you have anything special on this
SMBus? Proprietary EEPROM? Real-time clock? I have two laptops using
this driver (one Sony, one Dell) and none exhibited the problem you
described.

> - fix missing pci_release_region() in error path

Another bug I let go through :( Thanks again.

-- 
Jean Delvare
