Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVA1HGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVA1HGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 02:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVA1HGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 02:06:23 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:39006 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261493AbVA1HGQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 02:06:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Victor Hahn <victorhahn@web.de>
Subject: Re: Really annoying bug in the mouse driver
Date: Fri, 28 Jan 2005 02:06:06 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <41E91795.9060609@web.de>
In-Reply-To: <41E91795.9060609@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501280206.06747.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2005 08:16, Victor Hahn wrote:
> Jan 15 13:33:36 vic kernel: psmouse.c: bad data from KBC - bad parity
> Jan 15 13:33:38 vic kernel: psmouse.c: Wheel Mouse at 
> isa0060/serio1/input0 lost
>  synchronization, throwing 3 bytes away.
> 
> Sometimes, only one of these messages appears; the number of bytes in 
> the second message varies, but mostly it is 3.
> 

Hi,

Could you please try the patch below?

Thanks!

-- 
Dmitry

===== psmouse-base.c 1.88 vs edited =====
--- 1.88/drivers/input/mouse/psmouse-base.c	2005-01-27 02:13:43 -05:00
+++ edited/psmouse-base.c	2005-01-28 00:05:08 -05:00
@@ -154,9 +154,19 @@
 				flags & SERIO_TIMEOUT ? " timeout" : "",
 				flags & SERIO_PARITY ? " bad parity" : "");
 		ps2_cmd_aborted(&psmouse->ps2dev);
+		if (psmouse->resend || serio_write(serio, PSMOUSE_CMD_RESEND)) {
+			psmouse->resend = 0;
+			psmouse->state = PSMOUSE_IGNORE;
+			serio_reconnect(serio);
+		} else {
+			psmouse->pktcnt = 0;
+			psmouse->resend = 1;
+		}
 		goto out;
 	}
 
+	psmouse->resend = 0;
+
 	if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_ACK))
 		if  (ps2_handle_ack(&psmouse->ps2dev, data))
 			goto out;
@@ -173,6 +183,10 @@
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
+		if (serio_write(serio, PSMOUSE_CMD_RESEND) == 0) {
+			psmouse->resend = 1;
+			psmouse->last = jiffies;
+		}
 	}
 
 	psmouse->last = jiffies;
===== psmouse.h 1.25 vs edited =====
--- 1.25/drivers/input/mouse/psmouse.h	2004-10-16 06:15:31 -05:00
+++ edited/psmouse.h	2005-01-28 00:04:47 -05:00
@@ -13,6 +13,7 @@
 #define PSMOUSE_CMD_ENABLE	0x00f4
 #define PSMOUSE_CMD_DISABLE	0x00f5
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
+#define PSMOUSE_CMD_RESEND	0x00fe
 #define PSMOUSE_CMD_RESET_BAT	0x02ff
 
 #define PSMOUSE_RET_BAT		0xaa
@@ -45,6 +46,7 @@
 	unsigned char pktsize;
 	unsigned char type;
 	unsigned char model;
+	unsigned char resend;
 	unsigned long last;
 	unsigned long out_of_sync;
 	enum psmouse_state state;
