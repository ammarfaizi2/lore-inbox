Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265858AbTL3WIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbTL3WGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:06:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:44737 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263424AbTL3WGZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:25 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <1072821970727@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:10 -0800
Message-Id: <10728219702169@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.6.2, 2003/12/04 00:43:55-08:00, khali@linux-fr.org

[PATCH] I2C: i2c documentation (1 of 2)

This is the document I wrote (and you reviewed) about porting client
drivers to Linux 2.6. The retained name is "porting-clients" (in line
with writing-clients). I won't commit it to i2c/lm_sensors2 CVS, since
that document is of no use outside of the 2.6 kernel (and I'm bored
keeping files in sync).


 Documentation/i2c/porting-clients |  121 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+)


diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/i2c/porting-clients	Tue Dec 30 12:32:57 2003
@@ -0,0 +1,121 @@
+Revision 3, 2003-10-04
+Jean Delvare <khali@linux-fr.org>
+Greg KH <greg@kroah.com>
+
+This is a guide on how to convert I2C chip drivers from Linux 2.4 to
+Linux 2.6. I have been using existing drivers (lm75, lm78) as examples.
+Then I converted a driver myself (lm83) and updated this document.
+
+There are two sets of points below. The first set concerns technical
+changes. The second set concerns coding policy. Both are mandatory.
+
+Although reading this guide will help you porting drivers, I suggest
+you keep an eye on an already ported driver while porting your own
+driver. This will help you a lot understanding what this guide
+exactly means. Choose the chip driver that is the more similar to
+yours for best results.
+
+Technical changes:
+
+* [Includes] Get rid of "version.h". Replace <linux/i2c-proc.h> with
+  <linux/i2c-sensor.h>. Includes typically look like that:
+  #include <linux/module.h>
+  #include <linux/init.h>
+  #include <linux/slab.h>
+  #include <linux/i2c.h>
+  #include <linux/i2c-sensor.h>
+  #include <linux/i2c-vid.h>     /* if you need VRM support */
+  #include <asm/io.h>            /* if you have I/O operations */
+  Some extra headers may be required for a given driver.
+
+* [Addresses] SENSORS_I2C_END becomes I2C_CLIENT_END, SENSORS_ISA_END
+  becomes I2C_CLIENT_ISA_END.
+
+* [Client data] Get rid of sysctl_id. Try using standard names for
+  register values (for example, temp_os becomes temp_max). You're
+  still relatively free here, but you *have* to follow the standard
+  names for sysfs files (see the Sysctl section below).
+
+* [Function prototypes] The detect functions loses its flags
+  parameter. Sysctl (e.g. lm75_temp) and miscellaneous (e.g.
+  swap_bytes) functions are off the list of prototypes. This
+  usually leaves five prototypes:
+  static int lm75_attach_adapter(struct i2c_adapter *adapter);
+  static int lm75_detect(struct i2c_adapter *adapter, int address,
+      int kind);
+  static void lm75_init_client(struct i2c_client *client);
+  static int lm75_detach_client(struct i2c_client *client);
+  static void lm75_update_client(struct i2c_client *client);
+
+* [Sysctl] All sysctl stuff is of course gone (defines, ctl_table
+  and functions). Instead, right after the static id definition
+  line, you have to define show and set functions for each sysfs
+  file. Only define set for writable values. Take a look at an
+  existing 2.6 driver for details (lm78 for example). Don't forget
+  to define the attributes for each file (this is that step that
+  links callback functions). Use the file names specified in
+  Documentation/i2c/sysfs-interface for the individual files. Also
+  convert the units these files read and write to the specified ones.
+  If you need to add a new type of file, please discuss it on the
+  sensors mailing list <sensors@stimpy.netroedge.com> by providing a
+  patch to the Documentation/i2c/sysfs-interface file.
+
+* [Attach] For I2C drivers, the attach function should make sure
+  that the adapter's class has I2C_ADAP_CLASS_SMBUS, using the
+  following construct:
+  if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
+          return 0;
+  ISA-only drivers of course don't need this.
+
+* [Detect] As mentioned earlier, the flags parameter is gone.
+  The type_name and client_name strings are replaced by a single
+  name string, which will be filled with a lowercase, short string
+  (typically the driver name, e.g. "lm75"). The errorN labels are
+  reduced to the number needed. If that number is 2 (i2c-only
+  drivers), it is advised that the labels are named exit and
+  exit_free. For i2c+isa drivers, labels should be named ERROR0,
+  ERROR1 and ERROR2. Don't forget to properly set err before
+  jumping to error labels. By the way, labels should be
+  left-aligned.
+  Use memset to fill the client and data area with 0x00.
+  Use i2c_set_clientdata to set the client data (as opposed to
+  a direct access to client->data).
+  Use strlcpy instead of strcpy to copy the client name.
+  Replace the sysctl directory registration by calls to
+  device_create_file. Move the driver initialization before any
+  sysfs file creation.
+
+* [Detach] Get rid of data, remove the call to
+  i2c_deregister_entry.
+
+* [Update] Don't access client->data directly, use
+  i2c_get_clientdata(client) instead.
+
+* [Interface] Init function should not print anything. Make sure
+  there is a MODULE_LICENSE() line.
+
+Coding policy:
+
+* [Copyright] Use (C), not (c), for copyright.
+
+* [Debug/log] Get rid of #ifdef DEBUG/#endif constructs whenever you
+  can. Calls to printk/pr_debug for debugging purposes are replaced
+  by calls to dev_dbg. Here is an example on how to call it (taken
+  from lm75_detect):
+  dev_dbg(&adapter->dev,
+          "lm75_detect called for an ISA bus adapter?!?\n");
+  Replace other printk calls with the dev_info, dev_err or dev_warn
+  function, as appropriate.
+
+* [Constants] Constants defines (registers, conversions, initial
+  values) should be aligned. This greatly improves readability.
+  Same goes for variables declarations. Alignments are achieved by the
+  means of tabs, not spaces. Remember that tabs are set to 8 in the
+  Linux kernel code.
+
+* [Structure definition] The name field should be standardized. All
+  lowercase and as simple as the driver name itself (e.g. "lm75").
+
+* [Layout] Avoid extra empty lines between comments and what they
+  comment. Respect the coding style (see Documentation/CodingStyle),
+  in particular when it comes to placing curly braces.

