Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSJ1Rru>; Mon, 28 Oct 2002 12:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJ1Rre>; Mon, 28 Oct 2002 12:47:34 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:1164 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261430AbSJ1Rdu>;
	Mon, 28 Oct 2002 12:33:50 -0500
Date: Mon, 28 Oct 2002 18:40:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Problem with mousedev.c
Message-ID: <20021028184008.B32183@ucw.cz>
References: <20021027010538.GA1690@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021027010538.GA1690@babylon.d2dc.net>; from warp@mercury.d2dc.net on Sat, Oct 26, 2002 at 09:05:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 09:05:38PM -0400, Zephaniah E. Hull wrote:
> To make a long story short, mousedev.c does not properly implement the
> EXPS/2 protocol, specificly dealing with the wheel.
> 
> The lower 8 bits of the 4th byte are supposed to be 0x1 or 0xf to
> indicate movement of the first wheel, and 0x2 or 0xe for the second
> wheel.

No, see microsoft documentation. They're expected to be a 4-bit signed
binary complement value that indicates the amount of movement.

> Attached is a patch to correct this.
> 
> This does not get my two wheel mouse working perfectly yet, sadly that
> will take a bit of a hack, and I'm not sure where the best place to put
> it is yet, but this gets it back to generating correct data.

PS/2 A4-Tech mouse do the ugly trick you describe above to stuff two
wheel information into a single-wheel oriented ImExPS/2 protocol. USB
A4-Tech mouse do another ugly trick (additional button which specifies
which wheel is rotating). I'm not interested in supporting these ugly
tricks.

If you want to support the H-Wheel in GPM, then please add
/dev/input/event support into GPM. (simple patch attached, you may need
to do more changes, namely for h-wheel).

--- mice.c	Mon Jan 24 17:01:13 2000
+++ mice.c.new	Mon Jan 24 17:01:30 2000
@@ -1405,6 +1405,46 @@
   return type;
 }
 
+static int M_evdev(Gpm_Event *state,  unsigned char *data)
+{
+  struct input_event *event = (struct input_event *)data;
+  switch (event->type) {
+    case EV_KEY:
+      switch (event->code) {
+        case BTN_LEFT:
+          state->buttons = (state->buttons & ~GPM_B_LEFT) | (GPM_B_LEFT*event->value);
+          break;
+        case BTN_RIGHT:
+          state->buttons = (state->buttons & ~GPM_B_RIGHT) | (GPM_B_RIGHT*event->value);
+          break;
+        case BTN_MIDDLE:
+          state->buttons = (state->buttons & ~GPM_B_MIDDLE) | (GPM_B_MIDDLE*event->value);
+          break;
+        default:
+          break;
+      }
+      break;
+    case EV_REL:
+      switch (event->code) {
+        case REL_X:
+          state->dx = event->value;
+          break;
+	case REL_Y:
+          state->dy = event->value;
+          break;
+        case REL_WHEEL:
+          state->wdx = event->value;
+          break;
+	default:
+	  break;
+      }
+      break;
+    default:
+        break;
+  }
+  return 0;
+}
+
 
 
 
@@ -1550,6 +1590,9 @@
            "                     connector with 6 pins), 3 buttons.",
            "", M_kmiabps2, I_kmiabps2, STD_FLG,
                                 {0x00, 0x00, 0x00, 0x00}, 3, 1, 0, 0, 0},
+
+  {"evdev",   "Linux input event device", "", M_evdev, NULL, STD_FLG,
+              {0x00, 0x00, 0x00, 0x00}, sizeof(struct input_event),
+              sizeof(struct input_event), 0, 0, 0},
 
   {"",     "",
            "", NULL, NULL, 0,
--- mice.c	Mon Jan 24 17:02:09 2000
+++ mice.c.new	Mon Jan 24 17:04:00 2000
@@ -69,6 +69,7 @@
 #include <linux/joystick.h>
 #endif
 
+#include <linux/input.h>
 
 #include "gpmInt.h"
 #include "twiddler.h"

-- 
Vojtech Pavlik
SuSE Labs
