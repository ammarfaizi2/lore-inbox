Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUIQP0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUIQP0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIQP0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:26:48 -0400
Received: from mail.convergence.de ([212.227.36.84]:55206 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268832AbUIQOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:41:46 -0400
Message-ID: <414AF779.6040409@linuxtv.org>
Date: Fri, 17 Sep 2004 16:40:57 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][13/14] dvb frontend updates
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org> <414AF605.5040605@linuxtv.org> <414AF65F.2010200@linuxtv.org> <414AF6B1.9040706@linuxtv.org> <414AF71B.5070702@linuxtv.org>
In-Reply-To: <414AF71B.5070702@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------020108080804070104030406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020108080804070104030406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------020108080804070104030406
Content-Type: text/plain;
 name="13-DVB-frontend-updates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="13-DVB-frontend-updates.diff"

- [DVB] all: replace dvb_unregister_frontend_new() with dvb_unregister_frontend()
- [DVB] sp887x: fix firmware download, patch by Jose Alberto Reguero
- [DVB] tda1004x: add firmware loading via firmware_class()
- [DVB] dvb_frontend: without hierachical coding, code_rate_LP is irrelevant, so we tolerate the otherwise invalid FEC_NONE setting
- [DVB] ves1x93: fixed dropouts on older DVB cards, fix tuning issues (Andreas Share / Gregoire Favre), 

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_ksyms.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ksyms.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_ksyms.c	2004-09-17 12:26:16.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_ksyms.c	2004-08-24 17:54:22.000000000 +0200
@@ -24,7 +24,7 @@
 EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
 
 EXPORT_SYMBOL(dvb_register_frontend);
-EXPORT_SYMBOL(dvb_unregister_frontend_new);
+EXPORT_SYMBOL(dvb_unregister_frontend);
 EXPORT_SYMBOL(dvb_add_frontend_ioctls);
 EXPORT_SYMBOL(dvb_remove_frontend_ioctls);
 EXPORT_SYMBOL(dvb_add_frontend_notifier);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/alps_tdlb7.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdlb7.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/alps_tdlb7.c	2004-09-17 12:26:19.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdlb7.c	2004-09-01 12:19:01.000000000 +0200
@@ -19,15 +19,10 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 */
-
 /* 
-    This driver needs a copy of the firmware file from the Technotrend
-    Windoze driver.
-
-    This page is worth a look:
-    http://www.heise.de/ct/ftp/projekte/vdr/firmware.shtml
-    
-    Copy 'Sc_main.mc'  to '/usr/lib/hotplug/firmware/dvb-fe-tdlb7-2.16.fw'.
+ * This driver needs external firmware. Please use the command
+ * "<kerneldir>/Documentation/dvb/get_dvb_firmware alps_tdlb7" to
+ * download/extract it, and then copy it to /usr/lib/hotplug/firmware.
 */  
 #define SP887X_DEFAULT_FIRMWARE "dvb-fe-tdlb7-2.16.fw"
 
