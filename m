Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTJGLHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTJGLHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:07:08 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:17816 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262168AbTJGLE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:04:26 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Oct 2003 13:04:59 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] saa7134 driver update
Message-ID: <20031007110459.GA3452@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the saa7134 driver.  It depends on the videobuf
patch.

Changes:

  * add support for mplex mpeg2 encoder cards (new saa6752hs module).
  * tv card list updates.
  * adapt to videobuf changes.
  * better sysfs support.

Please apply,

  Gerd

diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa6752hs.c linux/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa6752hs.c	2003-10-06 17:48:03.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa6752hs.c	2003-10-06 17:48:03.000000000 +0200
@@ -0,0 +1,406 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/i2c.h>
+#include <linux/types.h>
+#include <linux/videodev.h>
+#include <linux/init.h>
+
+#include <media/id.h>
+#include <media/saa6752hs.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {0x20, I2C_CLIENT_END};
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
+I2C_CLIENT_INSMOD;
+
+MODULE_DESCRIPTION("device driver for saa6752hs MPEG2 encoder");
+MODULE_AUTHOR("Andrew de Quincey");
+MODULE_LICENSE("GPL");
+
+static struct i2c_driver driver;
+static struct i2c_client client_template;
+
+
+enum saa6752hs_command {
+	SAA6752HS_COMMAND_RESET = 0,
+    	SAA6752HS_COMMAND_STOP = 1,
+    	SAA6752HS_COMMAND_START = 2,
+    	SAA6752HS_COMMAND_PAUSE = 3,
+    	SAA6752HS_COMMAND_RECONFIGURE = 4,
+    	SAA6752HS_COMMAND_SLEEP = 5,
+	SAA6752HS_COMMAND_RECONFIGURE_FORCE = 6,
+    
+	SAA6752HS_COMMAND_MAX
+};
+
+
+/* ---------------------------------------------------------------------- */
+
+static u8 PAT[] = {
+	0xc2, // i2c register
+	0x00, // table number for encoder
+  
+	0x47, // sync
+	0x40, 0x00, // transport_error_indicator(0), payload_unit_start(1), transport_priority(0), pid(0)
+	0x10, // transport_scrambling_control(00), adaptation_field_control(01), continuity_counter(0)
+     
+	0x00, // PSI pointer to start of table
+    
+	0x00, // tid(0)
+	0xb0, 0x0d, // section_syntax_indicator(1), section_length(13)
+    
+	0x00, 0x01, // transport_stream_id(1)
+    
+	0xc1, // version_number(0), current_next_indicator(1)
+    
+	0x00, 0x00, // section_number(0), last_section_number(0)
+
+	0x00, 0x01, // program_number(1)
+	
+	0xe0, 0x10, // PMT PID(0x10)
+
+	0x76, 0xf1, 0x44, 0xd1 // CRC32
+};
+
+static u8 PMT[] = {
+	0xc2, // i2c register
+	0x01, // table number for encoder
+  
+	0x47, // sync
+	0x40, 0x10, // transport_error_indicator(0), payload_unit_start(1), transport_priority(0), pid(0x10)
+	0x10, // transport_scrambling_control(00), adaptation_field_control(01), continuity_counter(0)
+     
+	0x00, // PSI pointer to start of table
+    
+	0x02, // tid(2)
+	0xb0, 0x17, // section_syntax_indicator(1), section_length(23)
+
+	0x00, 0x01, // program_number(1)
+    
+	0xc1, // version_number(0), current_next_indicator(1)
+    
+	0x00, 0x00, // section_number(0), last_section_number(0)
+    
+	0xe1, 0x04, // PCR_PID (0x104)
+   
+	0xf0, 0x00, // program_info_length(0)
+    
+	0x02, 0xe1, 0x00, 0xf0, 0x00, // video stream type(2), pid(0x100)
+	0x04, 0xe1, 0x03, 0xf0, 0x00, // audio stream type(4), pid(0x103)
+    
+	0xa1, 0xca, 0x0f, 0x82 // CRC32
+};
+
+static struct mpeg_params mpeg_params_template =
+{
+	.bitrate_mode = MPEG_BITRATE_MODE_CBR,
+	.video_target_bitrate = 5000,
+	.audio_bitrate = MPEG_AUDIO_BITRATE_256,
+	.total_bitrate = 6000,
+};
+
+  
+/* ---------------------------------------------------------------------- */
+
+
+static int saa6752hs_chip_command(struct i2c_client* client,
+				  enum saa6752hs_command command)
+{
+	unsigned char buf[3];
+	unsigned long timeout;
+	int status = 0;
+
+	// execute the command
+	switch(command) {
+  	case SAA6752HS_COMMAND_RESET:
+  		buf[0] = 0x00;
+		break;
+	  
+	case SAA6752HS_COMMAND_STOP:
+		  	buf[0] = 0x03;
+		break;
+	  
+	case SAA6752HS_COMMAND_START:
+  		buf[0] = 0x02;
+		break;
+
+	case SAA6752HS_COMMAND_PAUSE:
+  		buf[0] = 0x04;
+		break;
+	  
+	case SAA6752HS_COMMAND_RECONFIGURE:
+		buf[0] = 0x05;
+		break;
+	  
+  	case SAA6752HS_COMMAND_SLEEP:
+  		buf[0] = 0x06;
+		break;
+
+  	case SAA6752HS_COMMAND_RECONFIGURE_FORCE:
+		buf[0] = 0x07;
+		break;
+	
+	default:
+		return -EINVAL;  
+	}
+	
+  	// set it and wait for it to be so
+	i2c_master_send(client, buf, 1);
+	timeout = jiffies + HZ * 3;
+	for (;;) {
+		// get the current status
+		buf[0] = 0x10;
+	  	i2c_master_send(client, buf, 1);
+		i2c_master_recv(client, buf, 1);
+
+		if (!(buf[0] & 0x20))
+			break;
+		if (time_after(jiffies,timeout)) {
+			status = -ETIMEDOUT;
+			break;
+		}
+	
+		// wait a bit
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(1);
+	}
+
+	// delay a bit to let encoder settle
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(5);
+	
+	// done
+  	return status;
+}
+
+
+static int saa6752hs_set_bitrate(struct i2c_client* client,
+				 struct mpeg_params* params)
+{
+  	u8 buf[3];
+  
+	// set the bitrate mode
+	buf[0] = 0x71;
+	buf[1] = params->bitrate_mode;
+	i2c_master_send(client, buf, 2);
+	  
+	// set the video bitrate
+	if (params->bitrate_mode == MPEG_BITRATE_MODE_VBR) {
+		// set the target bitrate
+		buf[0] = 0x80;
+	    	buf[1] = params->video_target_bitrate >> 8;
+	  	buf[2] = params->video_target_bitrate & 0xff;
+		i2c_master_send(client, buf, 3);
+
+		// set the max bitrate
+		buf[0] = 0x81;
+	    	buf[1] = params->video_max_bitrate >> 8;
+	  	buf[2] = params->video_max_bitrate & 0xff;
+		i2c_master_send(client, buf, 3);
+	} else {
+		// set the target bitrate (no max bitrate for CBR)
+  		buf[0] = 0x81;
+	    	buf[1] = params->video_target_bitrate >> 8;
+	  	buf[2] = params->video_target_bitrate & 0xff;
+		i2c_master_send(client, buf, 3);
+	}
+	  
+	// set the audio bitrate
+ 	buf[0] = 0x94;
+  	buf[1] = params->audio_bitrate;
+	i2c_master_send(client, buf, 2);
+	
+	// set the total bitrate
+	buf[0] = 0xb1;
+  	buf[1] = params->total_bitrate >> 8;
+  	buf[2] = params->total_bitrate & 0xff;
+	i2c_master_send(client, buf, 3);
+  
+	return 0;
+}
+
+
+static int saa6752hs_init(struct i2c_client* client, struct mpeg_params* params)
+{  
+	unsigned char buf[3];
+
+	// check the bitrate parameters first
+	if (params != NULL) {
+		if (params->bitrate_mode >= MPEG_BITRATE_MODE_MAX)
+			return -EINVAL;
+		if (params->video_target_bitrate >= MPEG_VIDEO_TARGET_BITRATE_MAX)
+			return -EINVAL;
+  		if (params->video_max_bitrate >= MPEG_VIDEO_MAX_BITRATE_MAX)
+			return -EINVAL;
+		if (params->audio_bitrate >= MPEG_AUDIO_BITRATE_MAX)
+			return -EINVAL;
+		if (params->total_bitrate >= MPEG_TOTAL_BITRATE_MAX)
+        		return -EINVAL;
+		if (params->bitrate_mode         == MPEG_BITRATE_MODE_MAX &&
+		    params->video_target_bitrate <= params->video_max_bitrate)
+			return -EINVAL; 
+	}
+  
+    	// Set GOP structure {3, 13}
+	buf[0] = 0x72;
+	buf[1] = 0x03;
+	buf[2] = 0x0D;
+	i2c_master_send(client,buf,3);
+  
+    	// Set minimum Q-scale {4}
+	buf[0] = 0x82;
+	buf[1] = 0x04;
+	i2c_master_send(client,buf,2);
+  
+    	// Set maximum Q-scale {12}
+	buf[0] = 0x83;
+	buf[1] = 0x0C;
+	i2c_master_send(client,buf,2);
+  
+    	// Set Output Protocol
+	buf[0] = 0xD0;
+	buf[1] = 0x01;
+	i2c_master_send(client,buf,2);
+  
+    	// Set video output stream format {TS}
+	buf[0] = 0xB0;
+	buf[1] = 0x05;
+	i2c_master_send(client,buf,2);
+  
+    	// Set Audio PID {0x103}
+	buf[0] = 0xC1;
+	buf[1] = 0x01;
+	buf[2] = 0x03;
+	i2c_master_send(client,buf,3);
+  
+        // setup bitrate settings
+	if (params) {
+		saa6752hs_set_bitrate(client, params);
+		memcpy(client->data, params, sizeof(struct mpeg_params));
+	} else {
+		// parameters were not supplied. use the previous set
+   		saa6752hs_set_bitrate(client, (struct mpeg_params*) client->data);
+	}
+	  
+	// Send SI tables
+  	i2c_master_send(client,PAT,sizeof(PAT));
+  	i2c_master_send(client,PMT,sizeof(PMT));
+	  
+	// mute then unmute audio. This removes buzzing artefacts
+	buf[0] = 0xa4;
+	buf[1] = 1;
+	i2c_master_send(client, buf, 2);
+  	buf[1] = 0;
+	i2c_master_send(client, buf, 2);
+	  
+	// start it going
+	saa6752hs_chip_command(client, SAA6752HS_COMMAND_START);
+
+	return 0;
+}
+
+static int saa6752hs_attach(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct i2c_client *client;
+	struct mpeg_params* params;
+
+        client_template.adapter = adap;
+        client_template.addr = addr;
+
+        printk("saa6752hs: chip found @ 0x%x\n", addr<<1);
+
+        if (NULL == (client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)))
+                return -ENOMEM;
+        memcpy(client,&client_template,sizeof(struct i2c_client));
+	strlcpy(client->name, "saa6752hs", sizeof(client->name));
+   
+	if (NULL == (params = kmalloc(sizeof(struct mpeg_params), GFP_KERNEL)))
+		return -ENOMEM;
+	memcpy(params,&mpeg_params_template,sizeof(struct mpeg_params));
+	client->data = params;
+
+        i2c_attach_client(client);
+  
+	return 0;
+}
+
+static int saa6752hs_probe(struct i2c_adapter *adap)
+{
+	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, saa6752hs_attach);
+
+	return 0;
+}
+
+static int saa6752hs_detach(struct i2c_client *client)
+{
+	i2c_detach_client(client);
+	kfree(client->data);
+	kfree(client);
+	return 0;
+}
+
+static int
+saa6752hs_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct mpeg_params* init_arg = arg;
+
+        switch (cmd) {
+	case MPEG_SETPARAMS:
+   		return saa6752hs_init(client, init_arg);
+
+	default:
+		/* nothing */
+		break;
+	}
+	
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+static struct i2c_driver driver = {
+	.owner          = THIS_MODULE,
+        .name           = "i2c saa6752hs MPEG encoder",
+        .id             = I2C_DRIVERID_SAA6752HS,
+        .flags          = I2C_DF_NOTIFY,
+        .attach_adapter = saa6752hs_probe,
+        .detach_client  = saa6752hs_detach,
+        .command        = saa6752hs_command,
+};
+
+static struct i2c_client client_template =
+{
+	I2C_DEVNAME("(saa6752hs unset)"),
+	.flags      = I2C_CLIENT_ALLOW_USE,
+        .driver     = &driver,
+};
+
+static int saa6752hs_init_module(void)
+{
+	i2c_add_driver(&driver);
+	return 0;
+}
+
+static void saa6752hs_cleanup_module(void)
+{
+	i2c_del_driver(&driver);
+}
+
+module_init(saa6752hs_init_module);
+module_exit(saa6752hs_cleanup_module);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-cards.c	2003-10-06 17:46:19.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2003-10-06 17:48:03.000000000 +0200
@@ -32,6 +32,8 @@
 static char name_tv_mono[] = "TV (mono only)";
 static char name_comp1[]   = "Composite1";
 static char name_comp2[]   = "Composite2";
