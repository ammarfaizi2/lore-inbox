Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVALDzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVALDzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 22:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVALDzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 22:55:19 -0500
Received: from [204.127.198.39] ([204.127.198.39]:64252 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262275AbVALDzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 22:55:09 -0500
Date: Tue, 11 Jan 2005 19:54:46 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Greg <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk
Subject: Re: [PATCH]change 'struct device' -> platform_data to firmware_data
Message-ID: <20050112035446.GA11251@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1105498626.26324.14.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105498626.26324.14.camel@sli10-desk.sh.intel.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 12 2005, at 10:57, Li Shaohua was caught saying:
> Hi,
> struct device->platform_data is designed for ACPI, BIOS or other
> platform specific data, but some drivers misused the field which makes
> adding ACPI handle in device core impossible. Greg suggested me changing
> the name of the filed and so it breaks all such drivers, and then fix
> them. I'll try to fix some, but it would be great if the driver authors
> could do it.

Whatever the original purpose of this field was, it is now in use by
several drivers for ARM systems where we need to support multiple SOCs
with slight variations and we use the platform_data field to pass 
board-specific information to the drivers. Before we had this, we were
putting ugly #ifdefs in drivers.  Examples of drivers using this
include:

- serial/8250.c. 

  platform_data points to a plat_serial8250_port structure that 
  provides per-serial port information such as capabilities and 
  uart clk rate.

- mtd/maps/various ARM drivers

  platform_data points to a flash_platform_data structure containing
  information such as bus width and function pointers for some init
  and shutdown work.

- i2c/busses/i2c-ixp4xx.c and i2c-ixp2000.c

  The IXP4xx and IXP2000 chips do not have an I2C controller and 
  use GPIO pins to create a bit-bang "adapter". What I2C lines to
  use is up to the board designer so we pass that information via 
  a custom data structure shared between the driver and the board
  level code that contains the GPIO lines to use for SCL and SDA.

  i2c-s3c2410.c also seems to use platform_data to pass board-specific
  information to the driver.

So the question I have is whether we are using the field as intended
or we have overloaded it with our own purposes?

If we are doing things incorrectly, I am not argueing that our usage
has to the way it sits. We could create a new generic serial_device and 
flash_device structures and subsystems for these, but that requires 
rewriting drivers and board ports; however, we need enough time
to work with appropriate subsystem maintainers to do so. My suggestion
is to add a new firmware_data field for use by ACPI ATM while we
clean things up in ARM world if so required.  Since ACPI is non-existent 
on ARM systems, another option is that we keep using the renamed data
structure as we have been doing. /me votes for this option

Thoughts?
~Deepak
 

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

If you complain once more, you'll meet an army of me. - Bjork
