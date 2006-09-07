Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWIGXNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWIGXNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWIGXNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:13:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:49728 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1422698AbWIGXNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:13:40 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,227,1154934000"; 
   d="scan'208"; a="127329274:sNHT241364970"
Date: Thu, 7 Sep 2006 16:13:05 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com
Subject: patch [0/2]: acpi: add generic removable drive bay support
Message-Id: <20060907161305.67804d14.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Ever since I put out the docking station patches people have been asking me
if I could get removable drive bays to work as well.  These are devices such
as the IBM/Lenovo Ultrabay, or the Dell Module Bay - basically removable disk
drives.  There is an IBM platform specific solution that works with some IBM
laptops, but nothing generic.  In addition, the ibm_acpi driver had the
limitation that it would not correctly identify ultrabay devices that had
been inserted after the OS booted.  This driver implements bay handling 
using ACPI to safely power off the drive.  It works similarly
to the ibm_acpi driver, in that it will simply generate an acpi event which
can then be used by udev to unmount or rescan depending on the event.  It will
create a proc entry under /proc/acpi/bay for "eject" and for "status".  Writing 
a 1 to the eject call will cause the drive bays acpi eject method to be called, 
and should be done prior to removing the device.  Reading the "status" entry
will tell you either "present" or "removed" depending on the state of the
device.  User space scripts can use the status entry to determine if a device
has been either inserted or removed in the case of some laptops who generate
the exact same event for either insertion or removal (i.e. the Dell M65 for
example).  Same scripts for using these events and udev can be found on the
thinkwiki website:

http://www.thinkwiki.org/wiki/How_to_hotswap_UltraBay_devices#When_using_the_ata
_piix_driver

Note that due to the lack of hotplug PATA, this driver will only work with 
SATA devices, or with ata_piix driver.  Hopefully if/when hotplug PATA support
gets into libata, we can support that as well.

Note that this driver does not have the same limitations that the ibm_acpi
driver had with regard to device insertion after booting.  i.e. - if you boot
the laptop without a drive bay inserted, and then insert the drive bay later
on, this driver will still detect the insertion and send an event to user
space.  The bay driver will also register with the dock station driver so that
if the removeable drive bay is on a dock station, an event will be sent to
userspace upon dock/undock that will allow any udev scripts specifically for
bay handling to still be executed.

The driver still needs more testing, and I still have a little bit of funkiness
to sort out with the Lenovo X60 with the SATA controller in compatibility
mode - but I think it is ready for you to experiment with if you like and
I hope that you will give it a try and send me any feedback you have.

patch 1 is just a bug fix to the dock driver that will allow devices who's 
parents are listed as being on the dock to also be recognized as being on
a dock station.  patch 2 is the driver.

Thanks,
Kristen
