Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbTAHL7f>; Wed, 8 Jan 2003 06:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTAHL7f>; Wed, 8 Jan 2003 06:59:35 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:58773 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267276AbTAHL7X>; Wed, 8 Jan 2003 06:59:23 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Jan 2003 13:12:55 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] i2c update for tuner.c
Message-ID: <20030108121255.GA17473@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch has some i2c adaptions and cleanups for the tv card tuner
module.  Please apply,

  Gerd

--- linux-2.5.54/drivers/media/video/tuner.c	2003-01-08 10:34:58.000000000 +0100
+++ linux/drivers/media/video/tuner.c	2003-01-08 10:59:59.000000000 +0100
@@ -18,17 +18,7 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
 static unsigned short normal_i2c_range[] = {0x60,0x6f,I2C_CLIENT_END};
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
-};
+I2C_CLIENT_INSMOD;
 
 /* insmod options */
 static int debug =  0;
@@ -142,7 +132,7 @@
 	  16*140.25,16*463.25,0x02,0x04,0x01,0x8e,623},
 	{ "Philips PAL_I (FI1246 and compatibles)", Philips, PAL_I,
 	  16*140.25,16*463.25,0xa0,0x90,0x30,0x8e,623},
-	{ "Philips NTSC (FI1236 and compatibles)", Philips, NTSC,
+	{ "Philips NTSC (FI1236,FM1236 and compatibles)", Philips, NTSC,
 	  16*157.25,16*451.25,0xA0,0x90,0x30,0x8e,732},
 	{ "Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)", Philips, SECAM,
 	  16*168.25,16*447.25,0xA7,0x97,0x37,0x8e,623},
@@ -736,6 +726,7 @@
 
         if2=10700*1000; //  10.7MHz FM intermediate frequency
 
+	// per Manual for FM tuning: first if center freq. 1085 MHz
         mt2032_set_if_freq(c,freq* 1000*1000/16, 1085*1000*1000,if2,if2,if2);
 }
 
@@ -811,6 +802,7 @@
         memset(t,0,sizeof(struct tuner));
 	if (type >= 0 && type < TUNERS) {
 		t->type = type;
+		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
 		strncpy(client->name, tuners[t->type].name, sizeof(client->name));
 	} else {
 		t->type = -1;
@@ -820,7 +812,6 @@
                  mt2032_init(client);
 
 	MOD_INC_USE_COUNT;
-
 	return 0;
 }
 
@@ -837,6 +828,7 @@
 	case I2C_ALGO_BIT | I2C_HW_B_BT848:
 	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
 	case I2C_ALGO_SAA7134:
+	case I2C_ALGO_SAA7146:
 		printk("tuner: probing %s i2c adapter [id=0x%x]\n",
 		       adap->name,adap->id);
 		rc = i2c_probe(adap, &addr_data, tuner_attach);
@@ -875,7 +867,7 @@
 	/* --- configuration --- */
 	case TUNER_SET_TYPE:
 		if (t->type != -1) {
-			printk("tuner: type already set\n");
+			printk("tuner: type already set (%d)\n",t->type);
 			return 0;
 		}
 		if (*iarg < 0 || *iarg >= TUNERS)
@@ -975,18 +967,19 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.name		= "i2cTVtunerdriver",
-	.id		= I2C_DRIVERID_TUNER,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= tuner_probe,
-	.detach_client	= tuner_detach,
-	.command	= tuner_command,
+	.owner          = THIS_MODULE,
+        .name           = "i2c TV tuner driver",
+        .id             = I2C_DRIVERID_TUNER,
+        .flags          = I2C_DF_NOTIFY,
+        .attach_adapter = tuner_probe,
+        .detach_client  = tuner_detach,
+        .command        = tuner_command,
 };
-static struct i2c_client client_template = 
+static struct i2c_client client_template =
 {
-	.name	= "(tunerunset)",
-	.flags	= I2C_CLIENT_ALLOW_USE,
-	.driver	= &driver,
+        .name   = "(tuner unset)",
+	.flags  = I2C_CLIENT_ALLOW_USE,
+        .driver = &driver,
 };
 
 static int tuner_init_module(void)

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
