Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318328AbSGYL5u>; Thu, 25 Jul 2002 07:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318329AbSGYL5t>; Thu, 25 Jul 2002 07:57:49 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:43202 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318328AbSGYL5e>;
	Thu, 25 Jul 2002 07:57:34 -0400
Date: Thu, 25 Jul 2002 14:00:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net, rmk@arm.linux.org.uk
Subject: [cset] Add a input_sync() a method to tell which events belong together.
Message-ID: <20020725140040.A14561@ucw.cz>
References: <20020725083716.A20717@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020725083716.A20717@ucw.cz>; from vojtech@suse.cz on Thu, Jul 25, 2002 at 08:37:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull http://linux-input.bkbits.net:8080/linux-input' should also
work.

===================================================================


ChangeSet@1.444, 2002-07-25 13:56:28+02:00, vojtech@twilight.ucw.cz
  By popular request, and explicit method of telling which events
  from a device belong together was implemented - input_sync() and
  EV_SYN. Touches every input driver. The first to make use of it
  is mousedev.c to properly merge events into PS/2 packets.

===================================================================

 Documentation/input/input-programming.txt      |   12 ++++++++-
 drivers/input/input.c                          |   32 +++++++++++++++++--------
 drivers/input/joystick/a3d.c                   |    4 +++
 drivers/input/joystick/adi.c                   |    2 +
 drivers/input/joystick/amijoy.c                |    2 +
 drivers/input/joystick/analog.c                |    2 +
 drivers/input/joystick/cobra.c                 |    2 +
 drivers/input/joystick/db9.c                   |    2 +
 drivers/input/joystick/gamecon.c               |   11 ++++++++
 drivers/input/joystick/gf2k.c                  |    2 +
 drivers/input/joystick/grip.c                  |    2 +
 drivers/input/joystick/grip_mp.c               |    4 +++
 drivers/input/joystick/guillemot.c             |    2 +
 drivers/input/joystick/iforce/iforce-packets.c |    3 ++
 drivers/input/joystick/interact.c              |    2 +
 drivers/input/joystick/magellan.c              |    2 +
 drivers/input/joystick/sidewinder.c            |   10 +++++++
 drivers/input/joystick/spaceball.c             |    2 +
 drivers/input/joystick/spaceorb.c              |    2 +
 drivers/input/joystick/stinger.c               |    2 +
 drivers/input/joystick/tmdc.c                  |    2 +
 drivers/input/joystick/turbografx.c            |    2 +
 drivers/input/joystick/twidjoy.c               |    2 +
 drivers/input/joystick/warrior.c               |    7 +++--
 drivers/input/keybdev.c                        |    3 --
 drivers/input/keyboard/amikbd.c                |    2 +
 drivers/input/keyboard/atkbd.c                 |    1 
 drivers/input/keyboard/maple_keyb.c            |    2 +
 drivers/input/keyboard/newtonkbd.c             |    2 +
 drivers/input/keyboard/ps2serkbd.c             |    1 
 drivers/input/keyboard/sunkbd.c                |    1 
 drivers/input/keyboard/xtkbd.c                 |    1 
 drivers/input/mouse/amimouse.c                 |    2 +
 drivers/input/mouse/inport.c                   |    2 +
 drivers/input/mouse/logibm.c                   |    2 +
 drivers/input/mouse/maplemouse.c               |    1 
 drivers/input/mouse/pc110pad.c                 |    3 --
 drivers/input/mouse/psmouse.c                  |    1 
 drivers/input/mouse/rpcmouse.c                 |    2 +
 drivers/input/mouse/sermouse.c                 |    4 +++
 drivers/input/mousedev.c                       |   21 ++++++++++------
 drivers/input/touchscreen/gunze.c              |    1 
 drivers/input/touchscreen/h3600_ts_input.c     |    4 +++
 drivers/macintosh/adbhid.c                     |    6 ++++
 drivers/macintosh/mac_hid.c                    |    1 
 drivers/usb/input/aiptek.c                     |    2 +
 drivers/usb/input/hid-core.c                   |    3 ++
 drivers/usb/input/hid-input.c                  |    5 +++
 drivers/usb/input/hid.h                        |    2 +
 drivers/usb/input/powermate.c                  |    1 
 drivers/usb/input/usbkbd.c                     |    4 ++-
 drivers/usb/input/usbmouse.c                   |    4 ++-
 drivers/usb/input/wacom.c                      |    5 +++
 drivers/usb/input/xpad.c                       |    2 +
 include/linux/input.h                          |   20 +++++++++++----
 55 files changed, 193 insertions(+), 33 deletions(-)


diff -Nru a/Documentation/input/input-programming.txt b/Documentation/input/input-programming.txt
--- a/Documentation/input/input-programming.txt	Thu Jul 25 13:56:59 2002
+++ b/Documentation/input/input-programming.txt	Thu Jul 25 13:56:59 2002
@@ -23,6 +23,7 @@
 static void button_interrupt(int irq, void *dummy, struct pt_regs *fp)
 {
 	input_report_key(&button_dev, BTN_1, inb(BUTTON_PORT) & 1);
+	input_sync(&button_dev);
 }
 
 static int __init button_init(void)