+static char name_comp3[]   = "Composite3";
+static char name_comp4[]   = "Composite4";
 static char name_svideo[]  = "S-Video";
 
 /* ------------------------------------------------------------------ */
@@ -361,14 +363,16 @@
         },
 	[SAA7134_BOARD_MD7134] = {
 		.name           = "Medion 7134",
-		.audio_clock    = 0x00200000,
+		//.audio_clock    = 0x00200000,
+		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
 		.need_tda9887   = 1,
 		.inputs = {{
 			.name   = name_tv,
 			.vmux   = 1,
-			.amux   = LINE2,
+			.amux   = TV,
 			.tv     = 1,
+#if 0
 		},{
 			.name   = name_comp1,
 			.vmux   = 0,
@@ -381,6 +385,7 @@
 			.name   = name_svideo,
 			.vmux   = 8,
 			.amux   = LINE2,
+#endif
 		}},
 		.radio = {
 			.name   = name_radio,
@@ -388,9 +393,12 @@
 		},
 	},
 	[SAA7134_BOARD_TYPHOON_90031] = {
+		/* Christian Rothl�nder <Christian@Rothlaender.net> */
 		.name           = "Typhoon TV+Radio 90031",
 		.audio_clock    = 0x00200000,
-		.tuner_type     = TUNER_PHILIPS_PAL,
+		//.tuner_type     = TUNER_PHILIPS_PAL,
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.need_tda9887   = 1,
 		.inputs         = {{
 			.name   = name_tv,
 			.vmux   = 1,
@@ -409,7 +417,7 @@
 			.name   = name_radio,
 			.amux   = LINE2,
 		},
-	},
+        },
 	[SAA7134_BOARD_ELSA] = {
 		.name           = "ELSA EX-VISION 300TV",
 		.audio_clock    = 0x00187de7,
@@ -444,14 +452,123 @@
 			.tv   = 1,
 		}},
         },
-	
+	[SAA7134_BOARD_ASUSTeK_TVFM7134] = {
+                .name           = "ASUS TV-FM 7134",
+                .audio_clock    = 0x00187de7,
+                .tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+                .need_tda9887   = 1,
+                .inputs         = {{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = TV,
+                        .tv   = 1,
+#if 0 /* untested */
+                },{
+                        .name = name_comp1,
+                        .vmux = 4,
+                        .amux = LINE2,
+                },{
+                        .name = name_comp2,
+                        .vmux = 2,
+                        .amux = LINE2,
+                },{
+                        .name = name_svideo,
+                        .vmux = 6,
+                        .amux = LINE2,
+                },{
+                        .name = "S-Video2",
+                        .vmux = 7,
+                        .amux = LINE2,
+#endif
+                }},
+                .radio = {
+                        .name = name_radio,
+                        .amux = LINE1,
+                },
+	},
+	[SAA7134_BOARD_VA1000POWER] = {
+                .name           = "AOPEN VA1000 POWER",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_NTSC,
+                .inputs         = {{
+                        .name = name_svideo,
+                        .vmux = 8,
+                        .amux = LINE1,
+                },{
+                        .name = name_comp1,
+                        .vmux = 3,
+                        .amux = LINE1,
+                },{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = LINE2,
+                        .tv   = 1,
+                }},
+	},
+	[SAA7134_BOARD_BMK_MPEX_NOTUNER] = {
+		/* "Andrew de Quincey" <adq@lidskialf.net> */
+		.name		= "BMK MPEX No Tuner",
+		.audio_clock	= 0x200000,
+		.tuner_type	= TUNER_ABSENT,
+		.inputs         = {{
+			.name = name_comp1,
+			.vmux = 4,
+			.amux = LINE1,
+		},{
+			.name = name_comp2,
+			.vmux = 3,
+			.amux = LINE1,
+		},{
+			.name = name_comp3,
+			.vmux = 0,
+			.amux = LINE1,
+		},{
+			.name = name_comp4,
+			.vmux = 1,
+			.amux = LINE1,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		}},
+		.i2s_rate  = 48000,
+		.has_ts    = 1,
+		.video_out = CCIR656,
+	},
+	[SAA7134_BOARD_VIDEOMATE_TV] = {
+		.name           = "Compro VideoMate TV",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_NTSC_M,
+                .inputs         = {{
+                        .name = name_svideo,
+                        .vmux = 8,
+                        .amux = LINE1,
+                },{
+                        .name = name_comp1,
+                        .vmux = 3,
+                        .amux = LINE1,
+                },{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = LINE2,
+                        .tv   = 1,
+                }},
+        },
+	[SAA7134_BOARD_CRONOS_PLUS] = {
+		.name           = "Matrox CronosPlus",
+		.tuner_type     = TUNER_ABSENT,
+                .inputs         = {{
+                        .name = name_comp1,
+                        .vmux = 0,
+                }},
+        },
 };
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
 /* ------------------------------------------------------------------ */
 /* PCI ids + subsystem IDs                                            */
 
