Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbVH3NWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVH3NWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVH3NWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:22:36 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:53717 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751431AbVH3NWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:22:35 -0400
Message-ID: <43145D95.8060006@acm.org>
Date: Tue, 30 Aug 2005 08:22:29 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>,
       openipmi-developer@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re:  [PATCH] IPMI: driver model and sysfs support
References: <2538186705083003561f5f97e0@mail.gmail.com>
In-Reply-To: <2538186705083003561f5f97e0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is very good.  I believe the structure is correct, but I'm not a 
sysfs expert.

There are a few things we need to deal with, though.

* There are some significant changes to versioning in the
  driver that are in the mm tree right now (you can pull them from
  
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/broken-out)

* There are some coding style problems.  You have places like:
  +static void ipmi_bmc_unregister(struct ipmi_si_device *si,
  + struct ipmi_bmc_device *bmc){
  The '{' for functions and structures needs to be on it's own line.
  Also, several:
  + if(bmc->guid_present){
  that need spaces after the 'if' and before the '{'.
  The patch also adds some trailing spaces to empty lines, the
  following is a telltale sign:
  -
  +
  There was also one place where you added unneeded braces to
  a single statement and another where you deleted the empty line
  between two functions.
  These are all standard kernel coding style rules.

* I'd prefer to store the product id, device id, and manufacturer id
  decoded.  This makes it easier to handle (no need to use "memcmp"
  to compare) and print.  The printing of the product id, for instance,
  will be rather unnatural in product_id_show().

* guids are not printable strings (see guid_show()).

* The printing of the guid in ipmi_bmc_register is, well, kind of ugly.
  It should probably be moved to its own function that lets you pass in
  the rest of the string.

-Corey

Yani Ioannou wrote:

>Hi Corey,
>
>Here is a patch against 2.6.13 I've been working on (and mentioned to
>you at OLS), that adds support for the 2.6 driver model, and sysfs to
>the ipmi subsystem. It is loosely inspired by the USB driver model
>system. There is a driver struct added for the ipmi_msghandler, and
>one for each system interface 'driver' (for each state machine in
>ipmi_si). A device struct is created for each system interface in the
>system, and for each unique BMC on the system, with a symlink between
>each system interface and the bmc it interfaces to. Each bmc has a set
>of fundamental device attributes, and each of the drivers has a
>version attribute reflecting the driver/state machine versions.
>Furthermore each of these devices is registered as a class_device with
>the ipmi class (moved to ipmi_msghandler) as bmcx and smix.
>
>This in effect creates the following sysfs interface on a machine with
>a single BMC and two interfaces:
>
>/sys/
>|-- block
>|-- bus
>|   |-- platform
>|   |   |-- devices
>|   |   |   |-- ipmi_bmc.0 -> ../../../devices/platform/ipmi_bmc.0
>|   |   |   |-- ipmi_si.0 -> ../../../devices/platform/ipmi_si.0
>|   |   |   |-- ipmi_si.1 -> ../../../devices/platform/ipmi_si.1
>|   |   `-- drivers
>|   |       |-- ipmi_bt_sm
>|   |       |   |-- bind
>|   |       |   |-- ipmi_si.1 -> ../../../../devices/platform/ipmi_si.1
>|   |       |   |-- unbind
>|   |       |   `-- version
>|   |       |-- ipmi_kcs_sm
>|   |       |   |-- bind
>|   |       |   |-- ipmi_si.0 -> ../../../../devices/platform/ipmi_si.0
>|   |       |   |-- unbind
>|   |       |   `-- version
>|   |       |-- ipmi_msghandler
>|   |       |   |-- bind
>|   |       |   |-- ipmi_bmc.0 -> ../../../../devices/platform/ipmi_bmc.0
>|   |       |   |-- unbind
>|   |       |   `-- version
>|-- class
>|   |-- ipmi
>|   |   |-- bmc0
>|   |   |   `-- device -> ../../../devices/platform/ipmi_bmc.0
>|   |   |-- ipmi0
>|   |   |   `-- dev
>|   |   |-- ipmi1
>|   |   |   `-- dev
>|   |   |-- smi0
>|   |   |   `-- device -> ../../../devices/platform/ipmi_si.0
>|   |   `-- smi1
>|   |       `-- device -> ../../../devices/platform/ipmi_si.1
>|-- devices
>|   |-- platform
>|   |   |-- ipmi_bmc.0
>|   |   |   |-- bus -> ../../../bus/platform
>|   |   |   |-- device_id
>|   |   |   |-- driver -> ../../../bus/platform/drivers/ipmi_msghandler
>|   |   |   |-- firmware_revision
>|   |   |   |-- ipmi_version
>|   |   |   |-- power
>|   |   |   |   `-- state
>|   |   |   |-- product_id
>|   |   |   `-- revision
>|   |   |-- ipmi_si.0
>|   |   |   |-- bmc -> ../../../devices/platform/ipmi_bmc.0
>|   |   |   |-- bus -> ../../../bus/platform
>|   |   |   |-- driver -> ../../../bus/platform/drivers/ipmi_kcs_sm
>|   |   |   `-- power
>|   |   |       `-- state
>|   |   |-- ipmi_si.1
>|   |   |   |-- bmc -> ../../../devices/platform/ipmi_bmc.0
>|   |   |   |-- bus -> ../../../bus/platform
>|   |   |   |-- driver -> ../../../bus/platform/drivers/ipmi_bt_sm
>|   |   |   `-- power
>|   |   |       `-- state
>|-- kernel
>|-- module
>|   |-- ipmi_devintf
>|   |   |-- refcnt
>|   |   `-- sections
>|   |       `-- __param
>|   |-- ipmi_msghandler
>|   |   |-- refcnt
>|   |   `-- sections
>|   |       |-- __ksymtab
>|   |       `-- __ksymtab_strings
>|   |-- ipmi_si
>|   |   |-- refcnt
>|   |   `-- sections
>|   |       `-- __param
>`-- power
>
>My motiviation for the patch is to have a device struct (bmc) to
>register with the new hwmon class for my in-progress hwmon driver
>ipmi_sensors. With this patch the driver can create device attributes
>under bmc devices representing sensor readings for the
>hwmon/lm_sensors interface.
>
>I have tested the patch on two systems of mine with a single bmc, it
>should however also work for a machine with multiple bmcs using the
>guid/product+device id to differentiate.
>
>Thanks,
>Yani
>  
>

