Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319117AbSHUU2g>; Wed, 21 Aug 2002 16:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319213AbSHUU2g>; Wed, 21 Aug 2002 16:28:36 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:8903 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319117AbSHUU2b>;
	Wed, 21 Aug 2002 16:28:31 -0400
Date: Wed, 21 Aug 2002 22:32:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Franz Sirl's final PPC input conversion part
Message-ID: <20020821223222.A19016@ucw.cz>
References: <20020820153813.A13034@ucw.cz> <20020821191034.A6014@ucw.cz> <20020821191227.B6014@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020821191227.B6014@ucw.cz>; from vojtech@suse.cz on Wed, Aug 21, 2002 at 07:12:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.512, 2002-08-21 22:30:28+02:00, Franz.Sirl-kernel@lauterbach.com
  Hi Vojtech,
  I noticed you just pushed the pc_keyb.c removal to linux-input, here is the
  PPC part of it that removes now superflous stuff. The small change in
  keyboard.c is a bugfix from 2.4 and ruby that didn't make it into 2.5 yet.
  Franz.

 arch/ppc/config.in              |    5 --
 arch/ppc/platforms/chrp_setup.c |   17 ------
 arch/ppc/platforms/pmac_setup.c |   12 ----
 drivers/char/keyboard.c         |    2 
 drivers/macintosh/Makefile      |    2 
 drivers/macintosh/mac_hid.c     |   98 +---------------------------------------
 include/asm-ppc/machdep.h       |    6 --
 7 files changed, 6 insertions(+), 136 deletions(-)

===================================================================

diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Wed Aug 21 22:30:48 2002
+++ b/arch/ppc/config.in	Wed Aug 21 22:30:48 2002
@@ -540,11 +540,6 @@
          bool '     Support for mouse button 2+3 emulation' CONFIG_MAC_EMUMOUSEBTN
       fi
    fi
-   # This is for drivers/macintosh/mac_hid.o, which is needed if the input
-   # layer is used.
-   if [ "$CONFIG_INPUT" != "n" ]; then
-      define_bool CONFIG_MAC_HID y
-   fi
    if [ "$CONFIG_ADB_CUDA" != "n" ]; then
       bool 'Support for ANS LCD display' CONFIG_ANSLCD
    fi
diff -Nru a/arch/ppc/platforms/chrp_setup.c b/arch/ppc/platforms/chrp_setup.c
--- a/arch/ppc/platforms/chrp_setup.c	Wed Aug 21 22:30:48 2002
+++ b/arch/ppc/platforms/chrp_setup.c	Wed Aug 21 22:30:48 2002
@@ -68,7 +68,6 @@
 void btext_progress(char *, unsigned short);
 
 extern unsigned long pmac_find_end_of_memory(void);
-extern void select_adb_keyboard(void);
 extern int of_show_percpuinfo(struct seq_file *, int);
 
 extern kdev_t boot_dev;
@@ -437,22 +436,6 @@
 
 	if (ppc_md.progress)
 		ppc_md.progress("  Have fun!    ", 0x7777);
-
-#if defined(CONFIG_VT) && defined(CONFIG_INPUT)
-	/* see if there is a keyboard in the device tree
-	   with a parent of type "adb" */
-	{
-		struct device_node *kbd;
-
-		for (kbd = find_devices("keyboard"); kbd; kbd = kbd->next) {
-			if (kbd->parent && kbd->parent->type
-			    && strcmp(kbd->parent->type, "adb") == 0) {
-				select_adb_keyboard();
-				break;
-			}
-		}
-	}
-#endif /* CONFIG_VT && CONFIG_INPUT */
 }
 
 void __init
diff -Nru a/arch/ppc/platforms/pmac_setup.c b/arch/ppc/platforms/pmac_setup.c
--- a/arch/ppc/platforms/pmac_setup.c	Wed Aug 21 22:30:48 2002
+++ b/arch/ppc/platforms/pmac_setup.c	Wed Aug 21 22:30:48 2002
@@ -66,7 +66,6 @@
 #include <asm/ohare.h>
 #include <asm/mediabay.h>
 #include <asm/machdep.h>
-#include <asm/keyboard.h>
 #include <asm/dma.h>
 #include <asm/bootx.h>
 #include <asm/cputable.h>
@@ -618,15 +617,6 @@
 }
 
 void __init
