Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWEIHsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWEIHsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWEIHsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:48:17 -0400
Received: from relay4.usu.ru ([194.226.235.39]:31915 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751443AbWEIHsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:48:16 -0400
Message-ID: <44604977.1090008@ums.usu.ru>
Date: Tue, 09 May 2006 13:49:11 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing
References: <Pine.LNX.4.61.0604022005290.12603@yvahk01.tjqt.qr> <44308100.6080009@ums.usu.ru> <Pine.LNX.4.61.0604031048330.2220@yvahk01.tjqt.qr> <Pine.LNX.4.61.0605082211580.20743@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605082211580.20743@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.1.29; VDF: 6.34.1.53; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Hi Alex,
>
>   
>>> Yes, please assume this line on all utf8 composing patches I submitted to LKML:
>>> But this line already exists in http://lkml.org/lkml/2006/3/20/571 :)
>>>       
>> Must have missed it.
>>
>>     
>
> Your patch will not apply 100% cleanly to 2.6.17-rc3, and in fact it 
> seems like it is not needed anymore (composing works without it again).
> Can you confirm that?
>
>
>
> Jan Engelhardt
>   
No, I can't.

What they did is to inline the equivalent of the put_8bit() function, 
minus the call to conv_8bit_to_uni(). So, the result is that the result 
of the composing operation is still taken from the accent_table, and 
thus cannot be more than "unsigned char" allows (but is correctly 
converted to UTF-8). See the definition of struct kbdiacr in 
include/linux/kd.h. So, the result of such operation can be only in the 
Latin-1 range of Unicode. This is not acceptable for languages that use 
dead keys and characters from Latin-2 set.

In short: in UTF-8 mode, it is possible to generate characters from 
Latin-1 set by composing, and they are generated correctly. It is 
impossible to generate characters outside of Latin-1 (unlike the 
situation with my patch).

Both the current situation and my patch share the defect that an accent 
cannot be put on top of a multibyte character, such as Greek letter alpha.

The updated patch is pasted below. It works and contains the needed 
functionality (plus Unicode copy-and-paste functionality), but is 
ideologically wrong (it would be more correct to introduce a new version 
of struct kbdiacr and new version of kbd). However, it is currently the 
only known way to generate characters outside of Latin-1 by composing in 
UTF-8 mode.

Submitted by: Alexander E. Patrakov <patrakov@ums.usu.ru>
Signed-off-by: Alexander E. Patrakov <patrakov@ums.usu.ru>
Date: 2006-05-09
Initial Package Version: 2.6.17-rc3
Upstream Status: Discussion on LKML
Origin: http://chris.heathens.co.nz/linux/downloads/patches-2.6.4-cdh1.tar.gz
        Porting to linux-2.6.17-rc3 by Alexander E. Patrakov
Description: This patch fixes dead keys and copy/paste of non-ASCII characters
             in UTF-8 mode on Linux console.
             See more details about the original patch at:
             http://chris.heathens.co.nz/linux/utf8.html

---

diff -ur linux-2.6.17-rc3.orig/drivers/char/consolemap.c linux-2.6.17-rc3.my/drivers/char/consolemap.c
--- linux-2.6.17-rc3.orig/drivers/char/consolemap.c	2005-12-25 10:00:12.000000000 +0500
+++ linux-2.6.17-rc3.my/drivers/char/consolemap.c	2005-12-25 10:01:22.000000000 +0500
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
diff -ur linux-2.6.17-rc3.orig/drivers/char/keyboard.c linux-2.6.17-rc3.my/drivers/char/keyboard.c
--- linux-2.6.17-rc3.orig/drivers/char/keyboard.c	2006-05-09 02:39:23.000000000 +0600
+++ linux-2.6.17-rc3.my/drivers/char/keyboard.c	2006-05-09 06:38:24.000000000 +0600
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
@@ -341,11 +341,21 @@
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
 
@@ -414,7 +424,7 @@
 		return d;
 
 	if (kbd->kbdmode == VC_UNICODE)
-		to_utf8(vc, d);
+		to_utf8(vc, conv_8bit_to_uni(d));
 	else if (d < 0x100)
 		put_queue(vc, d);
 
@@ -428,7 +438,7 @@
 {
 	if (diacr) {
 		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, diacr);
+			to_utf8(vc, conv_8bit_to_uni(diacr));
 		else if (diacr < 0x100)
 			put_queue(vc, diacr);
 		diacr = 0;
@@ -640,7 +650,7 @@
 		return;
 	}
 	if (kbd->kbdmode == VC_UNICODE)
-		to_utf8(vc, value);
+		to_utf8(vc, conv_8bit_to_uni(value));
 	else if (value < 0x100)
 		put_queue(vc, value);
 }
@@ -798,7 +808,7 @@
 	/* kludge */
 	if (up_flag && shift_state != old_state && npadch != -1) {
 		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, npadch & 0xffff);
+			to_utf8(vc, npadch);
 		else
 			put_queue(vc, npadch & 0xff);
 		npadch = -1;
diff -ur linux-2.6.17-rc3.orig/drivers/char/selection.c linux-2.6.17-rc3.my/drivers/char/selection.c
--- linux-2.6.17-rc3.orig/drivers/char/selection.c	2005-12-25 10:00:12.000000000 +0500
+++ linux-2.6.17-rc3.my/drivers/char/selection.c	2005-12-25 10:01:22.000000000 +0500
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
diff -ur linux-2.6.17-rc3.orig/include/linux/consolemap.h linux-2.6.17-rc3.my/include/linux/consolemap.h
--- linux-2.6.17-rc3.orig/include/linux/consolemap.h	2005-12-25 10:00:13.000000000 +0500
+++ linux-2.6.17-rc3.my/include/linux/consolemap.h	2005-12-25 10:01:22.000000000 +0500
@@ -10,6 +10,7 @@
 
 struct vc_data;
 
-extern unsigned char inverse_translate(struct vc_data *conp, int glyph);
+extern u16 inverse_translate(struct vc_data *conp, int glyph, int use_unicode);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+extern u32 conv_8bit_to_uni(unsigned char c);

-- 
Alexander E. Patrakov


