Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTFVQv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 12:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTFVQv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 12:51:59 -0400
Received: from pop.gmx.net ([213.165.64.20]:39878 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264780AbTFVQvt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 12:51:49 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org, Hans-Georg Thien <1682-600@onlinehome.de>,
       Disconnect <kernel@gotontheinter.net>
Subject: Re: [PATCH] Disable Trackpad while typing
Date: Sun, 22 Jun 2003 19:05:09 +0200
User-Agent: KMail/1.4.3
References: <200306201818.40805.torsten.foertsch@gmx.net>
In-Reply-To: <200306201818.40805.torsten.foertsch@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306221905.15686.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is now an improved version of the patch. It's against 2.4.21.

The following has changed from the original patch by Hans-Georg Thien 
<1682-600@onlinehome.de>:

- - mouse events are dropped in 12 byte chunks to better fit the PS/2 mouse 
protocol. That avoids spurious mouse events when the mouse is moving while 
the delay timer is being reached.

- - to disable the feature after pressing or releasing some particular keys 
(CTRL, SHIFT, ...) now keycodes instead of scancodes are used. "showkey -k" 
shows the correct values. The bit 0x100 is used to distinguish press and 
release events. 0 means press, 1 release. So,

	escape 97
	escape 29

mean disable "Disable Trackpad while typing" after pressing right and left 
CTRL (useful for xterm users). While

	escape 353		# 97+256
	escape 258		# 29+256

mean disable "Disable Trackpad while typing" after releasing right and left 
CTRL.

- - escaped keys are reported in /proc/tty/ps2-trackpad as decimal as "showkey 
- -k" also display them as decimal. On input sscanf( "%i" ) is expected.

- - Documentation has been moved from Documentation/Configure.help to a separate 
file Documentation/ps2-trackpad.txt.

History:
http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=DISABLE_TRACKPAD_WHILE_TYPING&q=b

Torsten

diff -Naur -X dontdiff linux-2.4.21-orig/Documentation/Configure.help 
linux-2.4.21/Documentation/Configure.help
- --- linux-2.4.21-orig/Documentation/Configure.help	2003-06-22 
15:45:55.000000000 +0000
+++ linux-2.4.21/Documentation/Configure.help	2003-06-22 14:10:39.000000000 
+0000
@@ -17964,6 +17964,21 @@
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
+  /proc/tty/ps2-trackpad file.
+
+  See Documentation/ps2-trackpad.txt for detailed information.
+
 C&T 82C710 mouse port support (as on TI Travelmate)
 CONFIG_82C710_MOUSE
   This is a certain kind of PS/2 mouse used on the TI Travelmate. If
diff -Naur -X dontdiff linux-2.4.21-orig/Documentation/ps2-trackpad.txt 
linux-2.4.21/Documentation/ps2-trackpad.txt
- --- linux-2.4.21-orig/Documentation/ps2-trackpad.txt	1970-01-01 
00:00:00.000000000 +0000
+++ linux-2.4.21/Documentation/ps2-trackpad.txt	2003-06-22 15:13:45.000000000 
+0000
@@ -0,0 +1,50 @@
+For people with a notebook that have a build in trackpad.
+
+The "Disable trackpad while typing" feature prevents unintended mouse
+moves and mouse taps while typing on the notebook keyboard.
+
+The majority of notebooks on the market have a PS/2 trackpad. 
+So you will probably say "Y" if you have a notebook with a trackpad.
+
+Also note that you can control the behaviour of the trackpad via the 
+/proc/tty/ps2-trackpad file, e.g.
+
+Set the delay time to 2 Secs (default is 10 ==> 1 Sec)
+
+	echo "delay 20" > /proc/tty/ps2-trackpad
+
+
+Completely disable the trackpad (default 0). Useful if you plug in an
+external mouse.
+
+	echo "disable 1" > /proc/tty/ps2-trackpad
+
+To completely disable this feature use
+
+	echo "delay 0" > /proc/tty/ps2-trackpad
+
+
+Escape the keyboard keycode for the key. After these keycodes mouse
+events are passed without a delay. (defaults are the keycodes for
+CTRL, SHIFT, ALT and MS-Windows (both left and right) and Menu
+(Windows Taskbar) keys). 
+
+This is useful for some applications ( like xterm ) which are using
+keydown-click events.
+
+You can use showkey -k to find out the keycodes of your own keys. 
+Apply "escape ???" twice to unescape a keycode.
+
+Example: define an escape for HOME-KeyPress 
+
+	echo "escape 102" > /proc/tty/ps2-trackpad
+
+If you want to escape KeyRelease events add 0x100 (256) to the actual
+keycode value.
+
+	echo "escape 358" > /proc/tty/ps2-trackpad
+
+enables mouse events immediately after releasing HOME key.
+
+I can't imagine a situation where mouse events are needed immediately
+after key release events but it's implemented for completeness.
diff -Naur -X dontdiff linux-2.4.21-orig/drivers/char/Config.in 
linux-2.4.21/drivers/char/Config.in
- --- linux-2.4.21-orig/drivers/char/Config.in	2003-06-22 15:45:58.000000000 
+0000
+++ linux-2.4.21/drivers/char/Config.in	2003-06-22 08:50:04.000000000 +0000
@@ -179,6 +179,13 @@
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
diff -Naur -X dontdiff linux-2.4.21-orig/drivers/char/pc_keyb.c 
linux-2.4.21/drivers/char/pc_keyb.c
- --- linux-2.4.21-orig/drivers/char/pc_keyb.c	2002-11-28 23:53:12.000000000 
+0000
+++ linux-2.4.21/drivers/char/pc_keyb.c	2003-06-22 15:39:21.000000000 +0000
@@ -13,6 +13,14 @@
  * Code fixes to handle mouse ACKs properly.
  * C. Scott Ananian <cananian@alumni.princeton.edu> 1999-01-29.
  *
+ * Implemented the "disable trackpad while typing" feature. This prevents
+ * unintended mouse moves and mouse taps while typing on the keyboard on
+ * notebooks with a PS/2 trackpad.
+ * Hans-Georg Thien <1682-600@onlinehome.de> 2003-04-30.
+ *
+ * Improvements to the "disable trackpad while typing" feature.
+ * Torsten Förtsch <torsten.foertsch@gmx.net> 2003-06-20.
+ *
  */
 
 #include <linux/config.h>
@@ -35,7 +43,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
 #include <linux/pm.h>
- -
+#include <linux/proc_fs.h>
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -102,6 +110,133 @@
 #define MAX_RETRIES	60		/* some aux operations take long time*/
 #endif /* CONFIG_PSMOUSE */
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+
+static int trackpad_skipped_events = 0;
+static int last_kbd_event = 0;     /* timestamp of last kbd event */
+static int last_kbd_scancode = 0; 
+static int last_kbd_scancode_state = 0; 
+static int trackpad_disable = 0;
+static int trackpad_delay = HZ;    /* default delay is 1Sec */
+
+static unsigned char trackpad_escape[0x200/8]; /* 2*256-Bit vector of 
keyboard scancodes to ignore */
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
+                trackpad_delay = (tmp * HZ) / 10; /* convert 1/10Sec to 
jiffies */
+                success=1; 
+        }
+
+        if (sscanf(lbuf, "disable %d", &tmp)) {
+                trackpad_disable = tmp ? 1 : 0;
+                success=1; 
+        }
+
+        if (sscanf(lbuf, "escape %i", &tmp)) {
+                if ((tmp < 0) || (tmp >=0x200)) return -EINVAL;
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
+                                (trackpad_delay * 10) / HZ); /* convert 
jiffies to 1/10Sec */
+        len += sprintf(buf+len, "disable %d\n", trackpad_disable);
+
+        for (i = 0; i < sizeof(trackpad_escape) * 8; i++) {
+                if (test_bit(i, trackpad_escape)) {
+                        len += sprintf(buf+len, "escape %d\n", i);
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
+        set_bit(0x1d, trackpad_escape);  /* CTRL-L keydown */
+        set_bit(0x2a, trackpad_escape);  /* SHIFT-L keydown */
+        set_bit(0x38, trackpad_escape);  /* ALT-L keydown */
+
+        set_bit(0x61, trackpad_escape);  /* CTRL-R keydown */
+        set_bit(0x36, trackpad_escape);  /* SHIFT-R keydown */
+        set_bit(0x64, trackpad_escape);  /* ALT-R keydown */
+
+        set_bit(0x7d, trackpad_escape);  /* MS left WINDOWS keydown */
+        set_bit(0x7e, trackpad_escape);  /* MS right WINDOWS keydown */
+        set_bit(0x7f, trackpad_escape);  /* MS right MENU keydown */
+#if 0
+        set_bit(0x01, trackpad_escape);  /* ESC keydown */
+        set_bit(0x66, trackpad_escape);  /* HOME keydown */
+        set_bit(0x67, trackpad_escape);  /* CURSORUP keydown */
+        set_bit(0x68, trackpad_escape);  /* PAGEUP keydown */
+        set_bit(0x69, trackpad_escape);  /* CURSOR-L keydown */
+        set_bit(0x6a, trackpad_escape);  /* CURSOR-R keydown */
+        set_bit(0x6b, trackpad_escape);  /* END keydown */
+        set_bit(0x6c, trackpad_escape);  /* CURSORDOWN keydown */
+        set_bit(0x6d, trackpad_escape);  /* PAGEDOWN keydown */
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
@@ -449,6 +584,24 @@
 		return;
 	}
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        if (trackpad_disable) return;
+
+        if (!test_bit(last_kbd_scancode, trackpad_escape)) {
+	  /* do nothing if time since last kbd event is less then trackpad_delay */
+	  if (abs(jiffies - last_kbd_event) < trackpad_delay) {
+	    trackpad_skipped_events++;
+	    return;
+	  }
+        }
+	
+	if (trackpad_skipped_events%12) {
+	  trackpad_skipped_events++;
+	  return;
+	}
+	trackpad_skipped_events=0;
+#endif
+
 	prev_code = scancode;
 	add_mouse_randomness(scancode);
 	if (aux_count) {
@@ -469,6 +622,45 @@
 
 static inline void handle_keyboard_event(unsigned char scancode)
 {
+
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+  /* this more or less resembles the pckbd_translate() algorithm */
+  if( scancode==0xe0 && last_kbd_scancode_state==0 ) { /* escape 1b */
+    last_kbd_scancode_state = 0x100;
+  } else if( scancode==0xe1 && last_kbd_scancode_state==0 ) { /* escape 2b */
+    last_kbd_scancode_state = 0x200;
+  } else if(last_kbd_scancode_state==0x100) {
+    /* E0 table lookup */
+    if( last_kbd_scancode = e0_keys[scancode&0x7f] ) {
+      if( scancode & 0x80 ) last_kbd_scancode|=0x100;
+      last_kbd_event = jiffies;
+    }
+    last_kbd_scancode_state=0;
+  } else if(last_kbd_scancode_state==0x200) {
+    if( (scancode&0x7f)==0x1d ) {
+      last_kbd_scancode_state++;
+    } else {
+      last_kbd_scancode_state=0; /* unknown e1 sequence */
+    }
+  } else if(last_kbd_scancode_state==0x201) {
+    if( (scancode&0x7f)==0x45 ) { /* PAUSE key */
+      last_kbd_scancode = E1_PAUSE;
+      if( scancode & 0x80 ) last_kbd_scancode|=0x100;
+      last_kbd_event = jiffies;
+    }
+    last_kbd_scancode_state=0;
+  } else {
+    last_kbd_scancode = (scancode&0x7f);
+    if( last_kbd_scancode >= SC_LIM )
+      last_kbd_scancode=high_keys[last_kbd_scancode - SC_LIM];
+    if( last_kbd_scancode ) {
+      if( scancode & 0x80 ) last_kbd_scancode|=0x100;
+      last_kbd_event = jiffies;
+    }
+    last_kbd_scancode_state=0;
+  }
+#endif
+
 #ifdef CONFIG_VT
 	kbd_exists = 1;
 	if (do_acknowledge(scancode))
@@ -1219,6 +1411,10 @@
 	kbd_write_command(KBD_CCMD_MOUSE_DISABLE); /* Disable aux device. */
 	kbd_write_cmd(AUX_INTS_OFF); /* Disable controller ints. */
 
+#ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
+        trackpad_config_setup();
+#endif
+
 	return 0;
 }
 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+9eHLwicyCTir8T4RAg+PAJ47B2aQZEbBz50mo5++GQlQCKs5BACgnjmI
BIy+erf5vvQkEVRF5G89eB8=
=OSyM
-----END PGP SIGNATURE-----
