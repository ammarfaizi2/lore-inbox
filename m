Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTFMCXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 22:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbTFMCXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 22:23:16 -0400
Received: from charger.oldcity.dca.net ([207.245.82.76]:56774 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id S265105AbTFMCXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 22:23:12 -0400
Date: Thu, 12 Jun 2003 22:36:51 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [RFC][2.5] list_for_each_safe not so safe (was Re: OOPS w83781d during rmmod (2.5.70-bk1[1234]))
Message-ID: <20030613023651.GA1401@earth.solarsys.private>
Mail-Followup-To: Martin Schlemmer <azarah@gentoo.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
References: <20030524183748.GA3097@earth.solarsys.private> <3ED8067E.1050503@paradyne.com> <20030601143808.GA30177@earth.solarsys.private> <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private> <20030605194734.GA6238@kroah.com> <1055136870.5280.196.camel@workshop.saharacpt.lan> <20030610054107.GA22719@earth.solarsys.private> <1055401021.5280.3143.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055401021.5280.3143.camel@workshop.saharacpt.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Schlemmer <azarah@gentoo.org> [2003-06-12 08:57:02 +0200]:
> On Tue, 2003-06-10 at 07:41, Mark M. Hoffman wrote:
> > * Martin Schlemmer <azarah@gentoo.org> [2003-06-09 07:34:30 +0200]:
> > > 
> > > Anyhow, Only change I have made to the w83781d driver, is one line
> > > (just tell it to that if the chip id is 0x72, its also of type
> > > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > > it did not with 2.5.68 kernels when I still had the other board.  I will
> > > attach a oops tomorrow or such when I get home.
> > 
> > I reproduced the segfault here.  It looks like i2c_del_driver() tries
> > to call w83781d_detach_client() more than once now, partly because of
> > the safe list fix in 2.5.70-bk11.  But that function should only be
> > called for the "primary" client, not the subclients.
> > 
> > The quick/ugly patch below fixes the symptom, but maybe not the disease.
> > There might be more fundamental brokenness in the whole subclient scheme.
> > I'll keep looking when I get the chance.
> > 
> > <broken patch ommitted>
> 
> Nope, this do not fix it.
> 
> The problem is actually at the i2c driver side.  From
> drivers/i2c/i2c-core.c in i2c_del_driver(), we have:
<cut>

To recap:  list_for_each_safe() is not safe for deleting other than
the current "item".  But I disagree with you Martin because I think
the usage in i2c_del_driver is ok as is; and that w83781d.c should
change...

My first patch was naive; the patch below solves the problem by
letting w83781d_detach_client remove the three clients (1 * primary
+ 2 * subclients) independently.  It's a noisy patch because I had
to change the way the subclients were kmalloc'ed - sorry.  The meat
is around line 1422.  This patch works for me... comments?

Regards,

--- linux-2.5.70-bk14/drivers/i2c/chips/w83781d.c	2003-06-10 00:49:19.000000000 -0400
+++ linux-2.5.70/drivers/i2c/chips/w83781d.c	2003-06-12 22:24:47.000000000 -0400
@@ -299,8 +299,8 @@
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	struct i2c_client *lm75;	/* for secondary I2C addresses */
-	/* pointer to array of 2 subclients */
+	struct i2c_client *lm75[2];	/* for secondary I2C addresses */
+	/* array of 2 pointers to subclients */
 
 	u8 in[9];		/* Register value - 8 & 9 for 782D only */
 	u8 in_max[9];		/* Register value - 8 & 9 for 782D only */
@@ -1043,12 +1043,12 @@
 	const char *client_name;
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
-	if (!(data->lm75 = kmalloc(2 * sizeof (struct i2c_client),
-			GFP_KERNEL))) {
+	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!(data->lm75[0])) {
 		err = -ENOMEM;
 		goto ERROR_SC_0;
 	}
-	memset(data->lm75, 0x00, 2 * sizeof (struct i2c_client));
+	memset(data->lm75[0], 0x00, sizeof (struct i2c_client));
 
 	id = i2c_adapter_id(adapter);
 
@@ -1066,25 +1066,33 @@
 		w83781d_write_value(new_client, W83781D_REG_I2C_SUBADDR,
 				(force_subclients[2] & 0x07) |
 				((force_subclients[3] & 0x07) << 4));
-		data->lm75[0].addr = force_subclients[2];
+		data->lm75[0]->addr = force_subclients[2];
 	} else {
 		val1 = w83781d_read_value(new_client, W83781D_REG_I2C_SUBADDR);
-		data->lm75[0].addr = 0x48 + (val1 & 0x07);
+		data->lm75[0]->addr = 0x48 + (val1 & 0x07);
 	}
 
 	if (kind != w83783s) {
+
+		data->lm75[1] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+		if (!(data->lm75[1])) {
+			err = -ENOMEM;
+			goto ERROR_SC_1;
+		}
+		memset(data->lm75[1], 0x0, sizeof(struct i2c_client));
+
 		if (force_subclients[0] == id &&
 		    force_subclients[1] == address) {
-			data->lm75[1].addr = force_subclients[3];
+			data->lm75[1]->addr = force_subclients[3];
 		} else {
-			data->lm75[1].addr = 0x48 + ((val1 >> 4) & 0x07);
+			data->lm75[1]->addr = 0x48 + ((val1 >> 4) & 0x07);
 		}
-		if (data->lm75[0].addr == data->lm75[1].addr) {
+		if (data->lm75[0]->addr == data->lm75[1]->addr) {
 			dev_err(&new_client->dev,
 			       "Duplicate addresses 0x%x for subclients.\n",
-			       data->lm75[0].addr);
+			       data->lm75[0]->addr);
 			err = -EBUSY;
-			goto ERROR_SC_1;
+			goto ERROR_SC_2;
 		}
 	}
 
@@ -1103,19 +1111,19 @@
 
 	for (i = 0; i <= 1; i++) {
 		/* store all data in w83781d */
-		i2c_set_clientdata(&data->lm75[i], NULL);
-		data->lm75[i].adapter = adapter;
-		data->lm75[i].driver = &w83781d_driver;
-		data->lm75[i].flags = 0;
-		strlcpy(data->lm75[i].dev.name, client_name,
+		i2c_set_clientdata(data->lm75[i], NULL);
+		data->lm75[i]->adapter = adapter;
+		data->lm75[i]->driver = &w83781d_driver;
+		data->lm75[i]->flags = 0;
+		strlcpy(data->lm75[i]->dev.name, client_name,
 			DEVICE_NAME_SIZE);
-		if ((err = i2c_attach_client(&(data->lm75[i])))) {
+		if ((err = i2c_attach_client(data->lm75[i]))) {
 			dev_err(&new_client->dev, "Subclient %d "
 				"registration at address 0x%x "
-				"failed.\n", i, data->lm75[i].addr);
+				"failed.\n", i, data->lm75[i]->addr);
 			if (i == 1)
-				goto ERROR_SC_2;
-			goto ERROR_SC_1;
+				goto ERROR_SC_3;
+			goto ERROR_SC_2;
 		}
 		if (kind == w83783s)
 			break;
@@ -1124,10 +1132,14 @@
 	return 0;
 
 /* Undo inits in case of errors */
+ERROR_SC_3:
+	i2c_detach_client(data->lm75[0]);
 ERROR_SC_2:
-	i2c_detach_client(&(data->lm75[0]));
+	if (NULL != data->lm75[1])
+		kfree(data->lm75[1]);
 ERROR_SC_1:
-	kfree(data->lm75);
+	if (NULL != data->lm75[0])
+		kfree(data->lm75[0]);
 ERROR_SC_0:
 	return err;
 }
@@ -1326,7 +1338,8 @@
 				kind, new_client)))
 			goto ERROR3;
 	} else {
-		data->lm75 = NULL;
+		data->lm75[0] = NULL;
+		data->lm75[1] = NULL;
 	}
 
 	device_create_file_in(new_client, 0);
