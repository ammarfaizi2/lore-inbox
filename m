Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVLXWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVLXWHw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 17:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVLXWHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 17:07:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32649 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750736AbVLXWHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 17:07:52 -0500
Date: Sat, 24 Dec 2005 23:07:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix console utf8 composing
Message-ID: <Pine.LNX.4.61.0512242300360.29877@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


the following patch had been posted around spring 2005, but has not since 
been included. It is about that hitting the keys <Compose><o><e> for example
did not produce the utf8 sequence for o-with-diaeresis, but the ASCII/ISO8859-1
char for o-w-diaeresis, as I seem to recall.
http://groups.google.de/group/linux.kernel/browse_thread/thread/e60f286969e83d99/55688a5aab326aa7?tvc=2&q=chris+(+%22utf-8%22+OR+%22utf8%22+)+console#55688a5aab326aa7

I am posting an updated version that I hope applies to 2.6.15-rc6.
Not sure what the correct X-Y-by: procedure is for this, as it originally
is not my work (see URL).

diff -Ppru linux-2.6.15-rc6-20051219230006/drivers/char/consolemap.c linux-2.6-AS22/drivers/char/consolemap.c
--- linux-2.6.15-rc6-20051219230006/drivers/char/consolemap.c	2005-12-11 13:42:23.000000000 +0100
+++ linux-2.6-AS22/drivers/char/consolemap.c	2005-12-19 21:53:25.000000000 +0100
@@ -178,6 +178,7 @@ struct uni_pagedir {
 	unsigned long	refcount;
 	unsigned long	sum;
 	unsigned char	*inverse_translations[4];
+	u16		*inverse_trans_unicode;
 	int		readonly;
 };
 
@@ -208,6 +209,40 @@ static void set_inverse_transl(struct vc
 	}
 }
 
