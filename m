Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMP0r>; Mon, 13 Nov 2000 10:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQKMP0h>; Mon, 13 Nov 2000 10:26:37 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:22800 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S129050AbQKMP00>; Mon, 13 Nov 2000 10:26:26 -0500
Message-ID: <3A100930.FEEB617B@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac-buttons emulation broken in 2.4.0-test10
In-Reply-To: <3A0FC230.BF7E537B@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Nov 2000 10:26:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, it seems I found a solution to my own problem :)

Here are patches that fix the problem.

Doing this, I discovered there are 2 modes to button emulation (3 if you
include no emulation):
Mode 0:
No emulation whatsoever.
Mode 1:
echo "1" > /proc/sys/dev/mac_.../mouse_...
In this mode, when you press on fct-ctrl or fct-alt, then it's like if you
pressed on the corresponding mouse button.
Mode 2:
echo "2" > /proc/sys/dev/mac_.../mouse_...
In this mode, you have to hold down fct-ctrl or fct-alt __and__ click
the mouse to get the corresponding mouse button.

Cheers

Karim

---------------------------------------------------------------------------------------------------
--- linux/drivers/input/keybdev.c	Thu Jul 27 21:36:54 2000
+++ linux-2.4.0-test10/drivers/input/keybdev.c	Mon Nov 13 08:19:48 2000
@@ -90,7 +90,7 @@
 	return 0;
 }
 
-#elif defined(CONFIG_ADB_KEYBOARD)
+#elif defined(CONFIG_ADB_KEYBOARD) || defined(CONFIG_MAC_HID)
 
 static unsigned char mac_keycodes[128] =
 	{ 0, 53, 18, 19, 20, 21, 23, 22, 26, 28, 25, 29, 27, 24, 51, 48,
@@ -129,9 +129,19 @@
 	}
 }
 
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+extern int mac_hid_mouse_emulate_buttons(int caller, unsigned int keycode, int down);
+#endif
+
 void keybdev_event(struct input_handle *handle, unsigned int type, unsigned int code, int down)
 {
 	if (type != EV_KEY) return;
+
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+	/* There should be an if() here to determine whether emulate_raw() is to be called or not.
+	 If the key is caught, emulate_raw() should not be called. K.Y. */
+	mac_hid_mouse_emulate_buttons(1, code, down);
+#endif
 
 	if (emulate_raw(code, down))
 		printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", code);
--- linux/drivers/input/mousedev.c	Tue Aug 22 12:06:31 2000
+++ linux-2.4.0-test10/drivers/input/mousedev.c	Mon Nov 13 08:25:41 2000
@@ -79,6 +79,10 @@
 static struct mousedev *mousedev_table[MOUSEDEV_MINORS];
 static struct mousedev mousedev_mix;
 
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+extern int mac_hid_mouse_emulate_buttons(int caller, unsigned int keycode, int down);
+#endif
+
 static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct mousedev *mousedevs[3] = { handle->private, &mousedev_mix, NULL };
@@ -132,6 +136,9 @@
 						case BTN_MIDDLE: index = 2; break;	
 						default: return;
 					}
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+				        index = mac_hid_mouse_emulate_buttons(2, index, 0);
+#endif
 					switch (value) {
 						case 0: clear_bit(index, &list->buttons); break;
 						case 1: set_bit(index, &list->buttons); break;

---------------------------------------------------------------------------------------------------

Karim Yaghmour wrote:
> 
> The mac_hid_mouse_emulate_buttons() in drivers/macintosh/mac_hid.c
> which takes care of emulating multiple buttons on a mac doesn't
> seem to be used anywhere. In fact, by doing a "grep -r mac_hid... *"
> in the kernel's base directory yields only one result and it's
> the one in mac_hid.c. Shouldn't this be called upon from the
> keyboard and mouse handlers?
> 

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