@@ -1409,20 +1422,11 @@
 static int
 w83781d_detach_client(struct i2c_client *client)
 {
-	struct w83781d_data *data = i2c_get_clientdata(client);
 	int err;
 
-	/* release ISA region or I2C subclients first */
-	if (i2c_is_isa_client(client)) {
+	if (i2c_is_isa_client(client))
 		release_region(client->addr, W83781D_EXTENT);
-	} else {
-		i2c_detach_client(&data->lm75[0]);
-		if (data->type != w83783s)
-			i2c_detach_client(&data->lm75[1]);
-		kfree(data->lm75);
-	}
 
-	/* now it's safe to scrap the rest */
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		       "Client deregistration failed, client not detached.\n");
@@ -1484,7 +1488,7 @@
 			res = i2c_smbus_read_byte_data(client, reg & 0xff);
 		} else {
 			/* switch to subclient */
-			cl = &data->lm75[bank - 1];
+			cl = data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
 			case 0x50:	/* TEMP */
@@ -1555,7 +1559,7 @@
 						  value & 0xff);
 		} else {
 			/* switch to subclient */
-			cl = &data->lm75[bank - 1];
+			cl = data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
 			case 0x52:	/* CONFIG */


-- 
Mark M. Hoffman
mhoffman@lightlink.com