+static void set_inverse_trans_unicode(struct vc_data *conp, 
+				      struct uni_pagedir *p)
+{
+	int i, j, k, glyph;
+	u16 **p1, *p2;
+	u16 *q;
+	
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
@@ -218,19 +253,29 @@ unsigned short *set_translate(int m, str
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
@@ -354,6 +399,10 @@ static void con_release_unimap(struct un
 		kfree(p->inverse_translations[i]);
 		p->inverse_translations[i] = NULL;
 	}
+	if (p->inverse_trans_unicode) {
+		kfree(p->inverse_trans_unicode);
+		p->inverse_trans_unicode = NULL;
+	}
 }
 
 void con_free_unimap(struct vc_data *vc)
@@ -512,6 +561,7 @@ int con_set_unimap(struct vc_data *vc, u
 
 	for (i = 0; i <= 3; i++)
 		set_inverse_transl(vc, p, i); /* Update all inverse translations */
+	set_inverse_trans_unicode(vc, p);
   
 	return err;
 }
@@ -562,6 +612,7 @@ int con_set_default_unimap(struct vc_dat
 
 	for (i = 0; i <= 3; i++)
 		set_inverse_transl(vc, p, i);	/* Update all inverse translations */
+	set_inverse_trans_unicode(vc, p);
 	dflt = p;
 	return err;
 }
@@ -618,6 +669,19 @@ void con_protect_unimap(struct vc_data *
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
diff -Ppru linux-2.6.15-rc6-20051219230006/drivers/char/keyboard.c linux-2.6-AS22/drivers/char/keyboard.c
--- linux-2.6.15-rc6-20051219230006/drivers/char/keyboard.c	2005-12-19 21:53:05.000000000 +0100
+++ linux-2.6-AS22/drivers/char/keyboard.c	2005-12-19 21:53:25.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
+#include <linux/consolemap.h>
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 #include <linux/vt_kern.h>
@@ -353,6 +354,15 @@ static void to_utf8(struct vc_data *vc, 
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
@@ -413,7 +423,7 @@ static unsigned char handle_diacr(struct
 	if (ch == ' ' || ch == d)
 		return d;
 
-	put_queue(vc, d);
+	put_8bit(vc, d);
 	return ch;
 }
 
@@ -423,7 +433,7 @@ static unsigned char handle_diacr(struct
 static void fn_enter(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (diacr) {
-		put_queue(vc, diacr);
+		put_8bit(vc, diacr);
 		diacr = 0;
 	}
 	put_queue(vc, 13);
@@ -632,7 +642,7 @@ static void k_self(struct vc_data *vc, u
 		diacr = value;
 		return;
 	}
-	put_queue(vc, value);
+	put_8bit(vc, value);
 }
 
 /*
diff -Ppru linux-2.6.15-rc6-20051219230006/drivers/char/selection.c linux-2.6-AS22/drivers/char/selection.c
--- linux-2.6.15-rc6-20051219230006/drivers/char/selection.c	2005-12-11 13:42:24.000000000 +0100
+++ linux-2.6-AS22/drivers/char/selection.c	2005-12-19 21:53:25.000000000 +0100
@@ -20,6 +20,7 @@
 
 #include <asm/uaccess.h>
 
+#include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
 #include <linux/consolemap.h>
 #include <linux/selection.h>
@@ -34,6 +35,7 @@ extern void poke_blanked_console(void);
 /* Variables for selection control. */
 /* Use a dynamic buffer, instead of static (Dec 1994) */
 struct vc_data *sel_cons;		/* must not be disallocated */
+static int use_unicode;
 static volatile int sel_start = -1; 	/* cleared by clear_selection */
 static int sel_end;
 static int sel_buffer_lth;
@@ -54,10 +56,8 @@ static inline void highlight_pointer(con
 	complement_pos(sel_cons, where);
 }
 
-static unsigned char
-sel_pos(int n)
-{
-	return inverse_translate(sel_cons, screen_glyph(sel_cons, n));
+static u16 sel_pos(int n) {
+    return inverse_translate(sel_cons, screen_glyph(sel_cons, n), use_unicode);
 }
 
 /* remove the current selection highlight, if any,
@@ -86,8 +86,8 @@ static u32 inwordLut[8]={
   0xFF7FFFFF  /* latin-1 accented letters, not division sign */
 };
 
-static inline int inword(const unsigned char c) {
-	return ( inwordLut[c>>5] >> (c & 0x1F) ) & 1;
+static inline int inword(const u16 c) {
+    return c > 0xff || ((inwordLut[c >> 5] >> (c & 0x1F)) & 1);
 }
 
 /* set inwordLut contents. Invoked by ioctl(). */
@@ -108,13 +108,35 @@ static inline unsigned short limit(const
 	return (v > u) ? u : v;
 }
 
+/* stores the char in UTF8 and returns the number of bytes used (1-3) */
+int store_utf8(u16 c, char *p)  {
+	if (c < 0x80) {
+		/* 0******* */
+		p[0] = c;
+		return 1;
+	} else if (c < 0x800) {
+		/* 110***** 10****** */
+		p[0] = 0xc0 | (c >> 6);
+		p[1] = 0x80 | (c & 0x3f);
+		return 2;
+ 	} else {
+		/* 1110**** 10****** 10****** */
+		p[0] = 0xe0 | (c >> 12);
+		p[1] = 0x80 | ((c >> 6) & 0x3f);
+		p[2] = 0x80 | (c & 0x3f);
+		return 3;
+ 	}
+}
+
 /* set the current selection. Invoked by ioctl() or by kernel code. */
 int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int sel_mode, new_sel_start, new_sel_end, spc;
 	char *bp, *obp;
-	int i, ps, pe;
+        int i, ps, pe, multiplier;
+        u16 c;
+        struct kbd_struct *kbd = kbd_table + fg_console;
 
 	poke_blanked_console();
 
@@ -158,6 +180,7 @@ int set_selection(const struct tiocl_sel
 		clear_selection();
 		sel_cons = vc_cons[fg_console].d;
 	}
+	use_unicode = kbd && kbd->kbdmode == VC_UNICODE;
 
 	switch (sel_mode)
 	{
@@ -240,7 +263,8 @@ int set_selection(const struct tiocl_sel
 	sel_end = new_sel_end;
 
 	/* Allocate a new buffer before freeing the old one ... */
-	bp = kmalloc((sel_end-sel_start)/2+1, GFP_KERNEL);
+	multiplier = use_unicode ? 3 : 1;  /* chars can take up to 3 bytes */
+	bp = kmalloc((sel_end-sel_start)/2*multiplier+1, GFP_KERNEL);
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
 		clear_selection();
@@ -251,8 +275,12 @@ int set_selection(const struct tiocl_sel
 
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
diff -Ppru linux-2.6.15-rc6-20051219230006/include/linux/consolemap.h linux-2.6-AS22/include/linux/consolemap.h
--- linux-2.6.15-rc6-20051219230006/include/linux/consolemap.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-AS22/include/linux/consolemap.h	2005-12-19 21:53:25.000000000 +0100
@@ -10,6 +10,7 @@
 
 struct vc_data;
 
-extern unsigned char inverse_translate(struct vc_data *conp, int glyph);
+extern u16 inverse_translate(struct vc_data *conp, int glyph, int use_unicode);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+extern u32 conv_8bit_to_uni(unsigned char c);
#eof



Jan Engelhardt
-- 
