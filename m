Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWCUD4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWCUD4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 22:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWCUD4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 22:56:07 -0500
Received: from relay4.usu.ru ([194.226.235.39]:7815 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S964811AbWCUD4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 22:56:05 -0500
Message-ID: <441F7962.9080803@ums.usu.ru>
Date: Tue, 21 Mar 2006 08:56:18 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] Fix console utf8 composing (F)
References: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.0.14; VDF: 6.34.0.75; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Hello Alexander, Linus, LKML,
>
>
>
> can we have the patch[2] from this[1] thread merged? I have not yet heard back
> from Alexander since [3]. Plus we're lacking a Signed-off-by so far for [2].
> What to do?
>
>
> [1] http://lkml.org/lkml/2005/12/25/2
> [2] http://www.linuxfromscratch.org/~alexander/patches/linux-2.6.14-utf8_input-1.patch
> [3] http://lkml.org/lkml/2006/1/30/50
>
>
> Jan Engelhardt
>   
See the updated (in fact, just rediffed after "patch -Np1 -l") patch 
below. You certainly want to run Lindent after patching.

It includes the following patches from 
http://chris.heathens.co.nz/linux/utf8.html: p1_conv_8bit_to_uni.patch, 
p2_selection.patch, p3_extended_utf8.patch. The third patch may be 
useful only for things like fbiterm, I will remove it if there are 
objections.

Submitted by: Alexander E. Patrakov <patrakov@ums.usu.ru>
Signed-off-by: Alexander E. Patrakov <patrakov@ums.usu.ru>
Date: 2006-03-21
Initial Package Version: 2.6.15-rc6
Origin: http://chris.heathens.co.nz/linux/downloads/patches-2.6.4-cdh1.tar.gz
        Porting to linux-2.6.16 by Alexander E. Patrakov
Description: This patch fixes dead keys and copy/paste of non-ASCII characters
             in UTF-8 mode on Linux console.
             See more details about the original patch at:
             http://chris.heathens.co.nz/linux/utf8.html

diff -ur linux-2.6.15-rc6.orig/drivers/char/consolemap.c linux-2.6.15-rc6.my/drivers/char/consolemap.c
--- linux-2.6.15-rc6.orig/drivers/char/consolemap.c	2005-12-25 10:00:12.000000000 +0500
+++ linux-2.6.15-rc6.my/drivers/char/consolemap.c	2005-12-25 10:01:22.000000000 +0500
@@ -178,6 +178,7 @@
 	unsigned long	refcount;
 	unsigned long	sum;
 	unsigned char	*inverse_translations[4];
+	u16		*inverse_trans_unicode;
 	int		readonly;
 };
 
@@ -208,6 +209,41 @@
 	}
 }
 
