Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTE0Uc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTE0Uc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:32:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:39149 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264134AbTE0UbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:31:00 -0400
Message-ID: <3ED3CECA.9020706@onlinehome.de>
Date: Tue, 27 May 2003 22:47:06 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Khalid Aziz <khalid_aziz@hp.com>, subscript@free.fr
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
  aPS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de> <3EBAAC12.F4EA298D@hp.com>
In-Reply-To: <3EBAAC12.F4EA298D@hp.com>
Content-Type: multipart/mixed;
 boundary="------------070303040705070404020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303040705070404020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hans-Georg Thien wrote:
    > The short story
    > ---------------
    > Apple MacIntosh iBook Notebooks computers have a nice feature that
    > prevents unintended trackpad input while typing on the keyboard. There
    > are no mouse-moves or mouse-taps for a short period of time after each
    > keystroke. I wanted to have this feature on my i386 notebook ...

It it is now possible to adjust some settings via

       echo ???? > /proc/tty/ps2-trackpad

(1) Set the delay time to 2 Secs (default is 10 ==> 1 Sec)

         echo "delay 20" > /proc/tty/ps2-trackpad


(2)  Completely disable the trackpad (default 0). Useful if you plug in 
an external mouse.

         echo "disable 1" > /proc/tty/ps2-trackpad

(3)  Escape the keyboard scancode for a key. These scancodes are
passed without a delay. (defaults are the scancodes for CTRL and SHIFT
keys).

This is useful for some applications ( like xterm ) which are using 
keydown events in combination with mouseclick events.

You can use showkey -s to find out the scancodes of your own keys.
To unescape a scancode you must apply that scancode twice! For keys with 
multiple scancodes you must use the *last* generated scancode.

     Example: define an escape for HOME-KeyDown

         echo "escape 0x047" > /proc/tty/ps2-trackpad




--------------070303040705070404020104
Content-Type: text/plain;
 name="trackpad-2.4.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trackpad-2.4.20.diff"

--- /usr/src/linux-2.4.20/Documentation/Configure.help	Fri Nov 29 00:53:08 2002
+++ /usr/src/linux/Documentation/Configure.help	Wed May 28 00:04:44 2003
@@ -17752,6 +17752,44 @@
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
+  Also note that you can control the behaviour of the trackpad via the 
+  /proc/tty/ps2-trackpad file, e.g.
+
+  Set the delay time to 2 Secs (default is 10 ==> 1 Sec)
+
+  	echo "delay 20" > /proc/tty/ps2-trackpad
+  
+
+  Completely disable the trackpad (default 0). Useful if you plug in an
+  external mouse.
+
+  	echo "disable 1" > /proc/tty/ps2-trackpad
+
+
+  Escape the keyboard scancode for the key. These scancodes are passed
+  without a delay. (defaults are the scancodes for CTRL and SHIFT keys). 
+
+  This is useful for some applications ( like xterm ) which are using
+  keydown-click events.
+
+  You can use showkey -s to find out the scancodes of your own keys. 
+  Apply "escape 0x0??" twice to unescape a scancode. For keys with
+  multiple scancodes you must use the *last* generated scancode.
+
+  Example: define an escape for HOME-KeyDown 
+
+  	echo "escape 0x047" > /proc/tty/ps2-trackpad
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
+++ /usr/src/linux/drivers/char/pc_keyb.c	Tue May 27 23:08:46 2003
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
@@ -35,7 +40,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
 #include <linux/pm.h>
