Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTAHLvi>; Wed, 8 Jan 2003 06:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbTAHLvh>; Wed, 8 Jan 2003 06:51:37 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:5012 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267179AbTAHLvZ>; Wed, 8 Jan 2003 06:51:25 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Jan 2003 13:03:54 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] add bt832 module
Message-ID: <20030108120354.GA17225@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds a driver module for the bt832 chip.  It is needed
by the bttv driver to support the Pixelview Digital Camera.  The
bt832 is connected using the GPIO pins of the bt878 chip.

Please apply,

  Gerd

--- linux-2.5.54/drivers/media/video/bt832.c	2003-01-08 10:59:58.000000000 +0100
+++ linux/drivers/media/video/bt832.c	2003-01-08 10:59:58.000000000 +0100
@@ -0,0 +1,289 @@
+/* Driver for Bt832 CMOS Camera Video Processor
+    i2c-adresses: 0x88 or 0x8a
+
+  The BT832 interfaces to a Quartzsight Digital Camera (352x288, 25 or 30 fps)
+  via a 9 pin connector ( 4-wire SDATA, 2-wire i2c, SCLK, VCC, GND).
+  It outputs an 8-bit 4:2:2 YUV or YCrCb video signal which can be directly
+  connected to bt848/bt878 GPIO pins on this purpose.
+  (see: VLSI Vision Ltd. www.vvl.co.uk for camera datasheets)
+  
+  Supported Cards:
+  -  Pixelview Rev.4E: 0x8a
+		GPIO 0x400000 toggles Bt832 RESET, and the chip changes to i2c 0x88 !
+
+  (c) Gunther Mayer, 2002
+
+  STATUS:
+  - detect chip and hexdump
+  - reset chip and leave low power mode
+  - detect camera present
+
+  TODO:
+  - make it work (find correct setup for Bt832 and Bt878)
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/types.h>
+#include <linux/videodev.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+
+#include "id.h"
+#include "audiochip.h"
+#include "bttv.h"
+#include "bt832.h"
+
+MODULE_LICENSE("GPL");
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {I2C_CLIENT_END};
+static unsigned short normal_i2c_range[] = {I2C_BT832_ALT1>>1,I2C_BT832_ALT2>>1,I2C_CLIENT_END};
+I2C_CLIENT_INSMOD;
+
+/* ---------------------------------------------------------------------- */
+
+#define dprintk     if (debug) printk
+
+static int bt832_detach(struct i2c_client *client);
+
+
+static struct i2c_driver driver;
+static struct i2c_client client_template;
+
+struct bt832 {
+        struct i2c_client client;
+};
+
+int bt832_hexdump(struct i2c_client *i2c_client_s, unsigned char *buf)
+{
+	int i,rc;
+	buf[0]=0x80; // start at register 0 with auto-increment
+        if (1 != (rc = i2c_master_send(i2c_client_s,buf,1)))
+                printk("bt832: i2c i/o error: rc == %d (should be 1)\n",rc);
+
+        for(i=0;i<65;i++)
+                buf[i]=0;
+        if (65 != (rc=i2c_master_recv(i2c_client_s,buf,65)))
+                printk("bt832: i2c i/o error: rc == %d (should be 65)\n",rc);
+
+        // Note: On READ the first byte is the current index
+        //  (e.g. 0x80, what we just wrote)
+
+        if(1) {
+                int i;
+                printk("BT832 hexdump:\n");
+                for(i=1;i<65;i++) {
+			if(i!=1) {
+			  if(((i-1)%8)==0) printk(" ");
+                          if(((i-1)%16)==0) printk("\n");
+			}
+                        printk(" %02x",buf[i]);
+                }
+                printk("\n");
+        }
+	return 0;
+}
+
+// Return: 1 (is a bt832), 0 (No bt832 here)
+int bt832_init(struct i2c_client *i2c_client_s)
+{
+	unsigned char *buf;
+	int rc;
+
+	buf=kmalloc(65,GFP_KERNEL);
+	bt832_hexdump(i2c_client_s,buf);
+	
+	if(buf[0x40] != 0x31) {
+		printk("bt832: this i2c chip is no bt832 (id=%02x). Detaching.\n",buf[0x40]);
+		kfree(buf);
+		return 0;
+	}
+
+        printk("Write 0 tp VPSTATUS\n");
+        buf[0]=BT832_VP_STATUS; // Reg.52
+        buf[1]= 0x00;
+        if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
+                printk("bt832: i2c i/o error VPS: rc == %d (should be 2)\n",rc);
+
+        bt832_hexdump(i2c_client_s,buf);
+
+
+	// Leave low power mode:
+	printk("Bt832: leave low power mode.\n");
+	buf[0]=BT832_CAM_SETUP0; //0x39 57
+	buf[1]=0x08;
+	if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
+                printk("bt832: i2c i/o error LLPM: rc == %d (should be 2)\n",rc);
+
+        bt832_hexdump(i2c_client_s,buf);
+
+	printk("Write 0 tp VPSTATUS\n");
+        buf[0]=BT832_VP_STATUS; // Reg.52
+        buf[1]= 0x00;
+        if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
+                printk("bt832: i2c i/o error VPS: rc == %d (should be 2)\n",rc);
+
+        bt832_hexdump(i2c_client_s,buf);
+
+
+	// Enable Output
+	printk("Enable Output\n");
+	buf[0]=BT832_VP_CONTROL1; // Reg.40
+	buf[1]= 0x27 & (~0x01); // Default | !skip
+	if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
+                printk("bt832: i2c i/o error EO: rc == %d (should be 2)\n",rc);
+	
+        bt832_hexdump(i2c_client_s,buf);
+
+#if 0
+	// Full 30/25 Frame rate
+	printk("Full 30/25 Frame rate\n");
+	buf[0]=BT832_VP_CONTROL0; // Reg.39
+        buf[1]= 0x00;
+        if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
+                printk("bt832: i2c i/o error FFR: rc == %d (should be 2)\n",rc);
+
+        bt832_hexdump(i2c_client_s,buf);
+#endif
+
+#if 1
+	// for testing (even works when no camera attached)
+	printk("bt832: *** Generate NTSC M Bars *****\n");
+	buf[0]=BT832_VP_TESTCONTROL0; // Reg. 42
+	buf[1]=3; // Generate NTSC System M bars, Generate Frame timing internally
+        if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
+                printk("bt832: i2c i/o error MBAR: rc == %d (should be 2)\n",rc);
+#endif
+
+	printk("Bt832: Camera Present: %s\n",
+		(buf[1+BT832_CAM_STATUS] & BT832_56_CAMERA_PRESENT) ? "yes":"no");
+
+        bt832_hexdump(i2c_client_s,buf);
+	kfree(buf);
+	return 1;
+}
+
+
+
+static int bt832_attach(struct i2c_adapter *adap, int addr,
+			  unsigned short flags, int kind)
+{
+	struct bt832 *t;
+
+	printk("bt832_attach\n");
+
+        client_template.adapter = adap;
+        client_template.addr    = addr;
+
+        printk("bt832: chip found @ 0x%x\n", addr<<1);
+
+        if (NULL == (t = kmalloc(sizeof(*t), GFP_KERNEL)))
+                return -ENOMEM;
+	memset(t,0,sizeof(*t));
+	t->client = client_template;
+        t->client.data = t;
+        i2c_attach_client(&t->client);
+
+	MOD_INC_USE_COUNT;
+	if(! bt832_init(&t->client)) {
+		bt832_detach(&t->client);
+		return -1;
+	}
+        
+	return 0;
+}
+
+static int bt832_probe(struct i2c_adapter *adap)
+{
+	int rc;
+
+	printk("bt832_probe\n");
+
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_ALGO_SAA7134:
+		printk("bt832: probing %s i2c adapter [id=0x%x]\n",
+		       adap->name,adap->id);
+		rc = i2c_probe(adap, &addr_data, bt832_attach);
+		break;
+	default:
+		printk("bt832: ignoring %s i2c adapter [id=0x%x]\n",
+		       adap->name,adap->id);
+		rc = 0;
+		/* nothing */
+	}
+	return rc;
+}
+
+static int bt832_detach(struct i2c_client *client)
+{
+	struct bt832 *t = (struct bt832*)client->data;
+
+	printk("bt832: detach.\n");
+	i2c_detach_client(client);
+	kfree(t);
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static int
+bt832_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct bt832 *t = (struct bt832*)client->data;
+
+	printk("bt832: command %x\n",cmd);
+
+        switch (cmd) {
+		case BT832_HEXDUMP: {
+			unsigned char *buf;
+			buf=kmalloc(65,GFP_KERNEL);
+			bt832_hexdump(&t->client,buf);
+			kfree(buf);
+		}
+		break;
+		case BT832_REATTACH:
+			printk("bt832: re-attach\n");
+			i2c_del_driver(&driver);
+			i2c_add_driver(&driver);
+		break;
+	}
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+static struct i2c_driver driver = {
+	.owner          = THIS_MODULE,
+        .name           = "i2c bt832 driver",
+        .id             = -1, /* FIXME */
+        .flags          = I2C_DF_NOTIFY,
+        .attach_adapter = bt832_probe,
+        .detach_client  = bt832_detach,
+        .command        = bt832_command,
+};
+static struct i2c_client client_template =
+{
+        .name   = "bt832",
+	.flags  = I2C_CLIENT_ALLOW_USE,
+        .driver = &driver,
+};
+
+
+int bt832_init_module(void)
+{
+	i2c_add_driver(&driver);
+	return 0;
+}
+
+static void bt832_cleanup_module(void)
+{
+	i2c_del_driver(&driver);
+}
+
+module_init(bt832_init_module);
+module_exit(bt832_cleanup_module);
+
--- linux-2.5.54/drivers/media/video/bt832.h	2003-01-08 10:59:58.000000000 +0100
+++ linux/drivers/media/video/bt832.h	2003-01-08 10:59:58.000000000 +0100
@@ -0,0 +1,305 @@
+/* Bt832 CMOS Camera Video Processor (VP)
+
+ The Bt832 CMOS Camera Video Processor chip connects a Quartsight CMOS 
+  color digital camera directly to video capture devices via an 8-bit,
+  4:2:2 YUV or YCrCb video interface.
+
+ i2c adresses: 0x88 or 0x8a
+ */
+
+/* The 64 registers: */
+
+// Input Processor
+#define BT832_OFFSET 0
+#define BT832_RCOMP	1
+#define BT832_G1COMP	2
+#define BT832_G2COMP	3
+#define BT832_BCOMP	4
+// Exposures:
+#define BT832_FINEH	5
+#define BT832_FINEL	6
+#define BT832_COARSEH	7
+#define BT832_COARSEL   8
+#define BT832_CAMGAIN	9
+// Main Processor:
+#define BT832_M00	10
+#define BT832_M01	11
+#define BT832_M02	12
+#define BT832_M10	13
+#define BT832_M11	14
+#define BT832_M12	15
+#define BT832_M20	16
+#define BT832_M21	17
+#define BT832_M22	18
+#define BT832_APCOR	19
+#define BT832_GAMCOR	20
+// Level Accumulator Inputs
+#define BT832_VPCONTROL2	21
+#define BT832_ZONECODE0	22
+#define BT832_ZONECODE1	23
+#define BT832_ZONECODE2	24
+#define BT832_ZONECODE3	25
+// Level Accumulator Outputs:
+#define BT832_RACC	26
+#define BT832_GACC	27
+#define BT832_BACC	28
+#define BT832_BLACKACC	29
+#define BT832_EXP_AGC	30
+#define BT832_LACC0	31
+#define BT832_LACC1	32
+#define BT832_LACC2	33
+#define BT832_LACC3	34
+#define BT832_LACC4	35
+#define BT832_LACC5	36
+#define BT832_LACC6	37
+#define BT832_LACC7	38
+// System:
+#define BT832_VP_CONTROL0	39
+#define BT832_VP_CONTROL1	40
+#define BT832_THRESH	41
+#define BT832_VP_TESTCONTROL0	42
+#define BT832_VP_DMCODE	43
+#define BT832_ACB_CONFIG	44
+#define BT832_ACB_GNBASE	45
+#define BT832_ACB_MU	46
+#define BT832_CAM_TEST0	47
+#define BT832_AEC_CONFIG	48
+#define BT832_AEC_TL	49
+#define BT832_AEC_TC	50
+#define BT832_AEC_TH	51
+// Status:
+#define BT832_VP_STATUS	52
+#define BT832_VP_LINECOUNT	53
+#define BT832_CAM_DEVICEL	54 // e.g. 0x19
+#define BT832_CAM_DEVICEH	55 // e.g. 0x40  == 0x194 Mask0, 0x194 = 404 decimal (VVL-404 camera)
+#define BT832_CAM_STATUS		56
+ #define BT832_56_CAMERA_PRESENT 0x20
+//Camera Setups:
+#define BT832_CAM_SETUP0	57
+#define BT832_CAM_SETUP1	58
+#define BT832_CAM_SETUP2	59
+#define BT832_CAM_SETUP3	60
+// System:
+#define BT832_DEFCOR		61
+#define BT832_VP_TESTCONTROL1	62
+#define BT832_DEVICE_ID		63
+# define BT832_DEVICE_ID__31		0x31 // Bt832 has ID 0x31
+
+/* STMicroelectronivcs VV5404 camera module 
+   i2c: 0x20: sensor address
+   i2c: 0xa0: eeprom for ccd defect map
+ */
+#define VV5404_device_h		0x00  // 0x19
+#define VV5404_device_l		0x01  // 0x40
+#define VV5404_status0		0x02
+#define VV5404_linecountc	0x03 // current line counter
+#define VV5404_linecountl	0x04
+#define VV5404_setup0		0x10
+#define VV5404_setup1		0x11
+#define VV5404_setup2		0x12
+#define VV5404_setup4		0x14
+#define VV5404_setup5		0x15
+#define VV5404_fine_h		0x20  // fine exposure
+#define VV5404_fine_l		0x21
+#define VV5404_coarse_h		0x22  //coarse exposure
+#define VV5404_coarse_l		0x23
+#define VV5404_gain		0x24 // ADC pre-amp gain setting
+#define VV5404_clk_div		0x25
+#define VV5404_cr		0x76 // control register
+#define VV5404_as0		0x77 // ADC setup register
+
+
+// IOCTL
+#define BT832_HEXDUMP   _IOR('b',1,int)
+#define BT832_REATTACH	_IOR('b',2,int)
+
+/* from BT8x8VXD/capdrv/dialogs.cpp */
+
+/*
+typedef enum { SVI, Logitech, Rockwell } CAMERA;
+
+static COMBOBOX_ENTRY gwCameraOptions[] =
+{
+   { SVI,      "Silicon Vision 512N" },
+   { Logitech, "Logitech VideoMan 1.3"  },
+   { Rockwell, "Rockwell QuartzSight PCI 1.0"   }
+};
+
+// SRAM table values
+//===========================================================================
+typedef enum { TGB_NTSC624, TGB_NTSC780, TGB_NTSC858, TGB_NTSC392 } TimeGenByte;
+
+BYTE SRAMTable[][ 60 ] =
+{
+   // TGB_NTSC624
+   {
+      0x33, // size of table = 51
+      0x0E, 0xC0, 0x00, 0x00, 0x90, 0x02, 0x03, 0x10, 0x03, 0x06,
+      0x10, 0x04, 0x12, 0x12, 0x05, 0x02, 0x13, 0x04, 0x19, 0x00,
+      0x04, 0x39, 0x00, 0x06, 0x59, 0x08, 0x03, 0x85, 0x08, 0x07,
+      0x03, 0x50, 0x00, 0x91, 0x40, 0x00, 0x11, 0x01, 0x01, 0x4D,
+      0x0D, 0x02, 0x03, 0x11, 0x01, 0x05, 0x37, 0x00, 0x37, 0x21, 0x00
+   },
+   // TGB_NTSC780
+   {
+      0x33, // size of table = 51
+      0x0e, 0xc0, 0x00, 0x00, 0x90, 0xe2, 0x03, 0x10, 0x03, 0x06,
+      0x10, 0x34, 0x12, 0x12, 0x65, 0x02, 0x13, 0x24, 0x19, 0x00,
+      0x24, 0x39, 0x00, 0x96, 0x59, 0x08, 0x93, 0x85, 0x08, 0x97,
+      0x03, 0x50, 0x50, 0xaf, 0x40, 0x30, 0x5f, 0x01, 0xf1, 0x7f,
+      0x0d, 0xf2, 0x03, 0x11, 0xf1, 0x05, 0x37, 0x30, 0x85, 0x21, 0x50
+   },
+   // TGB_NTSC858
+   {
+      0x33, // size of table = 51
+      0x0c, 0xc0, 0x00, 0x00, 0x90, 0xc2, 0x03, 0x10, 0x03, 0x06,
+      0x10, 0x34, 0x12, 0x12, 0x65, 0x02, 0x13, 0x24, 0x19, 0x00,
+      0x24, 0x39, 0x00, 0x96, 0x59, 0x08, 0x93, 0x83, 0x08, 0x97,
+      0x03, 0x50, 0x30, 0xc0, 0x40, 0x30, 0x86, 0x01, 0x01, 0xa6,
+      0x0d, 0x62, 0x03, 0x11, 0x61, 0x05, 0x37, 0x30, 0xac, 0x21, 0x50
+   },
+   // TGB_NTSC392
+   // This table has been modified to be used for Fusion Rev D
+   {
+      0x2A, // size of table = 42
+      0x06, 0x08, 0x04, 0x0a, 0xc0, 0x00, 0x18, 0x08, 0x03, 0x24,
+      0x08, 0x07, 0x02, 0x90, 0x02, 0x08, 0x10, 0x04, 0x0c, 0x10,
+      0x05, 0x2c, 0x11, 0x04, 0x55, 0x48, 0x00, 0x05, 0x50, 0x00,
+      0xbf, 0x0c, 0x02, 0x2f, 0x3d, 0x00, 0x2f, 0x3f, 0x00, 0xc3,
+      0x20, 0x00
+   }
+};
+
+//===========================================================================
+// This is the structure of the camera specifications
+//===========================================================================
+typedef struct tag_cameraSpec
+{
+   SignalFormat signal;       // which digital signal format the camera has
+   VideoFormat  vidFormat;    // video standard
+   SyncVideoRef syncRef;      // which sync video reference is used
+   State        syncOutput;   // enable sync output for sync video input?
+   DecInputClk  iClk;         // which input clock is used
+   TimeGenByte  tgb;          // which timing generator byte does the camera use
+   int          HReset;       // select 64, 48, 32, or 16 CLKx1 for HReset
+   PLLFreq      pllFreq;      // what synthesized frequency to set PLL to
+   VSIZEPARMS   vSize;        // video size the camera produces
+   int          lineCount;    // expected total number of half-line per frame - 1
+   BOOL         interlace;    // interlace signal?
+} CameraSpec;
+
+//===========================================================================
+// <UPDATE REQUIRED>
+// Camera specifications database. Update this table whenever camera spec
+// has been changed or added/deleted supported camera models
+//===========================================================================
+static CameraSpec dbCameraSpec[ N_CAMERAOPTIONS ] =
+{  // Silicon Vision 512N
+   { Signal_CCIR656, VFormat_NTSC, VRef_alignedCb, Off, DecClk_GPCLK, TGB_NTSC624, 64, KHz19636,
+      // Clkx1_HACTIVE, Clkx1_HDELAY, VActive, VDelay, linesPerField; lineCount, Interlace
+   {         512,           0x64,       480,    0x13,      240 },         0,       TRUE
+   },
+   // Logitech VideoMan 1.3
+   { Signal_CCIR656, VFormat_NTSC, VRef_alignedCb, Off, DecClk_GPCLK, TGB_NTSC780, 64, KHz24545,
+      // Clkx1_HACTIVE, Clkx1_HDELAY, VActive, VDelay, linesPerField; lineCount, Interlace
+      {      640,           0x80,       480,    0x1A,      240 },         0,       TRUE
+   },
+   // Rockwell QuartzSight
+   // Note: Fusion Rev D (rev ID 0x02) and later supports 16 pixels for HReset which is preferable.
+   //       Use 32 for earlier version of hardware. Clkx1_HDELAY also changed from 0x27 to 0x20.
+   { Signal_CCIR656, VFormat_NTSC, VRef_alignedCb, Off, DecClk_GPCLK, TGB_NTSC392, 16, KHz28636,
+      // Clkx1_HACTIVE, Clkx1_HDELAY, VActive, VDelay, linesPerField; lineCount, Interlace
+      {      352,           0x20,       576,    0x08,      288 },       607,       FALSE
+   }
+};
+*/
+
+/*
+The corresponding APIs required to be invoked are:
+SetConnector( ConCamera, TRUE/FALSE );
+SetSignalFormat( spec.signal );
+SetVideoFormat( spec.vidFormat );
+SetSyncVideoRef( spec.syncRef );
+SetEnableSyncOutput( spec.syncOutput );
+SetTimGenByte( SRAMTable[ spec.tgb ], SRAMTableSize[ spec.tgb ] );
+SetHReset( spec.HReset );
+SetPLL( spec.pllFreq );
+SetDecInputClock( spec.iClk );
+SetVideoInfo( spec.vSize );
+SetTotalLineCount( spec.lineCount );
+SetInterlaceMode( spec.interlace );
+*/
+
+/* from web:
+ Video Sampling
+Digital video is a sampled form of analog video. The most common sampling schemes in use today are:
+                  Pixel Clock   Horiz    Horiz    Vert
+                   Rate         Total    Active
+NTSC square pixel  12.27 MHz    780      640      525
+NTSC CCIR-601      13.5  MHz    858      720      525
+NTSC 4FSc          14.32 MHz    910      768      525
+PAL  square pixel  14.75 MHz    944      768      625
+PAL  CCIR-601      13.5  MHz    864      720      625
+PAL  4FSc          17.72 MHz   1135      948      625
+
+For the CCIR-601 standards, the sampling is based on a static orthogonal sampling grid. The luminance component (Y) is sampled at 13.5 MHz, while the two color difference signals, Cr and Cb are sampled at half that, or 6.75 MHz. The Cr and Cb samples are colocated with alternate Y samples, and they are taken at the same position on each line, such that one sample is coincident with the 50% point of the falling edge of analog sync. The samples are coded to either 8 or 10 bits per component.
+*/
+
+/* from DScaler:*/
+/*
+//===========================================================================
+// CCIR656 Digital Input Support: The tables were taken from DScaler proyect
+//
+// 13 Dec 2000 - Michael Eskin, Conexant Systems - Initial version
+//
+
+//===========================================================================
+// Timing generator SRAM table values for CCIR601 720x480 NTSC
+//===========================================================================
+// For NTSC CCIR656 
+BYTE BtCard::SRAMTable_NTSC[] =
+{
+    // SRAM Timing Table for NTSC
+    0x0c, 0xc0, 0x00, 
+    0x00, 0x90, 0xc2, 
+    0x03, 0x10, 0x03, 
+    0x06, 0x10, 0x34, 
+    0x12, 0x12, 0x65, 
+    0x02, 0x13, 0x24, 
+    0x19, 0x00, 0x24, 
+    0x39, 0x00, 0x96, 
+    0x59, 0x08, 0x93, 
+    0x83, 0x08, 0x97,
+    0x03, 0x50, 0x30, 
+    0xc0, 0x40, 0x30, 
+    0x86, 0x01, 0x01, 
+    0xa6, 0x0d, 0x62, 
+    0x03, 0x11, 0x61, 
+    0x05, 0x37, 0x30, 
+    0xac, 0x21, 0x50
+};
+
+//===========================================================================
+// Timing generator SRAM table values for CCIR601 720x576 NTSC
+//===========================================================================
+// For PAL CCIR656
+BYTE BtCard::SRAMTable_PAL[] =
+{
+    // SRAM Timing Table for PAL
+    0x36, 0x11, 0x01,
+    0x00, 0x90, 0x02,
+    0x05, 0x10, 0x04,
+    0x16, 0x14, 0x05,
+    0x11, 0x00, 0x04,
+    0x12, 0xc0, 0x00,
+    0x31, 0x00, 0x06,
+    0x51, 0x08, 0x03,
+    0x89, 0x08, 0x07,
+    0xc0, 0x44, 0x00,
+    0x81, 0x01, 0x01,
+    0xa9, 0x0d, 0x02,
+    0x02, 0x50, 0x03,
+    0x37, 0x3d, 0x00,
+    0xaf, 0x21, 0x00,
+};
+*/

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
