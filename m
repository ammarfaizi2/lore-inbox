Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUF3F0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUF3F0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 01:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUF3F0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 01:26:05 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:28023 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266188AbUF3F0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 01:26:01 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 oops in psmouse/serio while booting
Date: Wed, 30 Jun 2004 00:25:53 -0500
User-Agent: KMail/1.6.2
Cc: twl@mail.com
References: <20040630042228.7FC414BDAE@ws1-1.us4.outblaze.com>
In-Reply-To: <20040630042228.7FC414BDAE@ws1-1.us4.outblaze.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406300025.57639.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 June 2004 11:22 pm, twl@mail.com wrote:
> The panic happens in psmouse_interrupt.  It doesn't happen every time I boot, 
> but it happens about half of the time.  It doesn't happen with 2.6.6. 
>  
> I have a USB mouse, but the input driver initially seems to think it has found 
> a serial PS/2 mouse. 
>  
> When it boots ok, I see this: 
>  
> mice: PS/2 mouse device common for all mice 
> serio: i8042 AUX port at 0x60,0x64 irq 12 
> input: PS/2 Generic Mouse on isa0060/serio1 
> <snip> 
> input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.0-1 
>  
> When it panics, I see this: 
>  
> mice: PS/2 mouse device common for all mice 
> serio: i8042 AUX port at 0x60,0x64 irq 12 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000 
>  printing eip:

Hi,

Could you please try the patch below? 

-- 
Dmitry

===== drivers/input/mouse/psmouse-base.c 1.65 vs edited =====
--- 1.65/drivers/input/mouse/psmouse-base.c	2004-06-28 23:00:50 -05:00
+++ edited/drivers/input/mouse/psmouse-base.c	2004-06-30 00:13:58 -05:00
@@ -717,13 +717,14 @@
 		goto out;
 	}
 
+	/* Install default protocol handler (may be overriden later) */
+	psmouse->protocol_handler = psmouse_process_byte;
+
 	psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
 	if (!psmouse->vendor)
 		psmouse->vendor = "Generic";
 	if (!psmouse->name)
 		psmouse->name = "Mouse";
-	if (!psmouse->protocol_handler)
-		psmouse->protocol_handler = psmouse_process_byte;
 
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
