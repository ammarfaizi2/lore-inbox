Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVCVCgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVCVCgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVCVCgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:36:00 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:53899 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262315AbVCVBgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:31 -0500
Message-Id: <20050322013500.794214000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:20 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-gcc-295-fixes.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 47/48] gcc 2.95 compile fixes
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch by Olaf Titz: gcc 2.95 compile fixes

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dibusb/dvb-dibusb-core.c |    2 +-
 dibusb/dvb-fe-dtt200u.c  |    7 ++++++-
 ttpci/av7110_ir.c        |    4 ++--
 ttpci/budget-av.c        |    2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:28:15.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:30:44.000000000 +0100
@@ -425,8 +425,8 @@ static struct dibusb_usb_device * dibusb
 static struct dibusb_usb_device * dibusb_find_device (struct usb_device *udev,int *cold)
 {
 	int i,j;
-	*cold = -1;
 	struct dibusb_usb_device *dev = NULL;
+	*cold = -1;
 
 	for (i = 0; i < sizeof(dibusb_devices)/sizeof(struct dibusb_usb_device); i++) {
 		for (j = 0; j < DIBUSB_ID_MAX_NUM && dibusb_devices[i].cold_ids[j] != NULL; j++) {
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-fe-dtt200u.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-fe-dtt200u.c	2005-03-22 00:28:15.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-fe-dtt200u.c	2005-03-22 00:30:44.000000000 +0100
@@ -175,8 +175,13 @@ static void dtt200u_fe_release(struct dv
 static int dtt200u_pid_control(struct dvb_frontend *fe,int index, int pid,int onoff)
 {
 	struct dtt200u_fe_state *state = (struct dtt200u_fe_state*) fe->demodulator_priv;
+	u8 b_pid[4];
 	pid = onoff ? pid : 0;
-	u8 b_pid[4] = { 0x04, index, pid & 0xff, (pid >> 8) & 0xff };
+
+	b_pid[0] = 0x04;
+	b_pid[1] = index;
+	b_pid[2] = pid & 0xff;
+	b_pid[3] = (pid >> 8) & 0xff;
 
 	dibusb_write_usb(state->dib,b_pid,4);
 	return 0;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ir.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_ir.c	2005-03-22 00:17:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ir.c	2005-03-22 00:30:44.000000000 +0100
@@ -161,11 +161,11 @@ static int av7110_ir_write_proc(struct f
 
 int __init av7110_ir_init(void)
 {
+	static struct proc_dir_entry *e;
+
 	if (ir_initialized)
 		return 0;
 
-	static struct proc_dir_entry *e;
-
 	init_timer(&keyup_timer);
 	keyup_timer.data = 0;
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/budget-av.c	2005-03-22 00:23:49.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-av.c	2005-03-22 00:30:44.000000000 +0100
@@ -188,6 +188,7 @@ static int ciintf_slot_reset(struct dvb_
 {
 	struct budget_av *budget_av = (struct budget_av *) ca->data;
 	struct saa7146_dev *saa = budget_av->budget.dev;
+	int max = 20;
 
 	if (slot != 0)
 		return -EINVAL;
@@ -199,7 +200,6 @@ static int ciintf_slot_reset(struct dvb_
 	msleep(100);
 	saa7146_setgpio(saa, 0, SAA7146_GPIO_OUTLO);
 
-	int max = 20;
 	while (--max > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
 		msleep(100);
 

--