@@ -86,12 +87,21 @@
 which upon every interrupt from the button checks its state and reports it
 via the 
 
-	input_report_btn()
+	input_report_key()
 
 call to the input system. There is no need to check whether the interrupt
 routine isn't reporting two same value events (press, press for example) to
 the input system, because the input_report_* functions check that
 themselves.
+
+Then there is the
+
+	input_sync()
+
+call to tell those who receive the events that we've sent a complete report.
+This doesn't seem important in the one button case, but is quite important
+for for example mouse movement, where you don't want the X and Y values
+to be interpreted separately, because that'd result in a different movement.
 
 1.2 dev->open() and dev->close()
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/input.c	Thu Jul 25 13:56:59 2002
@@ -72,16 +72,9 @@
 {
 	struct input_handle *handle = dev->handle;
 
-/*
- * Wake up the device if it is sleeping.
- */
 	if (dev->pm_dev)
 		pm_access(dev->pm_dev);
 
-/*
- * Filter non-events, and bad input values out.
- */
-
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
@@ -89,6 +82,19 @@
 
 	switch (type) {
 
+		case EV_SYN:
+			switch (code) {
+				case SYN_CONFIG:
+					if (dev->event) dev->event(dev, type, code, value);
+					break;
+
+				case SYN_REPORT:
+					if (dev->sync) return;
+					dev->sync = 1;
+					break;
+			}
+			break;
+
 		case EV_KEY:
 
 			if (code > KEY_MAX || !test_bit(code, dev->keybit) || !!test_bit(code, dev->key) == value)
@@ -185,9 +191,8 @@
 			break;
 	}
 
-/*
- * Distribute the event to handler modules.
- */
+	if (type != EV_SYN) 
+		dev->sync = 0;
 
 	while (handle) {
 		if (handle->open)
@@ -200,6 +205,7 @@
 {
 	struct input_dev *dev = (void *) data;
 	input_event(dev, EV_KEY, dev->repeat_key, 2);
+	input_sync(dev);
 	mod_timer(&dev->timer, jiffies + dev->rep[REP_PERIOD]);
 }
 
@@ -437,6 +443,12 @@
 	struct input_handler *handler = input_handler;
 	struct input_handle *handle;
 	struct input_device_id *id;
+
+/*
+ * Add the EV_SYN capability.
+ */
+
+	set_bit(EV_SYN, dev->evbit);
 
 /*
  * Initialize repeat timer to default values.
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/a3d.c	Thu Jul 25 13:56:59 2002
@@ -130,6 +130,8 @@
 			input_report_key(dev, BTN_LEFT,   data[3] & 2);
 			input_report_key(dev, BTN_MIDDLE, data[3] & 4);
 
+			input_sync(dev);
+
 			a3d->axes[0] = ((signed char)((data[11] << 6) | (data[12] << 3) | (data[13]))) + 128;
 			a3d->axes[1] = ((signed char)((data[14] << 6) | (data[15] << 3) | (data[16]))) + 128;
 			a3d->axes[2] = ((signed char)((data[17] << 6) | (data[18] << 3) | (data[19]))) + 128;
@@ -164,6 +166,8 @@
 			input_report_key(dev, BTN_THUMB,   data[8] & 2);
 			input_report_key(dev, BTN_TOP,     data[8] & 4);
 			input_report_key(dev, BTN_PINKIE,  data[7] & 1);
+
+			input_sync(dev);
 
 			return;
 	}
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/adi.c	Thu Jul 25 13:56:59 2002
@@ -249,6 +249,8 @@
 
 	for (i = 63; i < adi->buttons; i++)
 		input_report_key(dev, *key++, adi_get_bits(adi, 1));
+	
+	input_sync(dev);
 
 	return 0;
 }
diff -Nru a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
--- a/drivers/input/joystick/amijoy.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/amijoy.c	Thu Jul 25 13:56:59 2002
@@ -67,6 +67,8 @@
 			input_report_abs(amijoy_dev + i, ABS_X, ((data >> 1) & 1) - ((data >> 9) & 1));
 			data = ~(data ^ (data << 1));
 			input_report_abs(amijoy_dev + i, ABS_Y, ((data >> 1) & 1) - ((data >> 9) & 1));
+
+			input_sync(amijoy_dev + i);
 		}
 }
 
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/analog.c	Thu Jul 25 13:56:59 2002
@@ -215,6 +215,8 @@
 			input_report_abs(dev, analog_hats[j++],
 				((buttons >> ((i << 2) + 8)) & 1) - ((buttons >> ((i << 2) + 6)) & 1));
 		}
+
+	input_sync(dev);
 }
 
 /*
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/cobra.c	Thu Jul 25 13:56:59 2002
@@ -136,6 +136,8 @@
 			for (j = 0; cobra_btn[j]; j++)
 				input_report_key(dev, cobra_btn[j], data[i] & (0x20 << j));
 
+			input_sync(dev);
+
 		}
 
 	mod_timer(&cobra->timer, jiffies + COBRA_REFRESH_TIME);	
diff -Nru a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
--- a/drivers/input/joystick/db9.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/db9.c	Thu Jul 25 13:56:59 2002
@@ -266,6 +266,8 @@
 			break;
 		}
 
+	input_sync(dev);
+
 	mod_timer(&db9->timer, jiffies + DB9_REFRESH_TIME);
 }
 
diff -Nru a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
--- a/drivers/input/joystick/gamecon.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/gamecon.c	Thu Jul 25 13:56:59 2002
@@ -328,6 +328,8 @@
 
 				for (j = 0; j < 10; j++)
 					input_report_key(dev + i, gc_n64_btn[j], s & data[gc_n64_bytes[j]]);
+
+				input_sync(dev + i);
 			}
 		}
 	}
@@ -356,6 +358,8 @@
 			if (s & gc->pads[GC_SNES])
 				for (j = 0; j < 8; j++)
 					input_report_key(dev + i, gc_snes_btn[j], s & data[gc_snes_bytes[j]]);
+
+			input_sync(dev + i);
 		}
 	}
 
@@ -379,6 +383,8 @@
 
 			if (s & gc->pads[GC_MULTI2])
 				input_report_key(dev + i, BTN_THUMB, s & data[5]);
+
+			input_sync(dev + i);
 		}
 	}
 
@@ -398,6 +404,7 @@
 
 				input_report_key(dev + i, BTN_THUMBL, ~data[0] & 0x04);
 				input_report_key(dev + i, BTN_THUMBR, ~data[0] & 0x02);
+				input_sync(dev + i);
 
 			case GC_PSX_NEGCON:
 			case GC_PSX_ANALOG:
@@ -414,6 +421,8 @@
 				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
 				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
 
+				input_sync(dev + i);
+
 				break;
 
 			case GC_PSX_NORMAL:
@@ -426,6 +435,8 @@
 
 				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
 				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
+
+				input_sync(dev + i);
 
 				break;
 		}
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/gf2k.c	Thu Jul 25 13:56:59 2002
@@ -197,6 +197,8 @@
 
 	for (i = 0; i < gf2k_pads[gf2k->id]; i++)
 		input_report_key(dev, gf2k_btn_pad[i], (t >> i) & 1);
+
+	input_sync(dev);
 }
 
 /*
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/grip.c	Thu Jul 25 13:56:59 2002
@@ -276,6 +276,8 @@
 
 
 		}
+
+		input_sync(dev);
 	}
 
 	mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
diff -Nru a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
--- a/drivers/input/joystick/grip_mp.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/grip_mp.c	Thu Jul 25 13:56:59 2002
@@ -515,6 +515,10 @@
 	input_report_abs(dev, ABS_X, grip->xaxes[slot]);
 	input_report_abs(dev, ABS_Y, grip->yaxes[slot]);
 
+	/* Tell the receiver of the events to process them */
+
+	input_sync(dev);
+
 	grip->dirty[slot] = 0;
 }
 
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/guillemot.c	Thu Jul 25 13:56:59 2002
@@ -147,6 +147,8 @@
 			input_report_key(dev, guillemot->type->btn[i], (data[2 + (i >> 3)] >> (i & 7)) & 1);
 	}
 
