Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTEILdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTEILdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:33:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:63945 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262489AbTEILcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:32:55 -0400
Message-ID: <3EBB9563.7080709@onlinehome.de>
Date: Fri, 09 May 2003 13:47:47 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Khalid Aziz <khalid_aziz@hp.com>
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
  aPS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de> <3EBAAC12.F4EA298D@hp.com>
In-Reply-To: <3EBAAC12.F4EA298D@hp.com>
Content-Type: multipart/mixed;
 boundary="------------000909050607060608000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909050607060608000204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Khalid Aziz wrote:
> [...] impossible to perform any operation that requires
> pressing a key on the keyboard while clicking a mouse button - for
> example bringing up X-terminal menu with CTRL-<middle button>. I am sure
> there are other similar combination used by other software. You would
> think 1 second after the CTRL key is pressed (which is when a keyboard
> event is generated), mouse will be re-enabled and you should be able to
> click mouse buttons as long as you do not let go of the key. Does not
> seem to work that way. Mouse stays disabled as long as the key is
> pressed.
> 
Thanks a lot Khalid! I have fixed that now.

Now, when you first press a key the trackpad is disabled. But the
"timer" is not restarted now when you hold the key pressed down
(prev_scancode == actual_scancode).







--------------000909050607060608000204
Content-Type: text/plain;
 name="trackpad-2.4.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trackpad-2.4.20.diff"

--- /usr/src/linux-2.4.20/Documentation/Configure.help	Fri Nov 29 00:53:08 2002
+++ /usr/src/linux/Documentation/Configure.help	Thu May  1 02:12:04 2003
@@ -17752,6 +17752,16 @@
   <ftp://gnu.systemy.it/pub/gpm/>) solves this problem, or you can get
   the "mconv2" utility from <ftp://ibiblio.org/pub/Linux/system/mouse/>.
 
+Disable trackpad while typing
+CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+  For people with a notebook that have a build in trackpad.
+
+  It prevents unintended mouse moves and mouse taps while typing on
+  the notebook keyboard.
+
+  The majority of notebooks on the market have a PS/2 trackpad. 
+  So you will probably say "Y" if you have a notebook with a trackpad.
+
 C&T 82C710 mouse port support (as on TI Travelmate)
 CONFIG_82C710_MOUSE
   This is a certain kind of PS/2 mouse used on the TI Travelmate. If
--- /usr/src/linux-2.4.20/drivers/char/Config.in	Fri Nov 29 00:53:12 2002
+++ /usr/src/linux/drivers/char/Config.in	Thu May  1 02:30:45 2003
@@ -170,6 +170,13 @@
 tristate 'Mouse Support (not serial and bus mice)' CONFIG_MOUSE
 if [ "$CONFIG_MOUSE" != "n" ]; then
    bool '  PS/2 mouse (aka "auxiliary device") support' CONFIG_PSMOUSE
+
+   if [ "$CONFIG_PSMOUSE" = "y" ]
+   then
+     bool '    Disable Trackpad while typing on Notebooks' CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+   fi
+
+
    tristate '  C&T 82C710 mouse port support (as on TI Travelmate)' CONFIG_82C710_MOUSE
    tristate '  PC110 digitizer pad support' CONFIG_PC110_PAD
    tristate '  MK712 touch screen support' CONFIG_MK712_MOUSE
--- /usr/src/linux-2.4.20/drivers/char/pc_keyb.c	Fri Nov 29 00:53:12 2002
+++ /usr/src/linux/drivers/char/pc_keyb.c	Fri May  9 15:17:45 2003
@@ -13,6 +13,11 @@
  * Code fixes to handle mouse ACKs properly.
  * C. Scott Ananian <cananian@alumni.princeton.edu> 1999-01-29.
  *
+ * Implemented the "disable trackpad while typing" feature. This prevents
+ * unintended mouse moves and mouse taps while typing on the keyboard on
+ * notebooks with a PS/2 trackpad.
+ * Hans-Georg Thien <1682-600@onlinehome.de> 2003-04-30.
+ *
  */
 
 #include <linux/config.h>
@@ -67,6 +72,11 @@
 static void aux_write_ack(int val);
 static void __aux_write_ack(int val);
 static int aux_reconnect = 0;
+
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+static int last_kbd_event = 0; /* used to hold timestamp of last kbd event */
+#endif
+
 #endif
 
 #ifndef kbd_controller_present
@@ -449,6 +459,11 @@
 		return;
 	}
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        /* do nothing if time since last kbd event is less then 1Sec */
+        if ( abs(jiffies - last_kbd_event) < HZ ) return;
+#endif
+
 	prev_code = scancode;
 	add_mouse_randomness(scancode);
 	if (aux_count) {
@@ -469,6 +484,17 @@
 
 static inline void handle_keyboard_event(unsigned char scancode)
 {
+
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        static unsigned char prev_scancode=0;
+
+        if (scancode != prev_scancode)
+        {
+                last_kbd_event = jiffies;
+                prev_scancode=scancode;
+        }
+#endif
+
 #ifdef CONFIG_VT
 	kbd_exists = 1;
 	if (do_acknowledge(scancode))


--------------000909050607060608000204--