-struct pci_device_id __devinitdata saa7134_pci_tbl[] = {
+struct pci_device_id saa7134_pci_tbl[] = {
 	{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -519,6 +636,42 @@
 		.subdevice    = 0x226b,
 		.driver_data  = SAA7134_BOARD_ELSA_500TV,
 	},{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = PCI_VENDOR_ID_ASUSTEK,
+                .subdevice    = 0x4842,
+                .driver_data  = SAA7134_BOARD_ASUSTeK_TVFM7134,
+	},{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = PCI_VENDOR_ID_ASUSTEK,
+                .subdevice    = 0x4830,
+                .driver_data  = SAA7134_BOARD_ASUSTeK_TVFM7134,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = PCI_VENDOR_ID_PHILIPS,
+		.subdevice    = 0xfe01,
+		.driver_data  = SAA7134_BOARD_TYPHOON_90031,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x1131,
+                .subdevice    = 0x7133,
+		.driver_data  = SAA7134_BOARD_VA1000POWER,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+                .subvendor    = 0x185b,
+                .subdevice    = 0xc100,
+		.driver_data  = SAA7134_BOARD_VIDEOMATE_TV,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+                .subvendor    = PCI_VENDOR_ID_MATROX,
+                .subdevice    = 0x48d0,
+		.driver_data  = SAA7134_BOARD_CRONOS_PLUS,
+	},{
 		
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -595,22 +748,16 @@
 
 static void board_flyvideo(struct saa7134_dev *dev)
 {
+#if 0
 	u32 value;
+	int index;
 
-	saa_writel(SAA7134_GPIO_GPMODE0 >> 2,   0);
-	value = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
-#if 0
-	{
-		int index = (value & 0x1f00) >> 8;
-		printk(KERN_INFO "%s: flyvideo: gpio is 0x%x "
-				"[model=%s,tuner=%d]\n",
-		       dev->name, value, fly_list[index].model,
-		       fly_list[index].tuner_type);
-		dev->tuner_type = fly_list[index].tuner_type;
-	}
-#else
-	printk(KERN_INFO "%s: flyvideo: gpio is 0x%x\n",
-	       dev->name, value);
+	value = dev->gpio_value;
+	index = (value & 0x1f00) >> 8;
+	printk(KERN_INFO "%s: flyvideo: gpio is 0x%x [model=%s,tuner=%d]\n",
+	       dev->name, value, fly_list[index].model,
+	       fly_list[index].tuner_type);
+	dev->tuner_type = fly_list[index].tuner_type;
 #endif
 }
 
@@ -618,10 +765,19 @@
 
 int saa7134_board_init(struct saa7134_dev *dev)
 {
+	// Always print gpio, often manufacturers encode tuner type and other info.
+	saa_writel(SAA7134_GPIO_GPMODE0 >> 2, 0);
+	dev->gpio_value = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
+	printk(KERN_INFO "%s: board init: gpio is %x\n", dev->name, dev->gpio_value);
+
 	switch (dev->board) {
 	case SAA7134_BOARD_FLYVIDEO2000:
 	case SAA7134_BOARD_FLYVIDEO3000:
 		board_flyvideo(dev);
+		dev->has_remote = 1;
+		break;
+	case SAA7134_BOARD_CINERGY400:
+		dev->has_remote = 1;
 		break;
 	}
 	return 0;
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-core.c	2003-10-06 17:45:12.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2003-10-06 17:48:03.000000000 +0200
@@ -35,7 +35,7 @@
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
 MODULE_LICENSE("GPL");
 
-#define SAA7134_MAXBOARDS 4
+#define SAA7134_MAXBOARDS 8
 
 /* ------------------------------------------------------------------ */
 
@@ -51,32 +51,32 @@
 MODULE_PARM(gpio_tracking,"i");
 MODULE_PARM_DESC(gpio_tracking,"enable debug messages [gpio]");
 
-static unsigned int video_nr = -1;
-MODULE_PARM(video_nr,"i");
+static unsigned int video_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM(video_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(video_nr,"video device number");
 
-static unsigned int ts_nr = -1;
-MODULE_PARM(ts_nr,"i");
+static unsigned int ts_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM(ts_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(ts_nr,"ts device number");
 
-static unsigned int vbi_nr = -1;
-MODULE_PARM(vbi_nr,"i");
+static unsigned int vbi_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM(vbi_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(vbi_nr,"vbi device number");
 
-static unsigned int radio_nr = -1;
-MODULE_PARM(radio_nr,"i");
+static unsigned int radio_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM(radio_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(radio_nr,"radio device number");
 
 static unsigned int oss = 0;
 MODULE_PARM(oss,"i");
 MODULE_PARM_DESC(oss,"register oss devices (default: no)");
 
-static unsigned int dsp_nr = -1;
-MODULE_PARM(dsp_nr,"i");
+static unsigned int dsp_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM(dsp_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(dsp_nr,"oss dsp device number");
 
-static unsigned int mixer_nr = -1;
-MODULE_PARM(mixer_nr,"i");
+static unsigned int mixer_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM(mixer_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(mixer_nr,"oss mixer device number");
 
 static unsigned int tuner[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
@@ -529,7 +529,8 @@
 static char *irqbits[] = {
 	"DONE_RA0", "DONE_RA1", "DONE_RA2", "DONE_RA3",
 	"AR", "PE", "PWR_ON", "RDCAP", "INTL", "FIDT", "MMC",
-	"TRIG_ERR", "CONF_ERR", "LOAD_ERR"
+	"TRIG_ERR", "CONF_ERR", "LOAD_ERR",
+	"GPIO16?", "GPIO18", "GPIO22", "GPIO23"
 };
 #define IRQBITS ARRAY_SIZE(irqbits)
 
@@ -598,6 +599,13 @@
 		if ((report & SAA7134_IRQ_REPORT_DONE_RA3))
 			saa7134_irq_oss_done(dev,status);
 
+#ifdef CONFIG_VIDEO_IR
+		if ((report & (SAA7134_IRQ_REPORT_GPIO16 |
+			       SAA7134_IRQ_REPORT_GPIO18)) &&
+		    dev->remote)
+			saa7134_input_irq(dev);
+#endif
+
 	};
 	if (10 == loop) {
 		print_irqstatus(dev,loop,report,status);
@@ -613,23 +621,30 @@
 
 /* ------------------------------------------------------------------ */
 
-static int saa7134_hwinit(struct saa7134_dev *dev)
+/* early init (no i2c, no irq) */
+static int saa7134_hwinit1(struct saa7134_dev *dev)
 {
+	dprintk("hwinit1\n");
+
+	saa_writel(SAA7134_IRQ1, 0);
+	saa_writel(SAA7134_IRQ2, 0);
         init_MUTEX(&dev->lock);
 	dev->slock = SPIN_LOCK_UNLOCKED;
 
 	saa7134_track_gpio(dev,"pre-init");
-	saa7134_tvaudio_init(dev);
-	saa7134_video_init(dev);
-	saa7134_vbi_init(dev);
+	saa7134_video_init1(dev);
+	saa7134_vbi_init1(dev);
 	if (card_has_ts(dev))
-		saa7134_ts_init(dev);
+		saa7134_ts_init1(dev);
+#ifdef CONFIG_VIDEO_IR
+	saa7134_input_init1(dev);
+#endif
 
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7134:
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		saa7134_oss_init(dev);
+		saa7134_oss_init1(dev);
 		break;
 	}
 	
@@ -648,20 +663,6 @@
 		   SAA7134_MAIN_CTRL_EBADC |
 		   SAA7134_MAIN_CTRL_EBDAC);
 
-	/* IRQ's */
-	saa_writel(SAA7134_IRQ1, 0);
-	saa_writel(SAA7134_IRQ2,
-		   SAA7134_IRQ2_INTE_SC2  |
-		   SAA7134_IRQ2_INTE_SC1  |
-		   SAA7134_IRQ2_INTE_SC0  |
-		   /* SAA7134_IRQ2_INTE_DEC5 |  FIXME: TRIG_ERR ??? */
-		   SAA7134_IRQ2_INTE_DEC3 |
-		   SAA7134_IRQ2_INTE_DEC2 |
-		   /* SAA7134_IRQ2_INTE_DEC1 | */
-		   SAA7134_IRQ2_INTE_DEC0 |
-		   SAA7134_IRQ2_INTE_PE |
-		   SAA7134_IRQ2_INTE_AR);
-
 	/* enable peripheral devices */
 	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
 
@@ -671,6 +672,57 @@
 	return 0;
 }
 
+/* late init (with i2c + irq) */
+static int saa7134_hwinit2(struct saa7134_dev *dev)
+{
+	dprintk("hwinit2\n");
+
+	saa7134_video_init2(dev);
+	saa7134_tvaudio_init2(dev);
+
+	/* enable IRQ's */
+	saa_writel(SAA7134_IRQ1, 0);
+	saa_writel(SAA7134_IRQ2,
+		   SAA7134_IRQ2_INTE_GPIO18  |
+		   SAA7134_IRQ2_INTE_GPIO18A |
+		   SAA7134_IRQ2_INTE_GPIO16  |
+		   SAA7134_IRQ2_INTE_SC2     |
+		   SAA7134_IRQ2_INTE_SC1     |
+		   SAA7134_IRQ2_INTE_SC0     |
+		   /* SAA7134_IRQ2_INTE_DEC5    |  FIXME: TRIG_ERR ??? */
+		   SAA7134_IRQ2_INTE_DEC3    |
+		   SAA7134_IRQ2_INTE_DEC2    |
+		   /* SAA7134_IRQ2_INTE_DEC1    | */
+		   SAA7134_IRQ2_INTE_DEC0    |
+		   SAA7134_IRQ2_INTE_PE      |
+		   SAA7134_IRQ2_INTE_AR);
+
+	return 0;
+}
+
+/* shutdown */
+static int saa7134_hwfini(struct saa7134_dev *dev)
+{
+	dprintk("hwfini\n");
+
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		saa7134_oss_fini(dev);
+		break;
+	}
+	if (card_has_ts(dev))
+		saa7134_ts_fini(dev);
+#ifdef CONFIG_VIDEO_IR
+	saa7134_input_fini(dev);
+#endif
+	saa7134_vbi_fini(dev);
+	saa7134_video_fini(dev);
+	saa7134_tvaudio_fini(dev);
+	return 0;
+}
+
 static void __devinit must_configure_manually(void)
 {
 	unsigned int i,p;
@@ -698,6 +750,56 @@
 	}
 }
 
+static struct video_device *vdev_init(struct saa7134_dev *dev,
+				      struct video_device *template,
+				      char *type)
+{
+	struct video_device *vfd;
+	
+	vfd = video_device_alloc();
+	if (NULL == vfd)
+		return NULL;
+	*vfd = *template;
+	vfd->minor   = -1;
+	vfd->dev     = &dev->pci->dev;
+	vfd->release = video_device_release;
+	snprintf(vfd->name, sizeof(vfd->name), "%s %s (%s)",
+		 dev->name, type, saa7134_boards[dev->board].name);
+	return vfd;
+}
+
+static void saa7134_unregister_video(struct saa7134_dev *dev)
+{
+	if (dev->video_dev) {
+		if (-1 != dev->video_dev->minor)
+			video_unregister_device(dev->video_dev);
+		else
+			video_device_release(dev->video_dev);
+		dev->video_dev = NULL;
+	}
+	if (dev->ts_dev) {
+		if (-1 != dev->ts_dev->minor)
+			video_unregister_device(dev->ts_dev);
+		else
+			video_device_release(dev->ts_dev);
+		dev->ts_dev = NULL;
+	}
+	if (dev->vbi_dev) {
+		if (-1 != dev->vbi_dev->minor)
+			video_unregister_device(dev->vbi_dev);
+		else
+			video_device_release(dev->vbi_dev);
+		dev->vbi_dev = NULL;
+	}
+	if (dev->radio_dev) {
+		if (-1 != dev->radio_dev->minor)
+			video_unregister_device(dev->radio_dev);
+		else
+			video_device_release(dev->radio_dev);
+		dev->radio_dev = NULL;
+	}
+}
+
 static int __devinit saa7134_initdev(struct pci_dev *pci_dev,
 				     const struct pci_device_id *pci_id)
 {
@@ -705,10 +807,8 @@
 	int err;
 
 	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
-	if (NULL == dev) {
-		err = -ENOMEM;
-		goto fail0;
-	}
+	if (NULL == dev)
+		return -ENOMEM;
 	memset(dev,0,sizeof(*dev));
 
 	/* pci init */
@@ -785,19 +885,17 @@
 		goto fail1;
 	}
 	dev->lmmio = ioremap(pci_resource_start(pci_dev,0), 0x1000);
-	if (!dev->lmmio) {
-		printk(KERN_ERR "Unable to remap memory.\n");
-		err = -ENOMEM;
+	dev->bmmio = (__u8*)dev->lmmio;
+	if (NULL == dev->lmmio) {
+		err = -EIO;
+		printk(KERN_ERR "%s: can't ioremap() MMIO memory\n",
+		       dev->name);
 		goto fail2;
 	}
-	dev->bmmio = (__u8*)dev->lmmio;
-
-	/* register i2c bus */
-	saa7134_i2c_register(dev);
 
-	/* initialize hardware */
+	/* initialize hardware #1 */
 	saa7134_board_init(dev);
-	saa7134_hwinit(dev);
+	saa7134_hwinit1(dev);
 
 	/* get irq */
 	err = request_irq(pci_dev->irq, saa7134_irq,
@@ -808,53 +906,63 @@
 		goto fail3;
 	}
 
+	/* wait a bit, register i2c bus */
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(HZ/10);
+	saa7134_i2c_register(dev);
+
+	/* initialize hardware #2 */
+	saa7134_hwinit2(dev);
+
 	/* load i2c helpers */
 	if (TUNER_ABSENT != dev->tuner_type)
 		request_module("tuner");
 	if (saa7134_boards[dev->board].need_tda9887)
 		request_module("tda9887");
+  	if (card_has_ts(dev))
+		request_module("saa6752hs");
 
 	/* register v4l devices */
-	dev->video_dev = saa7134_video_template;
-	dev->video_dev.priv = dev;
-	err = video_register_device(&dev->video_dev,VFL_TYPE_GRABBER,video_nr);
+	dev->video_dev = vdev_init(dev,&saa7134_video_template,"video");
+	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
+				    video_nr[saa7134_devcount]);
 	if (err < 0) {
 		printk(KERN_INFO "%s: can't register video device\n",
 		       dev->name);
 		goto fail4;
 	}
 	printk(KERN_INFO "%s: registered device video%d [v4l2]\n",
-	       dev->name,dev->video_dev.minor & 0x1f);
+	       dev->name,dev->video_dev->minor & 0x1f);
 
-	dev->ts_dev = saa7134_ts_template;
-	dev->ts_dev.priv = dev;
 	if (card_has_ts(dev)) {
-		err = video_register_device(&dev->ts_dev,VFL_TYPE_GRABBER,ts_nr);
+		dev->ts_dev = vdev_init(dev,&saa7134_ts_template,"ts");
+		err = video_register_device(dev->ts_dev,VFL_TYPE_GRABBER,
+					    ts_nr[saa7134_devcount]);
 		if (err < 0) {
 			printk(KERN_INFO "%s: can't register video device\n",
 			       dev->name);
-			goto fail5;
+			goto fail4;
 		}
 		printk(KERN_INFO "%s: registered device video%d [ts]\n",
-		       dev->name,dev->ts_dev.minor & 0x1f);
+		       dev->name,dev->ts_dev->minor & 0x1f);
 	}
 	
-	dev->vbi_dev = saa7134_vbi_template;
-	dev->vbi_dev.priv = dev;
-	err = video_register_device(&dev->vbi_dev,VFL_TYPE_VBI,vbi_nr);
+	dev->vbi_dev = vdev_init(dev,&saa7134_vbi_template,"vbi");
+	err = video_register_device(dev->vbi_dev,VFL_TYPE_VBI,
+				    vbi_nr[saa7134_devcount]);
 	if (err < 0)
-		goto fail6;
+		goto fail4;
 	printk(KERN_INFO "%s: registered device vbi%d\n",
-	       dev->name,dev->vbi_dev.minor & 0x1f);
+	       dev->name,dev->vbi_dev->minor & 0x1f);
 
-	dev->radio_dev = saa7134_radio_template;
-	dev->radio_dev.priv = dev;
 	if (card_has_radio(dev)) {
-		err = video_register_device(&dev->radio_dev,VFL_TYPE_RADIO,radio_nr);
+		dev->radio_dev = vdev_init(dev,&saa7134_radio_template,"radio");
+		err = video_register_device(dev->radio_dev,VFL_TYPE_RADIO,
+					    radio_nr[saa7134_devcount]);
 		if (err < 0)
-			goto fail7;
+			goto fail4;
 		printk(KERN_INFO "%s: registered device radio%d\n",
-		       dev->name,dev->radio_dev.minor & 0x1f);
+		       dev->name,dev->radio_dev->minor & 0x1f);
 	}
 
 	/* register oss devices */
@@ -864,17 +972,19 @@
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		if (oss) {
 			err = dev->oss.minor_dsp =
-				register_sound_dsp(&saa7134_dsp_fops,dsp_nr);
+				register_sound_dsp(&saa7134_dsp_fops,
+						   dsp_nr[saa7134_devcount]);
 			if (err < 0) {
-				goto fail8;
+				goto fail4;
 			}
 			printk(KERN_INFO "%s: registered device dsp%d\n",
 			       dev->name,dev->oss.minor_dsp >> 4);
 			
 			err = dev->oss.minor_mixer =
-				register_sound_mixer(&saa7134_mixer_fops,mixer_nr);
+				register_sound_mixer(&saa7134_mixer_fops,
+						     mixer_nr[saa7134_devcount]);
 			if (err < 0)
-				goto fail9;
+				goto fail5;
 			printk(KERN_INFO "%s: registered device mixer%d\n",
 			       dev->name,dev->oss.minor_mixer >> 4);
 		}
@@ -887,7 +997,7 @@
 	saa7134_devcount++;
 	return 0;
 
- fail9:
+ fail5:
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7134:
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
@@ -896,39 +1006,18 @@
 			unregister_sound_dsp(dev->oss.minor_dsp);
 		break;
 	}
- fail8:
-	if (card_has_radio(dev))
-		video_unregister_device(&dev->radio_dev);
- fail7:
-	video_unregister_device(&dev->vbi_dev);
- fail6:
- 	if (card_has_ts(dev))
-  		video_unregister_device(&dev->ts_dev);
- fail5:
-	video_unregister_device(&dev->video_dev);
  fail4:
+	saa7134_unregister_video(dev);
+	saa7134_i2c_unregister(dev);
 	free_irq(pci_dev->irq, dev);
  fail3:
-	switch (dev->pci->device) {
-	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-	case PCI_DEVICE_ID_PHILIPS_SAA7133:
-	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		saa7134_oss_fini(dev);
-		break;
-	}
-	if (card_has_ts(dev))
-		saa7134_ts_fini(dev);
-	saa7134_vbi_fini(dev);
-	saa7134_video_fini(dev);
-	saa7134_tvaudio_fini(dev);
-	iounmap (dev->lmmio);
-	saa7134_i2c_unregister(dev);
+	saa7134_hwfini(dev);
+	iounmap(dev->lmmio);
  fail2:
 	release_mem_region(pci_resource_start(pci_dev,0),
 			   pci_resource_len(pci_dev,0));
  fail1:
 	kfree(dev);
- fail0:
 	return err;
 }
 
@@ -964,12 +1053,6 @@
 	saa7134_vbi_fini(dev);
 	saa7134_video_fini(dev);
 	saa7134_tvaudio_fini(dev);
-	iounmap(dev->lmmio);
-
-	/* release ressources */
-	free_irq(pci_dev->irq, dev);
-	release_mem_region(pci_resource_start(pci_dev,0),
-			   pci_resource_len(pci_dev,0));
 
 	/* unregister */
 	saa7134_i2c_unregister(dev);
@@ -983,17 +1066,18 @@
 		}
 		break;
 	}