+	input_sync(dev);
+
 	mod_timer(&guillemot->timer, jiffies + GUILLEMOT_REFRESH_TIME);
 }
 
diff -Nru a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
--- a/drivers/input/joystick/iforce/iforce-packets.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/iforce/iforce-packets.c	Thu Jul 25 13:56:59 2002
@@ -214,10 +214,13 @@
 				}
 			}
 
+			input_sync(dev);
+
 			break;
 
 		case 0x02:	/* status report */
 			input_report_key(dev, BTN_DEAD, data[0] & 0x02);
+			input_sync(dev);
 
 			/* Check if an effect was just started or stopped */
 			i = data[1] & 0x7f;
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/interact.c	Thu Jul 25 13:56:59 2002
@@ -176,6 +176,8 @@
 		}
 	}
 
+	input_sync(dev);
+
 	mod_timer(&interact->timer, jiffies + INTERACT_REFRESH_TIME);
 
 }
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/magellan.c	Thu Jul 25 13:56:59 2002
@@ -107,6 +107,8 @@
 			for (i = 0; i < 9; i++) input_report_key(dev, magellan_buttons[i], (t >> i) & 1);
 			break;
 	}
+
+	input_sync(dev);
 }
 
 static void magellan_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/sidewinder.c	Thu Jul 25 13:56:59 2002