-select_adb_keyboard(void)
-{
-#ifdef CONFIG_VT
-	ppc_md.kbd_translate     = mac_hid_kbd_translate;
-	ppc_md.kbd_unexpected_up = mac_hid_kbd_unexpected_up;
-#endif /* CONFIG_VT */
-}
-
-void __init
 pmac_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
 {
@@ -665,8 +655,6 @@
 	ppc_md.find_end_of_memory = pmac_find_end_of_memory;
 
 	ppc_md.feature_call   = pmac_do_feature_call;
-
-	select_adb_keyboard();
 
 #ifdef CONFIG_BOOTX_TEXT
 	ppc_md.progress = pmac_progress;
diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Wed Aug 21 22:30:48 2002
+++ b/drivers/char/keyboard.c	Wed Aug 21 22:30:48 2002
@@ -222,7 +222,7 @@
 			if (!test_bit(k, key_down))
 				continue;
 
-			sym = U(plain_map[k]);
+			sym = U(key_maps[0][k]);
 			if (KTYP(sym) != KT_SHIFT && KTYP(sym) != KT_SLOCK)
 				continue;
 
diff -Nru a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
--- a/drivers/macintosh/Makefile	Wed Aug 21 22:30:48 2002
+++ b/drivers/macintosh/Makefile	Wed Aug 21 22:30:48 2002
@@ -20,7 +20,7 @@
 ifneq ($(CONFIG_MAC),y)
   obj-$(CONFIG_NVRAM)		+= nvram.o
 endif
-obj-$(CONFIG_MAC_HID)		+= mac_hid.o
+obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_PPC_RTC)		+= rtc.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
diff -Nru a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
--- a/drivers/macintosh/mac_hid.c	Wed Aug 21 22:30:48 2002
+++ b/drivers/macintosh/mac_hid.c	Wed Aug 21 22:30:48 2002
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2000 Franz Sirl.
  *
- * Stuff inside CONFIG_MAC_EMUMOUSEBTN should really be moved to userspace.
+ * This file will soon be removed in favor of an uinput userspace tool.
  */
 
 #include <linux/config.h>
@@ -16,36 +16,14 @@
 #include <linux/module.h>
 
 
-static unsigned char e0_keys[128] = {
-	0, 0, 0, KEY_KPCOMMA, 0, KEY_INTL3, 0, 0,		/* 0x00-0x07 */
-	0, 0, 0, 0, KEY_LANG1, KEY_LANG2, 0, 0,			/* 0x08-0x0f */
-	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x10-0x17 */
-	0, 0, 0, 0, KEY_KPENTER, KEY_RIGHTCTRL, KEY_VOLUMEUP, 0,/* 0x18-0x1f */
-	0, 0, 0, 0, 0, KEY_VOLUMEDOWN, KEY_MUTE, 0,		/* 0x20-0x27 */
-	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x28-0x2f */
-	0, 0, 0, 0, 0, KEY_KPSLASH, 0, KEY_SYSRQ,		/* 0x30-0x37 */
-	KEY_RIGHTALT, KEY_BRIGHTNESSUP, KEY_BRIGHTNESSDOWN, 
-		KEY_EJECTCD, 0, 0, 0, 0,			/* 0x38-0x3f */
-	0, 0, 0, 0, 0, 0, 0, KEY_HOME,				/* 0x40-0x47 */
-	KEY_UP, KEY_PAGEUP, 0, KEY_LEFT, 0, KEY_RIGHT, 0, KEY_END, /* 0x48-0x4f */
-	KEY_DOWN, KEY_PAGEDOWN, KEY_INSERT, KEY_DELETE, 0, 0, 0, 0, /* 0x50-0x57 */
-	0, 0, 0, KEY_LEFTMETA, KEY_RIGHTMETA, KEY_COMPOSE, KEY_POWER, 0, /* 0x58-0x5f */
-	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x60-0x67 */
-	0, 0, 0, 0, 0, 0, 0, KEY_MACRO,				/* 0x68-0x6f */
-	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x70-0x77 */
-	0, 0, 0, 0, 0, 0, 0, 0					/* 0x78-0x7f */
-};
-
-#ifdef CONFIG_MAC_EMUMOUSEBTN
 static struct input_dev emumousebtn;
 static void emumousebtn_input_register(void);
 static int mouse_emulate_buttons = 0;
 static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
 static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
 static int mouse_last_keycode = 0;
-#endif
 
