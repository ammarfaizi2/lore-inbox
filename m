Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTEEWdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTEEWde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:33:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:46300 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261500AbTEEWd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:33:28 -0400
Message-ID: <3EB6EA2D.9050208@onlinehome.de>
Date: Tue, 06 May 2003 00:48:13 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
 a  PS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de.suse.lists.linux.kernel>
In-Reply-To: <3EB19625.6040904@onlinehome.de.suse.lists.linux.kernel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Georg Thien <1682-600@onlinehome.de> writes:

> The short story
> ---------------
> Apple MacIntosh iBook Notebooks computers have a nice feature that
> prevents unintended trackpad input while typing on the keyboard. There
> are no mouse-moves or mouse-taps for a short period of time after each
> keystroke. I wanted to have this feature on my i386 notebook ...

I have eliminated the use of a timer. The patch has been simple before, 
and now it is even more simple :)


diff -urN -X /tmp/dontdiff 
/usr/src/linux-2.4.20/Documentation/Configure.help 
/usr/src/linux/Documentation/Configure.help
--- /usr/src/linux-2.4.20/Documentation/Configure.help	Fri Nov 29 
00:53:08 2002
+++ /usr/src/linux/Documentation/Configure.help	Thu May  1 02:12:04 2003
@@ -17752,6 +17752,16 @@
    <ftp://gnu.systemy.it/pub/gpm/>) solves this problem, or you can get
    the "mconv2" utility from <ftp://ibiblio.org/pub/Linux/system/mouse/>.

+Disable trackpad while typing
+CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+  For people with a notebook that have a build in PS/2 trackpad.
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
diff -urN -X /tmp/dontdiff /usr/src/linux-2.4.20/drivers/char/Config.in 
/usr/src/linux/drivers/char/Config.in
--- /usr/src/linux-2.4.20/drivers/char/Config.in	Fri Nov 29 00:53:12 2002
+++ /usr/src/linux/drivers/char/Config.in	Thu May  1 02:30:45 2003
@@ -170,6 +170,13 @@
  tristate 'Mouse Support (not serial and bus mice)' CONFIG_MOUSE
  if [ "$CONFIG_MOUSE" != "n" ]; then
     bool '  PS/2 mouse (aka "auxiliary device") support' CONFIG_PSMOUSE
+
+   if [ "$CONFIG_PSMOUSE" = "y" ]
+   then
+     bool '    Disable Trackpad while typing on Notebooks' 
CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+   fi
+
+
     tristate '  C&T 82C710 mouse port support (as on TI Travelmate)' 
CONFIG_82C710_MOUSE
     tristate '  PC110 digitizer pad support' CONFIG_PC110_PAD
     tristate '  MK712 touch screen support' CONFIG_MK712_MOUSE
diff -urN -X /tmp/dontdiff /usr/src/linux-2.4.20/drivers/char/pc_keyb.c 
/usr/src/linux/drivers/char/pc_keyb.c
--- /usr/src/linux-2.4.20/drivers/char/pc_keyb.c	Fri Nov 29 00:53:12 2002
+++ /usr/src/linux/drivers/char/pc_keyb.c	Tue May  6 02:07:27 2003
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
+static int last_kbd_event = 0; /* used to hold timestamp of last kbd 
event */
+#endif
+
  #endif

  #ifndef kbd_controller_present
@@ -430,6 +440,7 @@
  }


+
  static inline void handle_mouse_event(unsigned char scancode)
  {
  #ifdef CONFIG_PSMOUSE
@@ -449,6 +460,11 @@
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
@@ -467,8 +483,14 @@

  static unsigned char kbd_exists = 1;

+
  static inline void handle_keyboard_event(unsigned char scancode)
  {
+
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        last_kbd_event = jiffies;
+#endif
+
  #ifdef CONFIG_VT
  	kbd_exists = 1;
  	if (do_acknowledge(scancode))


