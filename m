Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264780AbUD1Ng2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbUD1Ng2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbUD1Ng2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:36:28 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:45540 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264780AbUD1NgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:36:23 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Wed, 28 Apr 2004 15:36:07 +0200
From: stefan.eletzhofer@eletztrick.de
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: i2c_get_client() missing?
Message-ID: <20040428133606.GA23076@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
References: <20040427150144.GA2517@gonzo.local> <20040427153512.GA19633@kroah.com> <20040427192119.A21965@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427192119.A21965@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here's a patch that adds back i2c_get_client(). I tried to
implement such that it behaves the same way as it used to do.

As Russell King did point out already, I believe that this function
is needed for those I2C chip drivers which provide functions which
are used by other modules, like EEPROM I2C chips and RTC I2C chips.

Please see also my other post for the patch which adds support for the
Epson 8564 I2C RTC chip.

Patch URL:
http://213.239.196.168/~seletz/patches/2.6.6-rc2/i2c-get-client.patch

Please comment,
	Stefan E.

Add back missing i2c_get_client() call.

#
# Patch managed by http://www.mn-logistik.de/unsupported/pxa250/patcher
#

--- linux-ra_alpha-update/drivers/i2c/i2c-core.c~i2c-get-client
+++ linux-ra_alpha-update/drivers/i2c/i2c-core.c
@@ -412,6 +412,57 @@
 	return res;
 }
 
+struct i2c_client *i2c_get_client(int driver_id, int adapter_id, 
+					struct i2c_client *prev)
+{
+	struct list_head *adap_list;
+	struct list_head *item, *_n;
+	struct i2c_adapter *adap;
+	struct i2c_client *client;
+	int found;
+
+	down(&core_lists);
+
+	adap_list = &adapters;
+	if ( prev ) {
+		/* we start searching at the previous clients adapter */
+		adap_list = &prev->adapter->list;
+	}
+
+	found = 0;
+	client = NULL;
+	list_for_each_entry(adap, adap_list, list) {
+		dev_dbg(&adap->dev, "examining adapter id=%08x\n", adap->id);
+		
+		if ( adapter_id && adap->id != adapter_id )
+			continue; /* not the adapter id we want */
+		
+		list_for_each_safe(item, _n, &adap->clients) {
+			client = list_entry(item, struct i2c_client, list);
+			dev_dbg(&client->dev, "examining client\n");
+			dev_dbg(&client->dev, "driver id=%08x\n", client->driver->id);
+
+			if ( prev && prev == client ) {
+				prev = NULL;
+				continue;
+			}
+			
+			if (client->driver->id != driver_id)
+				continue; /* not the driver id we want */
+
+			if ( client->flags & I2C_CLIENT_ALLOW_USE ) {
+				dev_dbg(&client->dev, "found client\n");
+				found = 1;
+				goto out_unlock;
+			}
+		}
+	}
+
+out_unlock:
+	up(&core_lists);
+	return found?client:NULL;
+}
+
 static int i2c_inc_use_client(struct i2c_client *client)
 {
 
@@ -1261,6 +1312,7 @@
 EXPORT_SYMBOL(i2c_del_driver);
 EXPORT_SYMBOL(i2c_attach_client);
 EXPORT_SYMBOL(i2c_detach_client);
+EXPORT_SYMBOL(i2c_get_client);
 EXPORT_SYMBOL(i2c_use_client);
 EXPORT_SYMBOL(i2c_release_client);
 EXPORT_SYMBOL(i2c_clients_command);

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