@@ -323,6 +323,8 @@
 			input_report_key(dev, BTN_BASE4, !GB(38,1));
 			input_report_key(dev, BTN_BASE5, !GB(37,1));
 
+			input_sync(dev);
+
 			return 0;
 
 		case SW_ID_GP:
@@ -336,6 +338,8 @@
 
 				for (j = 0; j < 10; j++)
 					input_report_key(dev + i, sw_btn[SW_ID_GP][j], !GB(i*15+j+4,1));
+
+				input_sync(dev + i);
 			}
 
 			return 0;
@@ -356,6 +360,8 @@
 			for (j = 0; j < 9; j++)
 				input_report_key(dev, sw_btn[SW_ID_PP][j], !GB(j,1));
 
+			input_sync(dev);
+
 			return 0;
 
 		case SW_ID_FSP:
@@ -377,6 +383,8 @@
 			input_report_key(dev, BTN_MODE,   GB(38,1));
 			input_report_key(dev, BTN_SELECT, GB(39,1));
 
+			input_sync(dev);
+
 			return 0;
 
 		case SW_ID_FFW:
@@ -389,6 +397,8 @@
 
 			for (j = 0; j < 8; j++)
 				input_report_key(dev, sw_btn[SW_ID_FFW][j], !GB(j+22,1));
+
+			input_sync(dev);
 
 			return 0;
 	}
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/spaceball.c	Thu Jul 25 13:56:59 2002
@@ -137,6 +137,8 @@
 			printk(KERN_ERR "spaceball: Bad command. [%s]\n", spaceball->data + 1);
 			break;
 	}
+
+	input_sync(dev);
 }
 
 /*
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/spaceorb.c	Thu Jul 25 13:56:59 2002
@@ -124,6 +124,8 @@
 			printk("]\n");
 			break;
 	}
+
+	input_sync(dev);
 }
 
 static void spaceorb_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/stinger.c	Thu Jul 25 13:56:59 2002
@@ -85,6 +85,8 @@
 	input_report_abs(dev, ABS_X, (data[1] & 0x3F) - ((data[0] & 0x01) << 6));
 	input_report_abs(dev, ABS_Y, ((data[0] & 0x02) << 5) - (data[2] & 0x3F));
 
+	input_sync(dev);
+
 	return;
 }
 
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/tmdc.c	Thu Jul 25 13:56:59 2002
@@ -214,6 +214,8 @@
 						((data[j][tmdc_byte_d[k]] >> (i + tmdc->btno[j][k])) & 1));
 				l += tmdc->btnc[j][k];
 			}
+
+			input_sync(dev);
 	}
 
 	tmdc->bads += bad;
diff -Nru a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
--- a/drivers/input/joystick/turbografx.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/turbografx.c	Thu Jul 25 13:56:59 2002
@@ -101,6 +101,8 @@
 			input_report_key(dev, BTN_THUMB2,  (data2 & TGFX_THUMB2 ));
 			input_report_key(dev, BTN_TOP,     (data2 & TGFX_TOP    ));
 			input_report_key(dev, BTN_TOP2,    (data2 & TGFX_TOP2   ));
+
+			input_sync(dev);
 		}
 
 	mod_timer(&tgfx->timer, jiffies + TGFX_REFRESH_TIME);
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/twidjoy.c	Thu Jul 25 13:56:59 2002
@@ -127,6 +127,8 @@
 
 		input_report_abs(dev, ABS_X, -abs_x);
 		input_report_abs(dev, ABS_Y, +abs_y);
+
+		input_sync(dev);
 	}
 
 	return;
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/joystick/warrior.c	Thu Jul 25 13:56:59 2002
@@ -76,18 +76,19 @@
 			input_report_key(dev, BTN_THUMB,   (data[3] >> 1) & 1);
 			input_report_key(dev, BTN_TOP,     (data[3] >> 2) & 1);
 			input_report_key(dev, BTN_TOP2,    (data[3] >> 3) & 1);
-			return;
+			break;
 		case 3:					/* XY-axis info->data */
 			input_report_abs(dev, ABS_X, ((data[0] & 8) << 5) - (data[2] | ((data[0] & 4) << 5)));
 			input_report_abs(dev, ABS_Y, (data[1] | ((data[0] & 1) << 7)) - ((data[0] & 2) << 7));
-			return;
+			break;
 		case 5:					/* Throttle, spinner, hat info->data */
 			input_report_abs(dev, ABS_THROTTLE, (data[1] | ((data[0] & 1) << 7)) - ((data[0] & 2) << 7));
 			input_report_abs(dev, ABS_HAT0X, (data[3] & 2 ? 1 : 0) - (data[3] & 1 ? 1 : 0));
 			input_report_abs(dev, ABS_HAT0Y, (data[3] & 8 ? 1 : 0) - (data[3] & 4 ? 1 : 0));
 			input_report_rel(dev, REL_DIAL,  (data[2] | ((data[0] & 4) << 5)) - ((data[0] & 8) << 5));
