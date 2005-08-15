Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVHORvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVHORvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVHORvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:51:12 -0400
Received: from kent.litech.org ([72.9.242.215]:11786 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S964858AbVHORvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:51:12 -0400
Date: Mon, 15 Aug 2005 13:51:06 -0400
From: Nathan Lutchansky <lutchann@litech.org>
To: LKML <linux-kernel@vger.kernel.org>,
       lm-sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 0/5] improve i2c probing
Message-ID: <20050815175106.GA24959@litech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patch series makes a couple of improvements to the i2c device
probing process.

Currently, when a new i2c bus needs to be probed, the i2c subsystem
calls the attach_adapter callback for each loaded i2c client driver,
which must call the i2c_probe function with a list of addresses to be
probed and another callback for reporting detected devices:

    static int foo_attach_adapter(struct i2c_adapter *adapter)
    {
            if (!(adapter->class & I2C_CLASS_HWMON))
                    return 0;
            return i2c_probe(adapter, &addr_data, foo_detect);
    }

Virtually every i2c client driver uses exactly the same code, so there's
little point in requiring them all to implement this callback.  The
first patch in this series adds two new fields to the i2c_driver
structure, `address_data' and `detect_client', and if they are set by
the driver, the i2c core will automatically call i2c_probe using those
fields as the second and third argument.  If the `class' field of the
i2c_driver structure is set, it will be compared with the adapter class
first.

Patches 2 and 3 add these fields to the i2c_driver initializer in the
i2c hwmon and misc i2c chip drivers and remove the corresponding
attach_adapter callbacks.

The second improvement (which is really the point of this patch set) is
to add the functions i2c_probe_device and i2c_remove_device for directly
creating and destroying i2c clients on a particular adapter:

    int i2c_probe_device(struct i2c_adapter *adapter, int driver_id,
                         int addr, int kind);
    int i2c_remove_device(struct i2c_adapter *adapter, int driver_id,
                          int addr);

These functions make the i2c subsystem usable for special-purpose i2c
buses where probing isn't possible, either because probing is known to
be dangerous for devices that are present on the bus, or because the i2c
adapter lacks quick writes and/or error reporting.

The final patch adds a new i2c adapter flag to indicate that the adapter
should never be probed.

This patch set applies cleanly to the end of Greg KH's i2c patch queue,
as of 12-Aug-2005.  -Nathan

 Documentation/i2c/writing-clients |   58 ++++++++++++++---------
 drivers/hwmon/adm1021.c           |   12 +---
 drivers/hwmon/adm1025.c           |   12 +---
 drivers/hwmon/adm1026.c           |   13 +----
 drivers/hwmon/adm1031.c           |   13 +----
 drivers/hwmon/adm9240.c           |   12 +---
 drivers/hwmon/asb100.c            |   17 +-----
 drivers/hwmon/atxp1.c             |    9 ---
 drivers/hwmon/ds1621.c            |   10 ----
 drivers/hwmon/fscher.c            |   12 +---
 drivers/hwmon/fscpos.c            |   12 +---
 drivers/hwmon/gl518sm.c           |   12 +---
 drivers/hwmon/gl520sm.c           |   12 +---
 drivers/hwmon/it87.c              |   17 +-----
 drivers/hwmon/lm63.c              |   12 +---
 drivers/hwmon/lm75.c              |   13 +----
 drivers/hwmon/lm77.c              |   13 +----
 drivers/hwmon/lm78.c              |   17 +-----
 drivers/hwmon/lm80.c              |   12 +---
 drivers/hwmon/lm83.c              |   12 +---
 drivers/hwmon/lm85.c              |   12 +---
 drivers/hwmon/lm87.c              |   12 +---
 drivers/hwmon/lm90.c              |   12 +---
 drivers/hwmon/lm92.c              |   11 +---
 drivers/hwmon/max1619.c           |   12 +---
 drivers/hwmon/w83781d.c           |   17 +-----
 drivers/hwmon/w83792d.c           |   18 +------
 drivers/hwmon/w83l785ts.c         |   12 +---
 drivers/i2c/chips/ds1337.c        |    9 ---
 drivers/i2c/chips/ds1374.c        |    8 ---
 drivers/i2c/chips/eeprom.c        |   10 ----
 drivers/i2c/chips/m41t00.c        |    9 ---
 drivers/i2c/chips/max6875.c       |   10 ----
 drivers/i2c/chips/pca9539.c       |   10 ----
 drivers/i2c/chips/pcf8574.c       |   10 ----
 drivers/i2c/chips/pcf8591.c       |   10 ----
 drivers/i2c/chips/rtc8564.c       |    8 ---
 drivers/i2c/i2c-core.c            |   95 ++++++++++++++++++++++++++++++++++++--
 include/linux/i2c.h               |   21 ++++++++
 39 files changed, 246 insertions(+), 360 deletions(-)
