Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbQLGTac>; Thu, 7 Dec 2000 14:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbQLGTaW>; Thu, 7 Dec 2000 14:30:22 -0500
Received: from linuxpc1.lauterbach.com ([194.195.165.177]:58140 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S129904AbQLGTaP>; Thu, 7 Dec 2000 14:30:15 -0500
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Date: Thu, 7 Dec 2000 20:00:00 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0SO7N0E7TZ21PQXESZ64"
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Missing PPC merge bits
MIME-Version: 1.0
Message-Id: <00120720000000.06371@enzo.bigblue.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_0SO7N0E7TZ21PQXESZ64
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Linus,

the appended patch contains the missing PPC bits for 2.4.0, patch OK'ed by 
Paul Mackerras.

Franz.

	* drivers/char/keyboard.c: Use key_maps[0] instead of plain_map to enable
	proper keymap switching.
	* drivers/input/keybdev.c: Bring PPC keycode handling up-to-date.


--------------Boundary-00=_0SO7N0E7TZ21PQXESZ64
Content-Type: text/plain;
  name="ppc-kbd.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ppc-kbd.patch"

--- /cvsroot/linux_2_3/drivers/char/keyboard.c	Mon Dec  4 14:59:20 2000
+++ linuxppc_2_3/drivers/char/keyboard.c	Sat Nov 25 17:50:09 2000
@@ -322,7 +322,7 @@ void handle_scancode(unsigned char scanc
 			compute_shiftstate();
 			kbd->slockstate = 0; /* play it safe */
 #else
-			keysym = U(plain_map[keycode]);
+			keysym = U(key_maps[0][keycode]);
 			type = KTYP(keysym);
 			if (type == KT_SHIFT)
 			  (*key_handler[type])(keysym & 0xff, up_flag);
@@ -750,7 +750,7 @@ void compute_shiftstate(void)
 	    k = i*BITS_PER_LONG;
 	    for(j=0; j<BITS_PER_LONG; j++,k++)
 	      if(test_bit(k, key_down)) {
-		sym = U(plain_map[k]);
+		sym = U(key_maps[0][k]);
 		if(KTYP(sym) == KT_SHIFT || KTYP(sym) == KT_SLOCK) {
 		  val = KVAL(sym);
 		  if (val == KVAL(K_CAPSSHIFT))
--- /cvsroot/linux_2_3/drivers/input/keybdev.c	Mon Dec  4 15:00:12 2000
+++ linuxppc_2_3/drivers/input/keybdev.c	Thu Dec  7 19:39:41 2000
@@ -36,7 +36,7 @@
 #include <linux/module.h>
 #include <linux/kbd_kern.h>
 
-#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__)
+#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__) || defined(CONFIG_PPC)
 
 static int x86_sysrq_alt = 0;
 
@@ -57,8 +57,46 @@ static unsigned short x86_keycodes[256] 
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
 
@@ -89,30 +127,7 @@ static int emulate_raw(unsigned int keyc
 
 	return 0;
 }
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
-
-	return 0;
-}
-
-#endif
+#endif /* CONFIG_X86 || CONFIG_IA64 || __alpha__ || __mips__ || CONFIG_PPC */
 
 static struct input_handler keybdev_handler;
 

--------------Boundary-00=_0SO7N0E7TZ21PQXESZ64--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