-			return;
+			break;
 	}
+	input_sync(dev);
 }
 
 /*
diff -Nru a/drivers/input/keybdev.c b/drivers/input/keybdev.c
--- a/drivers/input/keybdev.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keybdev.c	Thu Jul 25 13:56:59 2002
@@ -132,11 +132,10 @@
 	struct input_handle *handle;	
 
 	for (handle = keybdev_handler.handle; handle; handle = handle->hnext) {
-
 		input_event(handle->dev, EV_LED, LED_SCROLLL, !!(led & 0x01));
 		input_event(handle->dev, EV_LED, LED_NUML,    !!(led & 0x02));
 		input_event(handle->dev, EV_LED, LED_CAPSL,   !!(led & 0x04));
-
+		input_sync(handle->dev);
 	}
 }
 
diff -Nru a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
--- a/drivers/input/keyboard/amikbd.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keyboard/amikbd.c	Thu Jul 25 13:56:59 2002
@@ -88,10 +88,12 @@
 		if (scancode == KEY_CAPS) {	/* CapsLock is a toggle switch key on Amiga */
 			input_report_key(&amikbd_dev, scancode, 1);
 			input_report_key(&amikbd_dev, scancode, 0);
+			input_sync(&amikbd_dev);
 			return;
 		}
 		
 		input_report_key(&amikbd_dev, scancode, down);
+		input_sync(&amikbd_dev);
 
 		return;
 	}
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 25 13:56:59 2002
@@ -195,6 +195,7 @@
 			break;
 		default:
 			input_report_key(&atkbd->dev, atkbd->keycode[code], !atkbd->release);
+			input_sync(&atkbd->dev);
 	}
 		
 	atkbd->release = 0;
diff -Nru a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
--- a/drivers/input/keyboard/maple_keyb.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keyboard/maple_keyb.c	Thu Jul 25 13:56:59 2002
@@ -76,6 +76,8 @@
 		}
 	}
 
+	input_sync(dev);
+
 	memcpy(kbd->old, kbd->new, 8);
 }
 
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keyboard/newtonkbd.c	Thu Jul 25 13:56:59 2002
@@ -72,6 +72,8 @@
 
 	else if (data == 0xe7) /* end of init sequence */
 		printk(KERN_INFO "input: %s on %s\n", nkbd_name, serio->phys);
+
+	input_sync(&nkbd->dev);
 }
 
 void nkbd_connect(struct serio *serio, struct serio_dev *dev)
diff -Nru a/drivers/input/keyboard/ps2serkbd.c b/drivers/input/keyboard/ps2serkbd.c
--- a/drivers/input/keyboard/ps2serkbd.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keyboard/ps2serkbd.c	Thu Jul 25 13:56:59 2002
@@ -161,6 +161,7 @@
         break;
     default:
         input_report_key(&ps2serkbd->dev, ps2serkbd->keycode[code], !ps2serkbd->release);
+	input_sync(&ps2serkbd->dev);
     }
 
     ps2serkbd->release = 0;
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keyboard/sunkbd.c	Thu Jul 25 13:56:59 2002
@@ -121,6 +121,7 @@
 		default:
 			if (sunkbd->keycode[data & SUNKBD_KEY]) {
                                 input_report_key(&sunkbd->dev, sunkbd->keycode[data & SUNKBD_KEY], !(data & SUNKBD_RELEASE));
+				input_sync(&sunkbd->dev);
                         } else {
                                 printk(KERN_WARNING "sunkbd.c: Unknown key (scancode %#x) %s.\n",
                                         data & SUNKBD_KEY, data & SUNKBD_RELEASE ? "released" : "pressed");
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/keyboard/xtkbd.c	Thu Jul 25 13:56:59 2002
@@ -75,6 +75,7 @@
 
 			if (xtkbd->keycode[data & XTKBD_KEY]) {
 				input_report_key(&xtkbd->dev, xtkbd->keycode[data & XTKBD_KEY], !(data & XTKBD_RELEASE));
+				input_sync(&xtkbd->dev);
 			} else {
 				printk(KERN_WARNING "xtkbd.c: Unknown key (scancode %#x) %s.\n",
 					data & XTKBD_KEY, data & XTKBD_RELEASE ? "released" : "pressed");
diff -Nru a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
--- a/drivers/input/mouse/amimouse.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/amimouse.c	Thu Jul 25 13:56:59 2002
@@ -68,6 +68,8 @@
 	input_report_key(&amimouse_dev, BTN_LEFT,   ciaa.pra & 0x40);
 	input_report_key(&amimouse_dev, BTN_MIDDLE, potgor & 0x0100);
 	input_report_key(&amimouse_dev, BTN_RIGHT,  potgor & 0x0400);
+
+	input_sync(&amimouse_dev);
 }
 
 static int amimouse_open(struct input_dev *dev)
diff -Nru a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
--- a/drivers/input/mouse/inport.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/inport.c	Thu Jul 25 13:56:59 2002
@@ -139,6 +139,8 @@
 
 	outb(INPORT_REG_MODE, INPORT_CONTROL_PORT);
 	outb(INPORT_MODE_IRQ | INPORT_MODE_BASE, INPORT_DATA_PORT);
+
+	input_sync(&inport_dev);
 }
 
 #ifndef MODULE
