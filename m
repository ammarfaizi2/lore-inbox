Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUFRJG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUFRJG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUFRJEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:04:01 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:49237 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265060AbUFRIpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:45:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/11] New set of input patches
Date: Fri, 18 Jun 2004 03:44:46 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       vojtech@ucw.cz
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406180344.46191.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is  my new set of input patches, most important IMHO is serio sysfs
integration. It is not complete in sense that we need add attributes to
individual drivers (like rate and resolution and protocol to psmouse)
and create some platform devices for i8042, q40kbd, etc so serio ports
would have parents. But the core integration is done. Unfortunately I do
not have 90% hardware to test my changes so there could be some problems,
although I tried to compile everything I could.

The patches are against Vojtech's tree and should apply to -mm as well.

01-psmouse-kvm-sync.patch
	- when getting partial packet (usually KVM resets mouse from IMPS/2
	  to bare PS/2 count it in out_of_sync counter so psmouse.resetafter
	  logic has a chance to reconnect and reestablish proper protocol;
	  set default value for psmouse.resetafter to 20 (was 0, disabled)

02-psmouse-state-locking.patch
	- Acquire underlying serio lock when changing psmouse state to
	  prevent interrupt handler runniong on us
 
03-serio-connect-mandatory.patch
	- Make serio driviers connect/disconnect methods mandatory as these
          methods open/close serio ports and link ports and drivers together

04-serio-rename-1.patch
	- Rename serio->driver to serio->port_data as with sysfs integration
	  driver is not the best name for arbitrary data

05-serio-rename-2.patch
	- Rename serio_dev to serio_driver as they are drivers in sysfs sense

06-serio-dynamic-alloc.patch
	- Switch from static to dynamic serio port allocation so serio ports
	  drivers can be freely unloaded even if not all references to ports
	  are dropped (sysfs req.)

07-serio-no-recursion.patch
	- do not do recursive discovery of children ports, needed for sysfs
          and generally better for stack

08-serio-sysfs.patch
	- sysfs integration. register ports and drivers in driver model, link
	  them all together.

09-serio-rebind.patch
	- allow user to disconnect or rebind serio port by writing appropriate
	  data to it's sysfs attribute:
		echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
		echo -n "none" > /sys/bus/serio/devices/serio0/driver

10-serio-manual-bind.patch
	- allow marking some drivers as requiring manual bind (to be used when
	  driver does not do automatic HW discovery)

11-serio_raw.patch
	- raw access to serio data ala 2.4 /dev/psaux

Vojtech, if you like some patches and want to pull any of it drop me a
note and I'll push it on bkbits.

-- 
Dmitry