-	if (card_has_radio(dev))
-		video_unregister_device(&dev->radio_dev);
-	video_unregister_device(&dev->vbi_dev);
-	if (card_has_ts(dev))
-		video_unregister_device(&dev->ts_dev);
-	video_unregister_device(&dev->video_dev);
-	pci_set_drvdata(pci_dev, NULL);
-#if 0
-	/* causes some trouble when reinserting the driver ... */
+	saa7134_unregister_video(dev);
+
+	/* release ressources */
+	free_irq(pci_dev->irq, dev);
+	iounmap(dev->lmmio);
+	release_mem_region(pci_resource_start(pci_dev,0),
+			   pci_resource_len(pci_dev,0));
+
+#if 0  /* causes some trouble when reinserting the driver ... */
 	pci_disable_device(pci_dev);
 #endif
+	pci_set_drvdata(pci_dev, NULL);
 
 	/* free memory */
 	list_del(&dev->devlist);
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-i2c.c linux/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-i2c.c	2003-10-06 17:44:51.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2003-10-06 17:48:03.000000000 +0200
@@ -311,6 +311,17 @@
 	return I2C_FUNC_SMBUS_EMUL;
 }
 
+#ifndef I2C_PEC
+static void inc_use(struct i2c_adapter *adap)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void dec_use(struct i2c_adapter *adap)
+{
+	MOD_DEC_USE_COUNT;
+}
+#endif
 
 static int attach_inform(struct i2c_client *client)
 {
@@ -330,8 +341,15 @@
 };
 
 static struct i2c_adapter saa7134_adap_template = {
+#ifdef I2C_PEC
 	.owner         = THIS_MODULE,
+#else
+	.inc_use       = inc_use,
+	.dec_use       = dec_use,
+#endif
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
 	.class         = I2C_ADAP_CLASS_TV_ANALOG,
+#endif
 	I2C_DEVNAME("saa7134"),
 	.id            = I2C_ALGO_SAA7134,
 	.algo          = &saa7134_algo,
@@ -393,12 +411,14 @@
 void saa7134_i2c_call_clients(struct saa7134_dev *dev,
 			      unsigned int cmd, void *arg)
 {
+	BUG_ON(NULL == dev->i2c_adap.algo_data);
 	i2c_clients_command(&dev->i2c_adap, cmd, arg);
 }
 
 int saa7134_i2c_register(struct saa7134_dev *dev)
 {
 	dev->i2c_adap = saa7134_adap_template;
+	dev->i2c_adap.dev.parent = &dev->pci->dev;
 	strcpy(dev->i2c_adap.name,dev->name);
 	dev->i2c_adap.algo_data = dev;
 	i2c_add_adapter(&dev->i2c_adap);
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-oss.c linux/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-oss.c	2003-10-06 17:45:22.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2003-10-06 17:48:03.000000000 +0200
@@ -732,7 +732,7 @@
 
 /* ------------------------------------------------------------------ */
 
-int saa7134_oss_init(struct saa7134_dev *dev)
+int saa7134_oss_init1(struct saa7134_dev *dev)
 {
 	/* general */
         init_MUTEX(&dev->oss.lock);
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-reg.h linux/drivers/media/video/saa7134/saa7134-reg.h
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-reg.h	2003-10-06 17:45:54.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-reg.h	2003-10-06 17:48:03.000000000 +0200
@@ -101,7 +101,15 @@
 #define   SAA7134_IRQ1_INTE_RA0_2               (1 <<  2)
 #define   SAA7134_IRQ1_INTE_RA0_1               (1 <<  1)
 #define   SAA7134_IRQ1_INTE_RA0_0               (1 <<  0)
+
 #define SAA7134_IRQ2                            (0x2c8 >> 2)
+#define   SAA7134_IRQ2_INTE_GPIO23A             (1 << 17)
+#define   SAA7134_IRQ2_INTE_GPIO23              (1 << 16)
+#define   SAA7134_IRQ2_INTE_GPIO22A             (1 << 15)
+#define   SAA7134_IRQ2_INTE_GPIO22              (1 << 14)
+#define   SAA7134_IRQ2_INTE_GPIO18A             (1 << 13)
+#define   SAA7134_IRQ2_INTE_GPIO18              (1 << 12)
+#define   SAA7134_IRQ2_INTE_GPIO16              (1 << 11) /* not certain */
 #define   SAA7134_IRQ2_INTE_SC2                 (1 << 10)
 #define   SAA7134_IRQ2_INTE_SC1                 (1 <<  9)
 #define   SAA7134_IRQ2_INTE_SC0                 (1 <<  8)
@@ -113,7 +121,12 @@
 #define   SAA7134_IRQ2_INTE_DEC0                (1 <<  2)
 #define   SAA7134_IRQ2_INTE_PE                  (1 <<  1)
 #define   SAA7134_IRQ2_INTE_AR                  (1 <<  0)
+
 #define SAA7134_IRQ_REPORT                      (0x2cc >> 2)
+#define   SAA7134_IRQ_REPORT_GPIO23             (1 << 17)
+#define   SAA7134_IRQ_REPORT_GPIO22             (1 << 16)
+#define   SAA7134_IRQ_REPORT_GPIO18             (1 << 15)
+#define   SAA7134_IRQ_REPORT_GPIO16             (1 << 14) /* not certain */
 #define   SAA7134_IRQ_REPORT_LOAD_ERR           (1 << 13)
 #define   SAA7134_IRQ_REPORT_CONF_ERR           (1 << 12)
 #define   SAA7134_IRQ_REPORT_TRIG_ERR           (1 << 11)
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-ts.c linux/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-ts.c	2003-10-06 17:44:30.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-ts.c	2003-10-06 17:48:03.000000000 +0200
@@ -24,10 +24,13 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
+#include <media/saa6752hs.h>
+
 /* ------------------------------------------------------------------ */
 
 static unsigned int ts_debug  = 0;
@@ -109,7 +112,7 @@
 		buf->vb.size   = size;
 		buf->pt        = &dev->ts.pt_ts;
 
-		err = videobuf_iolock(dev->pci,&buf->vb);
+		err = videobuf_iolock(dev->pci,&buf->vb,NULL);
 		if (err)
 			goto oops;
 		err = saa7134_pgtable_build(dev->pci,buf->pt,
@@ -162,6 +165,26 @@
 	.buf_release  = buffer_release,
 };
 
+
+/* ------------------------------------------------------------------ */
+
+static void ts_reset_encoder(struct saa7134_dev* dev) 
+{
+	saa_writeb(SAA7134_SPECIAL_MODE, 0x00);
+	mdelay(10);
+   	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
+   	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(HZ/10);
+}
+
+static int ts_init_encoder(struct saa7134_dev* dev, void* arg) 
+{
+	ts_reset_encoder(dev);
+	saa7134_i2c_call_clients(dev, MPEG_SETPARAMS, arg);
+ 	return 0;
+}
+
+
 /* ------------------------------------------------------------------ */
 
 static int ts_open(struct inode *inode, struct file *file)
@@ -173,7 +196,7 @@
 	
 	list_for_each(list,&saa7134_devlist) {
 		h = list_entry(list, struct saa7134_dev, devlist);
-		if (h->ts_dev.minor == minor)
+		if (h->ts_dev->minor == minor)
 			dev = h;
 	}
 	if (NULL == dev)
@@ -185,9 +208,11 @@
 	if (dev->ts.users)
 		goto done;
 
+	dev->ts.started = 0;
 	dev->ts.users++;
 	file->private_data = dev;
 	err = 0;
+
  done:
 	up(&dev->ts.ts.lock);
 	return err;
@@ -203,6 +228,11 @@
 	if (dev->ts.ts.reading)
 		videobuf_read_stop(file,&dev->ts.ts);
 	dev->ts.users--;
+
+	/* stop the encoder */
+	if (dev->ts.started)
+	      	ts_reset_encoder(dev);
+  
 	up(&dev->ts.ts.lock);
 	return 0;
 }
@@ -212,6 +242,11 @@
 {
 	struct saa7134_dev *dev = file->private_data;
 
+	if (!dev->ts.started) {
+		ts_init_encoder(dev, NULL);
+		dev->ts.started = 1;
+	}
+  
 	return videobuf_read_stream(file, &dev->ts.ts, data, count, ppos, 0);
 }
 
@@ -345,6 +380,7 @@
 		f->fmt.pix.height       = 576;
 		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
 		f->fmt.pix.sizeimage    = TS_PACKET_SIZE*TS_NR_PACKETS;
+		return 0;
 	}
 
 	case VIDIOC_REQBUFS:
@@ -365,6 +401,14 @@
 	case VIDIOC_STREAMOFF:
 		return videobuf_streamoff(file,&dev->ts.ts);
 
+	case VIDIOC_QUERYCTRL:
+	case VIDIOC_G_CTRL:
+	case VIDIOC_S_CTRL:
+		return saa7134_common_ioctl(dev, cmd, arg);
+
+	case MPEG_SETPARAMS:
+		return ts_init_encoder(dev, arg);
+	  
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -404,7 +448,7 @@
 	.minor	       = -1,
 };
 