diff -Nru a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
--- a/drivers/input/mouse/logibm.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/logibm.c	Thu Jul 25 13:56:59 2002
@@ -128,6 +128,8 @@
 	input_report_key(&logibm_dev, BTN_RIGHT,  buttons & 1);
 	input_report_key(&logibm_dev, BTN_MIDDLE, buttons & 2);
 	input_report_key(&logibm_dev, BTN_LEFT,   buttons & 4);
+	input_sync(&logibm_dev);
+
 	outb(LOGIBM_ENABLE_IRQ, LOGIBM_CONTROL_PORT);
 }
 
diff -Nru a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
--- a/drivers/input/mouse/maplemouse.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/maplemouse.c	Thu Jul 25 13:56:59 2002
@@ -40,6 +40,7 @@
 	input_report_rel(dev, REL_X,      relx);
 	input_report_rel(dev, REL_Y,      rely);
 	input_report_rel(dev, REL_WHEEL,  relz);
+	input_sync(dev);
 }
 
 
diff -Nru a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
--- a/drivers/input/mouse/pc110pad.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/pc110pad.c	Thu Jul 25 13:56:59 2002
@@ -78,6 +78,7 @@
 		pc110pad_data[1] | ((pc110pad_data[0] << 3) & 0x80) | ((pc110pad_data[0] << 1) & 0x100));
 	input_report_abs(&pc110pad_dev, ABS_Y,
 		pc110pad_data[2] | ((pc110pad_data[0] << 4) & 0x80));
+	input_sync(&pc110pad_dev);
 
 	pc110pad_count = 0;
 }
@@ -90,8 +91,6 @@
 
 static int pc110pad_open(struct input_dev *dev)
 {
-	unsigned long flags;
-	
 	if (pc110pad_used++)
 		return 0;
 
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/psmouse.c	Thu Jul 25 13:56:59 2002
@@ -167,6 +167,7 @@
 	input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
 	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
 
+	input_sync(dev);
 }
 
 /*
diff -Nru a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
--- a/drivers/input/mouse/rpcmouse.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/rpcmouse.c	Thu Jul 25 13:56:59 2002
@@ -63,6 +63,8 @@
 	input_report_key(&rpcmouse_dev, BTN_LEFT,   b & 0x10);
 	input_report_key(&rpcmouse_dev, BTN_MIDDLE, b & 0x20);
 	input_report_key(&rpcmouse_dev, BTN_RIGHT,  b & 0x40);
+
+	input_sync(&rpcmouse_dev);
 }
 
 static int __init rpcmouse_init(void)
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mouse/sermouse.c	Thu Jul 25 13:56:59 2002
@@ -89,6 +89,8 @@
 			break;
 	}
 
+	input_sync(dev);
+
 	if (++sermouse->count == (5 - ((sermouse->type == SERIO_SUN) << 1)))
 		sermouse->count = 0;
 }
@@ -187,6 +189,8 @@
 
 			break;
 	}
+
+	input_sync(dev);
 
 	sermouse->count++;
 }
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/mousedev.c	Thu Jul 25 13:56:59 2002
@@ -94,9 +94,10 @@
 	struct mousedev *mousedevs[3] = { handle->private, &mousedev_mix, NULL };
 	struct mousedev **mousedev = mousedevs;
 	struct mousedev_list *list;
-	int index, size;
+	int index, size, wake;
 
 	while (*mousedev) {
+		wake = 0;
 		list = (*mousedev)->list;
 		while (list) {
 			switch (type) {
@@ -158,16 +159,20 @@
 						case 2: return;
 					}
 					break;
-			}
-					
-			list->ready = 1;
-
-			kill_fasync(&list->fasync, SIGIO, POLL_IN);
 
+				case EV_SYN:
+					switch (code) {
+						case SYN_REPORT:
+							list->ready = 1;
+							kill_fasync(&list->fasync, SIGIO, POLL_IN);
+							wake = 1;
+							break;
+					}
+			}
 			list = list->next;
 		}
-
-		wake_up_interruptible(&((*mousedev)->wait));
+		if (wake)
+			wake_up_interruptible(&((*mousedev)->wait));
 		mousedev++;
 	}
 }
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/touchscreen/gunze.c	Thu Jul 25 13:56:59 2002
@@ -74,6 +74,7 @@
 	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10) * 4);
 	input_report_abs(dev, ABS_Y, 3072 - simple_strtoul(gunze->data + 6, NULL, 10) * 3);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
+	input_sync(dev);
 }
 
 static void gunze_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/input/touchscreen/h3600_ts_input.c	Thu Jul 25 13:56:59 2002
@@ -109,6 +109,7 @@
 	struct input_dev *dev = (struct input_dev *) dev_id;
 
 	input_report_key(dev, KEY_ENTER, down);
+	input_sync(dev);
 }
 
 static void npower_button_handler(int irq, void *dev_id, struct pt_regs *regs)
@@ -122,6 +123,7 @@
 	 */ 	
 	input_report_key(dev, KEY_SUSPEND, 1);
 	input_report_key(dev, KEY_SUSPEND, down); 	
