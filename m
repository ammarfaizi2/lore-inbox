Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVIFHco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVIFHco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVIFHcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:32:43 -0400
Received: from tumsa.unibanka.lv ([193.178.151.91]:31096 "EHLO fax.unibanka.lv")
	by vger.kernel.org with ESMTP id S932435AbVIFHcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:32:43 -0400
From: Aivils Stoss <aivils@unibanka.lv>
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: INPUT: keyboard_tasklet - don't touch LED's of already grabed device
Date: Tue, 6 Sep 2005 10:34:55 +0300
User-Agent: KMail/1.7.2
Cc: bruby <linuxconsole-dev@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509061034.55963.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vojtech!

Recent kernels allow exclusive usage of input device when
input device is grabed. keyboard_tasklet does not check
device state and switch LED's of all keyboards. However
grabed device may be use another LED steering code.

This patch forbid keyboard_tasklet switch LED's of
grabed devices.

Aivils Stoss

--- linux-2.6.13/drivers/char/keyboard.c        2005-08-29 02:41:01.000000000 +0300
+++ linux-2.6.13/drivers/char/keyboard.c~       2005-09-06 10:09:35.000000000 +0300
@@ -895,16 +895,18 @@ static inline unsigned char getleds(void

 static void kbd_bh(unsigned long dummy)
 {
        struct list_head * node;
        unsigned char leds = getleds();

        if (leds != ledstate) {
                list_for_each(node,&kbd_handler.h_list) {
+                       if (handle->dev->grab)
+                               continue;
                        struct input_handle * handle = to_handle_h(node);
                        input_event(handle->dev, EV_LED, LED_SCROLLL, !!(leds & 0x01));
                        input_event(handle->dev, EV_LED, LED_NUML,    !!(leds & 0x02));
                        input_event(handle->dev, EV_LED, LED_CAPSL,   !!(leds & 0x04));
                        input_sync(handle->dev);
                }
        }