-int saa7134_ts_init(struct saa7134_dev *dev)
+int saa7134_ts_init1(struct saa7134_dev *dev)
 {
 	/* sanitycheck insmod options */
 	if (tsbufs < 2)
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-10-06 17:44:29.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-10-06 17:48:03.000000000 +0200
@@ -2,7 +2,7 @@
  * device driver for philips saa7134 based TV cards
  * tv audio decoder (fm stereo, nicam, ...)
  *
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ * (c) 2001-03 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -172,7 +172,7 @@
 {
 	unsigned int mute;
 	struct saa7134_input *in;
-	int reg = 0;
+	int ausel=0, ics=0, ocs=0;
 	int mask;
 
 	/* look what is to do ... */
@@ -200,11 +200,13 @@
 
 	/* switch internal audio mux */
 	switch (in->amux) {
-	case TV:    reg = 0x02; break;
-	case LINE1: reg = 0x00; break;
-	case LINE2: reg = 0x01; break;
-	}
-	saa_andorb(SAA7134_ANALOG_IO_SELECT, 0x07, reg);
+	case TV:    ausel=0xc0; ics=0x00; ocs=0x02; break;
+	case LINE1: ausel=0x80; ics=0x00; ocs=0x00; break;
+	case LINE2: ausel=0x80; ics=0x08; ocs=0x01; break;
+	}
+	saa_andorb(SAA7134_AUDIO_FORMAT_CTRL, 0xc0, ausel);
+	saa_andorb(SAA7134_ANALOG_IO_SELECT, 0x08, ics);
+	saa_andorb(SAA7134_ANALOG_IO_SELECT, 0x07, ocs);
 
 	/* switch gpio-connected external audio mux */
 	if (0 == card(dev).gpiomask)
@@ -547,11 +549,19 @@
 		tvaudio_setstereo(dev,&tvaudio[audio],V4L2_TUNER_MODE_MONO);
 		dev->tvaudio = &tvaudio[audio];
 
-		if (tvaudio_sleep(dev,3*HZ))
-			goto restart;
-		rx = tvaudio_getstereo(dev,&tvaudio[i]);
-		mode = saa7134_tvaudio_rx2mode(rx);
-		tvaudio_setstereo(dev,&tvaudio[audio],mode);
+		for (;;) {
+			if (tvaudio_sleep(dev,3*HZ))
+				goto restart;
+			if (dev->thread.exit || signal_pending(current))
+				break;
+			if (UNSET == dev->thread.mode) {
+				rx = tvaudio_getstereo(dev,&tvaudio[i]);
+				mode = saa7134_tvaudio_rx2mode(rx);
+			} else {
+				mode = dev->thread.mode;
+			}
+			tvaudio_setstereo(dev,&tvaudio[audio],mode);
+		}
 	}
 
  done:
