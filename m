Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUITU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUITU1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUITU1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:27:32 -0400
Received: from CYRUS.andrew.cmu.edu ([128.2.10.174]:49597 "EHLO
	mail-fe4.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S267326AbUITUXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:23:32 -0400
Message-ID: <414F3C21.60209@andrew.cmu.edu>
Date: Mon, 20 Sep 2004 16:22:57 -0400
From: Peter Nelson <pnelson+kernel@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: [PATCH TRIVIAL] joysticks/gamecon: Fix GPF and GC_DDR bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus recently accepted my patch that has been in Vojtech's tree for a 
while but I have just been able to get my development machine working 
again and found two bugs.  The first causes a General Protection Fault 
because of a missing ',' when initializing the gc_names array (took 
forever to track down).  The second causes no data to be processed when 
the type is set to GC_DDR.  Some of the PSX functions check the status 
bits against only GC_PSX instead of both (since DDR is a subset of PSX).

-Peter Nelson

---

===== drivers/input/joystick/gamecon.c 1.18 vs edited =====
--- 1.18/drivers/input/joystick/gamecon.c       2004-06-24 11:55:22 -04:00
+++ edited/drivers/input/joystick/gamecon.c     2004-09-20 13:58:40 -04:00
@@ -89,7 +89,7 @@ static struct gc *gc_base[3];
 static int gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08 };
 
 static char *gc_names[] = { NULL, "SNES pad", "NES pad", "NES FourPort", "Multisystem joystick",
-                               "Multisystem 2-button joystick", "N64 controller", "PSX controller"
+                               "Multisystem 2-button joystick", "N64 controller", "PSX controller",
                                "PSX DDR controller" };
 /*
  * N64 support.
@@ -271,7 +271,8 @@ static void gc_psx_command(struct gc *gc
                udelay(gc_psx_delay);
                read = parport_read_status(gc->pd->port) ^ 0x80;
                for (j = 0; j < 5; j++)
-                       data[j] |= (read & gc_status_bit[j] & gc->pads[GC_PSX]) ? (1 << i) : 0;
+                       data[j] |= (read & gc_status_bit[j] & (gc->pads[GC_PSX] | gc->pads[GC_DDR]))
+                               ? (1 << i) : 0;
                parport_write_data(gc->pd->port, cmd | GC_PSX_CLOCK | GC_PSX_POWER);
                udelay(gc_psx_delay);
        }
@@ -300,7 +301,8 @@ static void gc_psx_read_packet(struct gc
        gc_psx_command(gc, 0, data2);                                                   /* Dump status */
 
        for (i =0; i < 5; i++)                                                          /* Find the longest pad */
-               if((gc_status_bit[i] & gc->pads[GC_PSX]) && (GC_PSX_LEN(id[i]) > max_len))
+               if((gc_status_bit[i] & (gc->pads[GC_PSX] | gc->pads[GC_DDR]))
+                  && (GC_PSX_LEN(id[i]) > max_len))
                        max_len = GC_PSX_LEN(id[i]);
 
        for (i = 0; i < max_len * 2; i++) {                                             /* Read in all the data */