+static void set_inverse_trans_unicode(struct vc_data *conp, 
+				      struct uni_pagedir *p)
+{
+	int i, j, k, glyph;
+	u16 **p1, *p2;
+	u16 *q;
+	
+	if (!p) return;
+	q = p->inverse_trans_unicode;
+	if (!q) {
+		q = p->inverse_trans_unicode =
+			kmalloc(MAX_GLYPH * sizeof(u16), GFP_KERNEL);
+		if (!q)
+			return;
+	}
+	memset(q, 0, MAX_GLYPH * sizeof(u16));
+
+	for (i = 0; i < 32; i++) {
+		p1 = p->uni_pgdir[i];
+		if (!p1)
+			continue;
+		for (j = 0; j < 32; j++) {
+			p2 = p1[j];
+			if (!p2)
+				continue;
+			for (k = 0; k < 64; k++) {
+				glyph = p2[k];
+				if (glyph >= 0 && glyph < MAX_GLYPH 
+					       && q[glyph] < 32)
+		  			q[glyph] = (i << 11) + (j << 6) + k;
+			}
+		}
+	}
+}
+
 unsigned short *set_translate(int m, struct vc_data *vc)
 {
 	inv_translate[vc->vc_num] = m;
@@ -218,19 +254,29 @@
  * Inverse translation is impossible for several reasons:
  * 1. The font<->character maps are not 1-1.
  * 2. The text may have been written while a different translation map
- *    was active, or using Unicode.
+ *    was active.
  * Still, it is now possible to a certain extent to cut and paste non-ASCII.
  */
-unsigned char inverse_translate(struct vc_data *conp, int glyph)
+u16 inverse_translate(struct vc_data *conp, int glyph, int use_unicode)
 {
 	struct uni_pagedir *p;
+	int m;
 	if (glyph < 0 || glyph >= MAX_GLYPH)
 		return 0;
-	else if (!(p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc) ||
-		 !p->inverse_translations[inv_translate[conp->vc_num]])
+	else if (!(p = (struct uni_pagedir *)*conp->vc_uni_pagedir_loc))
 		return glyph;
-	else
-		return p->inverse_translations[inv_translate[conp->vc_num]][glyph];
+	else if (use_unicode) {
+		if (!p->inverse_trans_unicode)
+			return glyph;
+		else
+			return p->inverse_trans_unicode[glyph];
+	} else {
+		m = inv_translate[conp->vc_num];
+		if (!p->inverse_translations[m])
+			return glyph;
+		else
+			return p->inverse_translations[m][glyph];
+	}
 }
 
 static void update_user_maps(void)
@@ -244,6 +290,7 @@
 		p = (struct uni_pagedir *)*vc_cons[i].d->vc_uni_pagedir_loc;
 		if (p && p != q) {
 			set_inverse_transl(vc_cons[i].d, p, USER_MAP);
+			set_inverse_trans_unicode(vc_cons[i].d, p);
 			q = p;
 		}
 	}
@@ -354,6 +401,10 @@
 		kfree(p->inverse_translations[i]);
 		p->inverse_translations[i] = NULL;
 	}
+	if (p->inverse_trans_unicode) {
+		kfree(p->inverse_trans_unicode);
+		p->inverse_trans_unicode = NULL;
+	}
 }
 
 void con_free_unimap(struct vc_data *vc)
@@ -512,6 +563,7 @@
 
 	for (i = 0; i <= 3; i++)
 		set_inverse_transl(vc, p, i); /* Update all inverse translations */
+	set_inverse_trans_unicode(vc, p);
   
 	return err;
 }
@@ -562,6 +614,7 @@
 
 	for (i = 0; i <= 3; i++)
 		set_inverse_transl(vc, p, i);	/* Update all inverse translations */
+	set_inverse_trans_unicode(vc, p);
 	dflt = p;
 	return err;
 }
@@ -618,6 +671,19 @@
 		p->readonly = rdonly;
 }
 