@@ -592,8 +602,8 @@
 	[0x1f] = "??? [in progress]",
 };
 
-#define DSP_RETRY 16
-#define DSP_DELAY 16
+#define DSP_RETRY 30
+#define DSP_DELAY 10
 
 static inline int saa_dsp_wait_bit(struct saa7134_dev *dev, int bit)
 {
@@ -838,10 +848,11 @@
 	return retval;
 }
 
-int saa7134_tvaudio_init(struct saa7134_dev *dev)
+int saa7134_tvaudio_init2(struct saa7134_dev *dev)
 {
 	DECLARE_MUTEX_LOCKED(sem);
 	int (*my_thread)(void *data) = NULL;
+	int rc;
 
 	/* enable I2S audio output */
 	if (saa7134_boards[dev->board].i2s_rate) {
@@ -872,8 +883,12 @@
 		/* start tvaudio thread */
 		init_waitqueue_head(&dev->thread.wq);
 		dev->thread.notify = &sem;
-		kernel_thread(my_thread,dev,0);
-		down(&sem);
+		rc = kernel_thread(my_thread,dev,0);
+		if (rc < 0)
+			printk(KERN_WARNING "%s: kernel_thread() failed\n",
+			       dev->name);
+		else
+			down(&sem);
 		dev->thread.notify = NULL;
 		wake_up_interruptible(&dev->thread.wq);
 	}
@@ -900,6 +915,7 @@
 int saa7134_tvaudio_do_scan(struct saa7134_dev *dev)
 {
 	if (dev->thread.task) {
+		dev->thread.mode = UNSET;
 		dev->thread.scan2++;
 		wake_up_interruptible(&dev->thread.wq);
 	} else {
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-vbi.c linux/drivers/media/video/saa7134/saa7134-vbi.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-vbi.c	2003-10-06 17:46:31.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-vbi.c	2003-10-06 17:48:03.000000000 +0200
@@ -146,7 +146,7 @@
 		buf->vb.size   = size;
 		buf->pt        = &fh->pt_vbi;
 
-		err = videobuf_iolock(dev->pci,&buf->vb);
+		err = videobuf_iolock(dev->pci,&buf->vb,NULL);
 		if (err)
 			goto oops;
 		err = saa7134_pgtable_build(dev->pci,buf->pt,
@@ -215,7 +215,7 @@
 
 /* ------------------------------------------------------------------ */
 
-int saa7134_vbi_init(struct saa7134_dev *dev)
+int saa7134_vbi_init1(struct saa7134_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->vbi_q.queue);
 	init_timer(&dev->vbi_q.timeout);
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134-video.c	2003-10-06 17:44:51.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2003-10-06 17:48:03.000000000 +0200
@@ -578,21 +578,12 @@
 	saa_writeb(SAA7134_VIDEO_LINES2(task),      height/div >> 8);
 
 	/* deinterlace y offsets */
-	if (interlace) {
-		y_odd  = dev->ctl_y_odd;
-		y_even = dev->ctl_y_even;
-		saa_writeb(SAA7134_V_PHASE_OFFSET0(task), y_odd);
-		saa_writeb(SAA7134_V_PHASE_OFFSET1(task), y_even);
-		saa_writeb(SAA7134_V_PHASE_OFFSET2(task), y_odd);
-		saa_writeb(SAA7134_V_PHASE_OFFSET3(task), y_even);
-	} else {
-		y_odd  = dev->ctl_y_odd;
-		y_even = dev->ctl_y_even;
-		saa_writeb(SAA7134_V_PHASE_OFFSET0(task), y_odd);
-		saa_writeb(SAA7134_V_PHASE_OFFSET1(task), y_even);
-		saa_writeb(SAA7134_V_PHASE_OFFSET2(task), y_odd);
-		saa_writeb(SAA7134_V_PHASE_OFFSET3(task), y_even);
-	}
+	y_odd  = dev->ctl_y_odd;
+	y_even = dev->ctl_y_even;
+	saa_writeb(SAA7134_V_PHASE_OFFSET0(task), y_odd);
+	saa_writeb(SAA7134_V_PHASE_OFFSET1(task), y_even);
+	saa_writeb(SAA7134_V_PHASE_OFFSET2(task), y_odd);
+	saa_writeb(SAA7134_V_PHASE_OFFSET3(task), y_even);
 }
 
 /* ------------------------------------------------------------------ */
@@ -912,7 +903,7 @@
 		buf->fmt       = fh->fmt;
 		buf->pt        = &fh->pt_cap;
 
-		err = videobuf_iolock(dev->pci,&buf->vb);
+		err = videobuf_iolock(dev->pci,&buf->vb,&dev->ovbuf);
 		if (err)
 			goto oops;
 		err = saa7134_pgtable_build(dev->pci,buf->pt,
@@ -1084,7 +1075,7 @@
 	default:
 		return -EINVAL;
 	}
-	if (restart_overlay && res_check(fh, RESOURCE_OVERLAY)) {
+	if (restart_overlay && fh && res_check(fh, RESOURCE_OVERLAY)) {
 		spin_lock_irqsave(&dev->slock,flags);
 		stop_preview(dev,fh);
 		start_preview(dev,fh);
@@ -1140,13 +1131,13 @@
 	
 	list_for_each(list,&saa7134_devlist) {
 		h = list_entry(list, struct saa7134_dev, devlist);
-		if (h->video_dev.minor == minor)
+		if (h->video_dev && (h->video_dev->minor == minor))
 			dev = h;
-		if (h->radio_dev.minor == minor) {
+		if (h->radio_dev && (h->radio_dev->minor == minor)) {
 			radio = 1;
 			dev = h;
 		}
-		if (h->vbi_dev.minor == minor) {
+		if (h->vbi_dev && (h->vbi_dev->minor == minor)) {
 			type = V4L2_BUF_TYPE_VBI_CAPTURE;
 			dev = h;
 		}
@@ -1188,13 +1179,10 @@
 
 	if (fh->radio) {
 		/* switch to radio mode */
-		u32 v = 400*16;
 		saa7134_tvaudio_setinput(dev,&card(dev).radio);
-		saa7134_i2c_call_clients(dev,VIDIOCSFREQ,&v);
 		saa7134_i2c_call_clients(dev,AUDC_SET_RADIO,NULL);
 	} else {
 		/* switch to video/vbi mode */
-		set_tvnorm(dev,dev->tvnorm);
 		video_mux(dev,dev->ctl_input);
 	}
         return 0;
@@ -1327,7 +1315,7 @@
 	f->fmt.vbi.count[0] = norm->vbi_v_stop - norm->vbi_v_start +1;
 	f->fmt.vbi.start[1] = norm->video_v_stop + norm->vbi_v_start +1;
 	f->fmt.vbi.count[1] = f->fmt.vbi.count[0];
-	f->fmt.vbi.flags = 0; /* VBI_UNSYNC VBI_INTERLACED */;
+	f->fmt.vbi.flags = 0; /* VBI_UNSYNC VBI_INTERLACED */
 
 #if 0
 	if (V4L2_STD_PAL == norm->id) {
@@ -1479,6 +1467,92 @@
 	}
 }
 
+int saa7134_common_ioctl(struct saa7134_dev *dev,
+			 unsigned int cmd, void *arg)
+{
+	int err;
+	
+	switch (cmd) {
+	case VIDIOC_QUERYCTRL:
+	{
+		const struct v4l2_queryctrl *ctrl;
+		struct v4l2_queryctrl *c = arg;
+
+		if ((c->id <  V4L2_CID_BASE ||
+		     c->id >= V4L2_CID_LASTP1) &&
+		    (c->id <  V4L2_CID_PRIVATE_BASE ||
+		     c->id >= V4L2_CID_PRIVATE_LASTP1))
+			return -EINVAL;
+		ctrl = ctrl_by_id(c->id);
+		*c = (NULL != ctrl) ? *ctrl : no_ctrl;
+		return 0;
+	}
+	case VIDIOC_G_CTRL:
+		return get_control(dev,arg);
+	case VIDIOC_S_CTRL:
+	{
+		down(&dev->lock);
+		err = set_control(dev,NULL,arg);
+		up(&dev->lock);
+		return err;
+	}
+	/* --- input switching --------------------------------------- */
+	case VIDIOC_ENUMINPUT:
+	{
+		struct v4l2_input *i = arg;
+		unsigned int n;
+
+		n = i->index;
+		if (n >= SAA7134_INPUT_MAX)
+			return -EINVAL;
+		if (NULL == card_in(dev,i->index).name)
+			return -EINVAL;
+		memset(i,0,sizeof(*i));
+		i->index = n;
+		i->type  = V4L2_INPUT_TYPE_CAMERA;
+		strcpy(i->name,card_in(dev,n).name);
+		if (card_in(dev,n).tv)
+			i->type = V4L2_INPUT_TYPE_TUNER;
+		i->audioset = 1;
+		if (n == dev->ctl_input) {
+			int v1 = saa_readb(SAA7134_STATUS_VIDEO1);
+			int v2 = saa_readb(SAA7134_STATUS_VIDEO2);
+
+			if (0 != (v1 & 0x40))
+				i->status |= V4L2_IN_ST_NO_H_LOCK;
+			if (0 != (v2 & 0x40))
+				i->status |= V4L2_IN_ST_NO_SYNC;
+			if (0 != (v2 & 0x0e))
+				i->status |= V4L2_IN_ST_MACROVISION;
+		}
+		for (n = 0; n < TVNORMS; n++)
+			i->std |= tvnorms[n].id;
+		return 0;
+	}
+	case VIDIOC_G_INPUT:
+	{
+		int *i = arg;
+		*i = dev->ctl_input;
+		return 0;
+	}
+	case VIDIOC_S_INPUT:
+	{
+		int *i = arg;
+		
+		if (*i < 0  ||  *i >= SAA7134_INPUT_MAX)
+			return -EINVAL;
+		if (NULL == card_in(dev,*i).name)
+			return -EINVAL;
+		down(&dev->lock);
+		video_mux(dev,*i);
+		up(&dev->lock);
+		return 0;
+	}
+
+	}
+	return 0;
+}
+
 /*
  * This function is _not_ called directly, but from
  * video_generic_ioctl (and maybe others).  userspace
@@ -1562,59 +1636,6 @@
 		return 0;
 	}
 
-	/* --- input switching --------------------------------------- */
-	case VIDIOC_ENUMINPUT:
-	{
-		struct v4l2_input *i = arg;
-		unsigned int n;
-
-		n = i->index;
-		if (n >= SAA7134_INPUT_MAX)
-			return -EINVAL;
-		if (NULL == card_in(dev,i->index).name)
-			return -EINVAL;
-		memset(i,0,sizeof(*i));
-		i->index = n;
-		i->type  = V4L2_INPUT_TYPE_CAMERA;
-		strcpy(i->name,card_in(dev,n).name);
-		if (card_in(dev,n).tv)
-			i->type = V4L2_INPUT_TYPE_TUNER;
-		i->audioset = 1;
-		if (n == dev->ctl_input) {
-			int v1 = saa_readb(SAA7134_STATUS_VIDEO1);
-			int v2 = saa_readb(SAA7134_STATUS_VIDEO2);
-
-			if (0 != (v1 & 0x40))
-				i->status |= V4L2_IN_ST_NO_H_LOCK;
-			if (0 != (v2 & 0x40))
-				i->status |= V4L2_IN_ST_NO_SYNC;
-			if (0 != (v2 & 0x0e))
-				i->status |= V4L2_IN_ST_MACROVISION;
-		}
-		for (n = 0; n < TVNORMS; n++)
-			i->std |= tvnorms[n].id;
-		return 0;
-	}
-	case VIDIOC_G_INPUT:
-	{
-		int *i = arg;
-		*i = dev->ctl_input;
-		return 0;
-	}
-	case VIDIOC_S_INPUT:
-	{
-		int *i = arg;
-		
-		if (*i < 0  ||  *i >= SAA7134_INPUT_MAX)
-			return -EINVAL;
-		if (NULL == card_in(dev,*i).name)
-			return -EINVAL;
-		down(&dev->lock);
-		video_mux(dev,*i);
-		up(&dev->lock);
-		return 0;
-	}
-
 	/* --- tuner ioctls ------------------------------------------ */
 	case VIDIOC_G_TUNER:
 	{
@@ -1643,9 +1664,17 @@
 	}
 	case VIDIOC_S_TUNER:
 	{
-#if 0
 		struct v4l2_tuner *t = arg;
-#endif
+		int rx,mode;
+
+		mode = dev->thread.mode;
+		if (UNSET == mode) {
+			rx   = saa7134_tvaudio_getstereo(dev);
+			mode = saa7134_tvaudio_rx2mode(t->rxsubchans);
+		}
+		if (mode != t->audmode) {
+			dev->thread.mode = t->audmode;
+		}
 		return 0;
 	}
 	case VIDIOC_G_FREQUENCY:
@@ -1673,29 +1702,14 @@
 	}
 		
 	/* --- control ioctls ---------------------------------------- */
+	case VIDIOC_ENUMINPUT:
+	case VIDIOC_G_INPUT:
+	case VIDIOC_S_INPUT:
 	case VIDIOC_QUERYCTRL:
-	{
-		const struct v4l2_queryctrl *ctrl;
-		struct v4l2_queryctrl *c = arg;
-
-		if ((c->id <  V4L2_CID_BASE ||
-		     c->id >= V4L2_CID_LASTP1) &&
-		    (c->id <  V4L2_CID_PRIVATE_BASE ||
-		     c->id >= V4L2_CID_PRIVATE_LASTP1))
-			return -EINVAL;
-		ctrl = ctrl_by_id(c->id);
-		*c = (NULL != ctrl) ? *ctrl : no_ctrl;
-		return 0;
-	}
 	case VIDIOC_G_CTRL:
-		return get_control(dev,arg);
 	case VIDIOC_S_CTRL:
-	{
-		down(&dev->lock);
-		err = set_control(dev,fh,arg);
-		up(&dev->lock);
-		return err;
-	}
+		return saa7134_common_ioctl(dev, cmd, arg);
+
 	case VIDIOC_G_AUDIO:
 	{
 		struct v4l2_audio *a = arg;
@@ -1828,8 +1842,9 @@
 
 		q = saa7134_queue(fh);
 		memset(&req,0,sizeof(req));
-		req.type  = q->type;
-		req.count = gbuffers;
+		req.type   = q->type;
+		req.count  = gbuffers;
+		req.memory = V4L2_MEMORY_MMAP;
 		err = videobuf_reqbufs(file,q,&req);
 		if (err < 0)
 			return err;
@@ -1913,6 +1928,9 @@
 		struct v4l2_tuner *t = arg;
 		struct video_tuner vt;
 
+		if (0 != t->index)
+			return -EINVAL;
+
 		memset(t,0,sizeof(*t));
 		strcpy(t->name, "Radio");
                 t->rangelow  = (int)(65*16);
@@ -2046,7 +2064,7 @@
 	.minor         = -1,
 };
 
-int saa7134_video_init(struct saa7134_dev *dev)
+int saa7134_video_init1(struct saa7134_dev *dev)
 {
 	/* sanitycheck insmod options */
 	if (gbuffers < 2 || gbuffers > VIDEO_MAX_FRAME)
@@ -2072,12 +2090,6 @@
 	dev->video_q.timeout.data     = (unsigned long)(&dev->video_q);
 	dev->video_q.dev              = dev;
 
-	/* init video hw */
-	set_tvnorm(dev,&tvnorms[0]);
-	video_mux(dev,0);
-	saa7134_tvaudio_setmute(dev);
-	saa7134_tvaudio_setvolume(dev,dev->ctl_volume);
-
 	if (saa7134_boards[dev->board].video_out) {
 		/* enable video output */
 		int vo = saa7134_boards[dev->board].video_out;
@@ -2095,6 +2107,16 @@
 	return 0;
 }
 
+int saa7134_video_init2(struct saa7134_dev *dev)
+{
+	/* init video hw */
+	set_tvnorm(dev,&tvnorms[0]);
+	video_mux(dev,0);
+	saa7134_tvaudio_setmute(dev);
+	saa7134_tvaudio_setvolume(dev,dev->ctl_volume);
+	return 0;
+}
+
 int saa7134_video_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
diff -u linux-2.6.0-test6/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.0-test6/drivers/media/video/saa7134/saa7134.h	2003-10-06 17:45:55.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134.h	2003-10-06 17:48:03.000000000 +0200
@@ -19,20 +19,25 @@
  */
 
 #include <linux/version.h>
+#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,9)
+
 #include <linux/pci.h>
 #include <linux/i2c.h>
 #include <linux/videodev.h>
 #include <linux/kdev_t.h>
+#include <linux/input.h>
 
 #include <asm/io.h>
 
+#ifdef CONFIG_VIDEO_IR
+#include "ir-common.h"
+#endif
+
 #include <media/video-buf.h>
 #include <media/tuner.h>
 #include <media/audiochip.h>
 #include <media/id.h>
 
-#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,8)
-
 #ifndef TRUE
 # define TRUE (1==1)
 #endif
@@ -133,6 +138,11 @@
 #define SAA7134_BOARD_TYPHOON_90031    13
 #define SAA7134_BOARD_ELSA             14
 #define SAA7134_BOARD_ELSA_500TV       15
+#define SAA7134_BOARD_ASUSTeK_TVFM7134 16
+#define SAA7134_BOARD_VA1000POWER      17
+#define SAA7134_BOARD_BMK_MPEX_NOTUNER 18
+#define SAA7134_BOARD_VIDEOMATE_TV     19
+#define SAA7134_BOARD_CRONOS_PLUS      20
 
 #define SAA7134_INPUT_MAX 8
 
@@ -200,6 +210,7 @@
 	unsigned int               exit;
 	unsigned int               scan1;
 	unsigned int               scan2;
+	unsigned int               mode;
 };
 
 /* buffer for one video/vbi/ts frame */
@@ -255,6 +266,7 @@
 	/* TS capture */
 	struct videobuf_queue      ts;
 	struct saa7134_pgtable     pt_ts;
+	int			   started;
 };
 
 /* oss dsp status */
@@ -286,6 +298,18 @@
 	unsigned int               read_count;
 };
 
+#ifdef CONFIG_VIDEO_IR
+/* IR input */
+struct saa7134_ir {
+	struct input_dev           dev;
+	struct ir_input_state      ir;
+	char                       name[32];
+	char                       phys[32];
+	u32                        mask_keycode;
+	u32                        mask_keydown;
+};
+#endif
+
 /* global device status */
 struct saa7134_dev {
 	struct list_head           devlist;
@@ -294,13 +318,19 @@
 
 	/* various device info */
 	unsigned int               resources;
-	struct video_device        video_dev;
-	struct video_device        ts_dev;
-	struct video_device        radio_dev;
-	struct video_device        vbi_dev;
+	struct video_device        *video_dev;
+	struct video_device        *ts_dev;
+	struct video_device        *radio_dev;
+	struct video_device        *vbi_dev;
 	struct saa7134_oss         oss;
 	struct saa7134_ts          ts;
 
+	/* infrared remote */
+	int                        has_remote;
+#ifdef CONFIG_VIDEO_IR
+	struct saa7134_ir          *remote;
+#endif
+
 	/* pci i/o */
 	char                       name[32];
 	struct pci_dev             *pci;
@@ -311,6 +341,7 @@
 	/* config info */
 	unsigned int               board;
 	unsigned int               tuner_type;
+	unsigned int               gpio_value;
 
 	/* i2c i/o */
 	struct i2c_adapter         i2c_adap;
@@ -372,7 +403,9 @@
 #define saa_setb(reg,bit)          saa_andorb((reg),(bit),(bit))
 #define saa_clearb(reg,bit)        saa_andorb((reg),(bit),0)
 
-#define saa_wait(d) { if (need_resched()) schedule(); else udelay(d);}
+//#define saa_wait(d) { if (need_resched()) schedule(); else udelay(d);}
+#define saa_wait(d) { udelay(d); }
+//#define saa_wait(d) { schedule_timeout(HZ*d/1000 ?:1); }
 
 /* ----------------------------------------------------------- */
 /* saa7134-core.c                                              */
@@ -433,7 +466,8 @@
 int saa7134_common_ioctl(struct saa7134_dev *dev,
 			 unsigned int cmd, void *arg);
 
-int saa7134_video_init(struct saa7134_dev *dev);
+int saa7134_video_init1(struct saa7134_dev *dev);
+int saa7134_video_init2(struct saa7134_dev *dev);
 int saa7134_video_fini(struct saa7134_dev *dev);
 void saa7134_irq_video_intl(struct saa7134_dev *dev);
 void saa7134_irq_video_done(struct saa7134_dev *dev, unsigned long status);
@@ -443,7 +477,7 @@
 /* saa7134-ts.c                                                */
 
 extern struct video_device saa7134_ts_template;
-int saa7134_ts_init(struct saa7134_dev *dev);
+int saa7134_ts_init1(struct saa7134_dev *dev);
 int saa7134_ts_fini(struct saa7134_dev *dev);
 void saa7134_irq_ts_done(struct saa7134_dev *dev, unsigned long status);
 
@@ -454,7 +488,7 @@
 extern struct videobuf_queue_ops saa7134_vbi_qops;
 extern struct video_device saa7134_vbi_template;
 
-int saa7134_vbi_init(struct saa7134_dev *dev);
+int saa7134_vbi_init1(struct saa7134_dev *dev);
 int saa7134_vbi_fini(struct saa7134_dev *dev);
 void saa7134_irq_vbi_done(struct saa7134_dev *dev, unsigned long status);
 
@@ -470,7 +504,7 @@
 void saa7134_tvaudio_setvolume(struct saa7134_dev *dev, int level);
 int saa7134_tvaudio_getstereo(struct saa7134_dev *dev);
 
-int saa7134_tvaudio_init(struct saa7134_dev *dev);
+int saa7134_tvaudio_init2(struct saa7134_dev *dev);
 int saa7134_tvaudio_fini(struct saa7134_dev *dev);
 int saa7134_tvaudio_do_scan(struct saa7134_dev *dev);
 
@@ -482,10 +516,16 @@
 extern struct file_operations saa7134_dsp_fops;
 extern struct file_operations saa7134_mixer_fops;
 
-int saa7134_oss_init(struct saa7134_dev *dev);
+int saa7134_oss_init1(struct saa7134_dev *dev);
 int saa7134_oss_fini(struct saa7134_dev *dev);
 void saa7134_irq_oss_done(struct saa7134_dev *dev, unsigned long status);
 
+/* ----------------------------------------------------------- */
+/* saa7134-input.c                                             */
+
+int  saa7134_input_init1(struct saa7134_dev *dev);
+void saa7134_input_fini(struct saa7134_dev *dev);
+void saa7134_input_irq(struct saa7134_dev *dev);
 
 /*
  * Local variables:
diff -u linux-2.6.0-test6/include/media/saa6752hs.h linux/include/media/saa6752hs.h
--- linux-2.6.0-test6/include/media/saa6752hs.h	2003-10-06 17:48:03.000000000 +0200
+++ linux/include/media/saa6752hs.h	2003-10-06 17:48:03.000000000 +0200
@@ -0,0 +1,58 @@
+/* 
+    saa6752hs.h - definition for saa6752hs MPEG encoder
+
+    Copyright (C) 2003 Andrew de Quincey <adq@lidskialf.net>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef _SAA6752HS_H
+#define _SAA6752HS_H
+
+enum mpeg_bitrate_mode {
+	MPEG_BITRATE_MODE_VBR = 0, /* Variable bitrate */
+	MPEG_BITRATE_MODE_CBR = 1, /* Constant bitrate */
+
+	MPEG_BITRATE_MODE_MAX
+};
+
+enum mpeg_audio_bitrate {
+	MPEG_AUDIO_BITRATE_256 = 0, /* 256 kBit/sec */
+	MPEG_AUDIO_BITRATE_384 = 1, /* 384 kBit/sec */
+    
+	MPEG_AUDIO_BITRATE_MAX
+};
+
+#define MPEG_VIDEO_TARGET_BITRATE_MAX 27000
+#define MPEG_VIDEO_MAX_BITRATE_MAX 27000
+#define MPEG_TOTAL_BITRATE_MAX 27000
+    
+struct mpeg_params {
+	enum mpeg_bitrate_mode bitrate_mode;
+	unsigned int video_target_bitrate;
+	unsigned int video_max_bitrate; // only used for VBR
+	enum mpeg_audio_bitrate audio_bitrate;
+	unsigned int total_bitrate;
+};
+
+#define MPEG_SETPARAMS             _IOW('6',100,struct mpeg_params)
+
+#endif // _SAA6752HS_H
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */

-- 
You have a new virus in /var/mail/kraxel