+	input_sync(dev);
 }
 
 #ifdef CONFIG_PM
@@ -267,6 +269,8 @@
 			/* Send a non input event elsewhere */
 			break;
         }
+
+	input_sync(dev);
 }
 
 /*
diff -Nru a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
--- a/drivers/macintosh/adbhid.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/macintosh/adbhid.c	Thu Jul 25 13:56:59 2002
@@ -163,6 +163,8 @@
 	else
 		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
 		       up_flag ? "released" : "pressed");
+
+	input_sync(&adbhid[id]->input);
 }
 
 static void
@@ -259,6 +261,8 @@
 			 ((data[2]&0x7f) < 64 ? (data[2]&0x7f) : (data[2]&0x7f)-128 ));
 	input_report_rel(&adbhid[id]->input, REL_Y,
 			 ((data[1]&0x7f) < 64 ? (data[1]&0x7f) : (data[1]&0x7f)-128 ));
+
+	input_sync(&adbhid[id]->input);
 }
 
 static void
@@ -363,6 +367,8 @@
 	  }
 	  break;
 	}
+
+	input_sync(&adbhid[id]->input);
 }
 
 static struct adb_request led_request;
diff -Nru a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
--- a/drivers/macintosh/mac_hid.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/macintosh/mac_hid.c	Thu Jul 25 13:56:59 2002
@@ -162,6 +162,7 @@
 			 	input_report_key(&emumousebtn,
 						 keycode == mouse_button2_keycode ? BTN_MIDDLE : BTN_RIGHT,
 						 down);
+				input_sync(&emumousebtn);
 				return 1;
 			}
 			mouse_last_keycode = down ? keycode : 0;
diff -Nru a/drivers/usb/input/aiptek.c b/drivers/usb/input/aiptek.c
--- a/drivers/usb/input/aiptek.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/aiptek.c	Thu Jul 25 13:56:59 2002
@@ -161,6 +161,8 @@
 		input_report_key(dev, BTN_STYLUS2, data[5] & 0x10);
 	}
 
+	input_sync(dev);
+
 }
 
 struct aiptek_features aiptek_features[] = {
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/hid-core.c	Thu Jul 25 13:56:59 2002
@@ -903,6 +903,9 @@
 	for (n = 0; n < report->maxfield; n++)
 		hid_input_field(hid, report->field[n], data);
 
+	if (hid->claimed & HID_CLAIMED_INPUT)
+		hidinput_report_event(hid, report);
+
 	return 0;
 }
 
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/hid-input.c	Thu Jul 25 13:56:59 2002
@@ -428,6 +428,11 @@
 		input_event(input, usage->type, usage->code, 0);
 }
 
+void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
+{
+	input_sync(&hid->input);
+}
+
 static int hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct hid_device *hid = dev->private;
diff -Nru a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/hid.h	Thu Jul 25 13:56:59 2002
@@ -416,11 +416,13 @@
 /* We ignore a few input applications that are not widely used */
 #define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || ( a == 0x00010080) || ( a == 0x000c0001))
 extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32);
+extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
 extern int hidinput_connect(struct hid_device *);
 extern void hidinput_disconnect(struct hid_device *);
 #else
 #define IS_INPUT_APPLICATION(a) (0)
 static inline void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value) { }
+static inline void hidinput_report_event(struct hid_device *hid, struct hid_report *report) { }
 static inline int hidinput_connect(struct hid_device *hid) { return -ENODEV; }
 static inline void hidinput_disconnect(struct hid_device *hid) { }
 #endif
diff -Nru a/drivers/usb/input/powermate.c b/drivers/usb/input/powermate.c
--- a/drivers/usb/input/powermate.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/powermate.c	Thu Jul 25 13:56:59 2002
@@ -83,6 +83,7 @@
 	/* handle updates to device state */
 	input_report_key(&pm->input, BTN_0, pm->data[0] & 0x01);
 	input_report_rel(&pm->input, REL_DIAL, pm->data[1]);
+	input_sync(&pm->input);
 }
 
 /* Decide if we need to issue a control message and do so. Must be called with pm->lock down */
diff -Nru a/drivers/usb/input/usbkbd.c b/drivers/usb/input/usbkbd.c
--- a/drivers/usb/input/usbkbd.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/usbkbd.c	Thu Jul 25 13:56:59 2002
@@ -104,6 +104,8 @@
 		}
 	}
 
