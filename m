Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSJVXkm>; Tue, 22 Oct 2002 19:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJVXkl>; Tue, 22 Oct 2002 19:40:41 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:51193 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263105AbSJVXkZ>; Tue, 22 Oct 2002 19:40:25 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200210221046.46700.Take.Vos@binary-magic.com> 
References: <200210221046.46700.Take.Vos@binary-magic.com> 
To: Take Vos <Take.Vos@binary-magic.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PROBLEM: PS/2 mouse wart does not work, while scratch pad does. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 Oct 2002 00:46:31 +0100
Message-ID: <5001.1035330391@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Take.Vos@binary-magic.com said:
> hardware:DELL Inspiron 8100

>  The internal scratch pad works, but the internal wart mouse doesn't,
> in the  BIOS it is set to use both devices for input. This is tested
> with both  Xfree86 and running cat on /dev/input/mice and /dev/input/
> mouse0 and  /dev/input/event0. 

Probing for various other PS/2 extensions appears to confuse the thing such 
that the clitmouse no longer works. If we probe for it first and then abort 
the other probes, it seems happier...

--- 1.16/drivers/input/mouse/psmouse.c  Tue Oct  8 11:51:30 2002
+++ edited/drivers/input/mouse/psmouse.c        Wed Oct 23 00:39:06 2002
@@ -311,6 +311,26 @@
        if (psmouse_noext)
                return PSMOUSE_PS2;

+/*
+ * Try Synaptics TouchPad magic ID
+ */
+
+       param[0] = 0;
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+
+       if (param[1] == 0x47) {
+               /* We could do more here. But it's sufficient just
+                  to stop the subsequent probes from screwing the
+                  thing up. */
+               psmouse->vendor = "Synaptics";
+               psmouse->name = "TouchPad";
+               return PSMOUSE_PS2;
+       }
+
 /*
  * Try Genius NetMouse magic init.
  */


--
dwmw2