+/* may be called during an interrupt */
+u32 conv_8bit_to_uni(unsigned char c)
+{
+	/* 
+	 * Always use USER_MAP. This function is used by the keyboard,
+	 * which shouldn't be affected by G0/G1 switching, etc.
+	 * If the user map still contains default values, i.e. the 
+	 * direct-to-font mapping, then assume user is using Latin1.
+	 */
+	unsigned short uni = translations[USER_MAP][c];
+	return uni == (0xf000 | c) ? c : uni;
+}
+
 int
 conv_uni_to_pc(struct vc_data *conp, long ucs) 
 {
diff -ur linux-2.6.15-rc6.orig/drivers/char/keyboard.c linux-2.6.15-rc6.my/drivers/char/keyboard.c
--- linux-2.6.15-rc6.orig/drivers/char/keyboard.c	2005-12-25 10:00:12.000000000 +0500
+++ linux-2.6.15-rc6.my/drivers/char/keyboard.c	2005-12-25 10:01:22.000000000 +0500
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
+#include <linux/consolemap.h>
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 #include <linux/vt_kern.h>
@@ -329,10 +330,9 @@
  * Many other routines do put_queue, but I think either
  * they produce ASCII, or they produce some user-assigned
  * string, and in both cases we might assume that it is
- * in utf-8 already. UTF-8 is defined for words of up to 31 bits,
- * but we need only 16 bits here
+ * in utf-8 already.
  */
-static void to_utf8(struct vc_data *vc, ushort c)
+static void to_utf8(struct vc_data *vc, uint c)
 {
 	if (c < 0x80)
 		/*  0******* */
@@ -341,14 +341,33 @@
 		/* 110***** 10****** */
 		put_queue(vc, 0xc0 | (c >> 6));
 		put_queue(vc, 0x80 | (c & 0x3f));
-	} else {
+    	} else if (c < 0x10000) {
+	       	if (c >= 0xD800 && c < 0xE000)
+			return;
+		if (c == 0xFFFF)
+			return;
 		/* 1110**** 10****** 10****** */
 		put_queue(vc, 0xe0 | (c >> 12));
 		put_queue(vc, 0x80 | ((c >> 6) & 0x3f));
 		put_queue(vc, 0x80 | (c & 0x3f));
+    	} else if (c < 0x110000) {
+		/* 11110*** 10****** 10****** 10****** */
+		put_queue(vc, 0xf0 | (c >> 18));
+		put_queue(vc, 0x80 | ((c >> 12) & 0x3f));
+		put_queue(vc, 0x80 | ((c >> 6) & 0x3f));
+		put_queue(vc, 0x80 | (c & 0x3f));
 	}
 }
 
+static void put_8bit(struct vc_data *vc, u8 c)
+{
+	if (kbd->kbdmode != VC_UNICODE || c < 32 || c == 127) 
+		/* Don't translate control chars */
+		put_queue(vc, c);
+	else
+		to_utf8(vc, conv_8bit_to_uni(c));
+}
+
 /*
  * Called after returning from RAW mode or when changing consoles - recompute
  * shift_down[] and shift_state from key_down[] maybe called when keymap is
@@ -409,7 +428,7 @@
 	if (ch == ' ' || ch == d)
 		return d;
 
-	put_queue(vc, d);
+	put_8bit(vc, d);
 	return ch;
 }
 
@@ -419,7 +438,7 @@
 static void fn_enter(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (diacr) {
-		put_queue(vc, diacr);
+		put_8bit(vc, diacr);
 		diacr = 0;
 	}
 	put_queue(vc, 13);
@@ -628,7 +647,7 @@
 		diacr = value;
 		return;
 	}
-	put_queue(vc, value);
+	put_8bit(vc, value);
 }
 
 /*
@@ -774,7 +793,7 @@
 	/* kludge */
 	if (up_flag && shift_state != old_state && npadch != -1) {
 		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, npadch & 0xffff);
+			to_utf8(vc, npadch);
 		else
 			put_queue(vc, npadch & 0xff);
 		npadch = -1;
diff -ur linux-2.6.15-rc6.orig/drivers/char/selection.c linux-2.6.15-rc6.my/drivers/char/selection.c
--- linux-2.6.15-rc6.orig/drivers/char/selection.c	2005-12-25 10:00:12.000000000 +0500
+++ linux-2.6.15-rc6.my/drivers/char/selection.c	2005-12-25 10:01:22.000000000 +0500
@@ -20,6 +20,7 @@
 
 #include <asm/uaccess.h>
 
+#include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
 #include <linux/consolemap.h>
 #include <linux/selection.h>
@@ -34,6 +35,7 @@
 /* Variables for selection control. */
 /* Use a dynamic buffer, instead of static (Dec 1994) */
 struct vc_data *sel_cons;		/* must not be disallocated */
+static int use_unicode;
 static volatile int sel_start = -1; 	/* cleared by clear_selection */
 static int sel_end;
 static int sel_buffer_lth;
@@ -54,10 +56,11 @@
 	complement_pos(sel_cons, where);
 }
 
