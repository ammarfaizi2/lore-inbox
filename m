Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132806AbRDTG5v>; Fri, 20 Apr 2001 02:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbRDTG5n>; Fri, 20 Apr 2001 02:57:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:24069 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S132806AbRDTG5h>;
	Fri, 20 Apr 2001 02:57:37 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15071.56857.169362.920321@argo.ozlabs.ibm.com.au>
Date: Fri, 20 Apr 2001 16:58:33 +1000 (EST)
To: torvalds@transmeta.com
Cc: cort@fsmlabs.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        Vojtech Pavlik <vojtech@suse.cz>, franz.sirl-kernel@lauterbach.com
Subject: [PATCH] update drivers/input/keybdev.c
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following patch updates drivers/input/keybdev.c so that we can
generate either linux keycodes or ADB keycodes from keyboards that use
the input layer.  We now have ADB keyboards and mice using the input
layer as well as USB, so it is very useful to have the flexibility to
choose at runtime which type of keycodes you want to receive.  You
already have in your tree all of the other changes that we need in
order to do this, just this one file got missed somehow.

This change has been approved by the maintainer, Vojtech Pavlik.

If you decide not to take this patch, please let me know so I can
send you a patch to back out the corresponding changes that have
already been made in other files.

Paul.

diff -urN linux/drivers/input/keybdev.c pmac/drivers/input/keybdev.c
--- linux/drivers/input/keybdev.c	Thu Apr 19 15:03:43 2001
+++ pmac/drivers/input/keybdev.c	Fri Apr 20 16:47:48 2001
@@ -38,7 +38,8 @@
 #include <linux/kbd_kern.h>
 
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || \
-    defined(__mips__) || defined(CONFIG_SPARC64) || defined(CONFIG_SUPERH)
+    defined(__mips__) || defined(CONFIG_SPARC64) || defined(CONFIG_SUPERH) || \
+    defined(CONFIG_PPC) || defined(__mc68000__)
 
 static int x86_sysrq_alt = 0;
 #ifdef CONFIG_SPARC64
@@ -63,8 +64,46 @@
 	308,310,313,314,315,317,318,319,320,321,322,323,324,325,326,330,
 	332,340,341,342,343,344,345,346,356,359,365,368,369,370,371,372 };
 
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+extern int mac_hid_mouse_emulate_buttons(int, int, int);
+#endif /* CONFIG_MAC_EMUMOUSEBTN */
+#ifdef CONFIG_MAC_ADBKEYCODES
+extern int mac_hid_keyboard_sends_linux_keycodes(void);
+#else
+#define mac_hid_keyboard_sends_linux_keycodes()	0
+#endif /* CONFIG_MAC_ADBKEYCODES */
+#if defined(CONFIG_MAC_ADBKEYCODES) || defined(CONFIG_ADB_KEYBOARD)
+static unsigned char mac_keycodes[256] = {
+	  0, 53, 18, 19, 20, 21, 23, 22, 26, 28, 25, 29, 27, 24, 51, 48,
+	 12, 13, 14, 15, 17, 16, 32, 34, 31, 35, 33, 30, 36, 54,128,  1,
+	  2,  3,  5,  4, 38, 40, 37, 41, 39, 50, 56, 42,  6,  7,  8,  9,
+	 11, 45, 46, 43, 47, 44,123, 67, 58, 49, 57,122,120, 99,118, 96,
+	 97, 98,100,101,109, 71,107, 89, 91, 92, 78, 86, 87, 88, 69, 83,
+	 84, 85, 82, 65, 42,  0, 10,103,111,  0,  0,  0,  0,  0,  0,  0,
+	 76,125, 75,105,124,110,115, 62,116, 59, 60,119, 61,121,114,117,
+	  0,  0,  0,  0,127, 81,  0,113,  0,  0,  0,  0, 95, 55, 55,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0, 94,  0, 93,  0,  0,  0,  0,  0,  0,104,102 };
+#endif	/* CONFIG_MAC_ADBKEYCODES || CONFIG_ADB_KEYBOARD */
+ 
 static int emulate_raw(unsigned int keycode, int down)
 {
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+	if (mac_hid_mouse_emulate_buttons(1, keycode, down))
+		return 0;
+#endif /* CONFIG_MAC_EMUMOUSEBTN */
+#if defined(CONFIG_MAC_ADBKEYCODES) || defined(CONFIG_ADB_KEYBOARD)
+	if (!mac_hid_keyboard_sends_linux_keycodes()) {
+		if (keycode > 255 || !mac_keycodes[keycode])
+			return -1;
+       
+		handle_scancode((mac_keycodes[keycode] & 0x7f), down);
+		return 0;
+	}
+#endif	/* CONFIG_MAC_ADBKEYCODES || CONFIG_ADB_KEYBOARD */
+
 	if (keycode > 255 || !x86_keycodes[keycode])
 		return -1; 
 
@@ -103,28 +142,6 @@
 	if (keycode == KEY_STOP)
 		sparc_l1_a_state = down;
 #endif
-
-	return 0;
-}
-
-#elif defined(CONFIG_ADB_KEYBOARD)
-
-static unsigned char mac_keycodes[128] =
-	{ 0, 53, 18, 19, 20, 21, 23, 22, 26, 28, 25, 29, 27, 24, 51, 48,
-	 12, 13, 14, 15, 17, 16, 32, 34, 31, 35, 33, 30, 36, 54,128,  1,
-	  2,  3,  5,  4, 38, 40, 37, 41, 39, 50, 56, 42,  6,  7,  8,  9,
-	 11, 45, 46, 43, 47, 44,123, 67, 58, 49, 57,122,120, 99,118, 96,
-	 97, 98,100,101,109, 71,107, 89, 91, 92, 78, 86, 87, 88, 69, 83,
-	 84, 85, 82, 65, 42,  0, 10,103,111,  0,  0,  0,  0,  0,  0,  0,
-	 76,125, 75,105,124,  0,115, 62,116, 59, 60,119, 61,121,114,117,
-	  0,  0,  0,  0,127, 81,  0,113,  0,  0,  0,  0,  0, 55, 55 };
-
-static int emulate_raw(unsigned int keycode, int down)
-{
-	if (keycode > 127 || !mac_keycodes[keycode])
-		return -1;
-
-	handle_scancode(mac_keycodes[keycode] & 0x7f, down);
 
 	return 0;
 }
