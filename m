Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbTCYHOj>; Tue, 25 Mar 2003 02:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbTCYHOj>; Tue, 25 Mar 2003 02:14:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8209 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261595AbTCYHOh>;
	Tue, 25 Mar 2003 02:14:37 -0500
Date: Mon, 24 Mar 2003 23:25:12 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: How to convert i2c adapter drivers into good kernel code
Message-ID: <20030325072511.GD12590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, enough people have been asking me for this over the past week, so
here's a rough cut:

How to convert the i2c CVS adapter drivers to the new i2c changes
(or, how do I get that driver that I'm using into the main kernel tree)

Please only do this if you have the hardware for the driver you want to
port.  Or if not, be prepared to handle lots of user email :)

Here's the steps to do this work:

 - Resync with the lm_sensors CVS tree (instructions for how to do this
   is at: http://secure.netroedge.com/~lm78/download.html).  Go into the
   kernel/busses/ directory and copy the i2c-*.c file that you want to
   convert to your up to date kernel tree's drivers/i2c/busses/
   directory.

 - Add the proper drivers/i2c/busses/Makefile and
   drivers/i2c/busses/Kconfig entries for the driver.  Remember to add a
   help section for the configuration entry, and try to keep the
   Makefile in alphabetical order.

 - Test that the Makefile and Kconfig changes work.  Yes, the driver
   will probably blow up on compile time into a lot of little pieces,
   but at least you have added it to the build process properly :)

 - remove the
 	#include "version.h"
   line in the driver, and replace the LM_VERSION and LM_DATE entries
   with I2C_VERSION and I2C_DATE to fix that compile time error.

 - If this is a pci driver:
 	- fill in the pci_device_id table with the proper device ids.
	  These can usually be found in the probe function (or in the
	  function that the probe function calls).
	- add a struct pci_dev * parameter to the probe function if it
	  doesn't have it, and fix up any other pci probe logic errors.
   Examples of this kind of change can be seen here:
  	http://linux.bkbits.net:8080/linux-2.5/patch@1.889.334.6
		
 - If the driver calls check_region(), replace that with the test to
   request_region.
 
 - Fix all oddly formatted code (comments at the left side of the line,
   no tabs, etc.)

 - Make all functions and variables static.

 - Change all printk() calls to dev_* calls.  In doing this, all
 	#ifdef DEBUG
   lines can be removed.  Delete all instances of the driver's name in
   the printk() calls, as it is redundant with the dev_* calls.
 
 - Change the .name of the driver to use the .dev.name field.

 - When copying the name of the driver into .dev.name, use snprintf()
   and DEVICE_NAME_SIZE.
 
 - Right before calling i2c_add_adapter(), set up the
   i2c_adapter.dev.parent pointer to be the pci device.  This can be
   seen in the following patch:
	http://linux.bkbits.net:8080/linux-2.5/patch@1.889.334.10
   If this is not a pci driver, do not worry about this step, just make
   sure the parent pointer is NULL, and the driver will get placed onto
   the legacy bus in sysfs.

And that should be about it.  If all of the above works out, the driver
should build, and when loaded, it should show up in the sysfs directory
/sys/bus/pci/drivers.  Go into the device that driver binds to, and you
should see a i2c? directory, which is the start of the i2c bus bound to
that adapter.

Then, make up a patch (read Documentation/SubmittingPatches) and send
it off to me, copying the list.

If there are any questions about any of this, or I forgot any steps,
please let me know.

thanks,

greg k-h

