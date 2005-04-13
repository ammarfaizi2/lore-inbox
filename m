Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVDMLHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVDMLHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVDMLHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:07:14 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:53199 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S261309AbVDMLEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:04:11 -0400
Date: Wed, 13 Apr 2005 13:04:14 +0200
To: James Chapman <jchapman@katalix.com>, Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ds1337 4/4
Message-ID: <20050413110413.GA30618@orphique>
References: <20050407231904.GE27226@orphique> <FxPJVIPZ.1112958526.4787880.khali@localhost> <20050408123545.GA4961@orphique> <4256C315.3000902@katalix.com> <20050410195120.GA5422@linux-mips.org> <20050410231006.0469a472.khali@linux-fr.org> <425C0F2F.2000807@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425C0F2F.2000807@katalix.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 07:10:55PM +0100, James Chapman wrote:
[snip]
> It is used by the Radstone ppc7d platform, arch/ppc/radstone_ppc7d.c
> but wasn't added until very recently (2.6.12-rc2 I think).
> 
> To be honest, I meant to remove the 'id' thing before submitting the
> driver. There's no need to support more than one of these devices.

Patch bellow remove ds1337_do_command function and things needed by it.
I think device should be identified by bus and address as Jean said.
Please let me know if that fits your needs.

I'm assuming that you want to use drivers/char/genrtc.c to access ds1337
from userspace, but in arch/ppc/platforms/radstone_ppc7d.c 
ppc_md.get_rtc_time used by genrtc via get_rtc_time in asm-ppc/rtc.h
is set to NULL (same for set_rtc_time) and I didn't find where (if)
ds1337 registers to ppc_md.get_rtc_time.
Functions in asm-ppc/rtc.h also do magic with tm_mon and tm_year
so this driver doesn't need to handle epoch separately and doesn't need
to be aware that tm_mon starts from zero...

m68k, mips and parisc does the same in asm/rtc.h unlike arm, so I this
driver probably won't work for me without some tweaks to arm code.

[snip]
> >Back to the issue, some random thoughts summarizing my opinion:
> >
> >1* Initializing the battery charge register is a firmware/bios issue, as
> >you underlined earlier. It would make sense (and would be easier) to
> >just ignore it at the driver level.
> 
> Initializing the charge register should be done by the bios if possible.
> However, I assume Ladislav still wants to be able to change the register
> at runtime so some kernel support is needed?
> 
> >2* If it makes sense to stop the charge, then we should provide a simple
> >*switch* to the user, from the default charging register value (as
> >previously set by the firmware/bios) to 0 and back. The switch would
> >probably be a sysfs file unless a different API already exists.
> >
> >3* Having the driver write an arbitrary non-0 value to the register
> >should not be done unless the system has been identified. I have no idea
> >how your system can be identified (DMI?), but if it can't, then I'd
> >better see the register ignored altogether.

My board is OMAP (ARM core) based and there are ARM specific functions
(if (machine_is_xxx()) do_something(); ), but it is not what you want to
see in generic driver. It may be possible to use platform_data to pass
information to driver, but I do not like this idea.

So, if we use entry in sysfs, then only root can write it and root is
allowed to do weird things. Device itself refuses any action until high
four bits are 0xa. If that is still not enough I just found this patch
http://groups-beta.google.com/group/fa.linux.kernel/msg/06e0368f86c8f824
so you can use configfs to explicitly create "charge" entry. (
* I'm considering that an overkill
* I'm not sure if it can be easily done with configfs)

I'd add config option (disabled by default) for "charge" entry, if you
feel it is too dangerous. However I think that people should be a bit
responsible for their actions and not writing any randoms values to any
random files in /sys :)

> >4* Remember that you can always write a simple C tool relying on the
> >i2c-dev interface to do the job. The advantage of this approach is that
> >you can put big fat warnings and request user confirmation before any
> >action.
> 
> This makes sense. Ladislav, would this work for you? I guess we'd still
> add code to the ds1337 driver to detect ds1339 in order to ensure that
> this tool could not modify register 0 of a ds1337 by accident?

Yes, that would definitely work for me and I'm fine with that in case
proposal above would be rejected.


Remove nowhere referenced ds1337_do_command function. Apply after ds1337
patches 1-3.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-13 11:48:32.511011224 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-13 12:00:22.328102624 +0200
@@ -63,21 +63,6 @@ static struct i2c_driver ds1337_driver =
 	.command	= ds1337_command,
 };
 
-/*
- * Client data (each client gets its own)
- */
-struct ds1337_data {
-	struct i2c_client client;
-	struct list_head list;
-	int id;
-};
-
-/*
- * Internal variables
- */
-static int ds1337_id;
-static LIST_HEAD(ds1337_clients);
-
 static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
 {
 	s32 tmp = i2c_smbus_read_byte_data(client, reg);
@@ -213,25 +198,6 @@ static int ds1337_command(struct i2c_cli
 	}
 }
 
-/*
- * Public API for access to specific device. Useful for low-level
- * RTC access from kernel code.
- */
-int ds1337_do_command(int id, int cmd, void *arg)
-{
-	struct list_head *walk;
-	struct list_head *tmp;
-	struct ds1337_data *data;
-
-	list_for_each_safe(walk, tmp, &ds1337_clients) {
-		data = list_entry(walk, struct ds1337_data, list);
-		if (data->id == id)
-			return ds1337_command(&data->client, cmd, arg);
-	}
-
-	return -ENODEV;
-}
-
 static int ds1337_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, ds1337_detect);
@@ -244,7 +210,6 @@ static int ds1337_attach_adapter(struct 
 static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
-	struct ds1337_data *data;
 	int err = 0;
 	const char *name = "";
 
@@ -252,18 +217,10 @@ static int ds1337_detect(struct i2c_adap
 				     I2C_FUNC_I2C))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct ds1337_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	memset(data, 0, sizeof(struct ds1337_data));
-	INIT_LIST_HEAD(&data->list);
+	new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!new_client)
+		return -ENOMEM;
 
-	/* The common I2C client data is placed right before the
-	 * DS1337-specific data. 
-	 */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
 	new_client->driver = &ds1337_driver;
@@ -334,14 +291,10 @@ static int ds1337_detect(struct i2c_adap
 	/* Initialize the DS1337 chip */
 	ds1337_init_client(new_client);
 
-	/* Add client to local list */
-	data->id = ds1337_id++;
-	list_add(&data->list, &ds1337_clients);
-
 	return 0;
 
 exit_free:
-	kfree(data);
+	kfree(new_client);
 exit:
 	return err;
 }
@@ -360,7 +313,6 @@ static void ds1337_init_client(struct i2
 static int ds1337_detach_client(struct i2c_client *client)
 {
 	int err;
-	struct ds1337_data *data = i2c_get_clientdata(client);
 
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
@@ -368,8 +320,7 @@ static int ds1337_detach_client(struct i
 		return err;
 	}
 
-	list_del(&data->list);
-	kfree(data);
+	kfree(client);
 	return 0;
 }
 
