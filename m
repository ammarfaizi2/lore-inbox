Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVBLRDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVBLRDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 12:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVBLRDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 12:03:17 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:56206 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261159AbVBLRCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 12:02:02 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050211201013.GA6937@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
Content-Type: multipart/mixed; boundary="=-+2dCtP+LfDfQhW6BW/Ph"
Date: Sat, 12 Feb 2005 18:01:19 +0100
Message-Id: <1108227679.12327.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+2dCtP+LfDfQhW6BW/Ph
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Freitag, den 11.02.2005, 21:10 +0100 schrieb Vojtech Pavlik: 
> Hi!
> 
> I've reimplemented the Lifebook touchscreen driver using libps2 and
> input, to make it short and fitting into the kernel drivers.
> 
> Please comment on code and test for functionality!
> 
> PS.: The driver should register two input devices. It doesn't yet,
> since that isn't very straightforward in the psmouse framework.

First of all it's good to see lifebook-support integrated. 

I have tested your driver on my box but the initialization fails. Do you
have hardware available for testing? As far as I can see the
init-sequence is the one from Haralds xfree 3.3.6-driver. There is a
reason why this sequence is not like that anymore in my driver. This
sequence does not always work and there is not something like a "magic
knock sequence". The lifebook-touchscreen hardware is a little bit slow
and it happens quite often that it does not understand a command that
you send. This is the reason why you often have to send a command
several times until the hardware understands... 
Probably this was what was seen by Harald on the USB-bus and he just
used this sequence.

Second thing is that I am not shure that it is a good idea to integrate
the lbtouch-support into the psmouse-driver since there is no real way
of deciding if the device you are talking to is REALLY a
lifebook-touchsreen or not. 

You have put the init-sequence for the hw into the
lifebook_detect-function which is not correct since this not really a
"detect" but a HW-init. 

IMHO the driver should be standalone and the user should decide which
driver he wants to use. As default the touchscreen-functionality will be
disabled and only the quick-point device will work like a normal
PS2-mouse.

I also don't think that it is useful to have two devices for the
touchscreen. I assume you want to have one device for relative movements
and one for the absolute ones!? But for the implementor in userspace (X,
SDL,...) it will be easier if ALL events from this HW-device come via
one device-node. 

I attached the current version of my driver here so people can also have
a look at it. I didn't release this version on my homepage yet and the
only difference between the released version an this one is that the
y-axis is swapped. I did this since all input devices seem to have a
common idea of where y=0 is and my driver was the only one where y was
just the other way round.

One more thing I observed by inspecting your code is that your
untouch-event will never happen. 

I think my driver works and is clean enough for integration into the
kernel. We can talk about integrating calls to libps2 instead of doing
the stuff myself (I am a big fan of preventing code-duplication) but
don't you think it would be more wise to use a driver which works (since
the very early 2.6-days) and build upon that instead of trying to
implement your own one from the scratch and using snippets from very old
and obsolete code?

And as far as I can see you don't even have access to the hardware!?!?


Greetings 


Kenan

--=-+2dCtP+LfDfQhW6BW/Ph
Content-Disposition: attachment; filename=lbtouch-0.8.diff
Content-Type: text/x-patch; name=lbtouch-0.8.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -uprN -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/Kconfig linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/Kconfig
--- linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/Kconfig	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/Kconfig	2005-02-12 16:52:27.000000000 +0100
@@ -35,3 +35,10 @@ config TOUCHSCREEN_GUNZE
 	  To compile this driver as a module, choose M here: the
 	  module will be called gunze.
 