+	input_sync(&kbd->dev);
+
 	memcpy(kbd->old, kbd->new, 8);
 }
 
@@ -236,7 +238,7 @@
 
 	kbd->dev.name = kbd->name;
 	kbd->dev.phys = kbd->phys;	
-	kbd->dev.id.bus = BUS_USB;
+	kbd->dev.id.bustype = BUS_USB;
 	kbd->dev.id.vendor = dev->descriptor.idVendor;
 	kbd->dev.id.product = dev->descriptor.idProduct;
 	kbd->dev.id.version = dev->descriptor.bcdDevice;
diff -Nru a/drivers/usb/input/usbmouse.c b/drivers/usb/input/usbmouse.c
--- a/drivers/usb/input/usbmouse.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/usbmouse.c	Thu Jul 25 13:56:59 2002
@@ -72,6 +72,8 @@
 	input_report_rel(dev, REL_X,     data[1]);
 	input_report_rel(dev, REL_Y,     data[2]);
 	input_report_rel(dev, REL_WHEEL, data[3]);
+
+	input_sync(dev);
 }
 
 static int usb_mouse_open(struct input_dev *dev)
@@ -145,7 +147,7 @@
 
 	mouse->dev.name = mouse->name;
 	mouse->dev.phys = mouse->phys;
-	mouse->dev.id.bus = BUS_USB;
+	mouse->dev.id.bustype = BUS_USB;
 	mouse->dev.id.vendor = dev->descriptor.idVendor;
 	mouse->dev.id.product = dev->descriptor.idProduct;
 	mouse->dev.id.version = dev->descriptor.bcdDevice;
diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/wacom.c	Thu Jul 25 13:56:59 2002
@@ -136,6 +136,7 @@
 	}
 	
 	input_event(dev, EV_MSC, MSC_SERIAL, 0);
+	input_sync(dev);
 }
 
 static void wacom_graphire_irq(struct urb *urb)
@@ -189,6 +190,8 @@
 	input_report_key(dev, BTN_STYLUS2, data[1] & 0x04);
 
 	input_event(dev, EV_MSC, MSC_SERIAL, data[1] & 0x01);
+
+	input_sync(dev);
 }
 
 static void wacom_intuos_irq(struct urb *urb)
@@ -291,6 +294,8 @@
 	}
 	
 	input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+
+	input_sync(dev);
 }
 
 #define WACOM_INTUOS_TOOLS	(BIT(BTN_TOOL_BRUSH) | BIT(BTN_TOOL_PENCIL) | BIT(BTN_TOOL_AIRBRUSH) | BIT(BTN_TOOL_LENS))
diff -Nru a/drivers/usb/input/xpad.c b/drivers/usb/input/xpad.c
--- a/drivers/usb/input/xpad.c	Thu Jul 25 13:56:59 2002
+++ b/drivers/usb/input/xpad.c	Thu Jul 25 13:56:59 2002
@@ -158,6 +158,8 @@
 	/* "analog" buttons black, white */
 	input_report_key(dev, BTN_C, data[8]);
 	input_report_key(dev, BTN_Z, data[9]);
+
+	input_sync(dev);
 }
 
 static void xpad_irq_in(struct urb *urb)
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Thu Jul 25 13:56:59 2002
+++ b/include/linux/input.h	Thu Jul 25 13:56:59 2002
@@ -57,10 +57,10 @@
  */
 
 struct input_devinfo {
-	uint16_t bustype;
-	uint16_t vendor;
-	uint16_t product;
-	uint16_t version;
+	__u16 bustype;
+	__u16 vendor;
+	__u16 product;
+	__u16 version;
 };
 
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
@@ -89,7 +89,7 @@
  * Event types
  */
 
-#define EV_RST			0x00
+#define EV_SYN			0x00
 #define EV_KEY			0x01
 #define EV_REL			0x02
 #define EV_ABS			0x03
@@ -103,6 +103,13 @@
 #define EV_MAX			0x1f
 
 /*
+ * Synchronization events.
+ */
+
+#define SYN_REPORT		0
+#define SYN_CONFIG		1
+
+/*
  * Keys and buttons
  */
 
@@ -769,6 +776,8 @@
 	struct pm_dev *pm_dev;
 	int state;
 
+	int sync;
+
 	int abs[ABS_MAX + 1];
 	int rep[REP_MAX + 1];
 
@@ -883,6 +892,7 @@
 
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
+#define input_sync(a)		input_event(a, EV_SYN, SYN_REPORT, 0)
 #define input_report_key(a,b,c) input_event(a, EV_KEY, b, !!(c))
 #define input_report_rel(a,b,c) input_event(a, EV_REL, b, c)
 #define input_report_abs(a,b,c) input_event(a, EV_ABS, b, c)

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch14552
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
,>7WW!8V2#C<=GP``
`
end

-- 
Vojtech Pavlik
SuSE Labs
