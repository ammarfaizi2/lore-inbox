Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263007AbSJGM0A>; Mon, 7 Oct 2002 08:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263008AbSJGM0A>; Mon, 7 Oct 2002 08:26:00 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:8576 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263007AbSJGMZ6>;
	Mon, 7 Oct 2002 08:25:58 -0400
Date: Mon, 7 Oct 2002 14:31:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021007143133.A477@ucw.cz>
References: <20021003143132.A38769@ucw.cz> <Pine.LNX.4.44.0210031442500.14559-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210031442500.14559-100000@boris.prodako.se>; from tori@ringstrom.mine.nu on Thu, Oct 03, 2002 at 02:43:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:43:04PM +0200, Tobias Ringstrom wrote:
> On Thu, 3 Oct 2002, Vojtech Pavlik wrote:
> 
> > Good. You can use that for now, and I'll make a fix so that it works
> > even without it.
> 
> Great, thanks!

Ok, here is the promised fix. I'll send it to Linus soon.

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Mon Oct  7 14:30:14 2002
+++ b/drivers/input/serio/i8042.c	Mon Oct  7 14:30:14 2002
@@ -63,7 +63,7 @@
 
 extern struct pt_regs *kbd_pt_regs;
 
-static unsigned long i8042_unxlate_seen[128 / BITS_PER_LONG];
+static unsigned long i8042_unxlate_seen[256 / BITS_PER_LONG];
 static unsigned char i8042_unxlate_table[128] = {
 	  0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
 	 21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
@@ -407,14 +407,14 @@
 		}
 
 		if (data > 0x7f) {
-			if (test_and_clear_bit(data & 0x7f, i8042_unxlate_seen)) {
+			if (test_and_clear_bit((data & 0x7f) | (i8042_last_e0 << 7), i8042_unxlate_seen)) {
 				serio_interrupt(&i8042_kbd_port, 0xf0, dfl);
 				if (i8042_last_e0 && (data == 0xaa || data == 0xb6))
-					set_bit(data & 0x7f, i8042_unxlate_seen);
+					set_bit((data & 0x7f) | (i8042_last_e0 << 7), i8042_unxlate_seen);
 				data = i8042_unxlate_table[data & 0x7f];
 			}
 		} else {
-			set_bit(data, i8042_unxlate_seen);
+			set_bit(data | (i8042_last_e0 << 7), i8042_unxlate_seen);
 			data = i8042_unxlate_table[data];
 		}
 

===================================================================

-- 
Vojtech Pavlik
SuSE Labs