-static unsigned char
+static u16
 sel_pos(int n)
 {
-	return inverse_translate(sel_cons, screen_glyph(sel_cons, n));
+	return inverse_translate(sel_cons, screen_glyph(sel_cons, n),
+				use_unicode);
 }
 
 /* remove the current selection highlight, if any,
@@ -86,8 +89,8 @@
   0xFF7FFFFF  /* latin-1 accented letters, not division sign */
 };
 
-static inline int inword(const unsigned char c) {
-	return ( inwordLut[c>>5] >> (c & 0x1F) ) & 1;
+static inline int inword(const u16 c) {
+	return c > 0xff || (( inwordLut[c>>5] >> (c & 0x1F) ) & 1);
 }
 
 /* set inwordLut contents. Invoked by ioctl(). */
@@ -108,13 +111,36 @@
 	return (v > u) ? u : v;
 }
 
+/* stores the char in UTF8 and returns the number of bytes used (1-3) */
+int store_utf8(u16 c, char *p) 
+{
+	if (c < 0x80) {
+		/*  0******* */
+		p[0] = c;
+		return 1;
+	} else if (c < 0x800) {
+		/* 110***** 10****** */
+		p[0] = 0xc0 | (c >> 6);
+		p[1] = 0x80 | (c & 0x3f);
+		return 2;
+    	} else {
+		/* 1110**** 10****** 10****** */
+		p[0] = 0xe0 | (c >> 12);
+		p[1] = 0x80 | ((c >> 6) & 0x3f);
+		p[2] = 0x80 | (c & 0x3f);
+		return 3;
+    	}
+}
+
 /* set the current selection. Invoked by ioctl() or by kernel code. */
 int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int sel_mode, new_sel_start, new_sel_end, spc;
 	char *bp, *obp;
-	int i, ps, pe;
+	int i, ps, pe, multiplier;
+	u16 c;
+	struct kbd_struct *kbd = kbd_table + fg_console;
 
 	poke_blanked_console();
 
@@ -158,7 +184,8 @@
 		clear_selection();
 		sel_cons = vc_cons[fg_console].d;
 	}
-
+	use_unicode = kbd && kbd->kbdmode == VC_UNICODE;
+	
 	switch (sel_mode)
 	{
 		case TIOCL_SELCHAR:	/* character-by-character selection */
@@ -240,7 +267,8 @@
 	sel_end = new_sel_end;
 
 	/* Allocate a new buffer before freeing the old one ... */
-	bp = kmalloc((sel_end-sel_start)/2+1, GFP_KERNEL);
+	multiplier = use_unicode ? 3 : 1;  /* chars can take up to 3 bytes */
+	bp = kmalloc((sel_end-sel_start)/2*multiplier+1, GFP_KERNEL);
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
 		clear_selection();
@@ -251,8 +279,12 @@
 
 	obp = bp;
 	for (i = sel_start; i <= sel_end; i += 2) {
-		*bp = sel_pos(i);
-		if (!isspace(*bp++))
+		c = sel_pos(i);
+		if (use_unicode)
+			bp += store_utf8(c, bp);
+		else
+			*bp++ = c;
+		if (!isspace(c))
 			obp = bp;
 		if (! ((i + 2) % vc->vc_size_row)) {
 			/* strip trailing blanks from line and add newline,
diff -ur linux-2.6.15-rc6.orig/include/linux/consolemap.h linux-2.6.15-rc6.my/include/linux/consolemap.h
--- linux-2.6.15-rc6.orig/include/linux/consolemap.h	2005-12-25 10:00:13.000000000 +0500
+++ linux-2.6.15-rc6.my/include/linux/consolemap.h	2005-12-25 10:01:22.000000000 +0500
@@ -10,6 +10,7 @@
 
 struct vc_data;
 
-extern unsigned char inverse_translate(struct vc_data *conp, int glyph);
+extern u16 inverse_translate(struct vc_data *conp, int glyph, int use_unicode);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+extern u32 conv_8bit_to_uni(unsigned char c);


-- 
Alexander E. Patrakov


