Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271514AbRIVPhJ>; Sat, 22 Sep 2001 11:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRIVPhB>; Sat, 22 Sep 2001 11:37:01 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:38158 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S271514AbRIVPgv>; Sat, 22 Sep 2001 11:36:51 -0400
Date: Sat, 22 Sep 2001 11:37:12 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Stateful Magic SysRq
Message-ID: <20010922113712.F9352@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is NOT A PATCH YET! This is a question. The patch is coming.

I'm reworking a patch (ultimately) from Amazon which makes the Magic
SysRq system stateful. It is a good, solid approach they have taken, and
it makes SysRq really usable over all KVMs and crappy keyboards.

Here is the core part of the patch.

+#ifdef CONFIG_MAGIC_SYSRQ               /* Handle the SysRq Hack */
+	/*
+	  Pressing magic + command key acts as a chorded command
+	  Pressing and releasing magic without a command key acts sticky, using the next non-magic key as a command key
+	  Pressing magic twice without a command key passes the magic key through
+
+	  The sysrq_pressed states:
+	  0 = not pressed
+	  1 = pressed now but no command has been issued
+	  2 = pressed now and command has been issued
+	  3 = pressed and released, waiting for command key
+
+	    action   MgcDown   MgcUp   keyDown    keyUp
+	  State  +---------------------------------------
+	    0    |     1         0     normal     normal
+            1    |     1         3    2+action      1
+            2    |     2         0    2+action      2
+            3    |   3+pass    0+pass 3+action      0
+
+	    pass = pass key through to remainder of code
+	    action = perform magic action
+	    normal = standard action
+	 */
+
+        if (sysrq_ctls.enabled && keycode == sysrq_ctls.keycode) {
+	  switch(sysrq_pressed) {
+	  case 0:
+	    sysrq_pressed = up_flag ? 0 : 1;
+	    goto out;
+	  case 1:
+	    sysrq_pressed = up_flag ? 3 : 1;
+	    goto out;
+	  case 2:
+	    sysrq_pressed = up_flag ? 0 : 2;
+	    goto out;
+	  case 3:
+	    sysrq_pressed = up_flag ? 0 : 3;
+	    break;  // two magics in a row, pass the keycode through
+	  }
+        } else if (sysrq_pressed) {
+	  if (!up_flag) {
+	    handle_sysrq(kbd_sysrq_xlate[keycode], kbd_pt_regs, kbd, tty);
+	    if (sysrq_pressed == 1) { sysrq_pressed = 2; }
+	    goto out;
+	  } else {  // up_flag
+	    if (sysrq_pressed == 3) {
+	      sysrq_pressed = 0;
+	    }
+	  }
+        }
 #endif


The question is, is this good enough? If the magic key becomes stateful,
then a more advanced key entry mode could be setup. A 'readline'
function could collect keys for a handler until enter was pressed, and
we could get real string entry into sysrq handlers.

I am not suggesting writting that function now, but rather making it
possible to write later. If this is where we want to go, then the
behaviour shown in this code snippit needs to be split between this
function and handle_sysrq().

I will post both versions of this later tonight, but I wanted some
feedback.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
