Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTEAVdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTEAVdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:33:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:12014 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262624AbTEAVdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:33:50 -0400
Message-ID: <3EB19625.6040904@onlinehome.de>
Date: Thu, 01 May 2003 23:48:21 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh a
 PS/2 Trackpad
Content-Type: multipart/mixed;
 boundary="------------040904010309040302080300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040904010309040302080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for this long text and my bad english. And please be kind to me -
it is my very first posting to this mailing list ...

I have written a *very small* patch against the linux 2.4.20 kernel and
I want to submit it now.

The short story
---------------
The trackpad on the MacIntosh iBook Notebooks have a feature that
prevents unintended trackpad input while typing on the keyboard. There
are no mouse-moves or mouse-taps for a short period of time after each
keystroke.

I believe that many people with i386 notebooks would like this feature 
and I want to give it to the linux community.

First I had the idea of writing a loadable kernel module "trackpad" that
implements that feature and is loadable via

insmod keybd_irq=? mouse_irq=? delay=?

The long story
--------------
My first approach was - because I came from the bad old M$-DOS times -
write something like a "terminate and stay resident program"

      Procedure LoadModule
        Save the currentlly installed handlers for keyboard and mouse.
        Install your own interrupt handlers for keyboard and mouse.
      End

      Procedure UnloadModule
        Stop and remove "reset-timer" if necessary
        Restore the saved interrupt handlers for keyboard and mouse
      End

      Procedure KbdHandler
        Stop or modify "reset-timer" if necessary
        Set global variable block_mouse_events=1
        Start a timer that resets block_mouse_events=0 after ??? mSec
        Call the old keyboard interrupt handler
      End

      Proceure MouseHandler
        if block_mouse_events>0 then
          call ACK(mouse irq) if necessary
          do nothing
        else
          call old mouse interrupt handler
      End


So I bought the book "Linux Device Drivers" written by Alessandro Rubini
& Jonathan Corbert. It is an excellent book about LKM, but I couldn't
find a way  to "save and restore" irq-handlers as in the design
described above.

That's why I requested a little help in the newsgroup at
comp.os.linux.development.system. This ended up with some people who
said "don't mess around with irq-handlers in that way".

While trying to gain a deeper understanding of irq-handling - espically
for mouse and keyboard handlers - I found out that the keyboard and
mouse interrupts are handled *both* in
/usr/src/linux/drivers/char/pc_keyb.c.

Ok, that is only true for PS/2 mice, but the majority of notebooks on
the market have a PS/2 trackpad. On modifiying the pc_keyb.c file there
is no longer a need to save/restore Interrupt handlers or to call them
indirecty via a function pointer. Unfortunatly it has to be compiled in
the kernel and cannot be written as a LKM module.

But anyway - I sad down and got a working solution very quickly! I'm
very glad with it! I needed not more than 45 minutes to get this
working! Works in textmode (gpm) and under X11 as expected!


Testing
-------
I have tested my patch only on my own notebook (Compaq M300). It would
help a lot if there are some volunteers...


Future Plans
------------
[x] make the "disable trackpad time" configurable via the /proc
filesystem. Do you think that /proc/sys/kernel/trackpad is a good place
for it? There are other files under the /proc/sys/kernel directory that
fall in the category "keyboard handling", e.g. ctrl-alt-del or sysrq.

[x] make a /proc entry to allow "disable trackpad" and "enable
trackpad". That would allow to turn the builtin trackpad off when an
external mouse is pluged in, and to re-enable it when an external mouse
is unplugged again.


Here is the patch
-----------------



--------------040904010309040302080300
Content-Type: text/plain;
 name="trackpad_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trackpad_patch.diff"

diff -urN -X /tmp/dontdiff linux-2.4.20/Documentation/Configure.help /usr/src/linux/Documentation/Configure.help
--- linux-2.4.20/Documentation/Configure.help	Fri Nov 29 00:53:08 2002
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
diff -urN -X /tmp/dontdiff linux-2.4.20/drivers/char/Config.in /usr/src/linux/drivers/char/Config.in
--- linux-2.4.20/drivers/char/Config.in	Fri Nov 29 00:53:12 2002
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
diff -urN -X /tmp/dontdiff linux-2.4.20/drivers/char/pc_keyb.c /usr/src/linux/drivers/char/pc_keyb.c
--- linux-2.4.20/drivers/char/pc_keyb.c	Fri Nov 29 00:53:12 2002
+++ /usr/src/linux/drivers/char/pc_keyb.c	Thu May  1 02:30:45 2003
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
@@ -85,6 +90,10 @@
 /*
  *	PS/2 Auxiliary Device
  */
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+static int disable_trackpad_while_typing=0;
+static int trackpad_delay=HZ;  /* delay trackpad for 1Sec after a key-event */
+#endif
 
 static int __init psaux_init(void);
 
@@ -449,6 +458,10 @@
 		return;
 	}
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        if(disable_trackpad_while_typing > 0) return;
+#endif
+
 	prev_code = scancode;
 	add_mouse_randomness(scancode);
 	if (aux_count) {
@@ -467,8 +480,42 @@
 
 static unsigned char kbd_exists = 1;
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+
+void enable_trackpad(unsigned long ptr)
+{
+        disable_trackpad_while_typing=0; /* re-enable trackpad */
+}
+
+#endif
+
 static inline void handle_keyboard_event(unsigned char scancode)
 {
+
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+
+        /* setup a timer to re-enable the trackpad */
+        static struct timer_list enable_trackpad_timer;
+        static int enable_trackpad_timer_initialized=0;
+
+        disable_trackpad_while_typing=1; /* disable trackpad */
+
+        if(enable_trackpad_timer_initialized)
+        {
+                 /* trackpad timer already exists, - just restart it */
+                 mod_timer(&enable_trackpad_timer, jiffies+trackpad_delay);
+        }
+        else
+        {
+                 /* no trackpad timer yet. Initialize and start it */
+                 init_timer(&enable_trackpad_timer);
+                 enable_trackpad_timer.expires=jiffies+trackpad_delay;
+                 enable_trackpad_timer.function=enable_trackpad;
+                 add_timer(&enable_trackpad_timer);
+                 enable_trackpad_timer_initialized=1;
+        }
+#endif
+
 #ifdef CONFIG_VT
 	kbd_exists = 1;
 	if (do_acknowledge(scancode))



--------------040904010309040302080300--

