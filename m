Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTDXXz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTDXXu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:50:58 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49565 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264546AbTDXXpG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:45:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512287462983@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.68
In-Reply-To: <1051228746897@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:59:06 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1179.3.2, 2003/04/23 11:33:09-07:00, hch@lst.de

[PATCH] i2c: remove dead code from adm1021

Enough testing :)  This is the last user of some junk in i2c-sensors.h,
so it should better go away sooner than later..


 drivers/i2c/chips/adm1021.c |  122 --------------------------------------------
 1 files changed, 122 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Thu Apr 24 16:47:35 2003
+++ b/drivers/i2c/chips/adm1021.c	Thu Apr 24 16:47:35 2003
@@ -416,128 +416,6 @@
 	up(&data->update_lock);
 }
 
-
-/* FIXME, remove these four functions, they are here to verify the sysfs
- * conversion is correct, or not */
-__attribute__((unused))
-static void adm1021_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = i2c_get_clientdata(client);
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_max);
-		results[1] = TEMP_FROM_REG(data->temp_hyst);
-		results[2] = TEMP_FROM_REG(data->temp_input);
-		*nrels_mag = 3;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_max = TEMP_TO_REG(results[0]);
-			adm1021_write_value(client, ADM1021_REG_TOS_W,
-					    data->temp_max);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_hyst = TEMP_TO_REG(results[1]);
-			adm1021_write_value(client, ADM1021_REG_THYST_W,
-					    data->temp_hyst);
-		}
-	}
-}
-
-__attribute__((unused))
-static void adm1021_remote_temp(struct i2c_client *client, int operation,
-				int ctl_name, int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = i2c_get_clientdata(client);
-	int prec = 0;
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		if (data->type == adm1023) { *nrels_mag = 3; }
-                 else { *nrels_mag = 0; }
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = TEMP_FROM_REG(data->remote_temp_max);
-		results[1] = TEMP_FROM_REG(data->remote_temp_hyst);
-		results[2] = TEMP_FROM_REG(data->remote_temp_input);
-		if (data->type == adm1023) {
-			results[0] = results[0]*1000 + ((data->remote_temp_os_prec >> 5) * 125);
-			results[1] = results[1]*1000 + ((data->remote_temp_hyst_prec >> 5) * 125);
-			results[2] = (TEMP_FROM_REG(data->remote_temp_offset)*1000) + ((data->remote_temp_offset_prec >> 5) * 125);
-			results[3] = (TEMP_FROM_REG(data->remote_temp_input)*1000) + ((data->remote_temp_prec >> 5) * 125);
-			*nrels_mag = 4;
-		} else {
- 			*nrels_mag = 3;
-		}
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			if (data->type == adm1023) {
-				prec = ((results[0]-((results[0]/1000)*1000))/125)<<5;
-				adm1021_write_value(client, ADM1021_REG_REM_TOS_PREC, prec);
-				results[0] = results[0]/1000;
-				data->remote_temp_os_prec=prec;
-			}
-			data->remote_temp_max = TEMP_TO_REG(results[0]);
-			adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W, data->remote_temp_max);
-		}
-		if (*nrels_mag >= 2) {
-			if (data->type == adm1023) {
-				prec = ((results[1]-((results[1]/1000)*1000))/125)<<5;
-				adm1021_write_value(client, ADM1021_REG_REM_THYST_PREC, prec);
-				results[1] = results[1]/1000;
-				data->remote_temp_hyst_prec=prec;
-			}
-			data->remote_temp_hyst = TEMP_TO_REG(results[1]);
-			adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W, data->remote_temp_hyst);
-		}
-		if (*nrels_mag >= 3) {
-			if (data->type == adm1023) {
-				prec = ((results[2]-((results[2]/1000)*1000))/125)<<5;
-				adm1021_write_value(client, ADM1021_REG_REM_OFFSET_PREC, prec);
-				results[2]=results[2]/1000;
-				data->remote_temp_offset_prec=prec;
-				data->remote_temp_offset=results[2];
-				adm1021_write_value(client, ADM1021_REG_REM_OFFSET, data->remote_temp_offset);
-			}
-		}
-	}
-}
-
-__attribute__((unused))
-static void adm1021_die_code(struct i2c_client *client, int operation,
-			     int ctl_name, int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = i2c_get_clientdata(client);
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = data->die_code;
-		*nrels_mag = 1;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		/* Can't write to it */
-	}
-}
-
-__attribute__((unused))
-static void adm1021_alarms(struct i2c_client *client, int operation,
-			   int ctl_name, int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = i2c_get_clientdata(client);
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = data->alarms;
-		*nrels_mag = 1;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		/* Can't write to it */
-	}
-}
-
 static int __init sensors_adm1021_init(void)
 {
 	return i2c_add_driver(&adm1021_driver);