-#if defined(CONFIG_SYSCTL) && defined(CONFIG_MAC_EMUMOUSEBTN)
+#if defined(CONFIG_SYSCTL)
 /* file(s) in /proc/sys/dev/mac_hid */
 ctl_table mac_hid_files[] =
 {
@@ -85,76 +63,11 @@
 
 #endif /* endif CONFIG_SYSCTL */
 
-int mac_hid_kbd_translate(unsigned char scancode, unsigned char *keycode,
-			  char raw_mode)
-{
-	/* This code was copied from char/pc_keyb.c and will be
-	 * superflous when the input layer is fully integrated.
-	 * We don't need the high_keys handling, so this part
-	 * has been removed.
-	 */
-	static int prev_scancode = 0;
-
-	/* special prefix scancodes.. */
-	if (scancode == 0xe0 || scancode == 0xe1) {
-		prev_scancode = scancode;
-		return 0;
-	}
-
-	scancode &= 0x7f;
-
-	if (prev_scancode) {
-		if (prev_scancode != 0xe0) {
-			if (prev_scancode == 0xe1 && scancode == 0x1d) {
-				prev_scancode = 0x100;
-				return 0;
-			} else if (prev_scancode == 0x100 && scancode == 0x45) {
-				*keycode = KEY_PAUSE;
-				prev_scancode = 0;
-			} else {
-				if (!raw_mode)
-					printk(KERN_INFO "keyboard: unknown e1 escape sequence\n");
-				prev_scancode = 0;
-				return 0;
-			}
-		} else {
-			prev_scancode = 0;
-			if (scancode == 0x2a || scancode == 0x36)
-				return 0;
-		}
-		if (e0_keys[scancode])
-			*keycode = e0_keys[scancode];
-		else {
-			if (!raw_mode)
-				printk(KERN_INFO "keyboard: unknown scancode e0 %02x\n",
-				       scancode);
-			return 0;
-		}
-	} else {
-		switch (scancode) {
-		case  91: scancode = KEY_LINEFEED; break;
-		case  92: scancode = KEY_KPEQUAL; break;
-		case 125: scancode = KEY_INTL1; break;
-		}
-		*keycode = scancode;
-	}
-	return 1;
-}
-
-char mac_hid_kbd_unexpected_up(unsigned char keycode)
-{
-	if (keycode == KEY_F13)
-		return 0;
-	else
-		return 0x80;
-}
-
-#ifdef CONFIG_MAC_EMUMOUSEBTN
 int mac_hid_mouse_emulate_buttons(int caller, unsigned int keycode, int down)
 {
 	switch (caller) {
 	case 1:
-		/* Called from keybdev.c */
+		/* Called from keyboard.c */
 		if (mouse_emulate_buttons
 		    && (keycode == mouse_button2_keycode
 			|| keycode == mouse_button3_keycode)) {
@@ -191,16 +104,13 @@
 
 	printk(KERN_INFO "input: Macintosh mouse button emulation\n");
 }
-#endif
 
 int __init mac_hid_init(void)
 {
 
-#ifdef CONFIG_MAC_EMUMOUSEBTN
 	emumousebtn_input_register();
-#endif
 
-#if defined(CONFIG_SYSCTL) && defined(CONFIG_MAC_EMUMOUSEBTN)
+#if defined(CONFIG_SYSCTL)
 	mac_hid_sysctl_header = register_sysctl_table(mac_hid_root_dir, 1);
 #endif /* CONFIG_SYSCTL */
 
diff -Nru a/include/asm-ppc/machdep.h b/include/asm-ppc/machdep.h
--- a/include/asm-ppc/machdep.h	Wed Aug 21 22:30:48 2002
+++ b/include/asm-ppc/machdep.h	Wed Aug 21 22:30:48 2002
@@ -57,12 +57,6 @@
 	unsigned char 	(*nvram_read_val)(int addr);
 	void		(*nvram_write_val)(int addr, unsigned char val);
 
-	/* Tons of keyboard stuff. */
-	int		(*kbd_translate)(unsigned char scancode,
-				unsigned char *keycode,
-				char raw_mode);
-	char		(*kbd_unexpected_up)(unsigned char keycode);
-
 	/*
 	 * optional PCI "hooks"
 	 */

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch19000
M'XL(`'CX8ST``\U8:V^;2!3];'[%E;K2]F4\,PP#9)55NDD?T39ME,=*JZJ*
M!A@"#0;$0-)4_/B]0!*[=KS$SK;:)()@P[UG[CES'SR!4ZW*K=%E_J5206P\
M@7>YKK9&NM;*#+[A]5&>X_4DSJ=J<G/7Q+^8)%E15P9^?RBK((9+5>JM$36M
MNT^JZT)MC8Y>OSU]_^K(,+:W83>6V;DZ5A5L;QM57E[*--0[LHK3/#.K4F9Z
MJBII!OFTN;NU880P_+6I8Q%;-%00[C0!#2F5G*J0,.X*;MP`V[F!O?B\RRAU
MB."LL5U/>,8>4-.F#`B;$'?"*#"V99$MYKX@;(L0>(-@OIG'29F.+U29J70G
ME76E2E\&<8L/7C@P)L8?\-^N8M<(X%T"?_6+>8E7^Y#E51*H$*[S&K[4NH*B
MUC%>5[&"(CB[4->^&4"IICD"03R0)EG]==S1\Q)B52I(='LW6CL\W(5"EA7D
M$205?BBK_DFET<\5Z+I0993FM09=U5%DP@EZT5.9IA!T:X$D0SNMTUR6(3I&
MVQ+\^CQ*OD)48F28R4%F(92U?]U["),P^[6"J;Q0K=<D0Y#,M.%:528:ZV-M
M_`F6XQB',Y$8XS5_#(-(8OP^P(DL4;]%$4QZ8B?%5`9G6E5U809S-''"[(8Z
MGDL;VV8JXB$+!0L9L^F@.F8^BE1645Y.]3UN4).,6*T;8KGN^L"#N"Q6`D>5
M\<:U")61;47*I4&H-L*][&6&FS&/#^,.RZ1-#A,,0$N]CMO_SN(D7(!-14,(
MM41C^\+Q.+=I:-N^=(=A#WJ80>;"<L0&D`]0O%&2JD7$S!:6VP12<FFK2$FJ
M/.(/YX]!#W/B<`ES'XP8=VDYF6W/[^`2CE+VJ-<H'H1$"9^%D8HB2SP<[KWF
M9UBIQ9UAK'<J"_(L2L[-)%N4KV#"H8VT'1)RR_&B0#&4\AKZ7;!\BY`WW/,H
M&T289$%:AVHB]73<FD.6XE`59CR?QSWN81YW/%RVQ+#ZS'<%L64DAW$.V)\%
MU":$.%WM7%[:<!'=--!&&89UELIB)]=A:N;E^>K(4HNZ-D=I"<MR>%=8.5VJ
MJ_S!=97`V/XA=?6HJW.P^_'#F_VW9P>O=L_>[>]AU>D5\1'&Y57WAW7D\)YH
M;U"-]FQN@?T]>_<GUC6HW#3YWW5(U562)N=Q9=;!5=LI/2CG.XQC!]4E9X=9
MM*.9B26:[75HILZ/Y/DV26%_HY.P5KKM,/J"M8KK^P.P"?$.!8P1YP2H6,7_
M?$.P/O_K=RWK"&#9NH/[W&+"PJ+/7:R@G0"6]_EZ`F`_70!=HS7,__SZ-^%?
M>"W_`N."HX80+K!.!2NJZ##[CZKN2[/14#%O)R5L:JAE67U"]Q[!,T6>?PC-
M;W#@*/*RPE'H=NY`@OL.9('A%0O>A%G<24CM?G\:C4;Z>@K;</H4K9Y-9:$_
MD<^?+CX_^^T[OI>;O(=3OFD+:ES(9*<JJ%G6<3FNLV3LYT%<3\U0#=IVF(-%
M'7=\0[#-<3L-N/]'#:RJZ5W+O$($RXO>2`=6)X/VF/M?QK\\G</P^N#TX./I
M\>L_3CX\&[W8AMMA)%\ABKMA91-5K#=+K2P"@X8=+"'4%MA"8QD0?0?@/$(3
M',8>_^GYOQ__!I5QM_9-I.&VRF@/\!Q.XD1#M^$QWBGH/,_`5S?O7$+`)CZ2
MEWG9OH^1&=3=2QO`-%WJ0@8*@Y.GIK%'/6!M/R&ZKJ*SWQV?)!&$*.%,A;?Z
M._[[>/?D_3-$X8*P\5';:6_O3Z/1Y#GLRC2]S9ES->CYI/7#6P_4Z\H7([0_
M]5+O3O_BL=7VRKEF6-F/&[F,LM;5]4Y[#/*R:"V:LAXRZC#!&'.9:`1WL1UM
M-4VMQS4UXJ=KNI\1%S2]<N4;M3,$Q.Q-;Q"KX$+7T^W`#7W?IY;Q#^0_@H9$
#%@``
`
end

-- 
Vojtech Pavlik
SuSE Labs
