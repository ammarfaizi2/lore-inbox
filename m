Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264591AbUD2OHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUD2OHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUD2OHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:07:36 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:64195 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264591AbUD2OHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:07:30 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Thu, 29 Apr 2004 16:06:57 +0200
From: stefan.eletzhofer@eletztrick.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6 I2C re-add i2c_get_client()
Message-ID: <20040429140657.GC23468@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
here's a patch which re-adds i2c_get_client() back to i2c_core.c.
That call was removed in 2003 because there were no users of that
function at that time.

I think this call is needed for I2C chip drivers which provide functionality to
be used by other driver modules, for example RTC chips or EEPROMs. These chip
drivers tend to encapsulate raw i2c chip access and provide function calls
for other modulesi, for example via the i2c_driver->command() method.

I tried to get the locking right, so please comment. The patch is
against 2.6.6-rc3 and works quite fine with my i2c rtc chip.

Thanks,
	Stefan E.

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i2c-get-client.patch"

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

--X1bOJ3K7DJ5YkBrT--