+
+config TOUCHSCREEN_LBTOUCH
+	tristate "Lifebook touchscreen"
+	depends on INPUT && INPUT_TOUCHSCREEN && SERIO
+	help
+	  Say Y here if you have got a Fujitsu-Siemens Lifebook
+	  B-Series and want to be able to use its touchscreen.
diff -uprN -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/lbtouch.c linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/lbtouch.c
--- linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/lbtouch.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/lbtouch.c	2005-02-12 16:52:26.000000000 +0100
@@ -0,0 +1,603 @@
+/*
+ * $Id: lbtouch.c,v 1.3 2004/05/17 17:50:00 conan Exp $
+ *
+ *  Copyright (c) 2000-2004 Kenan Esau
+ */
+
+/*
+ * Lifebook touchscreen driver for Linux
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <kenan.esau@conan.de>, or by paper mail:
+ * Kenan Esau, Friedrich-Greinerstr. 8, 73666 Baltmannsweiler-2, 
+ * Germany
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+
+#include "lbtouch.h"
+
+#define LBTOUCH_DESC "Lifebook Touchscreen Driver"
+
+MODULE_AUTHOR("Kenan Esau <kenan.esau@conan.de>");
+MODULE_DESCRIPTION("LBTOUCH_DESC");
+MODULE_LICENSE("GPL");
+
+static char* lbtouch_version="V0.8";
+
+static int min_x = 86;
+static int max_x = 955;
+static int min_y = 37;
+static int max_y = 4000;
+static int rate  = _40HZ;
+static int resolution = _400CPI;
+
+static int valid_rates[] = {
+        _10HZ,
+        _20HZ,
+        _40HZ,
+        _60HZ,
+        _80HZ,
+        _100HZ,
+        _200HZ,
+        0xff,
+};
+
+static int valid_resolutions[] = {
+        _50CPI,
+        _100CPI,
+        _200CPI,
+        _400CPI,
+        0xff,
+};
+
+MODULE_PARM(min_x, "i");
+MODULE_PARM(min_y, "i");
+MODULE_PARM(max_x, "i");
+MODULE_PARM(max_y, "i");
+MODULE_PARM(rate, "i");
+MODULE_PARM(resolution, "i");
+
+MODULE_PARM_DESC(min_x, "Minimum X value");
+MODULE_PARM_DESC(min_y, "Minimum Y value");
+MODULE_PARM_DESC(max_x, "Maximum X value");
+MODULE_PARM_DESC(max_y, "Maximum Y value");
+MODULE_PARM_DESC(rate, "Sampling Rate of the Touchscreen\n"
+                 "\t\t\t10HZ=0x0A; 20HZ=0x14; 40HZ=0x28; 60HZ=0x3C;\n"
+                 "\t\t\t80HZ=0x50; 100HZ=0x64; 200HZ=0xC8\n"
+                 "\t\t\tDefault is 0x28");
+MODULE_PARM_DESC(resolution, "Resolution of the Touchscreen\n"
+                 "\t\t\t50CPI=0x00; 100CPI=0x01; 200CPI=0x02\n"
+                 "\t\t\t400CPI=0x03; Default is 0x03");
+
+
+/*#define LBTOUCH_DBG*/
+#ifdef LBTOUCH_DBG
+#define DBG(msg, args...) printk("lbtouch: "msg, ##args)
+#else
+#define DBG(msg, args...)
+#endif
+
+/*
+ * Definitions & global arrays.
+ */
+
+static char *lbtouch_name = "Lifebook TouchScreen";
+
+/*
+ * Per-touchscreen data.
+ */
+#define BUF_SIZE (1 * LBTOUCH_PACKET_SIZE)
+
+
+struct lbtouch {
+	struct input_dev dev;
+	struct serio *serio;
+
+        spinlock_t    data_lock;
+	int           idx_wr;
+        int           idx_rd;
+	unsigned char data[BUF_SIZE];
+        unsigned char *pkt;
+
+	char phys[32];
+
+        uint8_t touched;
+        uint8_t lb_down;
+        uint8_t rb_down;
+        
+        /* determine whether we are currently in command mode (send
+        command to the devices/ only during init) or if we are running
+        in normal mode */
+        atomic_t cmd_mode;
+        wait_queue_head_t sleepq;
+};
+
+
+static int lbtouch_snd_byte(struct lbtouch *lb, unsigned char c);
+static unsigned char lbtouch_read(struct lbtouch *lb);
+static int lbtouch_snd_cmd(struct lbtouch *lb, unsigned char cmd[]);
+static void lbtouch_process_packet(struct lbtouch *lb, struct pt_regs *regs);
+static irqreturn_t lbtouch_interrupt(struct serio *serio,
+                                     unsigned char data, 
+                                     unsigned int flags, 
+                                     struct pt_regs *regs);
+static void lbtouch_init_hw(struct lbtouch *lb);
+
+
+
+
+static int lbtouch_snd_byte(struct lbtouch *lb, unsigned char c)
+{
+        int res;
+
+        res = serio_write(lb->serio, c);
+        interruptible_sleep_on_timeout(&lb->sleepq, HZ/10);
+
+        return res;
+}
+
+
+
+
+static unsigned char lbtouch_read(struct lbtouch *lb)
+{
+        unsigned char ch;
+
+        spin_lock(&lb->data_lock);
+        ch = lb->data[lb->idx_rd];
+        lb->idx_rd = (lb->idx_rd + 1) % BUF_SIZE;
+        spin_unlock(&lb->data_lock);
+        
+        return ch;
+}
+
+
+
+
+static int lbtouch_snd_cmd(struct lbtouch *lb, unsigned char cmd[])
+{
+        unsigned char c;
+        int retry = 0;
+        int ret = -1;
+
+        atomic_set(&lb->cmd_mode, 1);
+
+        do {
+                lbtouch_snd_byte(lb, cmd[0]);        
+                c = lbtouch_read(lb);
+                switch (c) {
+                case ACK:
+                        break;
+
+                case ERROR:
+                default:
+                        DBG("ERROR: %02x \n", c);
+                case RESEND:
+                        DBG("    RESENDING\n");
+                        retry++;
+                        break;
+                }
+        } while ( (c != ACK) && (retry < 3) );
+
+        if (c != ACK)
+                goto out;
+        retry = 0;
+        
+
+        DBG("DEVICE GOT CMD: %02x \n", cmd[0]);
+        switch (cmd[0]) {
+        case RESET_DISPLAY:
+                interruptible_sleep_on_timeout(&lb->sleepq, HZ);
+                c = lbtouch_read(lb);
+                if (c != RESET_COMPLETE) 
+                        goto out; 
+                c = lbtouch_read(lb);
+                if (c != DEVICE_ID) 
+                        goto out; 
+                c = ACK;
+                DBG("RESET_DISPLAY\n");
+                break;
+
+        case DISABLE_DISPLAY:
+                DBG("DISABLE_DISPLAY\n");
+                break;
+        case ENABLE_DISPLAY:
+                DBG("ENABLE_DISPLAY\n");
+                break;
+
+        case SET_RESOLUTION:
+                do {
+                        lbtouch_snd_byte(lb, cmd[1]);
+                        retry++;
+                        c = lbtouch_read(lb);
+                        DBG("SET_RESOLUTION c = %02x\n", c);
+                } while ( (c != ACK) &&
+                          (retry < 3) );
+                DBG("SET_RESOLUTION\n");
+                break;
+
+        case SET_SAMPLE_RATE:
+                do {
+                        lbtouch_snd_byte(lb, cmd[1]);
+                        retry++;
+                        c = lbtouch_read(lb); 
+                } while ( (c != ACK) && 
+                          (retry < 3) );
+                DBG("SET_SAMPLE_RATE\n");
+                break;
+        }
+
+        if (c == ACK) {
+                DBG("CMD OK\n");
+                ret = 0;
+        }
+ out:
+        lb->idx_wr = 0;
+        lb->idx_rd = 0;
+        atomic_set(&lb->cmd_mode, 0);
+        return ret;
+}
+
+
+
+
+static void lbtouch_process_packet(struct lbtouch *lb, struct pt_regs *regs)
+{
+	struct input_dev *dev = &lb->dev;
+        unsigned long x = 0;
+        unsigned long y = 0;
+        short btn = 0;
+	uint8_t pkt_touch = lb->pkt[0] & LBTOUCH_TOUCHED;
+	uint8_t pkt_lb = lb->pkt[0] & LBTOUCH_LB;
+	uint8_t pkt_rb = lb->pkt[0] & LBTOUCH_RB;
+
+	/* calculate X and Y */
+	if (pkt_touch) {
+		x = ((unsigned short)lb->pkt[1] | 
+		    ((unsigned short)(lb->pkt[0] & LBTOUCH_X_HIGH) << 4 ));
+		y = max_y - ((unsigned short)lb->pkt[2] | 
+                    ((unsigned short)(lb->pkt[0] & LBTOUCH_Y_HIGH) << 2 ));
+	} else {
+		x = ((lb->pkt[0] & 0x10) ? lb->pkt[1]-256 : lb->pkt[1]);
+		y = - ((lb->pkt[0] & 0x20) ? lb->pkt[2]-256 : lb->pkt[2]);
+	}
+
+        input_regs(dev, regs);
+
+	/* left button down */
+	if ( pkt_lb && (lb->lb_down == 0) ) {
+                DBG("left button down\n");
+                input_report_key(dev, BTN_LEFT, 1);
+                lb->lb_down = 1;
+                btn++;
+        }
+
+	/* right button down */
+	if ( pkt_rb && (lb->rb_down == 0) ) {
+                DBG("right button down\n");
+                input_report_key(dev, BTN_RIGHT, 1);
+                lb->rb_down = 1;
+                btn++;
+        }
+
+	/* left button up */
+	if ( !pkt_lb && (lb->lb_down == 1) ) {
+                DBG("left button up\n");
+                input_report_key(dev, BTN_LEFT, 0);
+                lb->lb_down = 0;
+                btn++;
+        }
+
+	/* right button up */
+	if ( !pkt_rb && (lb->rb_down == 1) ) {
+                DBG("right button up\n");
+                input_report_key(dev, BTN_RIGHT, 0);
+                lb->rb_down = 0;
+                btn++;
+        }
+
+        if (btn)
+                goto out;
+
+	/* first touch */
+	if ( pkt_touch && !lb->touched ) {
+                DBG("first touch\n");
+                input_report_key(dev, BTN_TOUCH, 1);
+        }
+
+	/* untouch */
+	if ( !pkt_touch && lb->touched ) {
+                DBG("untouch\n");
+                input_report_key(dev, BTN_TOUCH, 0);
+        }
+
+	/* currently touched */
+	if (pkt_touch) {
+                DBG("penmove: X = %ld   Y = %ld\n", x, y);
+                input_report_abs(dev, ABS_X, x);
+                input_report_abs(dev, ABS_Y, y);
+        }
+
+	/* quickpoint move */
+	if ( !pkt_touch && !lb->touched  &&  (x || y ) ) {
+                DBG("quickpointmove: X = %ld   Y = %ld\n", x, y);
+                input_report_rel(dev, REL_X, x);
+                input_report_rel(dev, REL_Y, y);
+        }
+ out:
+	input_sync(dev);
+
+        /* save the state for the currently received packet */
+	lb->touched = pkt_touch;
+}
+
+
+
+
+static irqreturn_t lbtouch_interrupt(struct serio *serio,
+                                     unsigned char data, 
+                                     unsigned int flags, 
+                                     struct pt_regs *regs)
+{
+	struct lbtouch* lbtouch = serio->private;
+        static int packet_complete     = 0;
+
+        spin_lock(&lbtouch->data_lock);
+        lbtouch->data[lbtouch->idx_wr] = data;
+        lbtouch->idx_wr = (lbtouch->idx_wr + 1) % BUF_SIZE;
+        if ( (lbtouch->idx_wr % LBTOUCH_PACKET_SIZE) == 0 ) {
+                packet_complete = 1;
+                lbtouch->pkt = &lbtouch->data[lbtouch->idx_rd];
+                DBG("Packet complete \n");
+        }
+
+        spin_unlock(&lbtouch->data_lock);
+
+        if (atomic_read(&lbtouch->cmd_mode) == 1)
+                return IRQ_HANDLED;
+
+	if (packet_complete) {
+		lbtouch_process_packet(lbtouch, regs);
+                packet_complete = 0;
+                lbtouch->idx_rd = 0;
+	} 
+
+	return IRQ_HANDLED;
+}
+
+
+
+
+static void lbtouch_init_hw(struct lbtouch *lb)
+{
+        unsigned char c[3];
+	struct input_dev *dev = &lb->dev;
+        int exit_cnt = 10;
+        int rc = 0;
+        int i = 0;
+
+        int validated_rate = -1;
+        int validated_resolution = -1;
+
+        for(i=0; valid_rates[i]!=0xff; i++) {
+                if (rate==valid_rates[i]) {
+                        validated_rate = rate;
+                        break;
+                }
+        }
+        if (validated_rate==-1) {
+                printk(KERN_WARNING"Invalid rate parameter using 40Hz\n");
+                validated_rate = _40HZ;
+        }
+
+        for(i=0; valid_resolutions[i]!=0xff; i++) {
+                if (resolution==valid_resolutions[i]) {
+                        validated_resolution = resolution;
+                        break;
+                }
+        }
+        if (validated_resolution==-1) {
+                printk(KERN_WARNING"Invalid resolution parameter using 400CPI\n");
+                validated_rate = _400CPI;
+        }
+
+        while (exit_cnt > 0) {
+                exit_cnt--;
+                DBG("exit_cnt = %d\n", exit_cnt);
+
+                c[0]=DISABLE_DISPLAY;
+                rc = lbtouch_snd_cmd(lb, c);
+                if (rc != 0)
+                        continue;
+
+                c[0]=RESET_DISPLAY;
+                rc = lbtouch_snd_cmd(lb, c);
+                if (rc != 0)
+                        continue;
+
+                c[0]=RESET_SCALING;
+                rc = lbtouch_snd_cmd(lb, c);
+                if (rc != 0)
+                        continue;
+
+                c[0]=SET_SAMPLE_RATE;
+                c[1]=validated_rate;
+                rc = lbtouch_snd_cmd(lb, c);
+                if (rc != 0)
+                        continue;
+
+                c[0]=SET_RESOLUTION;        /*set display to normal mode*/
+                c[1]=NORMAL_MODE;           /*uses set_res.-command too */
+                rc = lbtouch_snd_cmd(lb, c); /* this always fails !?!? */
+
+                c[0]=SET_RESOLUTION;
+                c[1]=validated_resolution;
+                rc = lbtouch_snd_cmd(lb, c);
+                if (rc != 0)
+                        continue;
+          
+                c[0]=ENABLE_DISPLAY;
+                rc = lbtouch_snd_cmd(lb, c);
+                if (rc != 0)
+                        continue;
+                else 
+                        break;
+        }
+
+        if(rc != 0)
+                printk(KERN_ERR "lbtouch: HW init failed\n");
+        input_report_abs(dev, ABS_X, (max_x - max_y) / 2);
+        input_report_abs(dev, ABS_Y, (max_y - max_y) / 2);
+	input_sync(dev);
+}
+
+
+
+
+/*
+ * lbtouch_disconnect() is the opposite of lbtouch_connect()
+ */
+static void lbtouch_disconnect(struct serio *serio)
+{
+	struct lbtouch* lbtouch = serio->private;
+	input_unregister_device(&lbtouch->dev);
+	serio_close(serio);
+	kfree(lbtouch);
+}
+
+
+
+
+/*
+ * lbtouch_connect() is the routine that is called when someone adds a
+ * new serio device. It looks whether it was registered as a Lbtouch
+ * touchscreen and if yes, registers it as an input device.
+ */
+static void lbtouch_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct lbtouch *lbtouch;
+
+	if ((serio->type & SERIO_TYPE) != (SERIO_8042)) {
+                printk(KERN_ERR "lbtouch: not a lbtouchscreen \n");
+		return;
+        }
+
+	if (!(lbtouch = kmalloc(sizeof(struct lbtouch), GFP_KERNEL)))
+		return;
+
+	memset(lbtouch, 0, sizeof(struct lbtouch));
+
+	init_input_dev(&lbtouch->dev);
+	lbtouch->dev.evbit[0]  = BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_REL);
+        lbtouch->dev.absbit[0] = BIT(ABS_X)  | BIT(ABS_Y);
+        lbtouch->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	lbtouch->dev.absfuzz[ABS_X] = 0; 
+        lbtouch->dev.absfuzz[ABS_Y] = 0;
+ 	lbtouch->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT);
+	lbtouch->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+
+	lbtouch->dev.absmin[ABS_X] = min_x;
+	lbtouch->dev.absmax[ABS_X] = max_x;
+
+        lbtouch->dev.absmin[ABS_Y] = min_y;
+        lbtouch->dev.absmax[ABS_Y] = max_y;
+
+	lbtouch->serio = serio;
+	serio->private = lbtouch;
+
+	sprintf(lbtouch->phys, "%s/input0", serio->phys);
+        printk("lbtouch: %s\n", lbtouch->phys); 
+
+	lbtouch->dev.private = lbtouch;
+	lbtouch->dev.name = lbtouch_name;
+	lbtouch->dev.phys = lbtouch->phys;
+	lbtouch->dev.id.bustype = BUS_I8042;
+	lbtouch->dev.id.vendor = 1; /* SERIO_LBTOUCH; */
+	lbtouch->dev.id.product = 0x0001;
+	lbtouch->dev.id.version = 0x0001;
+
+        spin_lock_init(&lbtouch->data_lock);
+        init_waitqueue_head(&lbtouch->sleepq);
+        lbtouch->pkt = &lbtouch->data[0];
+
+	if (serio_open(serio, drv)) {
+		kfree(lbtouch);
+		return;
+	}
+
+	input_register_device(&lbtouch->dev);
+
+        lbtouch_init_hw(lbtouch);
+	printk(KERN_INFO "lbtouch: %s %s on %s\n", lbtouch_name, 
+               lbtouch_version, serio->phys);
+}
+
+
+
+
+static int lbtouch_reconnect(struct serio *serio)
+{
+	struct lbtouch* lbtouch = serio->private;
+
+        lbtouch_init_hw(lbtouch);
+        return 0;
+}
+
+/*
+ * The serio device structure.
+ */
+
+static struct serio_driver lbtouch_drv = {
+	.driver = {
+		.name = "lbtouch",
+	},
+	.description =  LBTOUCH_DESC,
+	.interrupt =	lbtouch_interrupt,
+	.connect   =    lbtouch_connect,
+	.disconnect =	lbtouch_disconnect,
+        .reconnect =    lbtouch_reconnect,
+};
+
+/*
+ * The functions for inserting/removing us as a module.
+ */
+
+int __init lbtouch_init(void)
+{
+        printk(KERN_INFO "lbtouch: Registering driver \n");
+        serio_register_driver(&lbtouch_drv);
+        return 0;
+}
+
+void __exit lbtouch_exit(void)
+{
+        printk(KERN_INFO "lbtouch: Unegistering driver \n");
+	serio_unregister_driver(&lbtouch_drv);
+}
+
+module_init(lbtouch_init);
+module_exit(lbtouch_exit);
diff -uprN -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/lbtouch.h linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/lbtouch.h
--- linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/lbtouch.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/lbtouch.h	2005-02-12 16:52:26.000000000 +0100
@@ -0,0 +1,77 @@
+#define LBTOUCH_PACKET_SIZE     3
+#define LBTOUCH_BUFFER_SIZE     (LBTOUCH_PACKET_SIZE * 500)
+#define LBTOUCH_TOUCHED 0x04
+#define LBTOUCH_X_HIGH  0x30
+#define LBTOUCH_Y_HIGH  0xC0
+#define LBTOUCH_LB      0x01
+#define LBTOUCH_RB      0x02
+#define LBTOUCH_ACK	0xF4
+#define LBTOUCH_TIMEOUT	500
+
+
+/*
+  COMMANDS
+*/
+#define RESET_SCALING   0xE6
+#define SET_SCALING     0xE7
+#define SET_RESOLUTION  0xE8
+#define GET_STATUS      0xE9
+#define SET_STREAM_MODE 0xEA
+#define READ_DATA       0xEB
+#define RESET_WRAP_MODE 0xEC
+#define SET_WRAP_MODE   0xEE
+#define SET_REMOTE_MODE 0xF0
+#define IDENTIFY_UNIT   0xF2
+#define SET_SAMPLE_RATE 0xF3
+#define ENABLE_DISPLAY  0xF4
+#define DISABLE_DISPLAY 0xF5
+#define SET_DEFAULTS    0xF6  
+/*
+  The Device can send RESEND as a reply to a command 
+  it did not understand but RESEND can also be send 
+  TO the display to repeat an erroneous received packet 
+*/
+#define RESET_DISPLAY   0xFF  /* Wait until 0xAA 0x00 arrives to indicate that the reset is complete */
+
+
+/*
+  TRANSMISSION RATES
+*/
+#define _10HZ  0x0A
+#define _20HZ  0x14
+#define _40HZ  0x28
+#define _60HZ  0x3C
+#define _80HZ  0x50
+#define _100HZ 0x64
+#define _200HZ 0xC8
+
+
+/*
+  RESOLUTIONS
+*/
+#define _50CPI  0x00
+#define _100CPI 0x01
+#define _200CPI 0x02
+#define _400CPI 0x03
+
+
+/*
+  REPLIES
+*/
+#define RESEND          0xFE
+#define ACK             0xFA
+#define ERROR           0xFC
+#define RESET_COMPLETE  0xAA
+#define DEVICE_ID       0x00
+
+/*
+  MODES
+*/
+#define STOPPED_MODE   0x06
+#define NORMAL_MODE    0x07
+#define ENHANCED_MODE  0x08
+
+/*
+  States
+*/
+#define STATE_TOUCHED 0x1L
diff -uprN -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/Makefile linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/Makefile
--- linux-2.6.11-rc3-vanilla/drivers/input/touchscreen/Makefile	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.11-rc3-lbtouch/drivers/input/touchscreen/Makefile	2005-02-12 16:52:26.000000000 +0100
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
+obj-$(CONFIG_TOUCHSCREEN_LBTOUCH) += lbtouch.o
diff -uprN -X dontdiff linux-2.6.11-rc3-vanilla/usr/initramfs_list linux-2.6.11-rc3-lbtouch/usr/initramfs_list
--- linux-2.6.11-rc3-vanilla/usr/initramfs_list	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc3-lbtouch/usr/initramfs_list	2005-02-12 16:57:03.000000000 +0100
@@ -0,0 +1,5 @@
+# This is a very simple, default initramfs
+
+dir /dev 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+dir /root 0700 0 0

--=-+2dCtP+LfDfQhW6BW/Ph--