-
+#include <linux/proc_fs.h>
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -102,6 +107,125 @@
 #define MAX_RETRIES	60		/* some aux operations take long time*/
 #endif /* CONFIG_PSMOUSE */
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+
+static int last_kbd_event = 0;     /* timestamp of last kbd event */
+static int last_kbd_scancode = 0; 
+static int trackpad_disable = 0;
+static int trackpad_delay = HZ;    /* default delay is 1Sec */
+
+static unsigned char trackpad_escape[256/8]; /* 256-Bit vector of keyboard scancodes to ignore */
+
+
+static int trackpad_write_proc(struct file *file,
+                               const char *buf,
+                               unsigned long len,
+                               void *data)
+{
+
+/*
+ * handle write requests to /proc/tty/ps2-trackpad
+ */
+        char lbuf[32];
+        int tmp;
+        int success = 0;
+ 
+        if (len > sizeof(lbuf)-1) return -EINVAL;
+
+        if (copy_from_user(lbuf, buf, len)) return -EFAULT;
+
+        lbuf[len] = '\0';
+
+        if (sscanf(lbuf, "delay %d", &tmp)) {
+                trackpad_delay = (tmp * HZ) / 10; /* convert 1/10Sec to jiffies */
+                success=1; 
+        }
+
+        if (sscanf(lbuf, "disable %d", &tmp)) {
+                trackpad_disable = tmp ? 1 : 0;
+                success=1; 
+        }
+
+        if (sscanf(lbuf, "escape 0x%x", &tmp)) {
+                if ((tmp < 0) || (tmp > 255)) return -EINVAL;
+                change_bit(tmp, trackpad_escape);
+                success=1; 
+        }
+
+        if (!success) return -EINVAL;
+
+        return len;
+}
+
+static int trackpad_read_proc(char *buf, char **start, off_t ofs,
+                              int count, int *eof, void *data)
+{  
+
+/* 
+ * handle read requests to /proc/tty/ps2-trackpad 
+ */
+
+        int len  = 0;
+        int i;
+
+        len += sprintf(buf+len, "delay %d\n", 
+                                (trackpad_delay * 10) / HZ); /* convert jiffies to 1/10Sec */
+        len += sprintf(buf+len, "disable %d\n", trackpad_disable);
+
+        for (i = 0; i < sizeof(trackpad_escape) * 8; i++) {
+                if (test_bit(i, trackpad_escape)) {
+                        len += sprintf(buf+len, "escape 0x0%x\n", i);
+                }
+        }
+
+        *eof = 1;
+        buf[len+1] = '\0';
+        return len;
+}
+
+static int trackpad_config_setup(void)
+{  
+
+/* 
+ * create read-write entries in /proc/tty/ps2-trackpad and setup some 
+ * defaults for the trackpad handling
+ */
+
+        struct proc_dir_entry *trackpad_proc_entry;
+
+        trackpad_proc_entry=create_proc_entry("tty/ps2-trackpad", 0, NULL);
+
+        if (trackpad_proc_entry == NULL) return -1;
+
+        trackpad_proc_entry->mode |=  S_IWUGO;
+        trackpad_proc_entry->read_proc = trackpad_read_proc;
+        trackpad_proc_entry->write_proc = trackpad_write_proc;
+
+        
+        /* set keyboard scancodes to ignore */
+        memset(trackpad_escape, 0, sizeof(trackpad_escape));
+        set_bit(0x1d, trackpad_escape);  /* CTRL-L/CTRL-R keydown */
+        set_bit(0x2a, trackpad_escape);  /* SHIFT-L keydown */
+        set_bit(0x36, trackpad_escape);  /* SHIFT-R keydown */
+#if 0
+        set_bit(0x38, trackpad_escape);  /* ALT-L/ALT-R keydown */
+        set_bit(0x01, trackpad_escape);  /* ESC keydown */
+        set_bit(0x47, trackpad_escape);  /* HOME keydown */
+        set_bit(0x48, trackpad_escape);  /* CURSORUP keydown */
+        set_bit(0x49, trackpad_escape);  /* PAGEUP keydown */
+        set_bit(0x4b, trackpad_escape);  /* CURSOR-L keydown */
+        set_bit(0x4d, trackpad_escape);  /* CURSOR-R keydown */
+        set_bit(0x4f, trackpad_escape);  /* END keydown */
+        set_bit(0x50, trackpad_escape);  /* CURSORDOWN keydown */
+        set_bit(0x51, trackpad_escape);  /* PAGEDOWN keydown */
+        set_bit(0x5d, trackpad_escape);  /* MENU keydown */
+#endif
+
+        return 0;
+}
+
+#endif /* CONFIG_DISABLE_TRACKPAD_WHILE_TYPING */
+
 /*
  * Wait for keyboard controller input buffer to drain.
  *
@@ -449,6 +573,15 @@
 		return;
 	}
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        if (trackpad_disable) return;
+
+        if (!test_bit(last_kbd_scancode, trackpad_escape)) {
+                  /* do nothing if time since last kbd event is less then trackpad_delay */
+                  if (abs(jiffies - last_kbd_event) < trackpad_delay) return;
+        }
+#endif
+
 	prev_code = scancode;
 	add_mouse_randomness(scancode);
 	if (aux_count) {
@@ -469,6 +602,12 @@
 
 static inline void handle_keyboard_event(unsigned char scancode)
 {
+
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+                last_kbd_event = jiffies;
+                last_kbd_scancode = scancode;
+#endif
+
 #ifdef CONFIG_VT
 	kbd_exists = 1;
 	if (do_acknowledge(scancode))
@@ -1219,6 +1358,10 @@
 	kbd_write_command(KBD_CCMD_MOUSE_DISABLE); /* Disable aux device. */
 	kbd_write_cmd(AUX_INTS_OFF); /* Disable controller ints. */
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        trackpad_config_setup();
+#endif
+
 	return 0;
 }
 



--------------070303040705070404020104--