@@ -690,7 +683,7 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	dvb_unregister_frontend_new (tdlb7_ioctl, state->dvb);
+	dvb_unregister_frontend (tdlb7_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdmb7.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/alps_tdmb7.c	2004-09-17 12:26:19.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/alps_tdmb7.c	2004-08-24 17:54:22.000000000 +0200
@@ -470,7 +467,7 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	dvb_unregister_frontend_new (tdmb7_ioctl, state->dvb);
+	dvb_unregister_frontend (tdmb7_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/at76c651.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/at76c651.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/at76c651.c	2004-09-17 12:26:19.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/at76c651.c	2004-08-24 17:54:22.000000000 +0200
@@ -514,7 +508,7 @@
 {
 	struct at76c651_state *state = i2c_get_clientdata(client);
 
-	dvb_unregister_frontend_new(at76c651_ioctl, state->dvb);
+	dvb_unregister_frontend(at76c651_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/cx24110.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/cx24110.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/cx24110.c	2004-09-17 12:26:19.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/cx24110.c	2004-08-24 17:54:22.000000000 +0200
@@ -708,7 +708,7 @@
 {
 	struct cx24110_state *state = i2c_get_clientdata(client);
 
-	dvb_unregister_frontend_new(cx24110_ioctl, state->dvb);
+	dvb_unregister_frontend(cx24110_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dst.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/dst.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dst.c	2004-09-17 12:26:19.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/dst.c	2004-08-24 17:54:22.000000000 +0200
@@ -1193,7 +1190,7 @@
 {
 	struct dst_data *state = (struct dst_data *) i2c_get_clientdata(client);
 	
-	dvb_unregister_frontend_new(dst_ioctl, state->dvb);
+	dvb_unregister_frontend(dst_ioctl, state->dvb);
 
 	device_remove_file(&client->dev, &dev_attr_client_type);
 	device_remove_file(&client->dev, &dev_attr_client_flags);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dvb_dummy_fe.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/dvb_dummy_fe.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dvb_dummy_fe.c	2004-09-17 12:26:24.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/dvb_dummy_fe.c	2004-08-24 17:54:22.000000000 +0200
@@ -207,7 +207,7 @@
 {
 	struct dvb_adapter *dvb = i2c_get_clientdata(client);
 
-	dvb_unregister_frontend_new(dvbdummyfe_ioctl, dvb);
+	dvb_unregister_frontend(dvbdummyfe_ioctl, dvb);
 	i2c_detach_client(client);
 	kfree(client);
 	return 0;
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/grundig_29504-401.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-401.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/grundig_29504-401.c	2004-09-17 12:26:24.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-401.c	2004-08-24 17:54:22.000000000 +0200
@@ -684,7 +684,7 @@
 {
 	struct l64781_state *state = i2c_get_clientdata(client);
 
-	dvb_unregister_frontend_new(l64781_ioctl, state->dvb);
+	dvb_unregister_frontend(l64781_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/grundig_29504-491.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-491.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/grundig_29504-491.c	2004-09-17 12:26:24.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/grundig_29504-491.c	2004-08-24 17:54:22.000000000 +0200
@@ -492,7 +490,7 @@
 {
 	struct tda8083_state *state = i2c_get_clientdata(client);
 
-	dvb_unregister_frontend_new (tda8083_ioctl, state->dvb);
+	dvb_unregister_frontend (tda8083_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/mt312.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt312.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/mt312.c	2004-09-17 12:26:24.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt312.c	2004-08-24 17:54:22.000000000 +0200
@@ -845,7 +845,7 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	dvb_unregister_frontend_new (mt312_ioctl, state->dvb);
+	dvb_unregister_frontend (mt312_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/mt352.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt352.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/mt352.c	2004-09-17 12:26:33.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt352.c	2004-08-24 17:54:22.000000000 +0200
@@ -840,7 +840,7 @@
 {
 	struct mt352_state *state = i2c_get_clientdata(client);
 
-	dvb_unregister_frontend_new (mt352_ioctl, state->dvb);
+	dvb_unregister_frontend (mt352_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/nxt6000.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/nxt6000.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/nxt6000.c	2004-09-17 12:26:29.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/nxt6000.c	2004-08-24 17:54:22.000000000 +0200
@@ -872,7 +791,7 @@
 static int detach_client(struct i2c_client *client)
 {
 	struct nxt6000_config *state = (struct nxt6000_config *) i2c_get_clientdata(client);
-	dvb_unregister_frontend_new(nxt6000_ioctl, state->dvb);
+	dvb_unregister_frontend(nxt6000_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/sp887x.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/sp887x.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/sp887x.c	2004-09-17 12:26:29.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/sp887x.c	2004-09-01 12:19:01.000000000 +0200
@@ -3,16 +3,9 @@
 */
 
 /*
-   This driver needs a copy of the Avermedia firmware. The version tested
-   is part of the Avermedia DVB-T 1.3.26.3 Application. If the software is
-   installed in Windoze the file will be in the /Program Files/AVerTV DVB-T/
-   directory and is called sc_main.mc. Alternatively it can "extracted" from
-   the install cab files.
-   
-   Copy this file to '/usr/lib/hotplug/firmware/dvb-fe-sp887x.fw'.
-   
-   With this version of the file the first 10 bytes are discarded and the
-   next 0x4000 loaded. This may change in future versions.
+ * This driver needs external firmware. Please use the command
+ * "<kerneldir>/Documentation/dvb/get_dvb_firmware sp887x" to
+ * download/extract it, and then copy it to /usr/lib/hotplug/firmware.
  */
 #define SP887X_DEFAULT_FIRMWARE "dvb-fe-sp887x.fw"
 
@@ -202,8 +195,8 @@
 		int c = BLOCKSIZE;
 		int err;
 
-		if (i+c > fw_size)
-			c = fw_size - i;
+		if (i+c > FW_SIZE)
+			c = FW_SIZE - i;
 
 		/* bit 0x8000 in address is set to enable 13bit mode */
 		/* bit 0x4000 enables multibyte read/write transfers */
@@ -650,7 +641,7 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	dvb_unregister_frontend_new (sp887x_ioctl, state->dvb);
+	dvb_unregister_frontend (sp887x_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/stv0299.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/stv0299.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/stv0299.c	2004-09-17 12:26:18.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/stv0299.c	2004-09-17 12:35:36.000000000 +0200
@@ -1414,7 +1414,7 @@
 {
 	struct stv0299_state *state = (struct stv0299_state*)i2c_get_clientdata(client);
 
-	dvb_unregister_frontend_new (uni0299_ioctl, state->dvb);
+	dvb_unregister_frontend (uni0299_ioctl, state->dvb);
 	i2c_detach_client(client);
 	kfree(client);
 	kfree(state);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/tda1004x.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/tda1004x.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/tda1004x.c	2004-09-17 12:26:18.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/tda1004x.c	2004-09-01 12:19:01.000000000 +0200
@@ -19,20 +19,14 @@
      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
    */
-
 /*
-    This driver needs a copy of the DLL "ttlcdacc.dll" from the Haupauge or Technotrend
-	windows driver.
-
-    Currently the DLL from v2.15a of the technotrend driver is supported. Other versions can
-    be added reasonably painlessly.
-
-    Windows driver URL: http://www.technotrend.de/
-
-	wget http://www.technotrend.de/new/215/TTweb_215a_budget_20_05_2003.zip
-	unzip -j TTweb_215a_budget_20_05_2003.zip Software/Oem/PCI/App/ttlcdacc.dll
+ * This driver needs external firmware. Please use the commands
+ * "<kerneldir>/Documentation/dvb/get_dvb_firmware tda10045",
+ * "<kerneldir>/Documentation/dvb/get_dvb_firmware tda10046" to
+ * download/extract them, and then copy them to /usr/lib/hotplug/firmware.
 */
-#define TDA1004X_DEFAULT_FIRMWARE "tda1004x.bin"
+#define TDA10045_DEFAULT_FIRMWARE "dvb-fe-tda10045.fw"
+#define TDA10046_DEFAULT_FIRMWARE "dvb-fe-tda10046.fw"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -181,32 +174,6 @@
 	int dspVersion;
 };
 
-struct fwinfo {
-	int file_size;
-	int fw_offset;
-	int fw_size;
-};
-
-static struct fwinfo tda10045h_fwinfo[] = {
-	{
-		.file_size = 286720,
-		.fw_offset = 0x34cc5,
-		.fw_size = 30555
-	},
-};
-
-static int tda10045h_fwinfo_count = sizeof(tda10045h_fwinfo) / sizeof(struct fwinfo);
-
-static struct fwinfo tda10046h_fwinfo[] = {
-	{
-		.file_size = 286720,
-		.fw_offset = 0x3c4f9,
-		.fw_size = 24479
-	}
-};
-
-static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
-
 static int tda1004x_write_byte(struct i2c_adapter *i2c, struct tda1004x_state *tda_state, int reg, int data)
 {
 	int ret;
@@ -403,22 +370,6 @@
 	return 0;
 	}
 
-static int tda1004x_find_extraction_params(struct fwinfo* fwInfo, int fwInfoCount, int size)
-{
-	int fwinfo_idx;
-
-        for (fwinfo_idx = 0; fwinfo_idx < fwInfoCount; fwinfo_idx++) {
-		if (fwInfo[fwinfo_idx].file_size == size)
-			break;
-	}
-        if (fwinfo_idx >= fwInfoCount) {
-		printk("tda1004x: Unsupported firmware uploaded.\n");
-		return -EIO;
-	}
-
-	return fwinfo_idx;
-	}
-
 static int tda1004x_check_upload_ok(struct i2c_adapter *i2c, struct tda1004x_state *state)
 {
 	u8 data1, data2;
@@ -438,14 +389,18 @@
         }
 
 
-static int tda10045_fwupload(struct i2c_adapter *i2c, struct tda1004x_state *state, const struct firmware *fw)
+static int tda10045_fwupload(struct i2c_adapter *i2c, struct tda1004x_state *state, struct i2c_client *client)
 {
-	int index;
 	int ret;
+	const struct firmware *fw;
 
-	index = tda1004x_find_extraction_params(tda10045h_fwinfo, tda10045h_fwinfo_count, fw->size);
-	if (index < 0)
-		return index;
+	/* request the firmware, this will block until someone uploads it */
+	printk("tda1004x: waiting for firmware upload...\n");
+	ret = request_firmware(&fw, TDA10045_DEFAULT_FIRMWARE, &client->dev);
+	if (ret) {
+		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
+	   	return ret;
+	}
 
 	/* set some valid bandwith parameters before uploading */
 
@@ -458,7 +413,7 @@
 	/* set parameters */
 	tda10045h_set_bandwidth(i2c, state, BANDWIDTH_8_MHZ);
 
-	ret = tda1004x_do_upload(i2c, state, fw->data + tda10045h_fwinfo[index].fw_offset, tda10045h_fwinfo[index].fw_size);
+	ret = tda1004x_do_upload(i2c, state, fw->data, fw->size);
 	if (ret)
 		return ret;
 
@@ -473,15 +428,19 @@
 	return 0;
 	}
 
-static int tda10046_fwupload(struct i2c_adapter *i2c, struct tda1004x_state *state, const struct firmware *fw)
+static int tda10046_fwupload(struct i2c_adapter *i2c, struct tda1004x_state *state, struct i2c_client *client)
 {
 	unsigned long timeout;
-	int index;
 	int ret;
+	const struct firmware *fw;
 
-	index = tda1004x_find_extraction_params(tda10046h_fwinfo, tda10046h_fwinfo_count, fw->size);
-	if (index < 0)
-		return index;
+	/* request the firmware, this will block until someone uploads it */
+	printk("tda1004x: waiting for firmware upload...\n");
+	ret = request_firmware(&fw, TDA10046_DEFAULT_FIRMWARE, &client->dev);
+	if (ret) {
+		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
+   	   	return ret;
+	}
 
 	/* set some valid bandwith parameters before uploading */
 
@@ -498,7 +457,7 @@
 	tda1004x_write_byte(i2c, state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
 	tda1004x_write_mask(i2c, state, TDA1004X_CONFC4, 8, 8); // going to boot from HOST
 
-	ret = tda1004x_do_upload(i2c, state, fw->data + tda10046h_fwinfo[index].fw_offset, tda10046h_fwinfo[index].fw_size);
+	ret = tda1004x_do_upload(i2c, state, fw->data, fw->size);
 	if (ret)
 		return ret;
 
@@ -814,7 +771,9 @@
         if ((tmp = tda1004x_set_frequency(i2c, tda_state, fe_params)) < 0)
 		return tmp;
 
-        // hardcoded to use auto as much as possible
+	// Hardcoded to use auto as much as possible
+	// The TDA10045 is very unreliable if AUTO mode is _not_ used. I have not
+	// yet tested the TDA10046 to see if this issue has been fixed
         fe_params->u.ofdm.code_rate_HP = FEC_AUTO;
         fe_params->u.ofdm.guard_interval = GUARD_INTERVAL_AUTO;
         fe_params->u.ofdm.transmission_mode = TRANSMISSION_MODE_AUTO;
@@ -1452,7 +1411,6 @@
 {
 	struct i2c_client *client;
 	struct tda1004x_state *state;
-	const struct firmware *fw;
 	int ret;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -1489,21 +1447,13 @@
 	// upload firmware
 	BUG_ON(!state->dvb);
 
-	/* request the firmware, this will block until someone uploads it */
-	printk("tda1004x: waiting for firmware upload...\n");
-	ret = request_firmware(&fw, TDA1004X_DEFAULT_FIRMWARE, &client->dev);
-	if (ret) {
-		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
-		goto out;
-	}
-
 	switch(state->fe_type) {
         case FE_TYPE_TDA10045H:
 		state->dspCodeCounterReg = TDA10045H_FWPAGE;
 		state->dspCodeInReg =  TDA10045H_CODE_IN;
 		state->dspVersion = 0x2c;
 
-		ret = tda10045_fwupload(adapter, state, fw);
+		ret = tda10045_fwupload(adapter, state, client);
 		if (ret) {
 			printk("tda1004x: firmware upload failed\n");
 			goto out;
@@ -1518,7 +1468,7 @@
 		state->dspCodeInReg =  TDA10046H_CODE_IN;
 		state->dspVersion = 0x20;
 
-		ret = tda10046_fwupload(adapter, state, fw);
+		ret = tda10046_fwupload(adapter, state, client);
 		if (ret) {
 			printk("tda1004x: firmware upload failed\n");
 			goto out;
@@ -1551,7 +1501,7 @@
 
 	dprintk("%s\n", __FUNCTION__);
 
-	dvb_unregister_frontend_new (tda1004x_ioctl, state->dvb);
+	dvb_unregister_frontend (tda1004x_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-09-17 12:26:16.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-09-01 12:19:01.000000000 +0200
@@ -762,6 +763,13 @@
 			fe->parameters.inversion = INVERSION_AUTO;
 			fetunesettings.parameters.inversion = INVERSION_AUTO;
 		}
+		if (fe->info->type == FE_OFDM) {
+			/* without hierachical coding code_rate_LP is irrelevant,
+			 * so we tolerate the otherwise invalid FEC_NONE setting */
+			if (fe->parameters.u.ofdm.hierarchy_information == HIERARCHY_NONE &&
+			    fe->parameters.u.ofdm.code_rate_LP == FEC_NONE)
+				fe->parameters.u.ofdm.code_rate_LP = FEC_AUTO;
+		}
 
 		/* get frontend-specific tuning settings */
 		if (dvb_frontend_internal_ioctl(&fe->frontend, FE_GET_TUNE_SETTINGS,
@@ -1180,7 +1186,7 @@
 	return 0;
 }
 
-int dvb_unregister_frontend_new (int (*ioctl) (struct dvb_frontend *frontend,
+int dvb_unregister_frontend (int (*ioctl) (struct dvb_frontend *frontend,
 					   unsigned int cmd, void *arg),
 			     struct dvb_adapter *dvb_adapter)
 {
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_frontend.h linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.h
--- linux-2.6.8.1-dvb1/drivers/media/dvb/dvb-core/dvb_frontend.h	2004-09-17 12:26:16.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/dvb-core/dvb_frontend.h	2004-09-17 12:35:35.000000000 +0200
@@ -42,6 +45,8 @@
 #define I2C_DRIVERID_DVBFE_ALPS_TDMB7	I2C_DRIVERID_EXP2
 #define I2C_DRIVERID_DVBFE_AT76C651	I2C_DRIVERID_EXP2
 #define I2C_DRIVERID_DVBFE_CX24110	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_CX22702	I2C_DRIVERID_EXP2
+#define I2C_DRIVERID_DVBFE_DIB3000MB	I2C_DRIVERID_EXP2
 #define I2C_DRIVERID_DVBFE_DST		I2C_DRIVERID_EXP2
 #define I2C_DRIVERID_DVBFE_DUMMY	I2C_DRIVERID_EXP2
 #define I2C_DRIVERID_DVBFE_L64781	I2C_DRIVERID_EXP2
@@ -102,7 +107,7 @@
 		       struct module *module);
 
 extern int
-dvb_unregister_frontend_new (int (*ioctl) (struct dvb_frontend *frontend,
+dvb_unregister_frontend (int (*ioctl) (struct dvb_frontend *frontend,
 				       unsigned int cmd, void *arg),
 			 struct dvb_adapter *dvb_adapter);
 
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/ves1820.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1820.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/ves1820.c	2004-09-17 12:26:18.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1820.c	2004-08-24 17:54:22.000000000 +0200
@@ -578,7 +575,7 @@
 static int detach_client(struct i2c_client *client)
 {
 	struct ves1820_state *state = (struct ves1820_state *) i2c_get_clientdata(client);
-	dvb_unregister_frontend_new(ves1820_ioctl, state->dvb);
+	dvb_unregister_frontend(ves1820_ioctl, state->dvb);
 	device_remove_file(&client->dev, &dev_attr_client_name);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/ves1x93.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1x93.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/ves1x93.c	2004-09-17 12:26:18.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/ves1x93.c	2004-09-15 10:26:45.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
 
@@ -48,7 +49,7 @@
 	.type			= FE_QPSK,
 	.frequency_min		= 950000,
 	.frequency_max		= 2150000,
-	.frequency_stepsize	= 250,           /* kHz for QPSK frontends */
+	.frequency_stepsize	= 125,		 /* kHz for QPSK frontends */
 	.frequency_tolerance	= 29500,
 	.symbol_rate_min	= 1000000,
 	.symbol_rate_max	= 45000000,
@@ -170,10 +171,26 @@
  *   set up the downconverter frequency divisor for a
  *   reference clock comparision frequency of 125 kHz.
  */
-static int sp5659_set_tv_freq (struct i2c_adapter *i2c, u32 freq, u8 pwr)
+static int sp5659_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
+	u8 pwr = 0;
+   	u8 buf[4];
         u32 div = (freq + 479500) / 125;
-	u8 buf [4] = { (div >> 8) & 0x7f, div & 0xff, 0x95, (pwr << 5) | 0x30 };
+   
+	if (freq > 2000000) pwr = 3;
+	else if (freq > 1800000) pwr = 2;
+	else if (freq > 1600000) pwr = 1;
+	else if (freq > 1200000) pwr = 0;
+	else if (freq >= 1100000) pwr = 1;
+	else pwr = 2;
+
+   	buf[0] = (div >> 8) & 0x7f;
+   	buf[1] = div & 0xff;
+   	buf[2] = ((div & 0x18000) >> 10) | 0x95;
+   	buf[3] = (pwr << 6) | 0x30;
+   	
+   	// NOTE: since we're using a prescaler of 2, we set the
+	// divisor frequency to 62.5kHz and divide by 125 above
 
 	return tuner_write (i2c, buf, sizeof(buf));
 }
@@ -195,10 +212,10 @@
 }
 
 
-static int tuner_set_tv_freq (struct i2c_adapter *i2c, u32 freq, u8 pwr)
+static int tuner_set_tv_freq (struct i2c_adapter *i2c, u32 freq)
 {
 	if ((demod_type == DEMOD_VES1893) && (board_type == BOARD_SIEMENS_PCI))
-		return sp5659_set_tv_freq (i2c, freq, pwr);
+		return sp5659_set_tv_freq (i2c, freq);
 	else if (demod_type == DEMOD_VES1993)
 		return tsa5059_set_tv_freq (i2c, freq);
 
@@ -252,17 +269,10 @@
 
 static int ves1x93_clr_bit (struct i2c_adapter *i2c)
 {
+	msleep(10);
         ves1x93_writereg (i2c, 0, init_1x93_tab[0] & 0xfe);
         ves1x93_writereg (i2c, 0, init_1x93_tab[0]);
-	msleep(5);
-	return 0;
-}
-
-static int ves1x93_init_aquire (struct i2c_adapter *i2c)
-{
-        ves1x93_writereg (i2c, 3, 0x00);
-	ves1x93_writereg (i2c, 3, init_1x93_tab[3]);
-	msleep(5);
+	msleep(50);
 	return 0;
 }
 
@@ -414,26 +423,6 @@
 	return 0;
 }
 
-
-static int ves1x93_afc (struct i2c_adapter *i2c, u32 freq, u32 srate)
-{
-	int afc;
-
-	afc = ((int)((ves1x93_readreg (i2c, 0x0a) << 1) & 0xff))/2;
-	afc = (afc * (int)(srate/1000/8))/16;
-    
-	if (afc) {
-	
-		freq -= afc;
-
-		tuner_set_tv_freq (i2c, freq, 0);
-
-		ves1x93_init_aquire (i2c);
-	}
-       
-	return 0;
-}
-
 static int ves1x93_set_voltage (struct i2c_adapter *i2c, fe_sec_voltage_t voltage)
 {
 	switch (voltage) {
@@ -464,6 +453,21 @@
 		fe_status_t *status = arg;
 		u8 sync = ves1x93_readreg (i2c, 0x0e);
 
+		/*
+		 * The ves1893 sometimes returns sync values that make no sense,
+		 * because, e.g., the SIGNAL bit is 0, while some of the higher
+		 * bits are 1 (and how can there be a CARRIER w/o a SIGNAL?).
+		 * Tests showed that the the VITERBI and SYNC bits are returned
+		 * reliably, while the SIGNAL and CARRIER bits ar sometimes wrong.
+		 * If such a case occurs, we read the value again, until we get a
+		 * valid value.
+		 */
+		int maxtry = 10; /* just for safety - let's not get stuck here */
+		while ((sync & 0x03) != 0x03 && (sync & 0x0c) && maxtry--) {
+			msleep(10);
+			sync = ves1x93_readreg (i2c, 0x0e);
+		}
+
 		*status = 0;
 
 		if (sync & 1)
@@ -525,11 +529,10 @@
         {
 		struct dvb_frontend_parameters *p = arg;
 
-		tuner_set_tv_freq (i2c, p->frequency, 0);
+		tuner_set_tv_freq (i2c, p->frequency);
 		ves1x93_set_inversion (i2c, p->inversion);
 		ves1x93_set_fec (i2c, p->u.qpsk.fec_inner);
 		ves1x93_set_symbolrate (i2c, p->u.qpsk.symbol_rate);
-		ves1x93_afc (i2c, p->frequency, p->u.qpsk.symbol_rate);	    
 		state->inversion = p->inversion;
                 break;
         }
@@ -650,7 +653,7 @@
 static int detach_client(struct i2c_client *client)
 {
 	struct ves1x93_state *state = (struct ves1x93_state*)i2c_get_clientdata(client);
-	dvb_unregister_frontend_new(ves1x93_ioctl, state->dvb);
+	dvb_unregister_frontend(ves1x93_ioctl, state->dvb);
 	i2c_detach_client(client);
 	BUG_ON(state->dvb);
 	kfree(client);
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.8.1-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-09-17 12:26:39.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-08-24 17:54:22.000000000 +0200
@@ -1689,7 +1686,7 @@
 
 static void ttusb_dec_exit_frontend(struct ttusb_dec *dec)
 {
-	dvb_unregister_frontend_new(dec->frontend_ioctl, dec->adapter);
+	dvb_unregister_frontend(dec->frontend_ioctl, dec->adapter);
 }
 
 static void ttusb_dec_init_filters(struct ttusb_dec *dec)

--------------020108080804070104030406--
